//
//  Constraints.swift
//  SoloChat
//
//  Created by Даниил Назаров on 10.06.2023.
//

import UIKit

extension MainViewController {
	
	func setupConstraints() {
//		NSLayoutConstraint.activate([
//			scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//		])
		
		NSLayoutConstraint.activate([
			testTaskLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			testTaskLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
		
		textFieldBottomConstraint = textField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
		NSLayoutConstraint.activate([
			textFieldBottomConstraint,
			textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			textField.heightAnchor.constraint(equalToConstant: 50)
		])
		
		tableViewBottomConstraint = tableView.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -10)
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: testTaskLabel.bottomAnchor),
			tableViewBottomConstraint,
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
}
