//
//  ColorPuzzle.swift
//  JaneChallenges
//
//  Created by Gordon Tucker on 2/16/18.
//  Copyright © 2018 Gordon Tucker. All rights reserved.
//

import UIKit

public class ColorPuzzle: NSObject {
    public enum Color: String {
        case red = "R"
        case orange = "O"
        case yellow = "Y"
        case green = "G"
        case blue = "B"
        case violet = "V"
        case wild = "W"
    }
    
    public class Tile: Equatable, Hashable {
        public static func ==(lhs: ColorPuzzle.Tile, rhs: ColorPuzzle.Tile) -> Bool {
            return lhs.x == rhs.x && lhs.y == rhs.y
        }
        
        public var hashValue: Int {
            return (x + y).hashValue
        }
        
        weak var cluster: TileCluster?
        public var color: Color
        public var x: Int
        public var y: Int
        
        var left: Tile?
        var right: Tile?
        var down: Tile?
        var up: Tile?
        
        init(x: Int, y: Int, color: Color) {
            self.x = x
            self.y = y
            self.color = color
        }
    }
    
    public class TileCluster: Equatable, Hashable {
        public var hashValue: Int {
            return self.id.hashValue
        }
        
        public static func ==(lhs: ColorPuzzle.TileCluster, rhs: ColorPuzzle.TileCluster) -> Bool {
            return rhs.id == lhs.id
        }
        
        public var id: String = UUID().uuidString
        public var color: Color
        public var tiles: Set<Tile> = []
        public var neighbors: Set<TileCluster> = []
        var neighboringTiles: [Tile] = []
        public var neighborsConsumed: Set<TileCluster> = []
        
        init(_ tile: Tile) {
            self.color = tile.color
            var tiles:Set<Tile> = []
            
            var neighboringTiles: [Tile] = []
            var queue: [Tile] = [tile]
            while queue.count > 0 {
                let next = queue.removeFirst()
                if next.color != self.color {
                    neighboringTiles.append(next)
                } else if next.cluster == nil {
                    tiles.insert(next)
                    next.cluster = self
                    if let up = next.up {
                        queue.append(up)
                    }
                    if let down = next.down {
                        queue.append(down)
                    }
                    if let left = next.left {
                        queue.append(left)
                    }
                    if let right = next.right {
                        queue.append(right)
                    }
                }
            }
            self.tiles = tiles
            self.neighboringTiles = neighboringTiles
        }
        
        public init(_ tileCluster: TileCluster) {
            self.color = tileCluster.color
            self.tiles = tileCluster.tiles
            self.neighboringTiles = tileCluster.neighboringTiles
            self.neighbors = tileCluster.neighbors
            self.neighborsConsumed = tileCluster.neighborsConsumed
            self.id = tileCluster.id
        }
        
        public func addCluster(_ cluster: TileCluster) -> TileCluster {
            let copy = TileCluster(self)
            guard !self.neighborsConsumed.contains(cluster) else { return copy }
            
            copy.color = cluster.color
            for tile in cluster.tiles {
                copy.tiles.insert(tile)
            }
            for neighbor in cluster.neighbors.filter({ $0 != self && !self.neighborsConsumed.contains($0) }) {
                copy.neighbors.insert(neighbor)
            }
            copy.neighborsConsumed.insert(cluster)
            copy.neighbors.remove(cluster)
            
            return copy
        }
    }
    
    public static func findClusterAndSequence(tiles: [[String]], targetColor: Color) -> (cluster: TileCluster, sequence: String) {
        // Convert input
        var tiles: [[Tile]] = tiles.enumerated().map { row in
            return row.element.enumerated().map({ column in
                return Tile(x: column.offset, y: row.offset, color: Color(rawValue: column.element)!)
            })
        }
        tiles.enumerated().forEach({ row in
            row.element.enumerated().forEach({ column in
                if row.offset > 0 {
                    column.element.left = tiles[row.offset - 1][column.offset]
                }
                if column.offset > 0 {
                    column.element.up = tiles[row.offset][column.offset - 1]
                }
                if row.offset < tiles.count - 1 {
                    column.element.right = tiles[row.offset + 1][column.offset]
                }
                if column.offset < row.element.count - 1 {
                    column.element.down = tiles[row.offset][column.offset + 1]
                }
            })
        })
        
        let clusters = tiles.reduce([], {
            return $0 + $1.flatMap({ (tile: Tile) -> TileCluster? in
                guard tile.cluster == nil else { return nil }
                return TileCluster(tile)
            })
        })
        
        for cluster in clusters {
            cluster.neighbors = Set(cluster.neighboringTiles.reduce([], { (result, tile) -> [TileCluster] in
                guard !result.contains(tile.cluster!) else { return result }
                return result + [tile.cluster!]
            }))
        }
        
        let sequence: [Color]? = convertCluster(cluster: clusters.first!, depth: 0, targetColor: targetColor)
        
        return (cluster: clusters.first!, sequence: sequence?.map({ $0.rawValue }).joined(separator: " ") ?? "")
    }
    
    static func findSequence(tiles: [[String]], targetColor: Color) -> String {
        return self.findClusterAndSequence(tiles: tiles, targetColor: targetColor).sequence
    }
    
    static func convertCluster(cluster: TileCluster, depth: Int, targetColor: Color) -> [Color]? {
        guard depth < 24 else {
            print("has \(cluster.neighbors.count) neighbors left, with \(cluster.tiles.count) tiles converted")
            return nil
        }
        var line: [String] = [""]
        for _ in 0 ..< depth {
            line.append(" ")
        }
        var colorPoints:[Color: Int] = [:]
        for neighbor in cluster.neighbors {
            colorPoints[neighbor.color] = (colorPoints[neighbor.color] ?? 0) + neighbor.tiles.count
        }
        
        let sorted = colorPoints.sorted(by: { $0.value > $1.value }).map({ $0.key })
        for color in sorted {
            let neighbors = cluster.neighbors.filter({ $0.color == color })
            var newCluster = cluster
            for neighbor in neighbors {
                newCluster = newCluster.addCluster(neighbor)
            }
            
            if newCluster.neighbors.count == 0 {
                if depth <= 22 && color != targetColor {
                    return [color] + [targetColor]
                } else if depth == 23 && color == targetColor {
                    return [color]
                } else {
                    return nil
                }
            }
            
            if let sequence = convertCluster(cluster: newCluster, depth: depth + 1, targetColor: targetColor) {
                return [color] + sequence
            }
        }
        
        return nil
    }
}
