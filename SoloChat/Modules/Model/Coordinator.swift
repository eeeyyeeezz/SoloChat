//
//  Coordinator.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit

protocol Coordinator {
	func getTextField() -> UITextField
	func getMainViewController() -> UIViewController
	func getTableView(frame: CGRect, style: UITableView.Style) -> UITableView
}

class MainCoordinator: Coordinator {
	
	func getTextField() -> UITextField {
		let textField = MessageTextField()
		return textField
	}
	
	func getMainViewController() -> UIViewController {
		let mainViewController = MainViewController(coordinator: self)
		return mainViewController
	}
	
	func getTableView(frame: CGRect, style: UITableView.Style) -> UITableView {
		let tableView = MessageTableView(frame: frame, style: style)
		return tableView
	}
	
}
