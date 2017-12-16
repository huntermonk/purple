import Foundation
import SceneKit
import AVFoundation

class Syncer: NSObject {
    static var shared = Syncer()

    var numberPreRolled = 0 {
        didSet {
            if numberPreRolled == 2 {
                numberPreRolled = 0

                players.forEach {
                    $0.automaticallyWaitsToMinimizeStalling = false

                    let host = CMClockGetTime(CMClockGetHostTimeClock())
                    $0.setRate(1, time: kCMTimeInvalid, atHostTime: host)
                }
            }
        }
    }

    func reset() {
        numberPreRolled = 0
    }

    private var players: [AVPlayer] = [] {
        didSet {
            players.forEach {
                $0.addObserver(Syncer.shared, forKeyPath: "status", options: .new, context: nil)
            }
        }
    }

    func sync(players: [AVPlayer]) {
        self.players = players
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if players.first!.status == .readyToPlay && players.last!.status == .readyToPlay {
            players.forEach {
                $0.preroll(atRate: 1) { success in
                    self.numberPreRolled += 1
                }
            }
        }
    }
}

