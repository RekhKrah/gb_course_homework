//
//  Edge.swift
//  snake
//
//  Created by DShirokov on 11/06/2020.
//  Copyright © 2020 DShirokov. All rights reserved.
//

import UIKit
import SpriteKit

class Edge: SKShapeNode {
    convenience init(position: CGPoint, width: Int, height: Int) {
        self.init()
        
        path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: width, height: height)).cgPath
        fillColor = UIColor.yellow
        strokeColor = UIColor.yellow
        lineWidth = 5
        
        self.position = position
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
        self.physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
    }
}
