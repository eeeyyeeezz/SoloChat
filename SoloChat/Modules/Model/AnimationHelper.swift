//
//  AnimationHelper.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit

typealias Animation = (UITableViewCell, IndexPath, UITableView) -> Void

final class Animator {
	
	// Проверяем анимированна ли ячейка
	private var isAnimated = [Int]()
	private let animation: Animation
	
	init(animation: @escaping Animation) {
		self.animation = animation
	}
	
	func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
//		if !isAnimated.contains(indexPath.row) {
//			print(indexPath.row, isAnimated.count)
//			animation(cell, indexPath, tableView)
//		}
//		isAnimated.append(indexPath.row)
		
		/// Анимация только 0'ой ячейки
		if indexPath.row == 0 {
			animation(cell, indexPath, tableView)
		}
	}
	
}

enum AnimationFactory {

	static func makeFadeAnimation(duration: TimeInterval, delayFactor: Double) -> Animation {
		return { cell, indexPath, _ in
			cell.alpha = 0

			UIView.animate(
				withDuration: duration,
				delay: delayFactor * Double(indexPath.row),
				animations: {
					cell.alpha = 1
			})
		}
	}
	
	static func makeSlideIn(duration: TimeInterval, delayFactor: Double) -> Animation {
		return { cell, indexPath, tableView in
			cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)

			UIView.animate(
				withDuration: duration,
				delay: delayFactor * Double(indexPath.row),
				options: [.curveEaseInOut],
				animations: {
					cell.transform = CGAffineTransform(translationX: 0, y: 0)
			})
		}
	}

	
	
}

