import SceneKit
import SpriteKit
import AVFoundation

extension SCNNode {

    convenience init(sticker: Sticker) {
        switch sticker {
        case .angel:
            self.init(geometry: SCNNode.node(image: UIImage(named: "angel-wings")!, width: 3.452, height: 2.558))
        case .brazzers:
            self.init(geometry: SCNNode.node(image: #imageLiteral(resourceName: "brazzers"), width: 0.35, height: 0.082))
        case .drake:
            self.init(geometry: SCNNode.masked(opaque: "drake.mp4", alpha: "drake-mask.mp4", contentSize: CGSize(width: 1280, height: 720), lifeSize: CGSize(width: 3.2512, height: 1.8288)))
        case .kanyeGlasses:
            self.init(geometry: SCNNode.node(image: #imageLiteral(resourceName: "kanye-glasses"), width: 0.2, height: 0.2))
        case .lightbulb:
            self.init(geometry: SCNNode.node(image: #imageLiteral(resourceName: "lightbulb"), width: 0.758, height: 0.8))
        case .missiles:
            self.init(geometry: SCNNode.masked(opaque: "missiles.mp4", alpha: "missiles-mask.mp4", contentSize: CGSize(width: 1280, height: 720), lifeSize: CGSize(width: 3.84, height: 2.16)))
        case .mustache:
            self.init(geometry: SCNNode.node(image: #imageLiteral(resourceName: "mustache"), width: 0.256, height: 0.128))
        case .sunglasses:
            self.init(geometry: SCNNode.node(image: #imageLiteral(resourceName: "sunglasses"), width: 0.2048, height: 0.0456))
        }
    }

    static var whiteBall: SCNNode {
        return SCNNode(geometry: SCNSphere(radius: 0.01))
    }

    static func node(image: UIImage, width: CGFloat, height: CGFloat) -> SCNNode {
        let plane: SCNPlane = node(image: image, width: width, height: height)
        return SCNNode(geometry: plane)
    }

    static func node(image: UIImage, width: CGFloat, height: CGFloat) -> SCNPlane {
        let plane = SCNPlane(width: width, height: height)

        let material = SCNMaterial()
        material.diffuse.contents = image
        material.isDoubleSided = true
        plane.materials = [material]
        return plane
    }

    static func masked(opaque: String, alpha: String, contentSize: CGSize, lifeSize: CGSize) -> SCNNode {
        let plane: SCNPlane = masked(opaque: opaque, alpha: alpha, contentSize: contentSize, lifeSize: lifeSize)
        return SCNNode(geometry: plane)
    }

    static func masked(opaque: String, alpha: String, contentSize: CGSize, lifeSize: CGSize) -> SCNPlane {
        Syncer.shared.reset()

        let opaque = VideoContent(filename: opaque, size: contentSize)
        let transparencyMask = VideoContent(filename: alpha, size: contentSize)

        Syncer.shared.sync(players: [opaque.player, transparencyMask.player])

        let maskedMaterial = MaskedMaterial(transparencyMask: transparencyMask)
        maskedMaterial.diffuse.contents = opaque
        maskedMaterial.isDoubleSided = true

        let plane = SCNPlane(width: lifeSize.width, height: lifeSize.height)
        plane.materials = [maskedMaterial]
        return plane
    }
}
