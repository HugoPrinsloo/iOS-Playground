//
//  LoginForm.swift
//  Playground App
//
//  Created by Hugo Prinsloo on 2022/05/19.
//

import SwiftUI

struct LoginForm: View {
    enum Field: Hashable {
        case username
        case password
    }

    @State private var username = ""
    @State private var password = ""
    @FocusState private var focusedField: Field?

    var body: some View {
        Form {
            TextField("Username", text: $username)
                .focused($focusedField, equals: .username)

            SecureField("Password", text: $password)
                .focused($focusedField, equals: .password)

            Button("Sign In") {
                if username.isEmpty {
                    focusedField = .username
                } else if password.isEmpty {
                    focusedField = .password
                } else {
                    focusedField = nil
                    // handleLogin(username, password)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                focusedField = .username
            }
        }
    }
}


struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

//AttributedString
