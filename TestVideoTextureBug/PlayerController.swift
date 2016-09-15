//
//  PlayerController.swift
//  TestVideoTextureBug
//
//  Created by Guillaume Sabran on 9/14/16.
//  Copyright © 2016 Guillaume Sabran. All rights reserved.
//

import Foundation
import UIKit

import SceneKit
import AVFoundation
import CoreGraphics

class PlayerController: SCNScene {

	var scnView: SCNView!
	var scnScene: SCNScene!
	var mainNode: SCNNode!
	var videoPlayer: AVPlayer!
	var playerItem: AVPlayerItem?
	var videoLayer: AVPlayerLayer!

	var displayView: UIImageView!
	var caDisplay: UIView!

	convenience init(view: SCNView, display: UIImageView, caDisplay: UIView) {
		self.init()
		self.displayView = display
		self.caDisplay = caDisplay

		setUpScene(on: view)
		setUpVideo()
	}

	private func setUpScene(on view: SCNView) {
		//scnView = SCNView(frame: view.bounds, options: [SCNView.Option.preferredRenderingAPI.rawValue: SCNRenderingAPI.openGLES2])
		scnView = view
		scnView.frame = view.bounds
		scnView.showsStatistics = true
		scnView.allowsCameraControl = true
		scnView.scene = self
		scnView.isPlaying = true

		print("scnView renderingAPI is metal", scnView.renderingAPI == SCNRenderingAPI.metal)
		print("scnView renderingAPI is opengl", scnView.renderingAPI == SCNRenderingAPI.openGLES2)

		scnView.delegate = self


		let cameraNode = SCNNode()
		cameraNode.camera = SCNCamera()
		cameraNode.camera?.zNear = 0.1
		cameraNode.camera?.zFar = 150.0
		cameraNode.position = SCNVector3(x: 0.0, y: 0.0, z: 25.0)
		rootNode.addChildNode(cameraNode)

		mainNode = SCNNode()
		mainNode.geometry = SCNBox(width: 5.0, height: 5.0, length: 5.0, chamferRadius: 0.0)
		mainNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
		rootNode.addChildNode(mainNode)
	}

	private func setUpVideo() {
		let item = AVPlayerItem(url: URL(fileURLWithPath: Bundle.main.path(forResource: "test", ofType: "mp4")!))
		item.addObserver(
			self,
			forKeyPath: "status",
			options: .new,
			context: nil
		)

		NotificationCenter.default
			.addObserver(
				self,
				selector: #selector(restartVideo),
				name: .AVPlayerItemDidPlayToEndTime,
				object: item
		)
		videoPlayer = AVPlayer(playerItem: item)

		videoLayer = AVPlayerLayer(player: videoPlayer)

		DispatchQueue.main.async {
			self.caDisplay.layer.insertSublayer(self.videoLayer, at: 0)
		}

		playerItem = item
	}

	override func observeValue(forKeyPath keyPath: String?,
	                           of object: Any?,
	                           change: [NSKeyValueChangeKey : Any]?,
	                           context: UnsafeMutableRawPointer?) {

		if let player = videoPlayer,
			let object = object as? AVPlayerItem,
			let item = player.currentItem, object == item,
			let key = keyPath, key == "status" {

			// Checks whether the video has buffered enough, and starts to play.
			if item.status == .readyToPlay, let size = item.asset.tracks(
				withMediaType: AVMediaTypeVideo).first?.naturalSize {
				self.videoIsReadyToPlay(item: item, size: size)
			}
		}
	}

	private func videoIsReadyToPlay(item: AVPlayerItem, size: CGSize) {
		print("videoIsReadyToPlay")
		// self.mainNode.geometry?.firstMaterial?.diffuse.contents = self.imageLayer
		videoPlayer.play()
	}


	func restartVideo() {
		videoPlayer.seek(to: CMTime(seconds: 0.0, preferredTimescale: 1))
		videoPlayer.play()
	}
}

extension PlayerController: SCNSceneRendererDelegate {
	func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
		// updateFrame()
	}
}
