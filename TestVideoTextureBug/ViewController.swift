//
//  ViewController.swift
//  TestVideoTextureBug
//
//  Created by Guillaume Sabran on 9/14/16.
//  Copyright © 2016 Guillaume Sabran. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {

	@IBOutlet weak var scnView: SCNView!


	var playerController: PlayerController!
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		playerController = PlayerController(view: scnView)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

