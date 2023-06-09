//
//  TextField.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit

final class MessageTextField: UITextField {
	
	init(placeholder: String) {
		super.init(frame: .zero)
		translatesAutoresizingMaskIntoConstraints = false
		setupTextField(placeholder: placeholder)
	}
	
	private func setupTextField(placeholder: String) {
		textColor = .white
		layer.cornerRadius = 10
		layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowRadius = 7
		layer.shadowOpacity = 0.4
		layer.shadowOffset = CGSize(width: 15, height: 15)
		
		attributedPlaceholder = NSAttributedString(string: placeholder,
												   attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemCyan])
		font = .boldSystemFont(ofSize: 18)
		
//		heightAnchor.constraint(equalToConstant: 60).isActive = true
		
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
