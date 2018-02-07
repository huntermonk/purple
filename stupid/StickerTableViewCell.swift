import UIKit

class StickerTableViewCell: UITableViewCell {
    @IBOutlet weak var stickerImageView: UIImageView!

    static let nibName = "StickerTableViewCell"
    func setup(with sticker: Sticker) {
        stickerImageView.image = sticker.image
        backgroundColor = .clear
    }
}
