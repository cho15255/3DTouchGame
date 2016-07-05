//
//  GameElements.swift
//  3DTouchGame
//
//  Created by Jae Hee Cho on 2016-06-28.
//  Copyright © 2016 Jae Hee Cho. All rights reserved.
//

import SpriteKit

struct CollisionBitMask {
    static let circle:UInt32 = 0x00
    static let Obstacle:UInt32 = 0x01
}

enum ObstacleType:Int {
    case small = 0
    case medium = 1
    case large = 2
}

enum RowType:Int {
    case oneS = 0
    case oneM = 1
    case oneL = 2
    case twoS = 3
    case twoM = 4
    case threeS = 5
}

extension GameScene {
    func addcircle1() {
        let circleRadius:CGFloat = 25
        
        circle1 = SKShapeNode(circleOfRadius: circleRadius)
        circle1.fillColor = UIColor.redColor()
        circle1.strokeColor = UIColor.redColor()
        circle1.position = CGPoint(x: self.size.width / 2, y: 350)
        circle1.name = "CIRCLE"
        circle1.physicsBody?.dynamic = false
        circle1.physicsBody = SKPhysicsBody(circleOfRadius: circleRadius)
        circle1.physicsBody?.categoryBitMask = CollisionBitMask.circle
        circle1.physicsBody?.collisionBitMask = 0
        circle1.physicsBody?.contactTestBitMask = CollisionBitMask.Obstacle
        
        circle2 = SKShapeNode(circleOfRadius: circleRadius)
        circle2.fillColor = UIColor.redColor()
        circle2.strokeColor = UIColor.redColor()
        circle2.position = CGPoint(x: self.size.width / 2, y: 350)
        circle2.name = "CIRCLE"
        circle2.physicsBody?.dynamic = false
        circle2.physicsBody = SKPhysicsBody(circleOfRadius: circleRadius)
        circle2.physicsBody?.categoryBitMask = CollisionBitMask.circle
        circle2.physicsBody?.collisionBitMask = 0
        circle2.physicsBody?.contactTestBitMask = CollisionBitMask.Obstacle
        
        addChild(circle1)
        addChild(circle2)
        
        initialcircle1Position = circle1.position
        
    }
    
    func addScore() {
        scoreLabel = SKLabelNode(fontNamed: "Optima-ExtraBlack")
        scoreLabel.fontColor = UIColor.yellowColor()
        scoreLabel.position = CGPoint(x: self.size.width - 150, y: self.size.height - 40)
        scoreLabel.text = "Score: \(score)"
        
        addChild(scoreLabel)
    }
    
    func addObstacle(type:ObstacleType) -> SKSpriteNode {
        let obstacle = SKSpriteNode(color: UIColor.whiteColor(), size: CGSize(width: 0, height: 30))
        obstacle.name = "OBSTACLE"
        obstacle.physicsBody?.dynamic = true
        
        switch type {
        case .small:
            obstacle.size.width = self.size.width * 0.2
            break
        case .medium:
            obstacle.size.width = self.size.width * 0.35
            break
        case .large:
            obstacle.size.width = self.size.width * 0.75
            break
        }
        
        obstacle.position = CGPoint(x: 0, y: self.size.height + obstacle.size.height)
        obstacle.physicsBody = SKPhysicsBody(rectangleOfSize: obstacle.size)
        obstacle.physicsBody?.categoryBitMask = CollisionBitMask.Obstacle
        obstacle.physicsBody?.collisionBitMask = 0
        
        return obstacle
    }
    
    func addObstacle(width:CGFloat) -> SKSpriteNode {
        let obstacle = SKSpriteNode(color: UIColor.whiteColor(), size: CGSize(width: width, height: 30))
        obstacle.name = "OBSTACLE"
        obstacle.physicsBody?.dynamic = true
        
        obstacle.position = CGPoint(x: 0, y: self.size.height + obstacle.size.height)
        obstacle.physicsBody = SKPhysicsBody(rectangleOfSize: obstacle.size)
        obstacle.physicsBody?.categoryBitMask = CollisionBitMask.Obstacle
        obstacle.physicsBody?.collisionBitMask = 0
        
        return obstacle
    }
    
    func addMovement(obstacle:SKSpriteNode) {
        var actionArray = [SKAction]()
        actionArray.append(SKAction.moveTo(CGPoint(x: obstacle.position.x, y: -obstacle.size.height), duration: NSTimeInterval(3)))
        actionArray.append(SKAction.removeFromParent())
        
        obstacle.runAction(SKAction.sequence(actionArray))
    }
    
