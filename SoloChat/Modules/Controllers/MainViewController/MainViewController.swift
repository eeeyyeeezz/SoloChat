//
//  ViewController.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit

// MARK: MainViewController
final class MainViewController: UIViewController {

	// MARK: Properties
	var textFieldBottomConstraint: NSLayoutConstraint
	
	var testLabelTopConstraint: NSLayoutConstraint
	
	lazy var animator = coordinator.getAnimator()
	
	let coordinator: Coordinator
	
	let textField: MessageTextField
	
	private lazy var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
	
	var models = MessageStruct(result: [])
	
	// MARK: Views
	let testTaskLabel: UILabel = {
		let label = UILabel()
		label.text = "⭐️ Тестовое Задание ⭐️"
		label.textColor = .black
		label.font = label.font.withSize(20)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy var lightModeSwitch: UISwitch = {
		let switcher = UISwitch()
		switcher.isOn = false
		switcher.addTarget(self, action: #selector(switcherTapped), for: .valueChanged)
		switcher.translatesAutoresizingMaskIntoConstraints = false
		return switcher
	}()
	
	lazy var tableView = coordinator.getTableView(frame: view.frame, style: .plain)
	
	init(coordinator: Coordinator) {
		self.coordinator = coordinator
		textField = coordinator.getTextField()
		testLabelTopConstraint = NSLayoutConstraint()
		textFieldBottomConstraint = NSLayoutConstraint()
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
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.isHidden = true
	}
	
	private func setupViewController() {
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
			DispatchQueue.main.async {
				self.tableView.footerView.isHidden = false
			}
			switch result {
			case .success(let data):
				/// Если приходит пустой Result значит мы дошли до конца и дальше не надо парсить
				if data.result.isEmpty { debugPrint("END OF FETCH LIST"); return }
				DispatchQueue.main.async {
					self.tableView.footerView.isHidden = true
					self.models.result.append(contentsOf: data.result)
					self.tableView.reloadSections(IndexSet(integersIn: 0...0), with: .fade)
				}
			case .failure(_):
				/// В случае failure вызывать функцию повторно
				self.fetchData()
			}
		}
		
	}
	
	// MARK: Private Methods
	private func setupBinding() {
		title = "Тестовое Задание"
		view.backgroundColor = .white
		textField.delegate = self
		tableView.delegate = self
		tableView.dataSource = self
	}
	
	private func addSubviews() {
		view.addSubview(lightModeSwitch)
		view.addSubview(testTaskLabel)
		view.addSubview(textField)
		view.addSubview(tableView)
		
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
		/// Обзервер для удаления элемента из массива
		NotificationCenter.default.addObserver(self,
											   selector: #selector(deleteCellFromModels),
											   name: .deleteCell,
											   object: nil)
	}
	
	private func removeObservers() {
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	@objc private func deleteCellFromModels(_ notification: Notification) {
		if let id = notification.userInfo?[Constants.deleteCell.rawValue] as? Int {
			print("Received id: \(id)")
			models.result.remove(at: id)
			tableView.reloadSections(IndexSet(0...0), with: .automatic)
		}
	}
	
	@objc private func switcherTapped(_ sender: UISwitch) {
		if sender.isOn {
			UIView.animate(withDuration: 0.5) { [weak self] in
				self?.tableView.backgroundColor = .black
				self?.testTaskLabel.textColor = .white
				self?.view.backgroundColor = .black
				self?.textField.textColor = .black
				self?.tableView.reloadData()
			}
			UserDefaults.standard.set(true, forKey: Constants.switcher.rawValue)
		} else {
			UIView.animate(withDuration: 0.5) { [weak self] in
				self?.testTaskLabel.textColor = .black
				self?.tableView.backgroundColor = .white
				self?.view.backgroundColor = .white
				self?.textField.textColor = .white
				self?.tableView.reloadData()
			}
			UserDefaults.standard.set(false, forKey: Constants.switcher.rawValue)
		}
		UserDefaults.standard.synchronize()
	}
	
	@objc private func hideKeyboard() {
		view.endEditing(true)
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
			
			tableView.reloadData()
		}
		textField.text = nil
		return true
	}
}


