//
//  LoaderViewModifier.swift
//  SwiftUiMovieDb
//
//  Created by mac on 27/11/23.
//

import SwiftUI

struct LoaderViewModifier: ViewModifier {
    let isLoading: Bool
    let tint: Color
    let background: Color
    let isDisabledOnLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isDisabledOnLoading && isLoading)
                .overlay(isLoading && isDisabledOnLoading ? background.opacity(0.7) : Color.clear)
                .zIndex(0)
            if isLoading {
                ProgressView()
                    .zIndex(1)
                    .progressViewStyle(CircularProgressViewStyle(tint: tint))                
            }
        }
    }
}
