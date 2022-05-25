//
//  HomeView.swift
//  Playground App
//
//  Created by Hugo Prinsloo on 2022/05/24.
//

import SwiftUI


struct HomeView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Login Form", destination: LoginForm())
                NavigationLink("AsyncImageLoading", destination: AsyncImageLoading())
                NavigationLink("AttributedStringView", destination: AttributedStringView())
                NavigationLink("DoCatchTryThrowsView", destination: DoCatchTryThrowsView())
                NavigationLink("AsyncTaskView", destination: AsyncTaskView())
                NavigationLink("Async Let", destination: AsyncLetView())

            }
            .navigationTitle("Playground")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
