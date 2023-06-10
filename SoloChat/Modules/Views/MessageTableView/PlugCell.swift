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
		let label = UILabel()
		label.center = center
		label.text = "No models"
		label.numberOfLines = 0
		label.textColor = .black
		label.font = label.font.withSize(45)
		label.adjustsFontSizeToFitWidth = true
		label.transform = CGAffineTransform(scaleX: 1, y: -1)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private lazy var plugImage: UIImageView = {
		let image = UIImageView(image: UIImage(systemName: "faceid"))
		image.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
		image.tintColor = .black
		image.center = center
		image.transform = CGAffineTransform(scaleX: 1, y: -1)
		return image
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		selectionStyle = .none
		backgroundColor = .white
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		addSubview(plugImage)
		addSubview(plugLabel)
		
		NSLayoutConstraint.activate([
			plugLabel.topAnchor.constraint(equalTo: plugImage.topAnchor, constant: -50),
			plugLabel.leadingAnchor.constraint(equalTo: plugImage.leadingAnchor),
			plugLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
