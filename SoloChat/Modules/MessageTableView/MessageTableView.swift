//
//  MessageTableView.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit

final class MessageTableView: UITableView {
	
	// private let realm: Realm
	
	override init(frame: CGRect, style: UITableView.Style) {
		// realm = try! Realm()
		super.init(frame: frame, style: style)
		delegate = self
		dataSource = self
		backgroundColor = .white
		transform = CGAffineTransform(scaleX: 1, y: -1)
		separatorStyle = UITableViewCell.SeparatorStyle.none
		register(MessageCell.self, forCellReuseIdentifier: MessageCell.identifier)
		translatesAutoresizingMaskIntoConstraints = false
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}

extension MessageTableView: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 10 }
	
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { frame.height / 6.5 }
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.identifier) as! MessageCell
		cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
		cell.backgroundColor = (indexPath.row % 2 == 0) ? #colorLiteral(red: 0.1169841662, green: 0.09732844681, blue: 0.08903429657, alpha: 1).withAlphaComponent(0.3) : .none
		return cell
	}
	
}
