//
//  twoD-array.swift
//  HackerRank
//
//  Created by Gordon Tucker on 3/2/18.
//  Copyright © 2018 Gordon Tucker. All rights reserved.
//

import UIKit

class TwoD_array: NSObject {
    
    struct Point {
        let x: Int
        let y: Int
    }
    
    class Hourglass {
        var point: Point
        var values: [Int] = []
        var value: Int
        
        init? (point: Point, structure: [[Int]]) {
            guard point.x > 0, point.y > 0, structure.count > 0, point.x < structure[0].count - 1, point.y < structure.count - 1 else {
                return nil
            }
            
            self.point = point
            let values:[Int] = [
                structure[point.y-1][point.x-1],
                structure[point.y-1][point.x],
                structure[point.y-1][point.x+1],
                structure[point.y][point.x],
                structure[point.y+1][point.x-1],
                structure[point.y+1][point.x],
                structure[point.y+1][point.x+1]
            ]
            self.values = values
            self.value = values.reduce(0, +)
        }
        
        var description: String {
            return values.map({ "\($0)" }).joined(separator: ", ")
        }
    }
    
    var reader: Reader
    var writer: Writer
    
    init(reader: Reader = ConsoleReader(), writer: Writer = ConsoleWriter()) {
        self.reader = reader
        self.writer = writer
    }
    
    func run() {
        let array = [
            reader.readIntArray(),
            reader.readIntArray(),
            reader.readIntArray(),
            reader.readIntArray(),
            reader.readIntArray(),
            reader.readIntArray()
        ]
        
        var hourglasses: [Hourglass] = []
        
        for y in 0 ..< array.count {
            for x in 0 ..< array[y].count {
                guard let hourglass = Hourglass(point: Point(x: x, y: y), structure: array) else { continue }
                hourglasses.append(hourglass)
            }
        }
        
        writer.writeLine(hourglasses.max(by: { $0.value < $1.value })?.value ?? 0)
    }
}
