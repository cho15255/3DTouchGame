//
//  GameOverScene.swift
//  3DTouchGame
//
//  Created by Jae Hee Cho on 2016-06-28.
//  Copyright © 2016 Jae Hee Cho. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    var score:Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    convenience init(size: CGSize, score: Int) {
        self.init(size: size)
        self.score = score
        
        self.backgroundColor = SKColor.blackColor()
        let message = "GAME OVER"
        
        let label = SKLabelNode(fontNamed: "Optima-ExtraBlack")
        label.text = message
        label.fontColor = SKColor.whiteColor()
        label.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        
        if score > NSUserDefaults.standardUserDefaults().integerForKey("highscore") {
            NSUserDefaults.standardUserDefaults().setInteger(score, forKey: "highscore")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        let highScoreLabel = SKLabelNode(fontNamed: "Optima-ExtraBlack")
        highScoreLabel.text = "HighScore: \(NSUserDefaults.standardUserDefaults().integerForKey("highscore"))"
        highScoreLabel.fontColor = SKColor.whiteColor()
        highScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2 - 40)
        
        let scoreLabel = SKLabelNode(fontNamed: "Optima-ExtraBlack")
        scoreLabel.text = "Score: \(self.score)"
        scoreLabel.fontColor = SKColor.whiteColor()
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2 - 80)
        
        addChild(label)
        addChild(highScoreLabel)
        addChild(scoreLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let transition = SKTransition.fadeWithDuration(0.5)
        let gameScene = GameScene(size: self.size)
        self.view?.presentScene(gameScene, transition: transition)
    }
}
