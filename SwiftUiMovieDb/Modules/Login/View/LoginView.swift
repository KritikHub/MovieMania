//
//  LoginView.swift
//  SwiftUiMovieDb
//
//  Created by mac on 31/12/23.
//

import SwiftUI

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    @State var visible = false
    @State var isEmailEmpty = false
    @State var isPassEmpty = false
    
    let textFieldWidth = UIScreen.main.bounds.width - 80
    let textFieldHeight = CGFloat(50)
    let imageWidth = CGFloat(300)
    let imageHeight = CGFloat(300)
    var emailBorderColor: Color {
        return isEmailEmpty && email.isEmpty ? Color.red : Color.blue
    }
    var passBorderColor: Color {
        return isPassEmpty && password.isEmpty ? Color.red : Color.blue
    }
    
    var body: some View {
        VStack {
            Image(LoginScreenConstants.loginImage)
                .resizable()
                .frame(width: imageWidth, height: imageHeight, alignment: .top)
            Text(LoginScreenConstants.signIn)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 5)
            TextField(LoginScreenConstants.email, text: $email, onEditingChanged: {editing in
                if editing {
                    isEmailEmpty = true
                }
            })
                .autocapitalization(.none)
                .padding()
                .frame(width: textFieldWidth, height: textFieldHeight)
                .background(RoundedRectangle(cornerRadius: 6).stroke(emailBorderColor, lineWidth: 2))
            HStack {
                VStack {
                    if visible {
                        TextField(LoginScreenConstants.password, text: $password,
                                  onEditingChanged: {editing in
                                      if editing {
                                          isPassEmpty = true
                                      }
                                  })
                            .autocapitalization(.none)
                    } else {
                        SecureField(LoginScreenConstants.password, text: $password, onCommit: {
                                isPassEmpty = true
                        })
                    }
                }
                Button(action: {
                    self.visible.toggle()
                }) {
                    Image(systemName: visible ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(Color.black.opacity(0.7))
                        .opacity(0.8)
                }
            }
            .padding()
            .frame(width: textFieldWidth, height: textFieldHeight)
            .background(RoundedRectangle(cornerRadius: 6).stroke(passBorderColor, lineWidth: 2))
            .padding(.top, 5)
            
            Button(action: {
                verify()
            }) {
                Text(LoginScreenConstants.signIn)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: textFieldWidth)
            }
            .background(Color.blue)
            .cornerRadius(6)
            .padding(.top, 15)
        }
    }
}

private func verify() {
    
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
