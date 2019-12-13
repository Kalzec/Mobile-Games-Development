//
//  Player.swift
//  Square World - Attack of the Roundies
//
//  Created by Michael Wolf on 25/11/2019.
//  Copyright © 2019 Michael Wolf. All rights reserved.
//
import SpriteKit
import GameplayKit
import AVFoundation

class Player: SKScene
{
        private var player : SKSpriteNode?
    
    override func sceneDidLoad() {
        
    self.player = self.childNode(withName: "//squareBoy") as? SKSpriteNode
    }
    
    func touchDown(atPoint pos : CGPoint) {
        print("yes")
    }
}
