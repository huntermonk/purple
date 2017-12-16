import Foundation
import SpriteKit
import AVFoundation

class VideoContent: SKScene {

    let player: AVPlayer

    init(filename: String, size: CGSize) {
        let videoURL = Bundle.main.url(forResource: filename, withExtension: nil)!
        player = AVPlayer(url: videoURL)
        player.actionAtItemEnd = .none

        super.init(size: size)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(restart),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: player.currentItem)

        backgroundColor = .clear
        scaleMode = .aspectFit

        let node = SKVideoNode(avPlayer: player)
        node.position = CGPoint(x: size.width / 2, y: size.height / 2)
        node.size = size
        node.yScale = -1
        addChild(node)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func restart(notification: NSNotification) {
        let item = notification.object as! AVPlayerItem
        item.seek(to: kCMTimeZero, completionHandler: nil)
    }

}

