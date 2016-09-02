//
//  Structure.swift
//  RTS
//
//  Created by Casey Manning on 8/11/16.
//  Copyright © 2016 Casey Manning. All rights reserved.
//

import Foundation
import SpriteKit

class Structure {
    
    var canProduce: Bool
    var productionModifier: Int
    var health: Int
    var canAttack: Bool
    var damage: Int
    var attackRate: Int
    var cost: Int
    var buildTime: Int
    var range: Int
    var production: Int
    var image: SKSpriteNode
    var ralleyPoint: CGPoint
    
    init(canProduce: Bool, productionModifier: Int, health: Int, canAttack: Bool, damage: Int, attackRate: Int, cost: Int, buildTime: Int, range: Int, production: Int, image: String, x: Int, y: Int) {
        self.attackRate = attackRate
        self.buildTime = buildTime
        self.canAttack = canAttack
        self.canProduce = canProduce
        self.cost = cost
        self.damage = damage
        self.health = health
        self.productionModifier = productionModifier
        self.range = range
        self.production = production
        self.image = SKSpriteNode(imageNamed: image)
        ralleyPoint = CGPoint(x: x, y:  y)
        self.image.position.x = CGFloat(x)
        self.image.position.y = CGFloat(y)
        self.image.xScale = 1.5
        self.image.yScale = 1.5
    }
    
    //Main Structure: Can attack and produce units, also generates small amount of income
    static func Base(x: Int, y: Int) -> Structure {
        return Structure(canProduce: true, productionModifier: 0, health: 40, canAttack: true, damage: 3, attackRate: 5, cost: 50, buildTime: 15, range: 5, production: 2, image: "human-city2.png", x: x, y: y)
    }
    
    //Incone generation structure: Can't attack or produce units, high income
    static func Mine(x: Int, y: Int) -> Structure {
        return Structure(canProduce: false, productionModifier: 0, health: 15, canAttack: false, damage: 0, attackRate: 0, cost: 20, buildTime: 8, range: 0, production: 6, image: "", x: x, y: y)
    }
    
    //Defensive Structure: Attacks nearby enemies
    static func CannonTower(x: Int, y: Int) -> Structure {
        return Structure(canProduce: false, productionModifier: 0, health: 25, canAttack: true, damage: 3, attackRate: 5, cost: 20, buildTime: 10, range: 3, production: 0, image: "human-city3.png", x: x, y: y)
    }
    
    //Very cheap structure that produces units at a higher price
    static func Barracks(x: Int, y: Int) -> Structure {
        return Structure(canProduce: true, productionModifier: 2, health: 20, canAttack: false, damage: 0, attackRate: 0, cost: 10, buildTime: 5, range: 3, production: 0, image: "", x: x, y: y)
    }
}