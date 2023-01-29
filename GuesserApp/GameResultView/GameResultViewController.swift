//
//  GameResultViewController.swift
//  GuesserApp
//
//  Created by Вадим on 28.01.2023.
//

import UIKit

final class GameResultViewController: UIViewController {
    let compScore: Int
    let userScore: Int
    
    override func loadView() {
        self.view = GameResultView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().delegate = self
        setCount()
        setStatusGame()
    }
    
    fileprivate func view() -> GameResultView {
        return self.view as! GameResultView
    }
    
    init(compScore: Int, userScore: Int) {
        self.compScore = compScore
        self.userScore = userScore
        super.init(nibName: nil, bundle: nil)
    }
    
    private func setCount() {
        view().userTryLabel.text = "Your's tries count: \(userScore)"
        view().compTryLabel.text = "Computers's tries count: \(compScore)"
    }
    
    private func setStatusGame() {
        if userScore < compScore {
            view().gameStatusLabel.text = Constants.gameStatus.win
        } else if userScore > compScore {
            view().gameStatusLabel.text = Constants.gameStatus.lose
        } else {
            view().gameStatusLabel.text = Constants.gameStatus.draw
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension GameResultViewController: GameResultViewControllerDelegate {
    func buttonAction() {
        self.view.window?.rootViewController = UINavigationController(rootViewController: StartGameViewController())
    }
}
