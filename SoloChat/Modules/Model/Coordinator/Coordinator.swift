//
//  Coordinator.swift
//  SoloChat
//
//  Created by Даниил Назаров on 12.06.2023.
//

import UIKit

protocol Coordinator {
	func getAnimator() -> Animator
	func getTextField() -> MessageTextField
	func getMainViewController() -> MainViewController
	func getCellViewController(_ cellID: Int, _ message: String) -> CellViewController
	func getTableView(frame: CGRect, style: UITableView.Style) -> MessageTableView
}
