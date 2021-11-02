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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = application.windows.first ?? UIWindow(frame: UIScreen.main.bounds)
        router.present(on: window)
        self.window = window
        window.makeKeyAndVisible()
         
        return true
    }
}

