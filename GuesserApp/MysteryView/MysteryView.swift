//
//  MysteryView.swift
//  GuesserApp
//
//  Created by Вадим on 25.01.2023.
//

import UIKit

protocol MysteryViewControllerDelegate: AnyObject {
    func buttonAction()
}

final class MysteryView: UIView {
    
    weak var delegate: MysteryViewControllerDelegate?
    
    let numberTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        textView.font = UIFont.systemFont(ofSize: 19)
        textView.textAlignment = .center
        textView.layer.borderWidth = 0.25
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.cornerRadius = 5
        textView.text = "Guess the number"
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    let enterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Enter the Number", for: .normal)
        button.setTitle("", for: .highlighted)
        button.layer.cornerRadius = Constants.Button.radius
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.alpha = 0.5
        button.isEnabled = false
        return button
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "enter number [1:100]"
        label.textColor = .systemRed
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setSubviews()
        setConstraints()
    }
    
    private func setSubviews() {
        self.addSubview(numberTextView)
        self.addSubview(enterButton)
        self.addSubview(errorLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            numberTextView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: MysteryViewConstants.textViewInsets),
            numberTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            numberTextView.widthAnchor.constraint(equalToConstant: Constants.Button.weight),
            numberTextView.heightAnchor.constraint(equalToConstant: MysteryViewConstants.textViewHeight),
            
            enterButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -MysteryViewConstants.buttonInsets),
            enterButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            enterButton.widthAnchor.constraint(equalToConstant: Constants.Button.weight),
            enterButton.heightAnchor.constraint(equalToConstant: Constants.Button.height),
            
            errorLabel.topAnchor.constraint(equalTo: numberTextView.bottomAnchor, constant: MysteryViewConstants.labelInsets),
            errorLabel.centerXAnchor.constraint(equalTo: numberTextView.centerXAnchor)
        ])
    }
    
    @objc func buttonPressed() {
        delegate?.buttonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private struct MysteryViewConstants {
    static let textViewInsets: CGFloat = 100
    static let buttonInsets: CGFloat = 50
    static let labelInsets: CGFloat = 50
    static let textViewHeight: CGFloat = 35
}
