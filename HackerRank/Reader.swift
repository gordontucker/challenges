//
//  ReadLine.swift
//  HackerRank
//
//  Created by Gordon Tucker on 2/16/18.
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

class FileReader: Reader {
    let encoding: String.Encoding
    let chunkSize: Int
    let fileHandle: FileHandle
    var buffer: Data
    let delimPattern : Data
    var isAtEOF: Bool = false
    
    init?(url: URL, delimeter: String = "\n", encoding: String.Encoding = .utf8, chunkSize: Int = 4096)
    {
        guard let fileHandle = try? FileHandle(forReadingFrom: url) else { return nil }
        self.fileHandle = fileHandle
        self.chunkSize = chunkSize
        self.encoding = encoding
        buffer = Data(capacity: chunkSize)
        delimPattern = delimeter.data(using: .utf8)!
    }
    
    deinit {
        fileHandle.closeFile()
    }
    
    func rewind() {
        fileHandle.seek(toFileOffset: 0)
        buffer.removeAll(keepingCapacity: true)
        isAtEOF = false
    }
    
    func nextLine() -> String? {
        if isAtEOF { return nil }
        
        repeat {
            if let range = buffer.range(of: delimPattern, options: [], in: buffer.startIndex..<buffer.endIndex) {
                let subData = buffer.subdata(in: buffer.startIndex..<range.lowerBound)
                let line = String(data: subData, encoding: encoding)
                buffer.replaceSubrange(buffer.startIndex..<range.upperBound, with: [])
                return line
            } else {
                let tempData = fileHandle.readData(ofLength: chunkSize)
                if tempData.count == 0 {
                    isAtEOF = true
                    return (buffer.count > 0) ? String(data: buffer, encoding: encoding) : nil
                }
                buffer.append(tempData)
            }
        } while true
    }
    
    func readString() -> String {
        return self.nextLine() ?? ""
    }
}

class ArrayReader: Reader {
    var lines: [String]
    
    init(_ lines: [String]) {
        self.lines = lines
    }
    
    func readString() -> String {
        guard lines.count > 0 else { return "" }
        return lines.removeFirst()
    }
}
