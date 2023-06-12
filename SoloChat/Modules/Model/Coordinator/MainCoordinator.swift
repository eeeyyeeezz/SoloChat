//
//  Coordinator.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit

class MainCoordinator: Coordinator {
	
	func getTextField() -> MessageTextField {
		let textField = MessageTextField()
		return textField
	}
	
	func getMainViewController() -> MainViewController {
		let mainViewController = MainViewController(coordinator: self)
		return mainViewController
	}
	
	func getCellViewController(_ cellID: Int, _ message: String) -> CellViewController {
		let cellViewController = CellViewController(cellID: cellID, message: message)
		return cellViewController
	}
	
	func getTableView(frame: CGRect, style: UITableView.Style) -> MessageTableView {
		let tableView = MessageTableView(frame: frame, style: style)
		return tableView
	}
	
	func getAnimator() -> Animator {
		let animation = AnimationFactory.makeFadeAnimation(duration: 0.5, delayFactor: 0.1)
		let animator = Animator(animation: animation)
		return animator
	}
	
	
}
