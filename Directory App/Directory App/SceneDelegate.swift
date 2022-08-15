//
//  SceneDelegate.swift
//  Directory App
//
//  Created by Kacper Cichosz on 23/07/2022.
//

import UIKit

enum Environment: String {
    case liveEnvironment = "Live Environment"
    case testingEnvironment = "QA Environment"
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let tabBarController = TabBarController()
        let navigationController = NavigationController(rootViewController: tabBarController)
        navigationController.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.backward.circle.fill")
        navigationController.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "chevron.backward.circle.fill")
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}

