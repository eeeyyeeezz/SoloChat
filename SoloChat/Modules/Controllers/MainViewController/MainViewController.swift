//
//  ViewController.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit

// MARK: ViewController 
final class MainViewController: UIViewController {

	lazy var animator = coordinator.getAnimator()
	
	// MARK: Private Properties
	
	let coordinator: Coordinator
	
	let textField: UITextField
	
	private lazy var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
	
	var models = MessageStruct(result: [])
	
	lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView(frame: view.frame)
		scrollView.addSubview(testTaskLabel)
		scrollView.addSubview(textField)
		scrollView.addSubview(tableView)
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		return scrollView
	}()
	
	let testTaskLabel: UILabel = {
		let label = UILabel()
		label.text = "Тестовое Задание"
		label.textColor = .black
		label.tintColor = .black
		label.font = label.font.withSize(22)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy var debugDeleteButton: UIButton = {
		let button = UIButton(frame: CGRect(x: 20, y: 30, width: 50, height: 50))
		button.layer.cornerRadius = 20
		button.addTarget(self, action: #selector(debugButtonDeleteAll), for: .touchUpInside)
		button.setTitle("DEL", for: .normal)
		button.backgroundColor = .red
		return button
	}()
	
	lazy var tableView = coordinator.getTableView(frame: view.frame, style: .plain)
	
	init(coordinator: Coordinator) {
		self.coordinator = coordinator
		textField = coordinator.getTextField()
		super.init(nibName: nil, bundle: nil)
	}
	
	deinit {
		removeObservers()
	}
	
	// MARK: Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViewController()
	}
	
	private func setupViewController() {
		appendRealmObjects() // Добавляем данные из Realm в локальный Storage
		fetchData()
		setupBinding()
		addSubviews()
		setupConstraints()
		registerForKeyboardNotifications()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension MainViewController {
	func fetchData() {
		NetworkManager.parseAPI { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let data):
				/// Если приходит пустой Result значит мы дошли до конца и дальше не надо парсить
				if data.result.isEmpty { debugPrint("END OF FETCH LIST"); return }
				models.result.append(contentsOf: data.result)
				DispatchQueue.main.async {
					self.tableView.reloadSections(IndexSet(integersIn: 0...0), with: .fade)
//					self.tableView.reloadData()
				}
			case .failure(_):
				/// В случае failure вызывать функцию повторно
				self.fetchData()
			}
		}
		
	}
	
	// MARK: Private Methods
	private func appendRealmObjects() {
		var newModel = [String]()
		let realmObjects = RealmHelper.getAllRealmObjects()
		realmObjects.forEach { realmModel in
			newModel.append(realmModel.message)
		}
		models.result.insert(contentsOf: newModel, at: 0)
	}
	
	private func setupBinding() {
		navigationController?.navigationBar.isHidden = true
		
		title = "Тестовое Задание"
		view.backgroundColor = .white
		textField.delegate = self
		tableView.delegate = self
		tableView.dataSource = self
	}
	
	private func addSubviews() {
		view.addSubview(scrollView)
		view.addSubview(debugDeleteButton)
//		view.addSubview(testTaskLabel)
//		view.addSubview(textField)
//		view.addSubview(tableView)
		
		// При нажатии на любую часть экрана TextField скрывается
		tapGestureRecognizer.cancelsTouchesInView = false
		view.addGestureRecognizer(tapGestureRecognizer)
		
	}

	private func registerForKeyboardNotifications() {
		NotificationCenter.default.addObserver(self,
											   selector: #selector(keyboardWillShow),
											   name: UIResponder.keyboardWillShowNotification,
											   object: nil)
		NotificationCenter.default.addObserver(self,
											   selector: #selector(keyboardWillHide),
											   name: UIResponder.keyboardWillHideNotification,
											   object: nil)
	}
	
	private func removeObservers() {
		NotificationCenter.default.removeObserver(self, name:  UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name:  UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	@objc private func hideKeyboard() {
		view.endEditing(true)
	}
	
	@objc private func keyboardWillShow(notification: Notification) {
		if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
			let keyboardHeight = keyboardFrame.cgRectValue.height
//			scrollView.contentOffset = CGPoint(x: 0, y: keyboardHeight)
			view.frame.origin.y -= keyboardHeight
			print(view.frame.origin.y, keyboardHeight)
		}
	}
	
	@objc private func keyboardWillHide() {
//		scrollView.contentOffset = CGPoint.zero
		view.frame.origin.y = 0
	}
	
	@objc func debugButtonDeleteAll() {
		RealmHelper.deleteAllModels()
		tableView.reloadData()
	}
}


// MARK: UITextFieldDelegates
extension MainViewController: UITextFieldDelegate {
	
	// Проверяем что написали в TextField
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if let text = textField.text, !text.isEmpty {
			let today = Date()
			let hours = (Calendar.current.component(.hour, from: today))
			let minutes = (Calendar.current.component(.minute, from: today))
			models.result.insert(contentsOf: [text], at: 0)
			
			// Push новых данные в Realm + добавление в начала стека
			RealmHelper.pushToRealm(message: text, time: "\(hours):\(minutes)")
			tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
			tableView.reloadSections(IndexSet(integersIn: 0...0), with: .fade)
		}
		textField.text = nil
		return true
	}
}


