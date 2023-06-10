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
		  
		  // Деактивация constraint перед обновлением
		  textFieldBottomConstraint.isActive = false
//		  tableViewBottomConstraint.isActive = false

		  // Обновление constraint
		  textFieldBottomConstraint = textField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -keyboardHeight-20)
//		  tableViewBottomConstraint = tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10)

		  // Активация обновленных constraint
		  NSLayoutConstraint.activate([
			 textFieldBottomConstraint
//			 tableViewBottomConstraint,
		  ])

		  // Анимация обновления layout
		  UIView.animate(withDuration: 0.3) {
			 self.view.layoutIfNeeded()
		  }
	   }

	   @objc func keyboardWillHide(_ notification: Notification) {
		   
		  // Деактивация constraint перед обновлением
		  textFieldBottomConstraint.isActive = false
//		  tableViewBottomConstraint.isActive = false

		  // Обновление constraint
		  textFieldBottomConstraint = textField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
//		  tableViewBottomConstraint = tableView.topAnchor.constraint(equalTo: testTaskLabel.bottomAnchor)

		  // Активация обновленных constraint
		  NSLayoutConstraint.activate([
			 textFieldBottomConstraint,
//			 tableViewBottomConstraint,
		  ])

		  // Анимация обновления layout
		  UIView.animate(withDuration: 0.3) {
			 self.view.layoutIfNeeded()
		  }
	   }



	
}
