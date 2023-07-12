//
//  SignupView.swift
//  UnitTesting-SampleProject
//
//  Created by Daniyal Yousuf on 2023-07-12.
//

import SwiftUI

struct SignupView: View {
    @Binding var presentSignupView: Bool
    
    @State private var presentList: Bool = false
    @State var tfFirstName: String = ""
    @State var tfLastName: String = ""
    @State var tfEmail: String = ""
    @State var tfPassword: String = ""
    @State var tfRepeatedPassword: String = ""
    @State var tfPhoneNumber: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    TextField("First Name", text: $tfFirstName)
                        .modifier(FormTextField())
                    TextField("Last  Name", text: $tfLastName)
                        .modifier(FormTextField())
                }
                
                TextField("Email Address", text: $tfEmail)
                    .modifier(FormTextField())
                    .keyboardType(.emailAddress)
                
                TextField("Password", text: $tfPassword)
                    .modifier(FormTextField())
                
                TextField("Repeated Password", text: $tfRepeatedPassword)
                    .modifier(FormTextField())
                
                TextField("Phone Number", text: $tfPhoneNumber)
                    .modifier(FormTextField())
                    .keyboardType(.phonePad)
                
                Button {
                    
                } label: {
                    Text("Sign up")
                        .modifier(FormTextButton(buttonDisabled: signupButtonState()))
                }.disabled(signupButtonState())
            }
            .formStyle(.columns)
            .navigationTitle("Sign up")
            .padding(18)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button  {
                        presentSignupView = false
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                            .fontWeight(.medium)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $presentList, content: {
            CatListView(presentScreen: $presentList)
        })
    }
    
    private func signupButtonState() -> Bool {
        return (tfEmail.isEmpty || tfPassword.isEmpty) //this goes in view mode not covered here
    }

}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(presentSignupView: .constant(false))
    }
}
