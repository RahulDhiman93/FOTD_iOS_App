//
//  String+Extention.swift
//  SylvanParent
//
//  Created by cl-macmini-79 on 22/11/17.
//  Copyright © 2017 Click-Labs. All rights reserved.
//

import Foundation

extension String {
    func containsWhiteSpace() -> Bool {
        // check if there's a range for a whitespace
        let range = self.rangeOfCharacter(from: .whitespaces)
        // returns false when there's no range for whitespace
        if let _ = range {
            return true
        } else {
            return false
        }
    }
}
