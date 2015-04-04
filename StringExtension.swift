//
//  StringExtenstion.swift
//  kurs
//
//  Created by Sergey Yuryev on 20/01/15.
//  Copyright (c) 2015 syuryev. All rights reserved.
//

import Foundation

extension String {
    func condenseWhitespace() -> String {
        let components = self.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).filter({!Swift.isEmpty($0)})
        return " ".join(components)
    }
}

extension String {
    func toBool() -> Bool {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return false
        }
    }
}