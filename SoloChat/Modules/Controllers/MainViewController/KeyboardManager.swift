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
			  
			testLabelTopConstraint.isActive = false
			textFieldBottomConstraint.isActive = false

			testLabelTopConstraint =
			testTaskLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -keyboardHeight)
			
			textFieldBottomConstraint =
			textField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -keyboardHeight - 10)

			NSLayoutConstraint.activate([
			 textFieldBottomConstraint,
			 testLabelTopConstraint
			])

			UIView.animate(withDuration: 0.3) {
			 self.view.layoutIfNeeded()
			}
		}

	@objc func keyboardWillHide(_ notification: Notification) {
		testLabelTopConstraint.isActive = false
		textFieldBottomConstraint.isActive = false
		
		testLabelTopConstraint = testTaskLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
		textFieldBottomConstraint = textField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
		  NSLayoutConstraint.activate([
			testLabelTopConstraint,
			 textFieldBottomConstraint
		  ])

		  // Анимация обновления layout
		  UIView.animate(withDuration: 0.3) {
			 self.view.layoutIfNeeded()
		  }
	}



	
}
