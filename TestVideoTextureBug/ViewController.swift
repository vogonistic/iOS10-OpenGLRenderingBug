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

		let cubeNode = SCNNode()
		cubeNode.geometry = SCNBox(width: 5.0, height: 5.0, length: 5.0, chamferRadius: 0.0)
		scnScene.rootNode.addChildNode(cubeNode)

		// setup SpriteKit Scene
		let skScene = SKScene()
		skScene.backgroundColor = UIColor.black
		skScene.size = CGSize(width: 100, height: 100)

		let skNode = SKShapeNode(rect: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 10.0))
		skNode.fillColor = UIColor.green
		skNode.position = CGPoint(x: 5.0, y: 5.0)
		skScene.addChild(skNode)

		cubeNode.geometry?.firstMaterial?.diffuse.contents = skScene
	}
}

