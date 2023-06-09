//
//  TextField.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit

final class MessageTextField: UITextField {
	
	init() {
		super.init(frame: .zero)
		setupTextField(placeholder: "Write Your Message")
	}
	
	private func setupTextField(placeholder: String) {
		translatesAutoresizingMaskIntoConstraints = false
		textColor = .white
		layer.cornerRadius = 10
		layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowRadius = 10
		layer.shadowOpacity = 0.3
		layer.shadowOffset = CGSize(width: 20, height: 15)
		
		attributedPlaceholder = NSAttributedString(string: placeholder,
												   attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
		font = .boldSystemFont(ofSize: 18)
		clearButtonMode = .whileEditing
		returnKeyType = UIReturnKeyType.done
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

