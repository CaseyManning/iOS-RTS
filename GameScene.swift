//
//  GameScene.swift
//  RTS
//
//  Created by Casey Manning on 8/11/16.
//  Copyright (c) 2016 Casey Manning. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var myStructures: [Structure] = []
    var enemyStructures: [Structure] = []
    
    var myUnits: [Unit] = []
    var enemyUnits: [Unit] = []
    
    var selectedStructures: [Structure] = []
    var selectedUnits: [Unit] = []
    
    var initialTouchLocation: CGPoint!
    var currentTouchLocation: CGPoint!
    
    var selection = SKSpriteNode(imageNamed: "selection.png")
    
    override func didMoveToView(view: SKView) {
        let house = Structure.Base(100, y: 100)
        addChild(house.image)
        myStructures.append(house)
        
        let sun = Unit.f(200, y: 200)
        addChild(sun.image)
        myUnits.append(sun)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        for touch in touches {
            let loc = touch.locationInNode(self)
            initialTouchLocation = loc
            let struc = structureAtLocation(loc)
            if !(struc.image.position.x == -1 && struc.image.position.y == -1) {
                //Pressed on a structure
                selectedStructures.removeAll()
                selectedUnits.removeAll()
                selectedStructures.append(struc)
                struc.image.runAction(SKAction.colorizeWithColor(UIColor.greenColor(), colorBlendFactor: 0.3, duration: 0))
                print("Whee!")
            } else {
                //Didn't press on anything
                for unit in myUnits {
                    unit.goTo(loc)
                }
                if myUnits.count == 0 {
                    for str in myStructures {
                        if str.canProduce {
                            str.ralleyPoint = loc
                        }
                    }
                }
            }
            print("\(selectedStructures.count) selected structures")
            selection.anchorPoint = CGPoint(x: 0, y: 1)
            addChild(selection)
            selection.position = loc
            selection.size.width = 0
            selection.size.height = 0
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            currentTouchLocation = touch.locationInNode(self)
        }
        
        selection.size.width = currentTouchLocation.x - initialTouchLocation.x
        selection.size.height = -(currentTouchLocation.y - initialTouchLocation.y)
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            currentTouchLocation = touch.locationInNode(self)
        }
        
        if abs(currentTouchLocation.x - initialTouchLocation.x) < 20 && abs(currentTouchLocation.y - initialTouchLocation.y) < 20 && selectedUnits.count > 0 {
            //move selected units to current location
            
            for unit in selectedUnits {
                let a = abs(unit.image.position.x - currentTouchLocation.x)*abs(unit.image.position.x - currentTouchLocation.x)
                
                let distance = sqrt(a + abs(unit.image.position.y - currentTouchLocation.y))
                
                let time = distance/CGFloat(unit.moveSpeed*20)
                
                let action = SKAction.moveTo(currentTouchLocation, duration: NSTimeInterval(time))
                unit.image.runAction(action)
            }
        }
        
        var f = false
        for unit in myUnits {
            if Int(unit.image.position.x) > min(Int(initialTouchLocation.x), Int(currentTouchLocation.x)) && Int(unit.image.position.x) < max(Int(initialTouchLocation.x), Int(currentTouchLocation.x)) && Int(unit.image.position.y) > min(Int(initialTouchLocation.y), Int(currentTouchLocation.y)) && Int(unit.image.position.y) < max(Int(initialTouchLocation.y), Int(currentTouchLocation.y)) {
                if f == false {
                    deSelectAllUnits()
                    deSelectAllStructures()
                }
                selectedUnits.append(unit)
                unit.image.runAction(SKAction.colorizeWithColor(UIColor.greenColor(), colorBlendFactor: 0.3, duration: 0))
                f = true
            }
        }
        if selectedUnits.count == 0 {
        for structure in myStructures {
            
            if Int(structure.image.position.x) > Int(initialTouchLocation.x) && Int(structure.image.position.x) < Int(currentTouchLocation.x) && Int(structure.image.position.y) > Int(initialTouchLocation.y) && Int(structure.image.position.y) < Int(currentTouchLocation.y) {
                
                selectedStructures.append(structure)
            }
        }
        }
        selection.removeFromParent()
        print("\(selectedUnits.count) selected units")
        if selectedUnits.count > 0 {
            deSelectAllStructures()
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        //print(children.count)
    }
    
    func structureAtLocation(loc: CGPoint) -> Structure {
        let node = self.nodeAtPoint(loc)
        for s in myStructures {
            if s.image == node {
                return s
            }
        }
        for s in enemyStructures {
            if s.image == node {
                return s
            }
        }
        return Structure.CannonTower(-1, y: -1)
    }
    
    func unitAtLocation(loc: CGPoint) -> Unit {
        let node = self.nodeAtPoint(loc)
        for s in myUnits {
            if s.image == node {
                return s
            }
        }
        for s in enemyUnits {
            if s.image == node {
                return s
            }
        }
        return Unit.f(-1, y: -1)
    }
    
    func deSelectAllStructures() {
        print("Hello \(selectedStructures.count)")
        for s in selectedStructures {
            print(children.count)
           s.image.runAction(SKAction.colorizeWithColor(UIColor.clearColor(), colorBlendFactor: 0, duration: 0.5))
        }
        selectedStructures.removeAll()
    }
    
    func deSelectAllUnits() {
        for s in selectedUnits {
            s.image.removeAllActions()
            s.image.runAction(SKAction.colorizeWithColor(UIColor.clearColor(), colorBlendFactor: 0, duration: 0.5))
        }
        selectedUnits.removeAll()
    }
    
}
