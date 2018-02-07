import UIKit

final class StickersTableViewController: UITableViewController {

    private var stickers = Sticker.all
    var selected: (Sticker) -> Void

    init(selected: @escaping (Sticker) -> Void) {
        self.selected = selected
        super.init(style: .plain)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup(table: tableView)
        title = "Stickers"
    }

    private func setup(table: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorEffect = UIVibrancyEffect(blurEffect: UIBlurEffect(style: .light))
        tableView.backgroundColor = .clear

        let size = CGSize(width: 100, height: 400)
        tableView.frame = CGRect(origin: CGPoint.zero, size: size)
        preferredContentSize = size

        table.register(UINib.init(nibName: StickerTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: "Sticker")
    }
}

// MARK: - Table view data source
extension StickersTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sticker = stickers[indexPath.row]
        selected(sticker)
        dismiss(animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stickers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Sticker", for: indexPath) as! StickerTableViewCell
        cell.setup(with: stickers[indexPath.row])
        return cell
    }

}
