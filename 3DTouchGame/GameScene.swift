//
//  GameScene.swift
//  3DTouchGame
//
//  Created by Jae Hee Cho on 2016-06-28.
//  Copyright (c) 2016 Jae Hee Cho. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var circle1:SKShapeNode!
    var circle2:SKShapeNode!
    
    var score:Int = 0
    var tempScore:Int = -4
    var scoreLabel:SKLabelNode!
    
    var initialcircle1Position:CGPoint!
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let maximumPossibleForce = touch.maximumPossibleForce
            let force = touch.force
            let normalizedForce = force/maximumPossibleForce
            
            circle1.position.x = (self.size.width / 2) - normalizedForce * (self.size.width/2 - 25)
            circle2.position.x = (self.size.width / 2) + normalizedForce * (self.size.width/2 - 25)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        resetcircle1Position()
    }
    
    func resetcircle1Position() {
        circle1.position = initialcircle1Position
        circle2.position = initialcircle1Position
    }
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self    
        addcircle1()
        addScore()
    }
    
    func addRandomRow() {
        let randomNumber = Int(arc4random_uniform(6))
        
        if (score < 50) {
            switch randomNumber {
            case 0:
                addRow(RowType(rawValue: 0)!)
                break
            case 1:
                addRow(RowType(rawValue: 1)!)
                break
            case 2:
                addRow(RowType(rawValue: 2)!)
                break
            case 3:
                addRow(RowType(rawValue: 3)!)
                break
            case 4:
                addRow(RowType(rawValue: 4)!)
                break
            case 5:
                addRow(RowType(rawValue: 5)!)
                break
            default:
                break
            }
        } else {
            switch randomNumber {
            case 0:
                addRow(0)
                break
            case 1:
                addRow(1)
                break
            case 2:
                addRow(2)
                break
            case 3:
                addRow(3)
                break
            case 4:
                addRow(4)
                break
            case 5:
                addRow(5)
                break
            default:
                break
            }
        }
    }
    
    var lastUpdateTimeInterval = NSTimeInterval()
    var lastYieldTimeInterval = NSTimeInterval()
    
    func updateWithTimeSinceLastUpdate (timeSinceLastUpdate:CFTimeInterval) {
        lastYieldTimeInterval += timeSinceLastUpdate
        if lastYieldTimeInterval > 0.6 {
            lastYieldTimeInterval = 0
            tempScore += 1
            score = tempScore > 0 ? tempScore : 0
            scoreLabel.text = "Score: \(score)"
            addRandomRow()
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        var timeSinceLastUpdate = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        
        if timeSinceLastUpdate > 1 {
            timeSinceLastUpdate = 1/60
            lastUpdateTimeInterval = currentTime
        }
        
        updateWithTimeSinceLastUpdate(timeSinceLastUpdate)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyB.node?.name == "CIRCLE" {
            showGameOverScene()
        }
    }
    
    func showGameOverScene() {
        let transition = SKTransition.fadeWithDuration(0.5)
        let gameOverScene = GameOverScene(size: self.size, score: score)
        self.view?.presentScene(gameOverScene, transition: transition)
    }
}
