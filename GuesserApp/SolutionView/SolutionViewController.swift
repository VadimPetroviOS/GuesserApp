//
//  SolutionViewController.swift
//  GuesserApp
//
//  Created by Вадим on 26.01.2023.
//

import UIKit

final class SolutionViewController: UIViewController {
    var number: Int
    
    override func loadView() {
        self.view = SolutionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
    
    fileprivate func view() -> SolutionView {
        return self.view as! SolutionView
    }
    
    init(number: Int) {
        self.number = number
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
