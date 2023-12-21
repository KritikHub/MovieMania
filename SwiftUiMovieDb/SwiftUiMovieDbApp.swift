//
//  SwiftUiMovieDbApp.swift
//  SwiftUiMovieDb
//
//  Created by mac on 25/07/23.
//

import SwiftUI

@main
struct SwiftUiMovieDbApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
