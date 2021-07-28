import Foundation
import UIKit
import MapKit

final class EarthquakeDetailsViewController: UIViewController {
    private let viewModel: EarthquakeDetailsViewModelProtocol

    init(viewModel: EarthquakeDetailsViewModelProtocol) {
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
        createItem()
    }

    // MARK: Views
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        return mapView
    }()

}

private extension EarthquakeDetailsViewController {
    func setupViews() {
        view.addSubview(mapView)
    }

    func layoutViews() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func createItem() {
        let circleOverlay: MKCircle = MKCircle(center: viewModel.earthquakeItem.location, radius: viewModel.earthquakeItem.radiusInMeters)
        mapView.addOverlay(circleOverlay)
        let annotation = MKPointAnnotation()
        annotation.coordinate = viewModel.earthquakeItem.location
        annotation.title = viewModel.earthquakeItem.identifier
        mapView.addAnnotation(annotation)
        mapView.centerToCoordinate(annotation.coordinate)

    }
}

extension EarthquakeDetailsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleView = MKCircleRenderer(overlay: overlay)
        circleView.strokeColor = .red
        circleView.lineWidth = 1
        return circleView
    }
}

extension MKMapView {
    func centerToCoordinate(
        _ coordinate: CLLocationCoordinate2D,
        regionRadius: CLLocationDistance = 500000
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        setRegion(coordinateRegion, animated: true)
    }
}
