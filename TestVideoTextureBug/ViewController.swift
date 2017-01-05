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

class ViewController: UIViewController {
	@IBOutlet weak var scnView: SCNView!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		scnView.showsStatistics = true
		scnView.allowsCameraControl = true

		let scnScene = SCNScene()
		scnView.scene = scnScene

		print("scnView renderingAPI is metal", scnView.renderingAPI == SCNRenderingAPI.metal)
		print("scnView renderingAPI is opengl", scnView.renderingAPI == SCNRenderingAPI.openGLES2)

		// setup SceneKit scene
		let cameraNode = SCNNode()
		cameraNode.camera = SCNCamera()
		cameraNode.position = SCNVector3(x: 0.0, y: 0.0, z: 25.0)
		scnScene.rootNode.addChildNode(cameraNode)
        scnScene.background.contents = UIColor.lightGray

		let cubeNode = SCNNode()
		cubeNode.geometry = SCNBox(width: 5.0, height: 5.0, length: 5.0, chamferRadius: 0.0)
		scnScene.rootNode.addChildNode(cubeNode)

		// setup SpriteKit Scene
		let skScene = SKScene()
		skScene.backgroundColor = UIColor.green
		skScene.size = CGSize(width: 480, height: 360)

        let videoNode = SKVideoNode(url: URL(string: "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8")!)
        videoNode.yScale = -1
        videoNode.size = CGSize(width: 480, height: 360)
        videoNode.position = CGPoint(x: 240, y: 180)
        skScene.addChild(videoNode)

		cubeNode.geometry?.firstMaterial?.diffuse.contents = skScene

        let cubeRotation = CABasicAnimation(keyPath: "transform")
        cubeRotation.toValue = NSValue(scnMatrix4: SCNMatrix4Rotate(cubeNode.transform, Float.pi, 1, 1, 0))
        cubeRotation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        cubeRotation.repeatCount = Float.greatestFiniteMagnitude
        cubeRotation.duration = 5.0
        cubeNode.addAnimation(cubeRotation, forKey: "RotateCube")

        videoNode.play()
	}
}

