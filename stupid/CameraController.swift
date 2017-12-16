import SpriteKit
import ARKit

class CameraController: UIViewController {

    var currentSticker: SCNNode?
    @IBOutlet var sceneView: ARSCNView!

    override func prefersHomeIndicatorAutoHidden() -> Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.showsStatistics = false

        addButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sceneView.session.run(ARWorldTrackingConfiguration())
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    private func addAtHit(touches: Set<UITouch>) {
        addAnchor(distance: 2, camera: sceneView.session.currentFrame!.camera.transform)
    }

    private func addAnchor(distance: Float, camera: matrix_float4x4) {
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -distance
        let transform = simd_mul(camera, translation)

        let anchor = ARAnchor(transform: transform)
        sceneView.session.add(anchor: anchor)
    }

    private func addButton() {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "sticker"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.constrain(size: CGSize(width: 40, height: 40))
        button.pinBottom(constant: 16)
        button.pinRight(constant: -16)
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(showStickers), for: .touchUpInside)
    }

    @objc private func showStickers(button: UIButton) {
        let stickers = StickersTableViewController { [unowned self] sticker in
            self.currentSticker = sticker.node
        }
        present(controller: stickers, from: button)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        addAtHit(touches: touches)
    }
}

extension CameraController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let sticker = currentSticker else {
            return nil
        }

        let constraint = SCNBillboardConstraint()
        constraint.freeAxes = SCNBillboardAxis.Y

        sticker.constraints = [constraint]
        return sticker
    }
}
