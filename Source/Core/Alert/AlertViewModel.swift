import Foundation
import UIKit

struct AlertViewModel {
    let title: String
    let message: String
    let actionText: String
    let action: (() -> Void)?

    init(
        title: String,
        message: String,
        actionText: String,
        action: (() -> Void)? = nil) {

        self.title = title
        self.message = message
        self.actionText = actionText
        self.action = action
    }
}

struct AlertViewModelFactory {
    static func create(error: Error) -> AlertViewModel {
        return AlertViewModel(
            title: "Error",
            message: error.localizedDescription,
            actionText: "OK"
        )
    }
}

extension UIAlertController {
    static func create(from viewModel: AlertViewModel) -> UIAlertController {
        let ac = UIAlertController(
            title: viewModel.title,
            message: viewModel.message,
            preferredStyle: .alert
        )

        ac.addAction(
            UIAlertAction(
                title: viewModel.actionText,
                style: .default,
                handler: { _ in viewModel.action?() }
            )
        )
        return ac
    }
}
