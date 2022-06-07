//
//  SessionWithMisch.swift
//  Playground App
//
//  Created by Hugo Prinsloo on 2022/05/31.
//

import SwiftUI

class NetworkManager {
    
    var shouldSucceed: Bool = true
    
    func getTitle() throws -> String {
        if self.shouldSucceed {
            return "New String!"
        } else {
            throw URLError(.networkConnectionLost)
        }
    }
}

class ExampleViewModel: ObservableObject {
    
    @Published var title: String?
    
    let manager = NetworkManager()
    
    func fetchStuff() {
        manager.shouldSucceed = Bool.random()
                
        do {
            let newTitle = try manager.getTitle()
            title = newTitle
        } catch {
            title = "Failed because \(error.localizedDescription)"
        }
    }
}

struct ExampleView: View {
    
    @StateObject var viewModel  = ExampleViewModel()
    
    var body: some View {
        ZStack {
            if let text = viewModel.title {
                Text(text)
                
            } else {
                ProgressView()
            }
        }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    viewModel.fetchStuff()
                }
            }
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}



