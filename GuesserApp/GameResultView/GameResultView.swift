//
//  GameResultView.swift
//  GuesserApp
//
//  Created by Вадим on 28.01.2023.
//

import UIKit

protocol GameResultViewControllerDelegate: AnyObject {
    func buttonAction()
}

final class GameResultView: UIView {
    
    weak var delegate: GameResultViewControllerDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Scores:"
        return label
    }()
    
    let userTryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Scores:"
        return label
    }()
    
    let compTryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Scores:"
        return label
    }()
    
    let gameStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Scores:"
        return label
    }()
    
    private let startNewGameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.Button.radius
        button.backgroundColor = .systemBlue
        button.setTitle("Main menu", for: .normal)
        button.setTitle("", for: .highlighted)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setConstraints()
    }
    
    private func setConstraints() {
        [titleLabel, userTryLabel, compTryLabel, gameStatusLabel, startNewGameButton].forEach {addSubview($0)}
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: GameResultViewConstants.insets),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            userTryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: GameResultViewConstants.indent),
            userTryLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -GameResultViewConstants.insets*3),
            compTryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: GameResultViewConstants.indent),
            compTryLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -GameResultViewConstants.insets),
            startNewGameButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: -GameResultViewConstants.insets),
            startNewGameButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            startNewGameButton.widthAnchor.constraint(equalToConstant: Constants.Button.weight),
            startNewGameButton.heightAnchor.constraint(equalToConstant: Constants.Button.height),
            gameStatusLabel.bottomAnchor.constraint(equalTo: startNewGameButton.topAnchor, constant: -GameResultViewConstants.insets*3),
            gameStatusLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func buttonPressed() {
        delegate?.buttonAction()
    }
    
}

private struct GameResultViewConstants {
    static let insets: CGFloat = 20
    static let indent: CGFloat = 20
}
