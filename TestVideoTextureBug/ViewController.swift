//
//  ViewController.swift
//  TestVideoTextureBug
//
//  Created by Guillaume Sabran on 9/14/16.
//  Copyright © 2016 Guillaume Sabran. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

let kShowVideo = true

class ViewController: GLKViewController {
    var renderer: SCNRenderer!

	override func viewDidLoad() {
        print("\(#function)")
		super.viewDidLoad()

        let scnScene = SCNScene()

		// setup SceneKit scene
		let cameraNode = SCNNode()
		cameraNode.camera = SCNCamera()
		cameraNode.position = SCNVector3(x: 0.0, y: 0.0, z: 20.0)
		scnScene.rootNode.addChildNode(cameraNode)
        scnScene.background.contents = UIColor.lightGray

		let cubeNode = SCNNode()
		cubeNode.geometry = SCNBox(width: 5.0, height: 5.0, length: 5.0, chamferRadius: 0.0)
		scnScene.rootNode.addChildNode(cubeNode)

		// setup SpriteKit Scene
        let size = CGSize(width: 480, height: 480)
		let skScene = SKScene()
		skScene.backgroundColor = UIColor.blue
		skScene.size = size

        if kShowVideo {
            let videoNode = SKVideoNode(url: URL(string: "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8")!)
            videoNode.yScale = -1
            videoNode.xScale = -1
            videoNode.size = size
            videoNode.position = CGPoint(x: size.width/2.0, y: size.height/2.0)
            skScene.addChild(videoNode)

            videoNode.play()
        } else {
            let skNode = SKShapeNode(rect: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 10.0))
            skNode.fillColor = UIColor.green
            skNode.position = CGPoint(x: 5.0, y: 5.0)
            skScene.addChild(skNode)
        }

		cubeNode.geometry?.firstMaterial?.diffuse.contents = skScene
//        cubeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        cubeNode.geometry?.firstMaterial?.isDoubleSided = true

        let context = EAGLContext(api: .openGLES2)!
        EAGLContext.setCurrent(context)
        (view as? GLKView)?.context = context

        renderer = SCNRenderer(context: context, options: nil)
        renderer.scene = scnScene
        renderer.showsStatistics = true
    }

    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(1.0, 1.0, 1.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT))

        renderer.render(atTime: 0.0)
    }
}

