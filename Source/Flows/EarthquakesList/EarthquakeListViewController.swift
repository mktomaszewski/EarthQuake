import Foundation
import UIKit
import SnapKit

final class EarthquakeListViewController: UIViewController {
    private var viewModel: EarthquakeViewModelProtocol

    init(viewModel: EarthquakeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        layoutViews()
        bindOutputs()
        viewModel.loadItems()
    }

    // MARK: Views

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EarthquakeTableViewCell.self, forCellReuseIdentifier: EarthquakeTableViewCell.reuseIdentifier)
        return tableView
    }()

}

private extension EarthquakeListViewController {
    func setupViews() {
        view.addSubview(tableView)
    }

    func layoutViews() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func bindOutputs() {
        viewModel.itemsLoaded = { [weak tableView] in
            tableView?.reloadData()
        }
    }
}

extension EarthquakeListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EarthquakeTableViewCell.reuseIdentifier, for: indexPath) as? EarthquakeTableViewCell else {
            return UITableViewCell()
        }

        let item = viewModel.items[indexPath.row]
        cell.setup(with: item)
        return cell
    }
}

extension EarthquakeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectItem(at: indexPath.row)
    }
}
