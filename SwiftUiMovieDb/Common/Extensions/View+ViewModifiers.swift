//
//  View+ViewModifiers.swift
//  SwiftUiMovieDb
//
//  Created by mac on 28/11/23.
//

import SwiftUI

extension View {
    
    func showLoader(_ isLoading: Bool, tint: Color = .white, background: Color = .black, isBGDisabledOnLoading: Bool = true) -> some View {
        modifier(LoaderViewModifier(isLoading: isLoading,
                                    tint: tint,
                                    background: background,
                                    isDisabledOnLoading: isBGDisabledOnLoading))
    }
    
    func emptyNavigationLink<T: View>(_ destination: T) -> some View {
        NavigationLink(destination: destination) {}
    }
    //
    //    func displayErrorAlert(errorType: DescriptiveErrorType?) -> Alert {
    //
    //        self.showAlert(title: Text(errorTitle), description: Text(errorDescription))
    //    }
    
    func showAlert(errorType: DescriptiveErrorType?) -> Alert {
        let errorDescription = errorType?.description ?? "An error occured"
        let errorTitle = errorType?.title ?? "Error"
        return Alert(title: Text(errorTitle), message: Text(errorDescription), dismissButton: .cancel())
    }
}

