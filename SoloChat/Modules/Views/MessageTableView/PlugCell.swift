//
//  PlugCell.swift
//  SoloChat
//
//  Created by Даниил Назаров on 10.06.2023.
//

import UIKit

// Ячейка заглушка, появляется если models пустой
class PlugCell: UITableViewCell {

	static let identifier = "PlugCell"

	private lazy var plugLabel: UILabel = {
		let label = UILabel(frame: CGRect(x: 50, y: 0, width: 250, height: 100))
		label.center = center
		label.text = "No models"
		label.numberOfLines = 0
		label.textColor = .black
		label.font = label.font.withSize(45)
		label.adjustsFontSizeToFitWidth = true
		label.transform = CGAffineTransform(scaleX: 1, y: -1)
		return label
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		selectionStyle = .none
		backgroundColor = .white
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		addSubview(plugLabel)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
