//
//  CompSolutionView.swift
//  GuesserApp
//
//  Created by Вадим on 26.01.2023.
//

import UIKit

protocol CompSolutionViewControllerDelegate: AnyObject {
    func lessButtonAction()
    func equalsButtonAction()
    func greaterButtonAction()
}

final class CompSolutionView: UIView {
    
    weak var delegate: CompSolutionViewControllerDelegate?
    
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
        label.text = "Computer is guessing"
        return label
    }()
    
    var computerNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let myNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My number is ..."
        return label
    }()
    
    let lessButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.gray.cgColor
        button.setTitle("<", for: .normal)
        button.setTitle("", for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(lessPressed), for: .touchUpInside)
        return button
    }()
    
    let equalsButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.gray.cgColor
        button.setTitle("=", for: .normal)
        button.setTitle("", for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(equalsPressed), for: .touchUpInside)
        return button
    }()
    
    let greaterButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.gray.cgColor
        button.setTitle(">", for: .normal)
        button.setTitle("", for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(greaterPressed), for: .touchUpInside)
        return button
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setConstraints()
    }
    
    private func setConstraints() {
        let stack = createStackView()
        let buttonStack = createButtonStackView()
        [stack, tryCounterLabel, computerGuessLabel, computerNumberLabel, myNumberLabel, buttonStack, errorLabel].forEach {addSubview($0)}
        
        NSLayoutConstraint.activate([
            
            stack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            computerGuessLabel.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor, constant: -CompSolutionViewConstants.buttonInsets),
            computerGuessLabel.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor),
            tryCounterLabel.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor),
            tryCounterLabel.bottomAnchor.constraint(equalTo: computerGuessLabel.topAnchor,constant: -CompSolutionViewConstants.buttonInsets),
            
            computerNumberLabel.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor),
            computerNumberLabel.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor),
            buttonStack.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor),
            buttonStack.centerYAnchor.constraint(equalTo: bottomContainerView.centerYAnchor),
            myNumberLabel.bottomAnchor.constraint(equalTo: buttonStack.topAnchor, constant: -CompSolutionViewConstants.buttonInsets),
            myNumberLabel.leadingAnchor.constraint(equalTo: buttonStack.leadingAnchor),
            
            lessButton.widthAnchor.constraint(equalToConstant: CompSolutionViewConstants.buttonWidth),
            lessButton.heightAnchor.constraint(equalToConstant: CompSolutionViewConstants.buttonHeight),
            equalsButton.widthAnchor.constraint(equalToConstant: CompSolutionViewConstants.buttonWidth),
            equalsButton.heightAnchor.constraint(equalToConstant: CompSolutionViewConstants.buttonHeight),
            greaterButton.widthAnchor.constraint(equalToConstant: CompSolutionViewConstants.buttonWidth),
            greaterButton.heightAnchor.constraint(equalToConstant: CompSolutionViewConstants.buttonHeight),
            
            errorLabel.topAnchor.constraint(equalTo: myNumberLabel.bottomAnchor, constant: -CompSolutionViewConstants.errorInsets),
            errorLabel.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor)
        ])
    }
    
    private func createStackView() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [topContainerView, middleContainerView, bottomContainerView])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    private func createButtonStackView() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [lessButton, equalsButton, greaterButton])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    @objc func lessPressed() {
        delegate?.lessButtonAction()
    }
    
    @objc func equalsPressed() {
        delegate?.equalsButtonAction()
    }
    
    @objc func greaterPressed() {
        delegate?.greaterButtonAction()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private struct CompSolutionViewConstants {
    static let buttonInsets: CGFloat = 20
    static let buttonWidth: CGFloat = 60
    static let buttonHeight: CGFloat = 60
    static let errorInsets: CGFloat = 60
}
