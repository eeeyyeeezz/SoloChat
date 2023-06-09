//
//  MessageTableView.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit

final class MessageTableView: UITableView {
	
	let animation = AnimationFactory.makeFadeAnimation(duration: 0.5, delayFactor: 0.05)
	lazy var animator = Animator(animation: animation)
	
	var messages = [String]()
	
	override init(frame: CGRect, style: UITableView.Style) {
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
		// TIME
		let today = Date()
		let hours = (Calendar.current.component(.hour, from: today))
		let minutes = (Calendar.current.component(.minute, from: today))
		cell.timeLabel.text = "\(hours):\(minutes)"
		
		animator.animate(cell: cell, at: indexPath, in: tableView)
		
		return cell
	}
	
	
}
