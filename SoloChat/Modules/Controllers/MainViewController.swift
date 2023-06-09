//
//  ViewController.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit

// MARK: ViewController 
final class MainViewController: UIViewController {

	// MARK: Private Properties
	
	private let coordinator: Coordinator
	
	private let textField: UITextField
	
	private lazy var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
	
	private let testTaskLabel: UILabel = {
		let label = UILabel()
		label.text = "Тестовое Задание"
		label.textColor = .black
		label.tintColor = .black
		label.font = label.font.withSize(22)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private lazy var debugDeleteButton: UIButton = {
		let button = UIButton(frame: CGRect(x: 20, y: 30, width: 50, height: 50))
		button.layer.cornerRadius = 20
		button.addTarget(self, action: #selector(debugButtonDeleteAll), for: .touchUpInside)
		button.setTitle("DEL", for: .normal)
		button.backgroundColor = .red
		return button
	}()
	
	private lazy var tableView = coordinator.getTableView(frame: view.frame, style: .plain)
	
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
	// MARK: Private Methods
	private func setupBinding() {
		navigationController?.navigationBar.isHidden = true
		
		title = "Тестовое Задание"
		view.backgroundColor = .white
		textField.delegate = self
	}
	
	private func addSubviews() {
		view.addSubview(debugDeleteButton)
		view.addSubview(testTaskLabel)
		view.addSubview(textField)
		view.addSubview(tableView)
		// При нажатии на любую часть экрана TextField скрывается
		tapGestureRecognizer.cancelsTouchesInView = false
		view.addGestureRecognizer(tapGestureRecognizer)
		
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			testTaskLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			testTaskLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
		
		NSLayoutConstraint.activate([
			textField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
			textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			textField.heightAnchor.constraint(equalToConstant: 50)
		])
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: testTaskLabel.bottomAnchor),
			tableView.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -10),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
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
			view.frame.origin.y -= keyboardHeight
			print(view.frame.origin.y, keyboardHeight)
		}
	}
	
	@objc private func keyboardWillHide() {
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
			RealmHelper.pushToRealm(message: text, time: "\(hours):\(minutes)")
			tableView.reloadData()
		}
		textField.text = nil
		return true
	}
}
