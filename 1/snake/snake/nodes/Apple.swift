//
//  Apple.swift
//  snake
//
//  Created by DShirokov on 11/06/2020.
//  Copyright © 2020 DShirokov. All rights reserved.
//

import UIKit
import SpriteKit

class Apple: SKShapeNode {
    convenience init(position: CGPoint) {
        self.init()
        
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        
        fillColor = UIColor.red
        strokeColor = UIColor.red
        lineWidth = 5
        
        self.position = position
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10, center: CGPoint(x: 5, y:5))
        self.physicsBody?.categoryBitMask = CollisionCategories.Apple
    }
}
