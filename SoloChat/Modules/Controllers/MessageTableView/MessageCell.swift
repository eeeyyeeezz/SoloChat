//
//  MessageCell.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit

final class MessageCell: UITableViewCell {

	static let identifier = "MessageCell"
	
	private lazy var activityIndicator = UIActivityIndicatorView(style: .large)
	
	private let cellImage: UIImageView = {
		let image = UIImageView()
		image.contentMode = .scaleAspectFill
		image.layer.masksToBounds = true
		image.transform = CGAffineTransform(scaleX: 1, y: -1)
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()
	
	let messageLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.tintColor = .black
		label.font = label.font.withSize(32)
		label.transform = CGAffineTransform(scaleX: 1, y: -1)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let timeLabel: UILabel = {
		let label = UILabel()
		label.text = "00:00"
		label.textColor = .black
		label.tintColor = .black
		label.font = label.font.withSize(15)
		label.transform = CGAffineTransform(scaleX: 1, y: -1)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: MessageCell.identifier)
		setupBinding()
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		cellImage.image = nil
		activityIndicator.startAnimating()
		loadImage()
	}
	
	private func setupBinding() {
		backgroundColor = .white
		activityIndicator.startAnimating()
		loadImage()
		addSubviews()
		setupConstraints()
	}
	
	private func loadImage() {
		ImageLoader.loadImageFromURL { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let image):
				DispatchQueue.main.async {
					self.cellImage.image = image
//					self.cellImage.layer.cornerRadius = self.cellImage.frame.size.width / 2
					self.cellImage.layer.cornerRadius = self.cellImage.frame.size.height / 2
					self.activityIndicator.stopAnimating()
				}
			case .failure(_):
				break ;
			}
		}
	}
	
	private func addSubviews() {
		addSubview(cellImage)
		cellImage.addSubview(activityIndicator)
		addSubview(messageLabel)
		addSubview(timeLabel)
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			cellImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
			cellImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
			cellImage.widthAnchor.constraint(equalToConstant: 100),
			cellImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
		])
		
		NSLayoutConstraint.activate([
			messageLabel.topAnchor.constraint(equalTo: topAnchor),
			messageLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 30),
			messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
			messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
		
		NSLayoutConstraint.activate([
			timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
			timeLabel.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -50)
		])
	}
	
	required init?(coder aDecoder: NSCoder) {
	   super.init(coder: aDecoder)
	}
	
}
