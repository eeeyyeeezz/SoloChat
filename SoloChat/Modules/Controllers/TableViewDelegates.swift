//
//  TableViewDelegates.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit


// MARK: Делегаты/ДатаСурс тейблвью
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		/// Если models пустой, то показать одну ячейку для заглушки PlugCell
		models.result.count == 0 ? 1 : models.result.count
	}
	
	/// Если показывать заглушку, то размер должен быть на весь экран
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		models.result.isEmpty ? view.frame.height : view.frame.height / 6.5
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		debugPrint("DIDSELECT", indexPath.row)
	}

	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if models.result.isEmpty {
			let cell = tableView.dequeueReusableCell(withIdentifier: PlugCell.identifier) as! PlugCell
			return cell
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.identifier) as! MessageCell
			/// Начинать подгрузку следующего списка в случае если находимся в конце списка
			if indexPath.row == models.result.count - 1 {
				debugPrint("FETCH DATA \(indexPath.row) \(models.result.count)")
				fetchData()
			}
			
			let message = models.result[indexPath.row]
			let time = "12:34"
			cell.messageLabel.text = "\(indexPath.row): " + message
			cell.timeLabel.text = time
			
			/// Анимирование ячейки
			animator.animate(cell: cell, at: indexPath, in: tableView)
			return cell
		}
		
	}
	
	
}
