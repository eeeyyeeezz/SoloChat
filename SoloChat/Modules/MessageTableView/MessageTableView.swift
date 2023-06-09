//
//  MessageTableView.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit

final class MessageTableView: UITableView {
	
	var messages = [String]()
	
	// private let realm: Realm
	
	override init(frame: CGRect, style: UITableView.Style) {
		// realm = try! Realm()
		super.init(frame: frame, style: style)
		delegate = self
		dataSource = self
		backgroundColor = .white
		transform = CGAffineTransformMakeScale(1, -1)
		separatorStyle = UITableViewCell.SeparatorStyle.none
		register(MessageCell.self, forCellReuseIdentifier: MessageCell.identifier)
		translatesAutoresizingMaskIntoConstraints = false
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}

extension MessageTableView: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { messages.count }
	
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { frame.height / 6.5 }
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.identifier) as! MessageCell
		cell.messageLabel.text = "\(indexPath.row): \(messages[indexPath.row])"
		return cell
	}
	
}
