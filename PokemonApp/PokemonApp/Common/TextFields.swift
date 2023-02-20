//
//  TextFields.swift
//  PokemonApp
//
//  Created by Dominik Maric on 18.02.2023..
//

import Foundation
import UIKit

extension UITextField {
    
    func isValid(with word: String) -> Bool {
        guard let text = self.text,
              !text.isEmpty else {
            print("Please fill the field.")
            return false
        }
    
    return true
    }
}
