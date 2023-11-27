//
//  MovieshomeViewcontrollerViewController.swift
//  SwiftUiMovieDb
//
//  Created by mac on 25/11/23.
//

import UIKit
import SwiftUI

class MoviesHomeViewController: UIViewController {
    
    var embedViewController: UIHostingController<ContentView> {
        UIHostingController(rootView: ContentView())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(embedViewController.view)
    }
    
    private func setupHostingController() {
        addChild(embedViewController)
        view.addSubview(embedViewController.view)
        embedViewController.didMove(toParent: self)
        embedViewController.view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(to: embedViewController.view)
    }
    
    private func addConstraints(to childView: UIView) {
        NSLayoutConstraint.activate([
            childView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            childView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            childView.topAnchor.constraint(equalTo: view.topAnchor),
            childView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
