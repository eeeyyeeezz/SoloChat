//
//  MessageCell.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit

final class MessageCell: UITableViewCell {

	@IBOutlet weak var cellImage: UIView!
	
	@IBOutlet weak var messageLabel: UILabel!
	
	@IBOutlet weak var timeLabel: UILabel!
	
	static let identifier = "MessageCell"

	init() {
		super.init(style: .default, reuseIdentifier: MessageCell.identifier)
	}
	
	required init?(coder aDecoder: NSCoder) {
	   super.init(coder: aDecoder)
	}
	
//	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//		super.init(style: style, reuseIdentifier: reuseIdentifier)
//		selectionStyle = .none
//		backgroundColor = .white
//	}
//	
//	required init?(coder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}

}
