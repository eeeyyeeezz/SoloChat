//
//  Constraints.swift
//  SoloChat
//
//  Created by Даниил Назаров on 10.06.2023.
//

import UIKit

extension MainViewController {
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		
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
}
