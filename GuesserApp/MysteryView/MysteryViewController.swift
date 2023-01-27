//
//  MysteryViewController.swift
//  GuesserApp
//
//  Created by Вадим on 25.01.2023.
//

import UIKit

final class MysteryViewController: UIViewController {
    
    override func loadView() {
        self.view = MysteryView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setKeyboardSettings()
    }
    
    fileprivate func view() -> MysteryView {
        return self.view as! MysteryView
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view().endEditing(true)
    }
    
    private func setDelegates() {
        view().delegate = self
        view().numberTextView.delegate = self
    }
    
    private func setKeyboardSettings() {
        view().numberTextView.keyboardType = .numberPad
    }
}

extension MysteryViewController: MysteryViewControllerDelegate {
    func buttonAction() {
        guard let number = Int(view().numberTextView.text) else { return }
        if number == 0 || number > 100 {
            view().errorLabel.isHidden = false
        } else {
            self.view.window?.rootViewController = UINavigationController(rootViewController: CompSolutionViewController(number: number))
        }
    }   
}

extension MysteryViewController: UITextViewDelegate {
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
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text?.count == 1 || textView.text?.count == 2 || textView.text?.count == 3 {
            self.view().enterButton.alpha = 1
            self.view().enterButton.isEnabled = true
        } else {
            self.view().enterButton.alpha = 0.5
            self.view().enterButton.isEnabled = false
        }
    }
}
