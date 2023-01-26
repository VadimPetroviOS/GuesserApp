//
//  StratGameView.swift
//  Guesser
//
//  Created by Вадим on 25.01.2023.
//

import UIKit

protocol StartGameViewControllerDelegate: AnyObject {
    func buttonAction()
}

final class StartGameView: UIView {
    
    weak var delegate: StartGameViewControllerDelegate?
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My Awesome Game"
        return label
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start New Game", for: .normal)
        button.setTitle("", for: .highlighted)
        button.layer.cornerRadius = Constants.Button.radius
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setSubviews()
        setConstraints()
    }
    
    private func setSubviews() {
        self.addSubview(welcomeLabel)
        self.addSubview(startButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: StartGameViewConstants.labelInsets),
            welcomeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            startButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -StartGameViewConstants.buttonInsets),
            startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: Constants.Button.weight),
            startButton.heightAnchor.constraint(equalToConstant: Constants.Button.height),
        ])
    }
    
    @objc func buttonPressed() {
        delegate?.buttonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private struct StartGameViewConstants {
    static let labelInsets: CGFloat = 100
    static let buttonInsets: CGFloat = 50
}
