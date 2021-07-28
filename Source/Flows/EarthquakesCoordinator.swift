import Foundation
import UIKit

final class EarthquakesCoordinator {
    var viewController: UIViewController { navigationController }
    private lazy var navigationController: UINavigationController = {
        UINavigationController(rootViewController: viewControllerFactory.makeEarthquakeListViewController(delegate: self))
    }()

    private let viewControllerFactory: EarthquakesViewControllerFactory

    init(viewControllerFactory: EarthquakesViewControllerFactory = EarthquakesViewControllerFactory()) {
        self.viewControllerFactory = viewControllerFactory
    }

}

extension EarthquakesCoordinator: EarthquakeViewModelDelegate {
    func didSelectItem(_ item: EarthquakeItem) {
        navigationController.pushViewController(viewControllerFactory.makeEarthquakeDetailViewController(item: item), animated: true)
    }
}


final class EarthquakesViewControllerFactory {
    func makeEarthquakeListViewController(delegate: EarthquakeViewModelDelegate) -> UIViewController {
        let repository = EarthquakeRepository(apiClient: EarthquakeApiClient(networkClient: NetworkClient()))
        let viewModel = EarthquakeViewModel(repository: repository, delegate: delegate)
        return EarthquakeListViewController(viewModel: viewModel)
    }

    func makeEarthquakeDetailViewController(item: EarthquakeItem) -> UIViewController {
        EarthquakeDetailsViewController(viewModel: EarthquakeDetailsViewModel(earthquakeItem: item))
    }
}
