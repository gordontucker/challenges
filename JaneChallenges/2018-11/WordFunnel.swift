//
//  WordFunnel.swift
//  JaneChallenges
//
//  Created by Gordon Tucker on 11/9/18.
//  Copyright © 2018 Gordon Tucker. All rights reserved.
//

import UIKit

public class WordFunnel: NSObject {
    public static var dictionary = Dictionary.load()
    public static var countMap: [Int: [String]] = {
        var countMap: [Int: [String]] = [:]
        for i in 0 ..< dictionary.max(by: { $0.count < $1.count })!.count {
            countMap[i] = dictionary.filter({ $0.count == i })
        }
        return countMap
    }()
    
    public static func funnel(_ fullWord: String, _ partialWord: String) -> Bool {
        guard fullWord.count - 1 == partialWord.count else { return false }
        var fullIndex = fullWord.startIndex
        var partialIndex = partialWord.startIndex
        var hasDroppedLetter = false
        var i = 0;
        while i < partialWord.count {
            if fullWord[fullIndex] != partialWord[partialIndex] {
                if hasDroppedLetter {
                    return false
                } else {
                    fullIndex = fullWord.index(after: fullIndex)
                    hasDroppedLetter = true
                    continue
                }
            }
            fullIndex = fullWord.index(after: fullIndex)
            partialIndex = partialWord.index(after: partialIndex)
            i += 1
        }
        return true
    }
    
    public static func bonus(_ word: String) -> [String] {
        let words = countMap[word.count - 1]!.filter({ possible in
            return (possible.first == word.first || possible.last == word.last)
        })
        
        return words.filter({ funnel(word, $0) })
    }
    
    public static func bonus2() -> [String] {
        let potentialWords = self.dictionary.filter({ $0.count >= 5 })
        let dictionary = Set(self.dictionary)
        
        var matches: [String] = []
        for word in potentialWords {
            var index = word.startIndex
            var subwordMatches: Set<String> = []
            
            while index != word.endIndex {
                var subWord = word
                subWord.remove(at: index)
                
                if dictionary.contains(subWord) {
                    subwordMatches.insert(subWord)
                }
                
                if subwordMatches.count > 5 {
                    break
                }
                index = word.index(after: index)
            }
            
            if subwordMatches.count == 5 {
                matches.append(word)
            }
        }
        return matches
    }
}
