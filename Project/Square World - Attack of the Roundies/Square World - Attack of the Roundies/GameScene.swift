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
    private var enemy : SKSpriteNode?
    private var walls : SKReferenceNode?
    
    let enemySpawn = GKRandomDistribution(forDieWithSideCount: 4)
    
    
    override func sceneDidLoad() {

        //create the player
        self.player = self.childNode(withName: "//squareBoy") as? SKSpriteNode
        self.enemy = self.childNode(withName: "//roundie") as? SKSpriteNode
        self.walls = self.childNode(withName: "//Walls") as? SKReferenceNode
        
        var enemyX:CGFloat?
        var enemyY:CGFloat?
        
        var spawnChoose:Int = enemySpawn.nextInt()

        if spawnChoose == 0
        {
            enemyX = 50
            enemyY = 50
        }
        
        if spawnChoose == 1
        {
            enemyX = -500
            enemyY = 100
        }
        
        if spawnChoose == 2
        {
            enemyX = 864
            enemyY = 256
        }
        
        if spawnChoose == 3
        {
            enemyX = 150
            enemyY = -500
        }
        
        if spawnChoose == 4
        {
            enemyX = -500
            enemyY = -500
        }
        
        let spawnX = SKAction.moveTo(x: enemyX!, duration: 0)
        let spawnY = SKAction.moveTo(y: enemyY!, duration: 0)
        
        let enemySpawnSeq = SKAction.sequence([spawnX, spawnY])
        
        enemy?.run(enemySpawnSeq)
        
    
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
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        

    }
    

    //enemy spawns

    
    @objc func enemySpawner()
    {
        

    }
    
    
    
    var moving:Bool = false //bool to check if current player or enemy is moving
    var playerTurn:Bool = true //bool to check if it is players turn to move
    var moveTimer:Double = 15 //
    
    let right = SKAction.moveBy(x: 1920, y: 0, duration: 1)
    let left = SKAction.moveBy(x: -1920, y: 0, duration: 1)
    let up = SKAction.moveBy(x: 0, y: 1080, duration: 1)
    let down = SKAction.moveBy(x: 0, y: -1080, duration: 1)
    
        //move right
        @objc func swipeRight (sender:UISwipeGestureRecognizer){
            if playerTurn == true{
                if moving == false {
                    player?.run(right)
                    moving = true
                    playerTurn = false
                    
                    player?.physicsBody?.isDynamic = true
                    enemy?.physicsBody?.isDynamic = false
                }
            }
            
            if playerTurn == false{
                if moving == false{
                    enemy?.run(right)
                    moving = true
                    playerTurn = true
                    
                    player?.physicsBody?.isDynamic = false
                    enemy?.physicsBody?.isDynamic = true
                }
            }
        }
        //move left
        @objc func swipeLeft (sender:UISwipeGestureRecognizer){
            if playerTurn == true{
                if moving == false{
                    player?.run(left)
                    moving = true
                    playerTurn = false

                    player?.physicsBody?.isDynamic = true
                    enemy?.physicsBody?.isDynamic = false
                }
            }
            
            if playerTurn == false{
                if moving == false{
                    enemy?.run(left)
                    moving = true
                    playerTurn = true
                    
                    player?.physicsBody?.isDynamic = false
                    enemy?.physicsBody?.isDynamic = true
                }
            }
        }
        //move up
        @objc func swipeUp (sender:UISwipeGestureRecognizer){
            if playerTurn == true{
                if moving == false{
                    player?.run(up)
                    moving = true
                    playerTurn = false
                    
                    player?.physicsBody?.isDynamic = true
                    enemy?.physicsBody?.isDynamic = false
                }
            }
            
            if playerTurn == false{
                if moving == false{
                    enemy?.run(up)
                    moving = true
                    playerTurn = true
                    
                    player?.physicsBody?.isDynamic = false
                    enemy?.physicsBody?.isDynamic = true
                }
            }
        }
        //move down
        @objc func swipeDown (sender:UISwipeGestureRecognizer){
            if playerTurn == true{
                if moving == false{
                    player?.run(down)
                    moving = true
                    playerTurn = false
                    
                    player?.physicsBody?.isDynamic = true
                    enemy?.physicsBody?.isDynamic = false
                }
            }
            
            if playerTurn == false{
                if moving == false{
                    enemy?.run(down)
                    moving = true
                    playerTurn = true
                    
                    player?.physicsBody?.isDynamic = false
                    enemy?.physicsBody?.isDynamic = true
                }
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

extension GameScene: SKPhysicsContactDelegate {
    
}

