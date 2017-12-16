import SceneKit
import SpriteKit
import AVFoundation

extension SCNNode {
    static var whiteBall: SCNNode {
        return SCNNode(geometry: SCNSphere(radius: 0.01))
    }

    static var brazzers: SCNNode {
        let plane = SCNPlane(width: 0.35, height: 0.082)

        let material = SCNMaterial()
        material.diffuse.contents = #imageLiteral(resourceName: "brazzers")
        plane.materials = [material]

        let parent = SCNNode(geometry: plane)
        return parent
    }
}


