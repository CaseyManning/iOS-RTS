//
//  Unit.swift
//  RTS
//
//  Created by Casey Manning on 8/11/16.
//  Copyright © 2016 Casey Manning. All rights reserved.
//

import Foundation
import SpriteKit

class Unit {
    
    var range: Int
    var damage: Int
    var attackRate: Int
    var health: Int
    var moveSpeed: Int
    var cost: Int
    var image: SKSpriteNode
    
    init(range: Int, damage: Int, health: Int, attackRate: Int, moveSpeed: Int, cost: Int, image: String, x: Int, y: Int) {
        self.health = health
        self.damage = damage
        self.range = range
        self.attackRate = attackRate
        self.moveSpeed = moveSpeed
        self.cost = cost
        self.image = SKSpriteNode(imageNamed: image)
        self.image.position.x = CGFloat(x)
        self.image.position.y = CGFloat(y)
    }
    
    func goTo(x: Int, y: Int) {
        
    }
    
    func goTo(loc: CGPoint) {
        
    }
    
    static func f/*ootman*/(x: Int, y: Int) -> Unit {
    return Unit(range: 1, damage: 1, health: 3, attackRate: 3, moveSpeed: 3, cost: 3, image: "unit1.png", x: x, y: y)
    }
    
    static func archer(x: Int, y: Int) -> Unit {
        return Unit(range: 3, damage: 1, health: 2, attackRate: 3, moveSpeed: 3, cost: 3, image: "unit1.png", x: x, y: y)
    }
    
    static func knight(x: Int, y: Int) -> Unit {
        return Unit(range: 1, damage: 2, health: 3, attackRate: 3, moveSpeed: 4, cost: 5, image: "unit1.png", x: x, y: y)
    }
    
    static func catapult(x: Int, y: Int) -> Unit {
        return Unit(range: 6, damage: 3, health: 3, attackRate: 6, moveSpeed: 1, cost: 10, image: "unit1.png", x: x, y: y)
    }
}