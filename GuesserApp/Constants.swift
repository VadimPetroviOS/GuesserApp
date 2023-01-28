//
//  Constants.swift
//  GuesserApp
//
//  Created by Вадим on 25.01.2023.
//

import UIKit

struct Constants {
    struct Button {
        static let radius: CGFloat = 25
        static let weight: CGFloat = 300
        static let height: CGFloat = 50
    }
    
    struct Errors {
        static let firstTry: String = "Why're you lying?"
        static let secondTry: String = "Seriously???"
        static let moreTry: String = "ignore..."
    }
    
    struct Value {
        static let leftNumber: Int = 1
        static let rightNumber: Int = 100
        static let tryCounter: Int = 1
        static let countError: Int = 0
    }
    
    struct gameStatus {
        static let win: String = "Yot Win"
        static let lose: String = "You Lose"
        static let draw: String = "It's a Draw"
    }
}
