//
//  AppDelegate.swift
//  SwiftUiMovieDb
//
//  Created by mac on 07/08/23.
//

import UIKit
import CoreData

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UITableView.appearance().separatorStyle = .none
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
}
