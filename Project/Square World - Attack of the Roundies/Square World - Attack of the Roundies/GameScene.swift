//
//  GameScene.swift
//  Square World - Attack of the Roundies
//
//  Created by Michael Wolf on 21/10/2019.
//  Copyright © 2019 Michael Wolf. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    
    private var player : SKSpriteNode?
    
    override func sceneDidLoad() {

        //create the player
        self.player = self.childNode(withName: "//squareBoy") as? SKSpriteNode
        
        self.lastUpdateTime = 0
        

    }
    
    override func didMove(to view: SKView) {
        let swipeRight = UISwipeGestureRecognizer(target: self,
                                                  action: #selector(GameScene.swipeRight(sender:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self,
                                                  action: #selector(GameScene.swipeLeft(sender:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(GameScene.swipeUp(sender:)))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self,
                                               action: #selector(GameScene.swipeDown(sender:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }
    
    var moving:Bool = false
    var moveTimer:Double = 50
    
    let right = SKAction.moveBy(x: 400, y: 0, duration: 0.6)
    let left = SKAction.moveBy(x: -400, y: 0, duration: 0.6)
    let up = SKAction.moveBy(x: 0, y: 400, duration: 0.6)
    let down = SKAction.moveBy(x: 0, y: -400, duration: 0.6)
    

        //move right
        @objc func swipeRight (sender:UISwipeGestureRecognizer){
            if moving == false {
                player?.run(right)
                moving = true
            }
        }
        //move left
        @objc func swipeLeft (sender:UISwipeGestureRecognizer){
            if moving == false{
                player?.run(left)
                moving = true
            }
        }
        //move up
        @objc func swipeUp (sender:UISwipeGestureRecognizer){
            if moving == false{
                player?.run(up)
                moving = true
            }
        }
        //move down
        @objc func swipeDown (sender:UISwipeGestureRecognizer){
            if moving == false{
                player?.run(down)
                moving = true
            }
        }
    

    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        //set timer to move again, temporary
        if moving{
            moveTimer -= 0.4
            if moveTimer <= 0{
                moving = false
                moveTimer = 50
            }
        }
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
