//
//  Extensions.swift
//  GuesserApp
//
//  Created by Вадим on 29.01.2023.
//

import UIKit

extension String {
   var containsValidCharacter: Bool {
   guard self != "" else { return true }
   let hexSet = CharacterSet(charactersIn: "0123456789")
   let newSet = CharacterSet(charactersIn: self)
   return hexSet.isSuperset(of: newSet)
 }
}
