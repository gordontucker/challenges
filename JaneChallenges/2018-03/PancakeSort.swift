//
//  PancakeSort.swift
//  JaneChallengesTests
//
//  Created by Gordon Tucker on 3/9/18.
//  Copyright © 2018 Gordon Tucker. All rights reserved.
//

import UIKit

class PancakeSort: NSObject {
    enum SortType {
        case simple
        case v2
    }
    
    static func run(_ sortType: SortType, values: Int...) -> (steps: Int, sorted: [Int]) {
        return PancakeSort.run(sortType, values: values)
    }
    
    static func run(_ sortType: SortType, values: [Int]) -> (steps: Int, sorted: [Int]) {
        switch sortType {
            case .simple: return self.simple(values: values)
            case .v2: return self.v2(values: values)
        }
    }
    
    static func simple(values: [Int]) -> (steps: Int, sorted: [Int]) {
        var sorted = values
        var flips: Int = 0
        
        print("\(flips): \(sorted)")
        for left in 0 ..< sorted.count {
            for rightOffset in 0 ..< sorted.count - left - 1 {
                let right = sorted.count - rightOffset - 1
                if sorted[left] > sorted[right] {
                    var originalValue = sorted[left]
                    sorted[left] = sorted[right]
                    sorted[right] = originalValue
                    flips += 1
                    print("\(flips): \(sorted)")
                }
            }
        }
        
        return (steps: flips, sorted: sorted)
    }
    
    static func v2(values: [Int]) -> (steps: Int, sorted: [Int]) {
        var sorted: [Int] = values.reversed()
        var flips: Int = 0
        
        print("flips: \(flips), sorted: \(sorted)")
        
        var currentIndex = 0
        while currentIndex < sorted.count - 1 {
            var largestIndex = currentIndex
            // Find the largest to swap with
            for compareIndex in currentIndex + 1 ..< sorted.count {
                if sorted[largestIndex] < sorted[compareIndex] {
                    // We need to flip the pancakes at this point, we found a bigger one
                    largestIndex = compareIndex
                }
            }
            
            guard largestIndex != currentIndex else {
                currentIndex += 1
                continue
            }
            
            if largestIndex != sorted.count - 1 {
                // Flip the larger pancake to the top
                let a = Array(sorted[0..<largestIndex])
                let b = Array(sorted[largestIndex...])
                sorted = a + b.reversed()
                flips += 1
                print("flips: \(flips), sorted: \(sorted)")
            }
            
            // Flip stack down to current index
            let a = Array(sorted[0..<currentIndex])
            let b = Array(sorted[currentIndex...])
            sorted = a + b.reversed()
            flips += 1
            print("flips: \(flips), sorted: \(sorted)")
            currentIndex += 1
        }
        
        return (steps: flips + 1, sorted: sorted.reversed())
    }
}
