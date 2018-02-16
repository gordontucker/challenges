//
//  Writer.swift
//  HackerRank
//
//  Created by Gordon Tucker on 2/16/18.
//  Copyright © 2018 Gordon Tucker. All rights reserved.
//

import UIKit

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

class ArrayWriter: Writer {
    var lines: [String] = []
    func writeLine(_ line: String) {
        self.lines.append(line)
    }
}
