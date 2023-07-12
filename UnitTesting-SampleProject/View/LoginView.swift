//
//  LoginView.swift
//  UnitTesting-SampleProject
//
//  Created by Daniyal Yousuf on 2023-07-11.
//

import SwiftUI

struct LoginView: View {
    @State private var tfEmail: String =  ""
    @State private var tfPassword: String = ""
    @State private var loginButtonEnabled: Bool = false
    @State private var presentList: Bool = false
    var body: some View {
        NavigationView(content: {
            Form {
                textField(title: "Email",
                          text: $tfEmail)
                textField(title: "Password",
                          text: $tfPassword)
                Button {
                    presentList = true
                } label: {
                    Text("Login")
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(loginButtonState() ? .gray.opacity(0.7) : .green)
                        .foregroundColor(.white)
                        .containerShape(RoundedRectangle(cornerRadius: 60))
                    
                }.disabled(loginButtonState())
                
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Sign up")
                            .font(.system(size: 18))
                            .foregroundColor(.blue)
                    }
                }
                
            }
            .padding()
            .formStyle(.columns)
            .navigationTitle("Sign in")
        })
        .edgesIgnoringSafeArea(.all)
        .ignoresSafeArea(.all)
        .fullScreenCover(isPresented: $presentList, content: {
            ContentView(presentScreen: $presentList)
        })
    }
    
    func loginButtonState() -> Bool {
        return (tfEmail.isEmpty || tfPassword.isEmpty)
    }
    
    
    @ViewBuilder
    private func textField(title: String,
                   text: Binding<String>) -> some View {
        TextField(title, text: text)
            .modifier(FormTextField())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct FormTextField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .background(.gray.opacity(0.2))
            .containerShape(RoundedRectangle(cornerRadius: 60))
            .foregroundColor(.black)
            .font(.system(size: 20))
    }
}