    func addRow(type:RowType) {
        switch type {
        case .oneS:
            let obst = addObstacle(.small)
            obst.position = CGPoint(x: self.size.width / 2, y: obst.position.y)
            addMovement(obst)
            addChild(obst)
            break
        case .oneM:
            let obst = addObstacle(.medium)
            obst.position = CGPoint(x: self.size.width / 2, y: obst.position.y)
            addMovement(obst)
            addChild(obst)
            break
        case .oneL:
            let obst = addObstacle(.large)
            obst.position = CGPoint(x: self.size.width / 2, y: obst.position.y)
            addMovement(obst)
            addChild(obst)
            break;
        case .twoS:
            let obst1 = addObstacle(.small)
            let obst2 = addObstacle(.small)
            
            obst1.position = CGPoint(x: obst1.size.width + 50, y: obst1.position.y)
            obst2.position = CGPoint(x: self.size.width - obst2.size.width - 50, y: obst2.position.y)
            
            addMovement(obst1)
            addMovement(obst2)
            
            addChild(obst1)
            addChild(obst2)
            break
        case .twoM:
            let obst1 = addObstacle(.medium)
            let obst2 = addObstacle(.medium)
            
            obst1.position = CGPoint(x: obst1.size.width / 2 + 50, y: obst1.position.y)
            obst2.position = CGPoint(x: self.size.width - obst2.size.width / 2 - 50, y: obst2.position.y)
            
            addMovement(obst1)
            addMovement(obst2)
            
            addChild(obst1)
            addChild(obst2)
            break;
        case .threeS:
            let obst1 = addObstacle(.small)
            let obst2 = addObstacle(.small)
            let obst3 = addObstacle(.small)
            
            obst1.position = CGPoint(x: obst1.size.width / 2 + 50, y: obst1.position.y)
            obst2.position = CGPoint(x: self.size.width - obst2.size.width / 2 - 50, y: obst2.position.y)
            obst3.position = CGPoint(x: self.size.width / 2, y: obst3.position.y)
            
            addMovement(obst1)
            addMovement(obst2)
            addMovement(obst3)
            
            addChild(obst1)
            addChild(obst2)
            addChild(obst3)
            break
        }
    }
    
    func addRow(type:Int) {
        let openingSize:CGFloat = 90
        
        switch type {
        case 0:
            let obstacleSize = self.size.width / 2 - openingSize
            
            let obst1 = addObstacle(obstacleSize)
            let obst2 = addObstacle(obstacleSize)
            
            obst1.position = CGPoint(x: obst1.size.width / 2, y: obst1.position.y)
            obst2.position = CGPoint(x: self.size.width - obst2.size.width / 2, y: obst2.position.y)
            
            addMovement(obst1)
            addMovement(obst2)
            
            addChild(obst1)
            addChild(obst2)
            break
        case 1:
            let obstacleSize1 = self.size.width / 2 - self.size.width / 12 - 45
            let obstacleSize2 = self.size.width / 6 - 90
            
            let obst1 = addObstacle(obstacleSize1)
            let obst2 = addObstacle(obstacleSize1)
            let obst3 = addObstacle(obstacleSize2)
            
            obst1.position = CGPoint(x: obst1.size.width / 2, y: obst1.position.y)
            obst2.position = CGPoint(x: self.size.width - obst2.size.width / 2, y: obst2.position.y)
            obst3.position = CGPoint(x: self.size.width / 2, y: obst3.position.y)
            
            addMovement(obst1)
            addMovement(obst2)
            addMovement(obst3)
            
            addChild(obst1)
            addChild(obst2)
            addChild(obst3)
            break
        case 2:
            let obstacleSize1 = self.size.width / 2 - self.size.width / 6 - 45
            let obstacleSize2 = self.size.width / 3 - 90
            
            let obst1 = addObstacle(obstacleSize1)
            let obst2 = addObstacle(obstacleSize1)
            let obst3 = addObstacle(obstacleSize2)
            
            obst1.position = CGPoint(x: obst1.size.width / 2, y: obst1.position.y)
            obst2.position = CGPoint(x: self.size.width - obst2.size.width / 2, y: obst2.position.y)
            obst3.position = CGPoint(x: self.size.width / 2, y: obst3.position.y)
            
            addMovement(obst1)
            addMovement(obst2)
            addMovement(obst3)
            
            addChild(obst1)
            addChild(obst2)
            addChild(obst3)
            break;
        case 3:
            let obstacleSize1 = self.size.width / 2 - self.size.width / 4 - 45
            let obstacleSize2 = self.size.width / 2 - 90
            
            let obst1 = addObstacle(obstacleSize1)
            let obst2 = addObstacle(obstacleSize1)
            let obst3 = addObstacle(obstacleSize2)
            
            obst1.position = CGPoint(x: obst1.size.width / 2, y: obst1.position.y)
            obst2.position = CGPoint(x: self.size.width - obst2.size.width / 2, y: obst2.position.y)
            obst3.position = CGPoint(x: self.size.width / 2, y: obst3.position.y)
            
            addMovement(obst1)
            addMovement(obst2)
            addMovement(obst3)
            
            addChild(obst1)
            addChild(obst2)
            addChild(obst3)
            break
        case 4:
            let obstacleSize1 = self.size.width / 2 - self.size.width * 5 / 12 - 45
            let obstacleSize2 = self.size.width * 5 / 6 - 90
            
            let obst1 = addObstacle(obstacleSize1)
            let obst2 = addObstacle(obstacleSize1)
            let obst3 = addObstacle(obstacleSize2)
            
            obst1.position = CGPoint(x: obst1.size.width / 2, y: obst1.position.y)
            obst2.position = CGPoint(x: self.size.width - obst2.size.width / 2, y: obst2.position.y)
            obst3.position = CGPoint(x: self.size.width / 2, y: obst3.position.y)
            
            addMovement(obst1)
            addMovement(obst2)
            addMovement(obst3)
            
            addChild(obst1)
            addChild(obst2)
            addChild(obst3)
            break;
        case 5:
            let obstacleSize = self.size.width - openingSize * 2
            
            let obst = addObstacle(obstacleSize)
            obst.position = CGPoint(x: self.size.width / 2, y: obst.position.y)
            addMovement(obst)
            addChild(obst)
            
            break
        default:
            break
        }
    }
}