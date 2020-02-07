//
//  SceneDelegate.swift
//  News
//
//  Created by Trung Vu on 2/4/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift

struct LoginManager {
    static func showMainFlow(_ window: UIWindow?) {
        if let mainTabViewController = mainAssembleResolver.resolve(MainTabViewController.self) {
            window?.rootViewController = mainTabViewController
        }
    }
    
    static func showLoginFlow(_ window: UIWindow?) {
        if let loginVc = mainAssembleResolver.resolve(LoginViewController.self) {
            window?.rootViewController = UINavigationController(rootViewController: loginVc)
        }
    }
}

let rxDisposeBag : DisposeBag = {
    return DisposeBag()
}()

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        configTheme()
        createWindow()
        
    }
    
    func configTheme() {
        window?.tintColor = UIColor.red
        window?.backgroundColor = UIColor.white
        // Sets the default color of the background of the UITabBar
        UITabBar.appearance().barTintColor = UIColor.white
    }
    
    private func createWindow() {
        if Context.isAuthenticated() {
            LoginManager.showMainFlow(window)
        } else {
            LoginManager.showLoginFlow(window)
        }
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

