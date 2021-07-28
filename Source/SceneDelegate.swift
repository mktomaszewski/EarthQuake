import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    lazy var coordinator: EarthquakesCoordinator = {
        EarthquakesCoordinator()
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let appWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
        appWindow.windowScene = windowScene

        appWindow.rootViewController = coordinator.viewController
        appWindow.makeKeyAndVisible()

        window = appWindow
    }
}

