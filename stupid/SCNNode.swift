import SceneKit
import SpriteKit
import AVFoundation

extension SCNNode {
    static var whiteBall: SCNNode {
        return SCNNode(geometry: SCNSphere(radius: 0.01))
    }

    static var angelWings: SCNNode {
        return node(image: UIImage(named: "angel-wings")!, width: 3.452, height: 2.558)
    }

    static var brazzers: SCNNode {
        return node(image: #imageLiteral(resourceName: "brazzers"), width: 0.35, height: 0.082)
    }

    static var kanyeGlasses: SCNNode {
        return node(image: #imageLiteral(resourceName: "kanye-glasses"), width: 0.2, height: 0.2)
    }

    static var mustache: SCNNode {
        return node(image: #imageLiteral(resourceName: "mustache"), width: 0.256, height: 0.128)
    }

    static var sunglasses: SCNNode {
        return node(image: #imageLiteral(resourceName: "sunglasses"), width: 0.2048, height: 0.0456)
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
