//
//  LoadingMDBView.swift
//  SwiftUiMovieDb
//
//  Created by mac on 23/11/23.
//

import SwiftUI

struct LoadingMDBView: View {
    
    let isLoading: Bool
    let error: MDBError?
    let retryAction: (() -> ())?
    
    var body: some View {
        ZStack {
            if isLoading {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            } else if error != nil {
                HStack {
                    Spacer()
                    VStack(spacing: 4) {
                        Text(error!.localizedDescription).font(.headline)
                        if self.retryAction != nil {
                            Button(action: self.retryAction!) {
                                Text("Retry")
                            }
                            .foregroundColor(Color(UIColor.systemBlue))
                            .buttonStyle(PlainButtonStyle())

                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

struct LoadingMDBView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingMDBView(isLoading: true, error: nil, retryAction: nil)
    }
}
