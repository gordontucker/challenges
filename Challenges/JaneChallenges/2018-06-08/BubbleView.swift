//
//  BubbleView.swift
//  Challenges
//
//  Created by Gordon Tucker on 6/8/18.
//  Copyright © 2018 Gordon Tucker. All rights reserved.
//

import UIKit
import PureLayout

@IBDesignable
class BubbleView: UIView, NibLoadable {
    
    @IBInspectable public var cornerRadius: CGFloat {
        set {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
            self.setNeedsDisplay()
        }
        get {
            return self.layer.cornerRadius
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFromNib()
        self.setupDots()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
        self.setupDots()
    }
    
    private func setupDots() {
        let rand = { (_ from: UInt32, _ to: UInt32) -> Int in
            return Int(arc4random_uniform(to - from) + from)
        }
        let numberOfCircles = rand(2, 4)
        
        for i in 0 ..< numberOfCircles {
            var size: CGFloat
            
            let view = UIView.newAutoLayout()
            view.backgroundColor = UIColor.white.withAlphaComponent(CGFloat(rand(4, 20)) * 0.01)
            self.insertSubview(view, belowSubview: self.imageView)
            
            switch (i, numberOfCircles) {
                case (0, 4), (0, 3), (0, 2): // Top left area
                    size = CGFloat(rand(80, 180))
                    view.autoPinEdge(toSuperviewEdge: .left, withInset: CGFloat(rand(0, 40) - 20))
                    view.autoPinEdge(toSuperviewEdge: .top, withInset: CGFloat(rand(0, 60) - 60))
                case (1, 4), (1, 3): // bottom left area
                    size = CGFloat(rand(80, 120))
                    view.autoPinEdge(toSuperviewEdge: .left, withInset: CGFloat(rand(0, 40) - 60))
                    view.autoPinEdge(toSuperviewEdge: .bottom, withInset: CGFloat(rand(0, 40) - 90))
                case (2, 4): // top right area
                    size = CGFloat(rand(50, 80))
                    view.autoPinEdge(toSuperviewEdge: .right, withInset: CGFloat(rand(0, 100)))
                    view.autoPinEdge(toSuperviewEdge: .top, withInset: CGFloat(rand(0, 40) - 20))
                case (3, 4), (1, 2): // bottom right area
                    size = CGFloat(rand(140, 280))
                    view.autoPinEdge(toSuperviewEdge: .right, withInset: CGFloat(rand(0, 60)))
                    view.autoPinEdge(toSuperviewEdge: .bottom, withInset: CGFloat(rand(0, 60)))
                default: // right center area
                    size = CGFloat(rand(100, 200))
                    view.autoPinEdge(toSuperviewEdge: .right, withInset: CGFloat(rand(0, 40) - 60))
                    view.autoAlignAxis(toSuperviewAxis: .horizontal)
            }
            
            view.autoSetDimensions(to: CGSize(width: size, height: size))
            view.layer.masksToBounds = true
            view.layer.cornerRadius = size / 2
            
            var animate: (() -> Void)!
            
            animate = { [weak view] in
                UIView.animate(withDuration: Double(rand(30,45)), delay: 0, options: .curveEaseInOut, animations: {
                    let zoom = CGFloat(rand(70, 140)) / 100.0
                    view?.transform = CGAffineTransform(translationX: CGFloat(rand(0, 80) - 40), y: CGFloat(rand(0, 80) - 40)).concatenating(CGAffineTransform(scaleX: zoom, y: zoom))
                    view?.alpha = CGFloat(rand(4, 20)) / 0.01
                }, completion: { (_) in
                    animate?()
                })
            }
        }
    }
}
