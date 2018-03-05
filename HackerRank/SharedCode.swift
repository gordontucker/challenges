//
//  SharedCode.swift
//  HackerRank
//
//  Created by Gordon Tucker on 3/2/18.
//  Copyright © 2018 Gordon Tucker. All rights reserved.
//

import UIKit


protocol Reader {
    func readString() -> String
    func readInt() -> Int
    func readStringArray(separatedBy string: String) -> [String]
    func readIntArray(separatedBy string: String) -> [Int]
    func readArray<T>(separatedBy string: String, map: (String) -> T) -> [T]
}

extension Reader {
    func readInt() -> Int {
        return Int(self.readString())!
    }
    
    func readStringArray(separatedBy string: String) -> [String] {
        return self.readString().components(separatedBy: string)
    }
    
    func readIntArray(separatedBy string: String) -> [Int] {
        return readArray(separatedBy: string, map: { Int($0)! })
    }
    
    func readIntArray() -> [Int] {
        return readArray(separatedBy: " ", map: { Int($0)! })
    }
    
    func readArray<T>(separatedBy string: String, map: (String) -> T) -> [T] {
        return self.readStringArray(separatedBy: string).map(map)
    }
}

struct ConsoleReader: Reader {
    func readString() -> String {
        return readLine() ?? ""
    }
}

protocol Writer {
    func writeLine(_ line: String)
}

extension Writer {
    func writeLine(_ int: Int) {
        self.writeLine("\(int)")
    }
}

class ConsoleWriter: Writer {
    func writeLine(_ line: String) {
        print(line)
    }
}

// MYCLASS().run()
