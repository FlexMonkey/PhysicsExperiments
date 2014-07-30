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
    var shapeEmitterTuples : [(SKShapeNode,SKEmitterNode)];

    init(coder aDecoder: NSCoder!)
    {
        shapeEmitterTuples = [];
        fieldNode = SKFieldNode.radialGravityField();
        fieldNode.falloff = 0.5;
        fieldNode.animationSpeed = 0.5; 
        fieldNode.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        fieldNode.categoryBitMask = categoryMask;
        super.init(coder: aDecoder)
    }

    
    override func didMoveToView(view: SKView)
    {
        self.scene.backgroundColor = UIColor.darkGrayColor();
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        let physicsBody = SKPhysicsBody (edgeLoopFromRect: self.frame);
        self.physicsBody = physicsBody;
        self.addChild(fieldNode);
        
        for i in 1...15
        {
            let shape = SKShapeNode(circleOfRadius: 20);
            shape.strokeColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.5);
            shape.fillColor = UIColor.blueColor()
            shape.lineWidth = 4
            shape.position = CGPoint();
           
            shape.position.x = self.size.width / 2;
            shape.position.y = self.size.height / 2;
            
            addChild(shape);
            
            shape.physicsBody = SKPhysicsBody(circleOfRadius: 20);
            shape.physicsBody.friction = 0;
            shape.physicsBody.charge = 4;
            shape.physicsBody.restitution = 0.4;
            shape.physicsBody.mass = 1;
            shape.physicsBody.allowsRotation = true
            shape.physicsBody.fieldBitMask = fieldMask;
            
            let untypedEmitter : AnyObject = NSKeyedUnarchiver.unarchiveObjectWithFile(NSBundle.mainBundle().pathForResource("MyParticle", ofType: "sks"));
            
            let emitter:SKEmitterNode = untypedEmitter as SKEmitterNode;
            
            emitter.particlePosition = shape.position;
            addChild(emitter)

            let shapeEmitterTuple = (shape, emitter);
            shapeEmitterTuples.append(shapeEmitterTuple);
        }

    }

    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!)
    {
        fieldNode.strength = 0;
    }
    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!)
    {
        let touch = event.allTouches().anyObject().locationInNode(self);
        
        fieldNode.strength = 2;
        self.fieldNode.position = touch;
    }
   
    override func update(currentTime: CFTimeInterval)
    {
        for (shape, emitter) in shapeEmitterTuples
        {
            emitter.particlePosition = shape.position;
        }
    }
}
