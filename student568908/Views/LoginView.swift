//
//  LoginView.swift
//  student568908
//
//  Created by user180971 on 10/12/20.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var username: String = ""
    @State var password: String = ""
    @State var isTryingToLogin: Bool = false
    
    var body: some View {
        VStack {
            if isTryingToLogin {
                ProgressView("Trying to login...")
            } else {
                TextField("Enter username", text: $username)
                    .padding()
                    .border(Color.black.opacity(0.2), width: 1)
                    .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                SecureField("Enter password", text: $password)
                    .padding()
                    .border(Color.black.opacity(0.2), width: 1)
                    .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                Button(action: {
                    isTryingToLogin = true
                    NewsReaderAPI.shared.login(username: username, password: password) { (result) in
                        switch result {
                        case .success(let response):
                            NewsReaderAPI.shared.accessToken = response.accessToken
                            self.presentationMode.wrappedValue.dismiss()
                        case .failure(_):
                            break
                        }
                        self.isTryingToLogin = false
                    }
                }, label: {
                    Text("Login")
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .foregroundColor(.white)
                })
                .background(Color.blue)
                .cornerRadius(8.0)
            }
        }.padding()
        .navigationTitle("Login")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
