//
//  Dictionary.swift
//  JaneChallenges
//
//  Created by Gordon Tucker on 6/4/18.
//  Copyright © 2018 Gordon Tucker. All rights reserved.
//

import UIKit

class Dictionary {
    static func load() -> [String] {
        guard let path = Bundle.main.path(forResource: "enable1", ofType: "txt") else { return [] }
        guard let contents = try? String(contentsOfFile: path) else { return [] }
        let words: [String] = contents.components(separatedBy: CharacterSet.whitespacesAndNewlines)
        return words.filter({ $0.count > 0 })
    }
}
