//
//  RegisterView.swift
//  student568908
//
//  Created by user180971 on 10/12/20.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var username: String = ""
    @State var password: String = ""
    @State var repeatPassword: String = ""
    @State var isTryingToRegister: Bool = false
    
    var isFormValid: Bool {
        return username.count >= 3 && password.count >= 3
    }
    
    var body: some View {
        VStack {
            if isTryingToRegister {
                ProgressView("Trying to register...")
            } else {
                TextField("Enter username", text: $username)
                    .padding()
                    .border(Color.black.opacity(0.2), width: 1)
                    .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                SecureField("Enter password", text: $password)
                    .padding()
                    .border(Color.black.opacity(0.2), width: 1)
                    .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                SecureField("Repeat password", text: $repeatPassword)
                    .padding()
                    .border(Color.black.opacity(0.2), width: 1)
                    .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                Button(action: {
                    isTryingToRegister = true
                    NewsReaderAPI.shared.register(username: username, password: password) { (result) in
                        switch result {
                        case .success(let response):
                            if response.success {
                                self.presentationMode.wrappedValue.dismiss()
                            } else {
                                // TO DO bestaat al
                            }
                        case .failure(let error ):
                            // TODO: error message
                            switch error {
                            case .urlError(let urlError):
                                print(urlError)
                            case .decodingError(let decodingError):
                                print(decodingError)
                            case .genericError(let error):
                                print(error)
                            }
                        }
                        self.isTryingToRegister = false
                    }
                }, label: {
                    Text("Register")
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .foregroundColor(.white)
                }).disabled(isFormValid == false)
                .background(Color.blue)
                .cornerRadius(8.0)
            }
        }.padding()
        .navigationTitle("Register")
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
