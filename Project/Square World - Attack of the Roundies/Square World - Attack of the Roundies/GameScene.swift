//
//  GameScene.swift
//  Square World - Attack of the Roundies
//
//  Created by Michael Wolf on 21/10/2019.
//  Copyright © 2019 Michael Wolf. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation
import UIKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    let defaults = UserDefaults.standard
    
    //Ui
    lazy var healthLabel: SKLabelNode = {
        let label = SKLabelNode(fontNamed: "Marker Felt")
        label.text = "100"
        label.fontSize = 96
        label.fontColor = .yellow
        label.position = CGPoint(x: -480, y: 373)
        return label
    }()
    
    lazy var moveLabel: SKLabelNode = {
        let label = SKLabelNode(fontNamed: "Marker Felt")
        label.text = "0"
        label.fontSize = 96
        label.fontColor = .yellow
        label.position = CGPoint(x: 210, y: 373)
        return label
    }()
    
    lazy var levelLabel: SKLabelNode = {
        let label = SKLabelNode(fontNamed: "Marker Felt")
        label.text = "1"
        label.fontSize = 96
        label.fontColor = .yellow
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        label.position = CGPoint(x: 770, y: 373)
        return label
    }()



    
    var Moves:Int = 0
    var Health:Int = 100
    var Level:Int = UserDefaults.standard.integer(forKey: "Level")
    

    //create audio player
    var audioPlayer = AVAudioPlayer()
    
    //tests
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    //for update stuff
    private var lastUpdateTime : TimeInterval = 0
    
    //variables to hold the player, enemy and the walls
    private var player : SKSpriteNode?
    private var enemy : SKSpriteNode?
    private var walls : SKReferenceNode?
    
    //random numbers for spawning and moving the enemy
    let enemySpawn = GKRandomDistribution(forDieWithSideCount: 4)
    let enemyMove = GKRandomDistribution(forDieWithSideCount: 4)
    

    override func sceneDidLoad() {
        
        //audioPlayer.play()
        
        //create the UI
        addChild(healthLabel)
        addChild(moveLabel)
        addChild(levelLabel)
    
        let levelString = String(defaults.integer(forKey: "Level"))
        levelLabel.text = levelString
        
        //set bumping sound
        let sound = Bundle.main.path(forResource: "Fantasia Fantasia", ofType:"mp3")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            //couldn't load file :(
            print(error)
        }
        
        //create the player
        self.player = self.childNode(withName: "//squareBoy") as? SKSpriteNode
        self.enemy = self.childNode(withName: "//roundie") as? SKSpriteNode
        self.walls = self.childNode(withName: "//Walls") as? SKReferenceNode
        
        //pathfinding 

        //variables to hold enemy spawn position
        var enemyX:CGFloat?
        var enemyY:CGFloat?
        
        //set chosen spawn from random enemySpawn variable
        let spawnChoose:Int = enemySpawn.nextInt()

        //set spawn depensing on random number chosen
        if spawnChoose == 1
        {
            enemyX = 864
            enemyY = -444
        }
        if spawnChoose == 2
        {
            enemyX = 864
            enemyY = 256
        }
        if spawnChoose == 3
        {
            enemyX = 608
            enemyY = 64
        }
        if spawnChoose == 4
        {
            enemyX = 32
            enemyY = 128
        }
        
        //create the actions to move the enemy to spawn point
        let spawnX = SKAction.moveTo(x: enemyX!, duration: 0)
        let spawnY = SKAction.moveTo(y: enemyY!, duration: 0)
        
        let enemySpawnSeq = SKAction.sequence([spawnX, spawnY])
        
        enemy?.run(enemySpawnSeq)
        
        self.lastUpdateTime = 0
    }
    
    //function to handle swipe gestures
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstObject = String(describing: contact.bodyA.node!.name!)
        var secondObject = String(describing:contact.bodyB.node!.name!)
        //print("Contact Detected between: \(firstObject) and \(secondObject)")
        
        if firstObject == "roundie" && secondObject == "squareBoy"
        {
            if playerTurn == false
            {
                
                print ("player hit enemy, move enemy to random place")
                //variables to hold enemy spawn position
                var enemyX:CGFloat?
                var enemyY:CGFloat?
                
                //increase level by 1 every time enemy is hit
                Level += 1
                defaults.set(Level, forKey: "Level")
                let levelString = String(defaults.integer(forKey: "Level"))
                levelLabel.text = levelString
                
                //set chosen spawn from random enemySpawn variable
                let spawnChoose:Int = enemySpawn.nextInt()
                
                //set spawn depensing on random number chosen
                if spawnChoose == 1
                {
                    enemyX = 489
                    enemyY = 260
                }
                if spawnChoose == 2
                {
                    enemyX = -544
                    enemyY = -64
                }
                if spawnChoose == 3
                {
                    enemyX = 224
                    enemyY = 252
                }
                if spawnChoose == 4
                {
                    enemyX = 288
                    enemyY = 128
                }
                
                //create the actions to move the enemy to spawn point
                let spawnX = SKAction.moveTo(x: enemyX!, duration: 0)
                let spawnY = SKAction.moveTo(y: enemyY!, duration: 0)
                
                let enemySpawnSeq = SKAction.sequence([spawnX, spawnY])
                
                enemy?.run(enemySpawnSeq)
                
            }
            if playerTurn == true
            {
                print ("enemy hit player, move player to random place and lower health")
                Health -= 10
                
                let healthString = String(Health)
                healthLabel.text = healthString
                
                //variables to hold enemy spawn position
                var playerX:CGFloat?
                var playerY:CGFloat?
                
                //set chosen spawn from random enemySpawn variable
                let spawnChoose:Int = enemySpawn.nextInt()
                
                //set spawn depensing on random number chosen
                if spawnChoose == 1
                {
                    playerX = 489
                    playerY = 260
                }
                if spawnChoose == 2
                {
                    playerX = -544
                    playerY = -64
                }
                if spawnChoose == 3
                {
                    playerX = 224
                    playerY = 252
                }
                if spawnChoose == 4
                {
                    playerX = 288
                    playerY = 128
                }
                
                //create the actions to move the enemy to spawn point
                let spawnX = SKAction.moveTo(x: playerX!, duration: 0)
                let spawnY = SKAction.moveTo(y: playerY!, duration: 0)
                
                let playerSpawnSeq = SKAction.sequence([spawnX, spawnY])
                
                player?.run(playerSpawnSeq)

            }
        }
    }
    

    
    var moving:Bool = false //bool to check if current player or enemy is moving
    var playerTurn:Bool = true //bool to check if it is players turn to move
    var moveTimer:Double = 15 //
    
    //bools to check if tiles for enemy to move are clear
    var rightClear:Bool = true
    var upClear:Bool = true
    var leftClear:Bool = true
    var downClear:Bool = true
    
    var enemySpaceCheck:Bool = false //bool for checking enemy space
    
    //set actions for moving
    let right = SKAction.moveBy(x: 1920, y: 0, duration: 1)
    let left = SKAction.moveBy(x: -1920, y: 0, duration: 1)
    let up = SKAction.moveBy(x: 0, y: 1080, duration: 1)
    let down = SKAction.moveBy(x: 0, y: -1080, duration: 1)
    
    //Players turn - controlled by Swipe Gesturing
    
        //move right
        @objc func swipeRight (sender:UISwipeGestureRecognizer){
            if playerTurn == true{
                if moving == false {
                    player?.run(right)
                    moving = true
                    playerTurn = false
                    enemySpaceCheck = true
                    
                    player?.physicsBody?.isDynamic = true
                    enemy?.physicsBody?.isDynamic = false
                    
                    Moves += 1
                    let moveString = String(Moves)
                    moveLabel.text = moveString
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
                    enemySpaceCheck = true

                    player?.physicsBody?.isDynamic = true
                    enemy?.physicsBody?.isDynamic = false
                    
                    Moves += 1
                    let moveString = String(Moves)
                    moveLabel.text = moveString
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
                    enemySpaceCheck = true
                    
                    player?.physicsBody?.isDynamic = true
                    enemy?.physicsBody?.isDynamic = false
                    
                    Moves += 1
                    let moveString = String(Moves)
                    moveLabel.text = moveString
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
                    enemySpaceCheck = true
                    
                    player?.physicsBody?.isDynamic = true
                    enemy?.physicsBody?.isDynamic = false
                    
                    Moves += 1
                    let moveString = String(Moves)
                    moveLabel.text = moveString
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
        
        
        
        //set timer to move again, temporary
        if moving{
            moveTimer -= 0.4
            if moveTimer <= 0{
                moving = false
                moveTimer = 50
            }
        }
        
        //enemy turn

        if enemySpaceCheck
        {
            //Convert enemy x and y positions to Ints
            var enemyX = Int(enemy!.position.x)
            var enemyY = Int(enemy!.position.y)
        
            //Convert Walls x and y position to Ints
            let wallsX = Int(walls!.position.x)
            let wallsY = Int(walls!.position.y)
            
        }
        
        //checking if tiles are clear

        
        if playerTurn == false
        {
            if moving == false{
                let moveChoose:Int = enemyMove.nextInt()
                
                if moveChoose == 1
                {
                    if rightClear == true
                    {
                        enemy?.run(right)
                        enemySpaceCheck = false
                    }
                }
                if moveChoose == 2
                {
                    if upClear == true
                    {
                        enemy?.run(up)
                        enemySpaceCheck = false
                    }
                }
                if moveChoose == 3
                {
                    if leftClear == true
                    {
                        enemy?.run(left)
                        enemySpaceCheck = false
                    }
                }
                if moveChoose == 4
                {
                    if downClear == true
                    {
                        enemy?.run(down)
                        enemySpaceCheck = false
                    }
                }
                
                moving = true
                playerTurn = true
                
                //player?.physicsBody?.isDynamic = false
                enemy?.physicsBody?.isDynamic = true
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


