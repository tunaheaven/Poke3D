//
//  ViewController.swift
//  Poke3D
//
//  Created by FF2 on 11/5/21.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = true
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "PokemonCards", bundle: Bundle.main) {
            configuration.trackingImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 4
            print("Imagest addes successfully.")
        }
        
        
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        if let imageAnchor = anchor as? ARImageAnchor {
            print(imageAnchor.referenceImage.name)
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5) // half transparent
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi/2 //rotete the plane 90 diegree so that it lays flat
            node.addChildNode(planeNode)
            
            if imageAnchor.referenceImage.name!.contains("eevee-card") {
                if let pokeScene = SCNScene(named: "art.scnassets/eevee.scn") {
                    if let pokeNode = pokeScene.rootNode.childNodes.first {
                        pokeNode.eulerAngles.x = .pi/2 //rotete the pokemon 90 diegree so that it stands on the card
                        planeNode.addChildNode(pokeNode)
                    }
                }
            }
            
            if imageAnchor.referenceImage.name!.contains("oddish-card") {
                if let pokeScene = SCNScene(named: "art.scnassets/oddish.scn") {
                    if let pokeNode = pokeScene.rootNode.childNodes.first {
                        pokeNode.eulerAngles.x = .pi/2 //rotete the pokemon 90 diegree so that it stands on the card
                        planeNode.addChildNode(pokeNode)
                    }
                }
            }
            
        }
        
        
        return node
    }
}
