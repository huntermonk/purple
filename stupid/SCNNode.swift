import SceneKit
import SpriteKit
import AVFoundation

extension SCNNode {
    static var whiteBall: SCNNode {
        return SCNNode(geometry: SCNSphere(radius: 0.01))
    }

    static var brazzers: SCNNode {
        return node(image: #imageLiteral(resourceName: "brazzers"), width: 0.35, height: 0.082)
    }

    static func node(image: UIImage, width: CGFloat, height: CGFloat) -> SCNNode {
        let plane = SCNPlane(width: width, height: height)

        let material = SCNMaterial()
        material.diffuse.contents = image
        plane.materials = [material]

        let parent = SCNNode(geometry: plane)
        return parent
    }
}
