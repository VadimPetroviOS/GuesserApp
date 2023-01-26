//
//  StartGameViewController.swift
//  Guesser
//
//  Created by Вадим on 25.01.2023.
//

import UIKit

final class StartGameViewController: UIViewController {
    
    override func loadView() {
        self.view = StartGameView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().delegate = self
    }
    
    fileprivate func view() -> StartGameView {
        return self.view as! StartGameView
    }
}

extension StartGameViewController: StartGameViewControllerDelegate {
    func buttonAction() {
        self.view.window?.rootViewController = UINavigationController(rootViewController: MysteryViewController())
    }
}

