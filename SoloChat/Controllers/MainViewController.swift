//
//  ViewController.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit

// MARK: ViewController 
final class MainViewController: UIViewController {

	private let textField: MessageTextField
	
	init() {
		textField = MessageTextField()
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
		title = "Тестовое Задание"
		textField.delegate = self
		view.backgroundColor = .white
	}
	
	private func addSubviews() {
		view.addSubview(textField)
		// При нажатии на любую часть экрана TextField скрывается
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			textField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
			textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			textField.heightAnchor.constraint(equalToConstant: 60)
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
		}
	}
	
	@objc private func keyboardWillHide() {
		view.frame.origin.y = 0
	}
}


extension MainViewController: UITextFieldDelegate {
	
	// Проверяем что написали в TextField
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if let text = textField.text {
			debugPrint(text)
		}
		textField.text = nil
//		textField.resignFirstResponder()
		return true
	}
}

