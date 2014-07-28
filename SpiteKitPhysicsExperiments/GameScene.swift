//
//  GameScene.swift
//  SpiteKitPhysicsExperiments
//
//  Created by Simon Gladman on 27/07/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import SpriteKit

let fieldMask : UInt32 = 0b1;
let categoryMask: UInt32 = 0b1;

class GameScene: SKScene {
  
    let fieldNode: SKFieldNode;
    //let dragField: SKFieldNode;
    
  
    init(coder aDecoder: NSCoder!)
    {
        //dragField = SKFieldNode.dragField();
        
        fieldNode = SKFieldNode.radialGravityField();
        fieldNode.physicsBody = SKPhysicsBody(circleOfRadius: 80)
        fieldNode.categoryBitMask = categoryMask;
        fieldNode.strength = 2.0;
        super.init(coder: aDecoder)
    }

    
    override func didMoveToView(view: SKView)
    {
        self.scene.backgroundColor = UIColor.darkGrayColor();
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        let physicsBody = SKPhysicsBody (edgeLoopFromRect: self.frame);
        self.physicsBody = physicsBody;
        self.addChild(fieldNode)
        
        for i in 1...10
        {
            let shape = SKShapeNode(circleOfRadius: 20);
            shape.strokeColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.5);
            shape.fillColor = UIColor.blueColor()
            shape.lineWidth = 4
            shape.position = CGPoint (x: i * 10, y: i * 10)
            self.addChild(shape);
            
            shape.physicsBody = SKPhysicsBody(circleOfRadius: shape.frame.size.width/2)
            shape.physicsBody.friction = 0.7

            shape.physicsBody.restitution = 0.4;
            shape.physicsBody.mass = 0.75;
            shape.physicsBody.allowsRotation = false
            shape.physicsBody.fieldBitMask = fieldMask;
 
            let untypedEmitter : AnyObject = NSKeyedUnarchiver.unarchiveObjectWithFile(NSBundle.mainBundle().pathForResource("MyParticle", ofType: "sks"));
            
            var emitter:SKEmitterNode = untypedEmitter as SKEmitterNode;
                       emitter.targetNode = shape;
 
            shape.addChild(emitter)
        }

    }

    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!)
    {
        let touch = event.allTouches().anyObject().locationInNode(self);
        self.fieldNode.position = touch;
    }
   
    override func update(currentTime: CFTimeInterval)
    {
        /* Called before each frame is rendered */
        println(currentTime)
    }
}
