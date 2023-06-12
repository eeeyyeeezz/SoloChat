//
//  CellViewController.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit

/// Контроллер появляющийся при нажатии на ячейку
class CellViewController: UIViewController {
	
	private let cellID: Int
	
	private let message: String
	
	private let image: UIImageView = {
		let image = UIImageView(image: UIImage(systemName: "faceid"))
		image.tintColor = .black
		image.clipsToBounds = true
		image.contentMode = .scaleAspectFill
		image.layer.cornerRadius = 30
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()
	
	private lazy var messageLabel: UILabel = {
		let label = UILabel()
		label.text = message
		label.numberOfLines = 0
		label.textColor = .black
		label.font = label.font.withSize(30)
		label.adjustsFontSizeToFitWidth = true
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
	
	init(cellID: Int, message: String) {
		self.cellID = cellID
		self.message = message
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
		
		/// Настройка согласна цветовой теме
		let lightMode = UserDefaults.standard.bool(forKey: Constants.switcher.rawValue)
		navigationController?.navigationBar.tintColor = lightMode ? .white : .black
		view.backgroundColor = lightMode ? .black : .white
		messageLabel.textColor = lightMode ? .white : .black
		timeLabel.textColor = lightMode ? .white : .black
		
		/// Выставление текущего времени
		/// Можно приколоться и выставлять согласно каждой ячейки
		/// Но я не хочу
		let formatter = DateFormatter()
		formatter.timeStyle = .short
		let time = formatter.string(from: Date.now)
		timeLabel.text = time
		
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
			image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			image.heightAnchor.constraint(equalToConstant: 300),
			image.widthAnchor.constraint(equalToConstant: 300)
		])
		
		NSLayoutConstraint.activate([
			timeLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 25),
			timeLabel.leadingAnchor.constraint(equalTo: image.leadingAnchor),
			timeLabel.heightAnchor.constraint(equalToConstant: 50)
		])
		
		NSLayoutConstraint.activate([
			messageLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 20),
			messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
			messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
			messageLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
		])
	}
	
	/// Можно приколоться и передавать в init также имейдж, но это в случае реализации нескольких аватарок 💀
	private func loadImage() {
		NetworkManager.loadImageFromURL { [weak self] result in
			switch result {
			case .success(let image):
				/// Нужно выставить альфу в 0 в том случае что если нет интернета чтобы показывалось стоковое изображение
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
		/// Передача ID для удаления модели в MainViewController
		let userInfo = [Constants.deleteCell.rawValue: cellID]
		debugPrint(userInfo)
		NotificationCenter.default.post(name: .deleteCell, object: nil, userInfo: userInfo)
		navigationController?.popViewController(animated: true)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
