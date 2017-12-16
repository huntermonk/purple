import UIKit

final class StickersTableViewController: UITableViewController {

    private var stickers = Sticker.all

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
    }
}

// MARK: - Table view data source
extension StickersTableViewController {

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
        cell.backgroundColor = .clear
        return cell
    }

}
