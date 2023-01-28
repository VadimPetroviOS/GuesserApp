//
//  UserSolutionViewController.swift
//  GuesserApp
//
//  Created by Вадим on 27.01.2023.
//

import UIKit

final class UserSolutionViewController: UIViewController {
    let compScore: Int
    var compNumber = Int()
    var leftNumber = Constants.Value.leftNumber
    var rightNumber = Constants.Value.rightNumber
    var tryCounter = Constants.Value.tryCounter
    
    override func loadView() {
        self.view = UserSolutionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setKeyboardSettings()
        getCompNumbers()
    }
    
    fileprivate func view() -> UserSolutionView {
        return self.view as! UserSolutionView
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view().endEditing(true)
    }
    
    private func setDelegates() {
        view().delegate = self
        view().numberGuessTV.delegate = self
    }
    
    private func setKeyboardSettings() {
        view().numberGuessTV.keyboardType = .numberPad
    }
    
    private func getCompNumbers() {
        compNumber = Int.random(in: leftNumber...rightNumber)
    }
    
    init(compScore: Int) {
        self.compScore = compScore
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension UserSolutionViewController: UserSolutionViewControllerDelegate {
    func buttonAction() {
        guard let userNumber = Int(view().numberGuessTV.text) else { return }
        if userNumber < compNumber {
            view().answerLabel.text = "No, my number is greater than yours"
            tryCounter += 1
        } else if userNumber > compNumber {
            view().answerLabel.text = "No, my number is less than yours"
            tryCounter += 1
        } else {
            view().answerLabel.text = "Yes, my number is \(compNumber)"
            let seconds = 1.5
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                //self.view.window?.rootViewController = UINavigationController(rootViewController: UserSolutionViewController())
            }
        }
        
        view().tryCounterLabel.text = "Try № \(tryCounter)"
    }
}

extension UserSolutionViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Guess the number"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentCharacterCount = textView.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + text.count - range.length
        return newLength <= 3
    }
}
