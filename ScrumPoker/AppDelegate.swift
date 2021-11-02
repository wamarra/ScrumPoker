//
//  AppDelegate.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 02/11/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let router = DeveloperRouter()

    private func application(_ application: UIWindowScene, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = application.windows.first ?? UIWindow(frame: UIScreen.main.bounds)
        router.present(on: window)
        self.window = window
        window.makeKeyAndVisible()
         
        return true
    }
}

