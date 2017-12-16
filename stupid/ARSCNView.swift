import ARKit

extension ARSCNView {
    @discardableResult func removeAnchors() -> [ARAnchor] {
        let anchors = session.currentFrame?.anchors ?? []
        anchors.forEach { session.remove(anchor: $0) }
        return anchors
    }
}

