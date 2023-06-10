//
//  CellViewController.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit

class CellViewController: UIViewController {
	
	private let model: MessageStruct
	
	private let image: UIImageView = {
		let image = UIImageView(image: UIImage(systemName: "faceid"))
		image.tintColor = .black
		image.clipsToBounds = true
		image.contentMode = .scaleAspectFill
		image.layer.cornerRadius = 30
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()
	
	let messageLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.adjustsFontSizeToFitWidth = true
		label.font = label.font.withSize(20)
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let timeLabel: UILabel = {
		let label = UILabel()
		label.text = "TIME: 12:34"
		label.textColor = .black
		label.tintColor = .black
		label.font = label.font.withSize(35)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	init(model: MessageStruct) {
		self.model = model
		super.init(nibName: nil, bundle: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		setupBinding()
	}
	
	private func setupBinding() {
		navigationController?.navigationBar.isHidden = false
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete",
															style: .plain,
															target: self,
															action: #selector(deleteMessageCell))
		navigationItem.rightBarButtonItem?.tintColor = .red
		
		addSubviews()
		setupConstraints()
		loadImage()
	}
	
	private func addSubviews() {
		view.addSubview(image)
		view.addSubview(messageLabel)
		view.addSubview(timeLabel)
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
			image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			image.heightAnchor.constraint(equalToConstant: 300),
			image.widthAnchor.constraint(equalToConstant: 300)
		])
		
		NSLayoutConstraint.activate([
			timeLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 25),
			timeLabel.leadingAnchor.constraint(equalTo: image.leadingAnchor)
		])
		
		NSLayoutConstraint.activate([
			messageLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: -40),
			messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
			messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
		])
	}
	
	/// Можно приколоться и передавать в init также имейдж, но это в случае реализации нескольких аватарок 💀
	private func loadImage() {
		NetworkManager.loadImageFromURL { [weak self] result in
			switch result {
			case .success(let image):
				self?.image.alpha = 0
				UIView.animate(withDuration: 1) {
					self?.image.alpha = 1
					self?.image.image = image
				}
			case .failure(_):
				break;
			}
		}
	}
	
	@objc private func deleteMessageCell() {
		debugPrint("DELETE CELL")
		NotificationCenter.default.post(name: .deleteCell, object: nil)
		navigationController?.popViewController(animated: true)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
