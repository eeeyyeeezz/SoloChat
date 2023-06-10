//
//  MessageTableView.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit

final class MessageTableView: UITableView {
	
	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		backgroundColor = .white
		transform = CGAffineTransformMakeScale(1, -1)
//		transform = CGAffineTransform(rotationAngle: -(CGFloat)(Double.pi))
		contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
		separatorStyle = UITableViewCell.SeparatorStyle.none
		register(MessageCell.self, forCellReuseIdentifier: MessageCell.identifier)
		translatesAutoresizingMaskIntoConstraints = false
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}
