//
//  AppDelegate.swift
//  SwiftUiMovieDb
//
//  Created by mac on 07/08/23.
//
import UIKit
import CoreData
import FirebaseCore

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        setupRootViewController()
        setupFirebase()
        UITableView.appearance().separatorStyle = .none
        return true
    }
    
    fileprivate func setupRootViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let initialViewController = MoviesHomeViewController()
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
    
    fileprivate func setupFirebase() {
        FirebaseApp.configure()
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
}
