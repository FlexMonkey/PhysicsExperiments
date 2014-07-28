//
//  GameScene.swift
//  SpiteKitPhysicsExperiments
//
//  Created by Simon Gladman on 27/07/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    
    let canvasWidth: UInt32 = 800
    let canvasHeight: UInt32 = 800
    
    override func didMoveToView(view: SKView)
    {
        self.scene.backgroundColor = UIColor.yellowColor();
        
        self.physicsWorld.gravity = CGVectorMake(0, -6);
        let physicsBody = SKPhysicsBody (edgeLoopFromRect: self.frame);
        self.physicsBody = physicsBody;
        
        for i in 1...30
        {
            let shape = SKShapeNode(circleOfRadius: 20);
            shape.strokeColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.5);
            shape.fillColor = UIColor.blueColor()
            shape.lineWidth = 4
            shape.position = CGPoint (x: i * 10, y: i * 10)
            self.addChild(shape);
            
            shape.physicsBody = SKPhysicsBody(circleOfRadius: shape.frame.size.width/2)
            shape.physicsBody.friction = 0.3
            shape.physicsBody.restitution = 0.9;
            shape.physicsBody.mass = 0.5
                      shape.physicsBody.allowsRotation = false
      
            let xyzzy : AnyObject = NSKeyedUnarchiver.unarchiveObjectWithFile(NSBundle.mainBundle().pathForResource("MyParticle", ofType: "sks"));
            var particle:SKEmitterNode = xyzzy as SKEmitterNode;
            particle.targetNode = shape;

            particle.particleLifetime = 1.5;
 
            shape.addChild(particle)
        }

    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
  
    }
   
    override func update(currentTime: CFTimeInterval)
    {
        /* Called before each frame is rendered */
        println(currentTime)
    }
}
