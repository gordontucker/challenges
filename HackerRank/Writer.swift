//
//  Writer.swift
//  HackerRank
//
//  Created by Gordon Tucker on 2/16/18.
//  Copyright © 2018 Gordon Tucker. All rights reserved.
//

import UIKit

class ArrayWriter: Writer {
    var lines: [String] = []
    func writeLine(_ line: String) {
        self.lines.append(line)
    }
}
