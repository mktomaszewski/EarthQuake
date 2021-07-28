import Foundation
import UIKit
import SnapKit

final class EarthquakeTableViewCell: UITableViewCell {
    static var reuseIdentifier: String { String(describing: EarthquakeTableViewCell.self) }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        layoutViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with item: EarthquakeItem) {
        titleLabel.text = item.identifier
        magnitudeLabel.text = item.magnitude
        magnitudeLabel.backgroundColor = item.magnitudeClass.color
    }

    // MARK - Views

    private let titleLabel = UILabel()
    private let magnitudeLabel = RoundedLabel()
    private let classView = UIView()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [magnitudeLabel, titleLabel])
        stackView.spacing = 8.0
        return stackView
    }()

}
private extension EarthquakeTableViewCell {
    func setupViews() {
        contentView.addSubview(stackView)
    }

    func layoutViews() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16.0)
        }
        magnitudeLabel.snp.makeConstraints {
            $0.width.equalTo(magnitudeLabel.snp.height)
        }

        magnitudeLabel.textAlignment = .center
    }
}

extension MagnitudeClass {
    var color: UIColor {
        switch self {
        case .normal: return .clear
        case .strong: return .red
        }
    }
}

#if canImport(SwiftUI)
import SwiftUI

struct DetailItemViewViewPreview: PreviewProvider {
    static var previews: some View {
        Group {
            UIViewPreview {
                let cell = EarthquakeTableViewCell(style: .default, reuseIdentifier: "")
                cell.setup(with: .init(earthQuake: .init(eqid: "Normal One", datetime: "", depth: 20.0, lat: 11.0, lng: 11.0, magnitude: 6.0)))
                return cell
            }.previewLayout(.fixed(width: 327, height: 80))
            .padding(10)
            UIViewPreview {
                let cell = EarthquakeTableViewCell(style: .default, reuseIdentifier: "")
                cell.setup(with: .init(earthQuake: .init(eqid: "Strong One", datetime: "", depth: 20.0, lat: 11.0, lng: 11.0, magnitude: 8.0)))
                return cell
            }.previewLayout(.fixed(width: 327, height: 80))
            .padding(10)
        }
    }
}
#endif
