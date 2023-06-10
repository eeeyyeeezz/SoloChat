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
//		RealmHelper.getAllRealmObjects().count
		models.result.count
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { view.frame.height / 6.5 }
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		debugPrint("DIDSELECT", indexPath.row)
	}

	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.identifier) as! MessageCell
//		let message = RealmHelper.getRealmObject(by: indexPath.row, messageEnum: .message)
//		let time = RealmHelper.getRealmObject(by: indexPath.row, messageEnum: .time)
//		cell.messageLabel.text = message as? String
//		cell.timeLabel.text = time as? String
		
		/// Начинать подгрузку следующего списка в случае если находимся в конце списка
		if indexPath.row == models.result.count - 1 {
			debugPrint("FETCH DATA \(indexPath.row) \(models.result.count)")
			fetchData()
		}
		
		let message = models.result[indexPath.row]
		let time = "12:34"
		cell.messageLabel.text = "\(indexPath.row): " + message
		cell.timeLabel.text = time
		
		
		animator.animate(cell: cell, at: indexPath, in: tableView)
		return cell
	}
	
	
}
