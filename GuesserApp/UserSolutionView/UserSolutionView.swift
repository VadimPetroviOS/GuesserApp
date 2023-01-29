//
//  UserSolutionView.swift
//  GuesserApp
//
//  Created by Вадим on 28.01.2023.
//

import UIKit

protocol UserSolutionViewControllerDelegate: AnyObject {
    func buttonAction()
}

final class UserSolutionView: UIView {
    
    weak var delegate: UserSolutionViewControllerDelegate?
    
    private let topContainerView : UIView = {
        let view = UIView()
        return view
    }()
    
    private let middleContainerView : UIView = {
        let view = UIView()
        return view
    }()
    
    private let bottomContainerView : UIView = {
        let view = UIView()
        return view
    }()
    
    let tryCounterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Try № 1"
        return label
    }()
    
    private let computerGuessLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Are you guessing"
        return label
    }()
    
    let numberGuessTV: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        textView.font = UIFont.systemFont(ofSize: 19)
        textView.textAlignment = .center
        textView.layer.borderWidth = 0.25
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.cornerRadius = 5
        return textView
    }()
    
    private let guessButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.Button.radius
        button.backgroundColor = .systemBlue
        button.setTitle("Guess", for: .normal)
        button.setTitle("", for: .highlighted)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    let answerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please enter number [1:100]"
        label.textColor = .systemRed
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setConstraints()
    }
    
    private func setConstraints() {
        let stack = createStackView()
        [stack, tryCounterLabel, computerGuessLabel, numberGuessTV, guessButton, answerLabel, errorLabel].forEach {addSubview($0)}
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            tryCounterLabel.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor),
            tryCounterLabel.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor, constant: -UserSolutionViewConstants.insets),
            computerGuessLabel.topAnchor.constraint(equalTo: tryCounterLabel.topAnchor, constant: UserSolutionViewConstants.insets*2),
            computerGuessLabel.centerXAnchor.constraint(equalTo: tryCounterLabel.centerXAnchor),
            
            numberGuessTV.topAnchor.constraint(equalTo: middleContainerView.topAnchor, constant: UserSolutionViewConstants.insets/2),
            numberGuessTV.centerXAnchor.constraint(equalTo: middleContainerView.centerXAnchor),
            numberGuessTV.widthAnchor.constraint(equalToConstant: Constants.Button.weight),
            numberGuessTV.heightAnchor.constraint(equalToConstant: UserSolutionViewConstants.textViewHeight),
             
            guessButton.bottomAnchor.constraint(equalTo: middleContainerView.bottomAnchor,constant: -UserSolutionViewConstants.insets/2),
            guessButton.centerXAnchor.constraint(equalTo: middleContainerView.centerXAnchor),
            guessButton.widthAnchor.constraint(equalToConstant: Constants.Button.weight),
            guessButton.heightAnchor.constraint(equalToConstant: Constants.Button.height),
            
            answerLabel.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: UserSolutionViewConstants.insets),
            answerLabel.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor),
            // nenen
            errorLabel.topAnchor.constraint(equalTo: numberGuessTV.bottomAnchor, constant: UserSolutionViewConstants.insets),
            errorLabel.centerXAnchor.constraint(equalTo: numberGuessTV.centerXAnchor)
        ])
    }
    
    private func createStackView() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [topContainerView, middleContainerView, bottomContainerView])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    @objc func buttonPressed() {
        delegate?.buttonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private struct UserSolutionViewConstants {
    static let insets: CGFloat = 20
    static let textViewHeight: CGFloat = 35
}

