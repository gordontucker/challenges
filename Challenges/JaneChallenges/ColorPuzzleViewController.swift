//
//  ColorPuzzleViewController.swift
//  Challenges
//
//  Created by Gordon Tucker on 2/23/18.
//  Copyright © 2018 Gordon Tucker. All rights reserved.
//

import UIKit
import JaneChallenges

extension ColorPuzzle.Color {
    var color: UIColor {
        switch self {
            case .red: return UIColor.red
            case .blue: return UIColor.blue
            case .green: return UIColor.green
            case .orange: return UIColor.orange
            case .violet: return UIColor.purple
            case .yellow: return UIColor.yellow
            case .wild: return UIColor.black
        }
    }
}

class ColorPuzzleViewController: UIViewController {
    
    @IBOutlet weak var verticalStackView: UIStackView!
    @IBOutlet weak var backgroundColorView: UIView!
    var sequence: [ColorPuzzle.Color]!
    var cluster: ColorPuzzle.TileCluster!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let clusterAndSequence = ColorPuzzle.findClusterAndSequence(tiles: [
            ["W", "Y", "O", "B", "V", "G", "V", "O", "Y", "B"],
            ["G", "O", "O", "V", "R", "V", "R", "G", "O", "R"],
            ["V", "B", "R", "R", "R", "B", "R", "B", "G", "Y"],
            ["B", "O", "Y", "R", "R", "G", "Y", "V", "O", "V"],
            ["V", "O", "B", "O", "R", "G", "B", "R", "G", "R"],
            ["B", "O", "G", "Y", "Y", "G", "O", "V", "R", "V"],
            ["O", "O", "G", "O", "Y", "R", "O", "V", "G", "G"],
            ["B", "O", "O", "V", "G", "Y", "V", "B", "Y", "G"],
            ["R", "B", "G", "V", "O", "R", "Y", "G", "G", "G"],
            ["Y", "R", "Y", "B", "R", "O", "V", "O", "B", "V"],
            ["O", "B", "O", "B", "Y", "O", "Y", "V", "B", "O"],
            ["V", "R", "R", "G", "V", "V", "G", "V", "V", "G"]
        ], targetColor: .violet)
        self.cluster = clusterAndSequence.cluster
        self.sequence = clusterAndSequence.sequence.components(separatedBy: .whitespaces).map({ ColorPuzzle.Color(rawValue: $0)! })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let size: CGFloat = 30
        
        for _ in 0 ..< 12 {
            var tileViews: [UIView] = []
            // Add stackview row
            for _ in 0 ..< 10 {
                // Add tile view
                let view = UIView()
                view.translatesAutoresizingMaskIntoConstraints = false
                var constraint = view.heightAnchor.constraint(equalToConstant: size)
                //constraint.priority = UILayoutPriority(Float(900 + j))
                constraint.isActive = true
                constraint = view.widthAnchor.constraint(equalToConstant: size)
                //constraint.priority = UILayoutPriority(Float(900 + j))
                constraint.isActive = true
                
                tileViews.append(view)
            }
            let stackView = UIStackView(arrangedSubviews: tileViews)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            self.verticalStackView.addArrangedSubview(stackView)
        }
        self.processSequence()
    }
    
    func processSequence(index: Int = 0) {
        print("processing index \(index)")
        self.updateColors {
            guard index < self.sequence.count else {
                self.cluster.color = .violet // We end on violet for this one
                self.updateColors { }
                return
            }
            
            let nextColor = self.sequence[index]
            let neighbors = self.cluster.neighbors.filter({ $0.color == nextColor })
            for neighbor in neighbors {
                self.cluster = self.cluster.addCluster(neighbor)
            }
            
            self.processSequence(index: index + 1)
        }
    }

    func updateColors(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0.6, delay: 0, options: [], animations: {
            var parsedClusters: [ColorPuzzle.TileCluster] = []
            var remainingClusters: [ColorPuzzle.TileCluster] = [self.cluster]
            
            while remainingClusters.count > 0 {
                let current = remainingClusters.removeFirst()
                
                // Update tiles
                for tile in current.tiles.enumerated() {
                    print("colorizing \(tile.element.x) \(tile.element.y)")
                    let stackView = self.verticalStackView.arrangedSubviews[tile.element.y] as! UIStackView
                    stackView.arrangedSubviews[tile.element.x].layer.backgroundColor = current.color.color.cgColor
                }
                
                parsedClusters.append(current)
                for next in current.neighbors {
                    if !parsedClusters.contains(next) && !remainingClusters.contains(next) && !self.cluster.neighborsConsumed.contains(next) {
                        remainingClusters.append(next)
                    }
                }
            }
            self.backgroundColorView.backgroundColor = self.cluster.color.color.withAlphaComponent(0.2)
        }, completion: { _ in
        //DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            completion()
        //}
        })
    }
}
