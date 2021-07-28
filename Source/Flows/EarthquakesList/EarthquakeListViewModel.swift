import Foundation

protocol EarthquakeViewModelDelegate: AnyObject {
    func didSelectItem(_ item: EarthquakeItem)
}

protocol EarthquakeViewModelProtocol {
    var items: [EarthquakeItem] { get }
    var itemsLoaded: (() -> Void)? { get set }
    var isLoading: ((Bool) -> Void)? { get set }
    var alert: ((AlertViewModel) -> Void)? { get set }
    func selectItem(at index: Int)
    func loadItems()
}

final class EarthquakeViewModel: EarthquakeViewModelProtocol {
    var itemsLoaded: (() -> Void)?
    var isLoading: ((Bool) -> Void)?
    var alert: ((AlertViewModel) -> Void)?
    private(set) var items: [EarthquakeItem] = [] {
        didSet {
            itemsLoaded?()
        }
    } 

    private let repository: EarthquakeRepositoryProtocol
    private weak var delegate: EarthquakeViewModelDelegate?

    init(repository: EarthquakeRepositoryProtocol,
         delegate: EarthquakeViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }

    func loadItems() {
        isLoading?(true)
        repository.getEarthquakeItems { [weak self] result in
            guard let self = self else { return }
            self.isLoading?(false)
            switch result {
            case .success(let items): self.items = items
            case .failure(let error): self.alert?(AlertViewModelFactory.create(error: error))
            }
        }
    }

    func selectItem(at index: Int) {
        delegate?.didSelectItem(items[index])
    }
}
