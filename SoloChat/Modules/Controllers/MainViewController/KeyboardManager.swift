//
//  KeyboardManage.swift
//  SoloChat
//
//  Created by Даниил Назаров on 10.06.2023.
//

import UIKit

extension MainViewController {
	
		@objc func keyboardWillShow(_ notification: Notification) {
			guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
			let keyboardHeight = keyboardFrame.height
			  
			textFieldBottomConstraint.isActive = false

			textFieldBottomConstraint =
			textField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -keyboardHeight - 10)

			NSLayoutConstraint.activate([
			 textFieldBottomConstraint
			])

			UIView.animate(withDuration: 0.3) {
			 self.view.layoutIfNeeded()
			}
		}

		@objc func keyboardWillHide(_ notification: Notification) {
		  textFieldBottomConstraint.isActive = false
		  textFieldBottomConstraint = textField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
		  NSLayoutConstraint.activate([
			 textFieldBottomConstraint
		  ])

		  // Анимация обновления layout
		  UIView.animate(withDuration: 0.3) {
			 self.view.layoutIfNeeded()
		  }
		}



	
}
