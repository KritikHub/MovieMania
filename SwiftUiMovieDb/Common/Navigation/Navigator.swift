//
//  Navigator.swift
//  SwiftUiMovieDb
//
//  Created by mac on 01/12/23.
//

import UIKit

enum NavigationOperation {
    case push
    case present(style: UIModalPresentationStyle,
                 transitionStyle: UIModalTransitionStyle = UIModalTransitionStyle.coverVertical)
    case reset
}

protocol Navigator {
    associatedtype Destination
    
    func navigate(to destination: Destination, operation: NavigationOperation, animated: Bool)
    func popViewController(animated: Bool)
}

class MDBNavigator: Navigator {
    
    enum Destination {
        case home
        case movieDetails
        case showAllMovies
    }
    
    private var navigationController: UINavigationController?
    private var topVieController: UIViewController? {
        return navigationController?.topViewController
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigate(to destination: Destination, operation: NavigationOperation, animated: Bool = true) {
        let viewController = makeViewController(for: destination)
        let viewControllerType = type(of: viewController)
        
        switch operation {
        case .push:
            if let destinationVC = navigationController?.viewControllers.first(where: {type(of: $0) == viewControllerType }) {
                navigationController?.popToViewController(destinationVC, animated: animated)
                return
            }
            navigationController?.pushViewController(viewController, animated: animated)
        case .present(let style, let transitionStyle):
            viewController.modalPresentationStyle = style
            viewController.modalTransitionStyle = transitionStyle
            navigationController?.present(viewController, animated: animated, completion: nil)
        case .reset:
            navigationController?.setViewControllers([viewController], animated: animated)
        }
    }
    
    func popViewController(animated: Bool = true) {
        navigationController?.popViewController(animated: true)
    }
    
    func popToRootViewController(animated: Bool = true) {
        navigationController?.popToRootViewController(animated: animated)
    }
    
    func popToHomeViewController(animated: Bool = true) {
        if let viewController = navigationController?.viewControllers.first(where: { $0 is MoviesHomeViewController }) {
            navigationController?.popToViewController(viewController, animated: animated)
        } else {
            popViewController()
        }
    }
    
    private func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .home:
            let viewController = MoviesHomeViewController()
            return viewController
        case .movieDetails:
            let viewController = MoviesHomeViewController()
            return viewController
        case .showAllMovies:
            let viewController = MoviesHomeViewController()
            return viewController
        }
    }
}
