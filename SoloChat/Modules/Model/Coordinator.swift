//
//  Coordinator.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit

protocol Coordinator {
	func getAnimator() -> Animator
	func getTextField() -> MessageTextField
	func getMainViewController() -> MainViewController
	func getCellViewController() -> CellViewController
	func getTableView(frame: CGRect, style: UITableView.Style) -> MessageTableView
}

class MainCoordinator: Coordinator {
	
	func getTextField() -> MessageTextField {
		let textField = MessageTextField()
		return textField
	}
	
	func getMainViewController() -> MainViewController {
		let mainViewController = MainViewController(coordinator: self)
		return mainViewController
	}
	
	func getCellViewController() -> CellViewController {
		let cellViewController = CellViewController()
		return cellViewController
	}
	
	func getTableView(frame: CGRect, style: UITableView.Style) -> MessageTableView {
		let tableView = MessageTableView(frame: frame, style: style)
		return tableView
	}
	
	func getAnimator() -> Animator {
		let animation = AnimationFactory.makeFadeAnimation(duration: 0.2, delayFactor: 0.1)
		let animator = Animator(animation: animation)
		return animator
	}
	
	
}
