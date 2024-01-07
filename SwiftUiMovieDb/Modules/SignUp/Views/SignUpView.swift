//
//  SignUpView.swift
//  SwiftUiMovieDb
//
//  Created by mac on 01/01/24.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var viewModel = SignUpViewModel()
    @State var name = ""
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var isPassVisible = false
    @State var isConfirmPassVisible = false
    @State var isEmailEmpty = false
    @State var isPassEmpty = false
    @State var isNameEmpty = false
    @State var isConfirmPasswordEmpty = false
    @State var isShowAlert = false
    
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
    var nameBorderColor: Color {
        return isNameEmpty && name.isEmpty ? Color.red : Color.blue
    }
    var confirmPassBorderColor: Color {
        return isConfirmPasswordEmpty && confirmPassword.isEmpty ? Color.red : Color.blue
    }
    var isAnyFieldEmpty: Bool {
        return name.isEmpty || password.isEmpty || email.isEmpty || confirmPassword.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Image(LoginScreenConstants.signUpImage)
                    .resizable()
                    .frame(width: imageWidth, height: imageHeight, alignment: .top)
                Text(LoginScreenConstants.signUp)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 5)
                
                textInput(placeholderName: LoginScreenConstants.name, text: $name, isEmpty: $isNameEmpty, color: nameBorderColor)
                
                textInput(placeholderName: LoginScreenConstants.email, text: $email, isEmpty: $isEmailEmpty, color: emailBorderColor)
                
                textInputWithEyeImage(placeholderName: LoginScreenConstants.password, text: $password, isEmpty: $isPassEmpty, visible: $isPassVisible, color: passBorderColor)
                
                textInputWithEyeImage(placeholderName: LoginScreenConstants.confirmPassword, text: $confirmPassword, isEmpty: $isConfirmPasswordEmpty, visible: $isConfirmPassVisible, color: confirmPassBorderColor)
                
                NavigationLink(destination: TabBarView()) {
                    Button(action: {
                        verify()
                    }) {
                        Text(LoginScreenConstants.signUp)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .frame(width: textFieldWidth)
                    }
                    .background(Color.blue)
                    .opacity(isAnyFieldEmpty ? 0.3 : 1)
                    .cornerRadius(6)
                    .padding(.top, 15)
                    .disabled(isAnyFieldEmpty)
                }
                Spacer()
            }
            .navigationBarHidden(true)
            .alert(isPresented: $isShowAlert, content: {
                return showAlert(errorType: viewModel.error)
            })
        }
       // Spacer()
    }
    
    private func textInputWithEyeImage(placeholderName: String, text: Binding<String>, isEmpty: Binding<Bool>, visible: Binding<Bool>, color: Color) -> some View {
        HStack {
            VStack {
                if visible.wrappedValue {
                    TextField(placeholderName, text: text, onEditingChanged: {editing in
                        if editing {
                            isEmpty.wrappedValue = true
                        }
                    })
                    .autocapitalization(.none)
                } else {
                    SecureField(placeholderName, text: text, onCommit: {
                        isEmpty.wrappedValue = true
                    })
                }
            }
            Button(action: {
                visible.wrappedValue.toggle()
            }) {
                Image(systemName: visible.wrappedValue ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(Color.black.opacity(0.7))
                    .opacity(0.8)
            }
        }
        .padding()
        .frame(width: textFieldWidth, height: textFieldHeight)
        .background(RoundedRectangle(cornerRadius: 6).stroke(color, lineWidth: 2))
        .padding(.top, 5)
    }
    
    private func textInput(placeholderName: String, text: Binding<String>, isEmpty: Binding<Bool>, color: Color) -> some View {
        TextField(placeholderName, text: text, onEditingChanged: {editing in
            if editing {
                isEmpty.wrappedValue = true
            }
        })
        .autocapitalization(.none)
        .padding()
        .frame(width: textFieldWidth, height: textFieldHeight)
        .background(RoundedRectangle(cornerRadius: 6).stroke(color, lineWidth: 2))
        .padding(.top, 5)
    }
    
    private func verify() {
        if isPassMatched() {
            let data = convertFieldsToSignUpData()
            viewModel.signUp(data)
            if viewModel.error != nil {
                isShowAlert = true
            }
        } else {
            isShowAlert = true
        }
    }
    
    private func isPassMatched() -> Bool {
        password == confirmPassword ? true : false
    }
    
    private func convertFieldsToSignUpData() -> SignUpData {
       SignUpData(name: name, email: email, password: password, confirmPassword: confirmPassword)
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
