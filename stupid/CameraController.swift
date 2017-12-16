import SpriteKit
import ARKit

class CameraController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!

    override func prefersHomeIndicatorAutoHidden() -> Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.showsStatistics = false
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
        sceneView.removeAnchors()
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
        button.pinTopMargin(constant: 16)
        button.pinRight(constant: -16)
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(showStickers), for: .touchUpInside)
    }

    @objc private func showStickers() {
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        addAtHit(touches: touches)
    }
}

final class StickersTableController: UITableViewController {

    var stickers = Sticker.all

    override func viewDidLoad() {
        super.viewDidLoad()
        setup(table: tableView)
        title = "Stickers"
    }

    private func setup(table: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorEffect = UIVibrancyEffect(blurEffect: UIBlurEffect(style: .light))
        tableView.backgroundColor = .clear

        let size = CGSize(width: 250, height: 400)
        tableView.frame = CGRect(origin: CGPoint.zero, size: size)
        preferredContentSize = size
    }
}

struct Sticker {
    var node: SCNNode
    var keyword: String
    var title: String

    static var angel: Sticker {
        return Sticker(node: SCNNode.angelWings, keyword: "angel wings", title: "😇")
    }

    static var brazzers: Sticker {
        return Sticker(node: SCNNode.brazzers, keyword: "brazzers", title: "😈")
    }

    static var kanyeGlasses: Sticker {
        return Sticker(node: SCNNode.kanyeGlasses, keyword: "kanye west glasses", title: "🐐")
    }

    static var mustache: Sticker {
        return Sticker(node: SCNNode.mustache, keyword: "mustache", title: "👨🏽")
    }

    static var sunglasses: Sticker {
        return Sticker(node: SCNNode.sunglasses, keyword: "glasses, deal with it", title: "🕶")
    }

    static var all: [Sticker] {
        return [
            angel,
            brazzers,
            kanyeGlasses,
            mustache,
            sunglasses
        ]
    }

}

// MARK: - Table view data source
extension StickersTableController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sticker = stickers[indexPath.row]
        print(sticker.title)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stickers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = stickers[indexPath.row].title
        return cell
    }

}

extension CameraController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode.brazzers

        let constraint = SCNBillboardConstraint()
        constraint.freeAxes = SCNBillboardAxis.Y

        node.constraints = [constraint]
        return node
    }
}

