//
//  DoCatchExample.swift
//  Playground App
//
//  Created by Hugo Prinsloo on 2022/06/01.
//

import SwiftUI

class TextDownloader {
    
    var shouldSucceed: Bool = true
    
    func downloadTitle() throws -> String {
        if shouldSucceed {
            return "Final text!"
        } else {
            throw URLError(.badURL)
        }
    }
    
}

class DoCatchViewModel: ObservableObject {
    
    @Published var title: String?
    
    let textDownloader = TextDownloader()
    
    func fetchText() {
        textDownloader.shouldSucceed = Bool.random()
        
        do {
            title = try textDownloader.downloadTitle()
            
            // Fetch Profile Picture else
            
            // Fetch Friends list else
            
            // Fetch something else
            
            // Fetch something else
        } catch {
            title = "Oops something went wrong"
        }
        
            
//        textDownloader.downloadTitle()
    }
}

struct DoCatchExample: View {
    
    @StateObject var viewModel = DoCatchViewModel()
    
    var body: some View {
        Text(viewModel.title ?? "")
            .onAppear {
                viewModel.fetchText()
            }
    }
}

struct DoCatchExample_Previews: PreviewProvider {
    static var previews: some View {
        DoCatchExample()
    }
}
