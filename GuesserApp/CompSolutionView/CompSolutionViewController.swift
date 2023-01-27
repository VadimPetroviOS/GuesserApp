//
//  CompSolutionViewController.swift
//  GuesserApp
//
//  Created by Вадим on 26.01.2023.
//

import UIKit

final class CompSolutionViewController: UIViewController {
    var userNumber: Int
    var compNumber = Int()
    var leftNumber = Constants.Value.leftNumber
    var rightNumber = Constants.Value.rightNumber
    var countError = Constants.Value.countError
    var tryCounter = Constants.Value.tryCounter
    
    override func loadView() {
        self.view = CompSolutionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().delegate = self
        getCompNumbers()
    }
    
    fileprivate func view() -> CompSolutionView {
        return self.view as! CompSolutionView
    }
    
    private func getCompNumbers() {
        compNumber = Int.random(in: leftNumber...rightNumber)
        view().computerNumberLabel.text = "Your number is - \(compNumber) ?"
    }
    
    private func gameLogics(_ leftNumber: Int, _ rightNumber: Int) {
        tryCounter += 1
        compNumber = Int.random(in: leftNumber...rightNumber)
        view().tryCounterLabel.text = "Try № \(tryCounter)"
        view().computerNumberLabel.text = "Your number is - \(compNumber) ?"
        view().errorLabel.text = ""
        countError = 0
    }
    
    private func sayError(_ countError: Int) {
        switch countError {
        case 1: view().errorLabel.text = Constants.Errors.firstTry
        case 2: view().errorLabel.text = Constants.Errors.secondTry
        default: view().errorLabel.text = Constants.Errors.moreTry
        }
    }
    
    private func nextRound() {
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.view.window?.rootViewController = UINavigationController(rootViewController: UserSolutionViewController())
        }
    }
    
    init(number: Int) {
        self.userNumber = number
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension CompSolutionViewController: CompSolutionViewControllerDelegate {
    func lessButtonAction() {
        if userNumber >= compNumber {
            countError += 1
            sayError(countError)
        } else {
            rightNumber = compNumber - 1
            gameLogics(leftNumber, rightNumber)
        }
    }
    
    func equalsButtonAction() {
        if userNumber < compNumber || userNumber > compNumber{
            countError += 1
            sayError(countError)
        } else {
            view().myNumberLabel.text = "Yes, My number is \(compNumber)"
            view().errorLabel.text = ""
            nextRound()
        }
    }
    
    func greaterButtonAction() {
        if userNumber <= compNumber {
            countError += 1
            sayError(countError)
        } else {
            leftNumber = compNumber + 1
            gameLogics(leftNumber, rightNumber)
        }
    }
}
