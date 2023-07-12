//
//  LoginView.swift
//  UnitTesting-SampleProject
//
//  Created by Daniyal Yousuf on 2023-07-11.
//

import SwiftUI

struct LoginView: View {
    enum Field: Hashable {
        case emailField
        case passwordField
    }
    @FocusState private var focusedField: Field?
    @State private var tfEmail: String =  ""
    @State private var tfPassword: String = ""
    @State private var loginButtonEnabled: Bool = false
    @State private var presentList: Bool = false
    @State private var presentSignupView: Bool = false
    @State private var isFocusedEmail: Bool = false
    @State private var isFocusedPassword: Bool = false
    var body: some View {
        NavigationView(content: {
            Form {
                TextField("Email", text: $tfEmail, onEditingChanged: { isEditing in
                    isFocusedEmail = isEditing
                })
                .modifier(FormTextField(isFocused: isFocusedEmail))
                
                TextField("Password", text: $tfPassword, onEditingChanged: { isEditing in
                    isFocusedPassword = isEditing
                })
                .modifier(FormTextField(isFocused: isFocusedPassword))
                
                Button {
                    presentList = true
                } label: {
                    Text("Login")
                        .modifier(FormTextButton(buttonDisabled: loginButtonState()))
                }.disabled(loginButtonState())
                
                HStack {
                    Spacer()
                    Button {
                        presentSignupView = true
                    } label: {
                        Text("Sign up")
                            .font(.system(size: 18))
                            .foregroundColor(.green)
                            .fontWeight(.bold)
                    }
                }
            }
            .padding(18)
            .formStyle(.columns)
            .navigationTitle("Sign in")
        })
        .edgesIgnoringSafeArea(.all)
        .ignoresSafeArea(.all)
        .fullScreenCover(isPresented: $presentList, content: {
            CatListView(presentScreen: $presentList)
        })
        .fullScreenCover(isPresented: $presentSignupView, content: {
            SignupView(presentSignupView: $presentSignupView)
        })
    }
    
    private func loginButtonState() -> Bool {
        return (tfEmail.isEmpty || tfPassword.isEmpty)
    }
    
    
//    @ViewBuilder
//    private func textField(title: String,
//                           text: Binding<String>) -> some View {
//        TextField(title, text: text, onEditingChanged: { isEditing in
//            isFocused = isEditing
//        })
//            .modifier(FormTextField(isFocused: isFocused))
//    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

