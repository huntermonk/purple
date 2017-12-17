import SpriteKit
import ARKit
import ARVideoKit

class CameraController: UIViewController {

    private var currentSticker: Sticker?
    private var recorder: RecordAR!
    @IBOutlet var sceneView: ARSCNView!

    override func prefersHomeIndicatorAutoHidden() -> Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        recorder = RecordAR(ARSceneKit: sceneView)
        sceneView.delegate = self
        sceneView.showsStatistics = false

        addRecordButton()
        addStickerButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let config = ARWorldTrackingConfiguration()
        recorder.prepare(config)
        sceneView.session.run(config)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        recorder.rest()
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

    private func addRecordButton() {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "record"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "recording"), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.constrain(size: CGSize(width: 44, height: 44))
        button.pinBottom(constant: 8)
        button.centerX()
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(recordPressed), for: .touchUpInside)
    }

    private func addStickerButton() {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "sticker"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.constrain(size: CGSize(width: 40, height: 40))
        button.pinBottom(constant: 8)
        button.pinRight(constant: -16)
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(showStickers), for: .touchUpInside)
    }

    private func beginRecording() {
        recorder.record()
    }

    private func endRecording() {
        recorder.stopAndExport()
    }

    @objc private func recordPressed(button: UIButton) {
        button.isSelected = !button.isSelected

        if button.isSelected {
            beginRecording()
        } else {
            endRecording()
        }
    }

    @objc private func showStickers(button: UIButton) {
        let controller = StickersTableViewController { selected in
            self.currentSticker = selected
        }

        present(controller: controller, from: button)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // TODO: - Only remove other videos
        sceneView.removeAnchors()
        addAtHit(touches: touches)
    }
}

extension CameraController: ARSCNViewDelegate {

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let sticker = currentSticker else {
            return nil
        }

        let node = SCNNode(sticker: sticker)

        let constraint = SCNBillboardConstraint()
        constraint.freeAxes = SCNBillboardAxis.Y

        node.constraints = [constraint]
        return node
    }
}

