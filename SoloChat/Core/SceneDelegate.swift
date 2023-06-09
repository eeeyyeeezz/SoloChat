//
//  SceneDelegate.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: windowScene)
		let coordinator = MainCoordinator()
		window?.rootViewController = UINavigationController(rootViewController: MainViewController(coordinator: coordinator))
		window?.makeKeyAndVisible()
	}

}

