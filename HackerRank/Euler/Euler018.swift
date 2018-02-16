//
//  Euler018.swift
//  HackerRank
//
//  Created by Gordon Tucker on 2/16/18.
//  Copyright © 2018 Gordon Tucker. All rights reserved.
//

import UIKit

class Euler018: NSObject {
    var reader: Reader
    var writer: Writer
    
    init(reader: Reader, writer: Writer) {
        self.reader = reader
        self.writer = writer
    }
    
    func run() {
        let count = reader.readInt()
        
        for _ in 0 ..< count {
            let rowCount = reader.readInt()
            
            var rows: [[Int]] = []
            for _ in 0 ..< rowCount {
                rows.append(reader.readIntArray())
            }
            
            var i = rowCount - 2
            while i >= 0 {
                var newRow:[Int] = []
                for j in 0 ..< rows[i].count {
                    let a = rows[i + 1][j]
                    let b = rows[i + 1][j + 1]
                    
                    newRow.append(max(a, b) + rows[i][j])
                }
                rows[i] = newRow
                i -= 1
            }
            
            writer.writeLine(rows[0][0])
        }
    }
}
