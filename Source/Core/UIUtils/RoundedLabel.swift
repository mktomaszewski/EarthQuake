import UIKit

final class RoundedLabel: UILabel {
    private let textInset: UIEdgeInsets
    init(textInset: UIEdgeInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)) {
        self.textInset = textInset
        super.init(frame: .zero)
        layer.masksToBounds = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += textInset.top + textInset.bottom
        contentSize.width += textInset.left + textInset.right
           return contentSize
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height/2.0
    }
}
