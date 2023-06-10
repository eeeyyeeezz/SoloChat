//
//  Coordinator.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit

protocol Coordinator {
	func getAnimator() -> Animator
	func getTextField() -> UITextField
	func getMainViewController() -> UIViewController
	func getTableView(frame: CGRect, style: UITableView.Style) -> MessageTableView
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
	
	func getTableView(frame: CGRect, style: UITableView.Style) -> MessageTableView {
		let tableView = MessageTableView(frame: frame, style: style)
		return tableView
	}
	
	func getAnimator() -> Animator {
		let animation = AnimationFactory.makeFadeAnimation(duration: 0.5, delayFactor: 0.05)
		let animator = Animator(animation: animation)
		return animator
	}
	
}
