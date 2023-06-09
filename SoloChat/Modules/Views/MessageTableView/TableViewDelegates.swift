//
//  TableViewDelegates.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit


// MARK: Делегаты/ДатаСурс тейблвью
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
	/// Если models пустой, то показать одну ячейку для заглушки PlugCell
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		debugPrint("NUMBERSOFROWSINSECTION", models.result.count)
		return models.result.count == 0 ? 1 : models.result.count
	}
	
	func numberOfSections(in tableView: UITableView) -> Int { 1 }
	
	/// Если показывать заглушку, то размер должен быть на весь экран
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		models.result.isEmpty ? view.frame.height : view.frame.height / 6.5
	}
	
	/// Переход на CellViewController
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		debugPrint("DIDSELECT", indexPath.row)
		/// Ограничение нужно в случае отсутствия интернета
		if !models.result.isEmpty {
			let vc = coordinator.getCellViewController(indexPath.row, models.result[indexPath.row])
			navigationController?.pushViewController(vc, animated: true)
		}
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
			/// Темная тема
			let lightMode = UserDefaults.standard.bool(forKey: Constants.switcher.rawValue)
			cell.backgroundColor = lightMode ? .black : .white
			cell.messageLabel.textColor = lightMode ? .white : .black
			cell.timeLabel.textColor = lightMode ? .white : .black

			/// Сообщение и время
			let message = models.result[indexPath.row]
			
			let formatter = DateFormatter()
			formatter.timeStyle = .short
			let time = formatter.string(from: Date.now)

			cell.messageLabel.text = "\(indexPath.row): " + message
			cell.timeLabel.text = time
			
			/// Анимирование 0й ячейки
			animator.animate(cell: cell, at: indexPath, in: tableView)
			return cell
		}
		
	}
	
	
}
