//
//  GameOverScene.swift
//  3DTouchGame
//
//  Created by Jae Hee Cho on 2016-06-28.
//  Copyright © 2016 Jae Hee Cho. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.backgroundColor = SKColor.blackColor()
        let message = "GAME OVER"
        
        let label = SKLabelNode(fontNamed: "Optima-ExtraBlack")
        label.text = message
        label.fontColor = SKColor.whiteColor()
        label.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        
        addChild(label)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let transition = SKTransition.fadeWithDuration(0.5)
        let gameScene = GameScene(size: self.size)
        self.view?.presentScene(gameScene, transition: transition)
    }
}
