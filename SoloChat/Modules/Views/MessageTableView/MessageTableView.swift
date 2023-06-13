//
//  MessageTableView.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit

final class MessageTableView: UITableView {
	
	lazy var footerView: UIView = {
		let view = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 40))
		let activityIndicator = UIActivityIndicatorView(style: .medium)
		activityIndicator.startAnimating()
		view.addSubview(activityIndicator)
		activityIndicator.center = view.center
		return view
	}()
	
	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		backgroundColor = .white
		transform = CGAffineTransformMakeScale(1, -1)
		contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
		separatorStyle = UITableViewCell.SeparatorStyle.none
		register(MessageCell.self, forCellReuseIdentifier: MessageCell.identifier)
		register(PlugCell.self, forCellReuseIdentifier: PlugCell.identifier)
		tableFooterView = footerView
		translatesAutoresizingMaskIntoConstraints = false
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}
