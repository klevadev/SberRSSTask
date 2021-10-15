//
//  SceneDelegate.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 02.11.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
            
        let vc = ReaderBaseVC()
        window.rootViewController = vc
        setupNavigationBar()
        
        self.window = window
        window.makeKeyAndVisible()
    }
    
    private func setupNavigationBar() {
        let attributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 20), NSAttributedString.Key.foregroundColor: ThemeManager.Color.sberColor]
        UINavigationBar.appearance().titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

