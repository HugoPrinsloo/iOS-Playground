//
//  ConcurrencyView.swift
//  Playground App
//
//  Created by Hugo Prinsloo on 2022/05/20.
//

import SwiftUI

class DoCatchTryThrowsDataManager {
    var isActive: Bool = true
    
    // Old way
    func getTitle() -> (title: String?, error: Error?) {
        if isActive {
            return ("New Text!", nil)
        } else {
            return (nil, URLError(.badURL))
        }
    }
    
    // Better way using Result
    func getTitleWithResult() -> Result<String, Error> {
        if isActive {
            return .success("New Text!")
        } else {
            return .failure(URLError(.cannotDecodeRawData))
        }
    }
    
    func getTitleWithTryAndThrow() throws -> String {
        if isActive {
            return "New Text!"
        } else {
            throw URLError(.cannotCreateFile)
        }
    }
    
    func getFinalTitle() throws -> String {
        if isActive {
            return "Final text!"
        } else {
            throw URLError(.cannotCreateFile)
        }
    }

}

class DoCatchTryThrowsViewModel: ObservableObject {
    
    @Published var text: String = "Starting text."
    let manager = DoCatchTryThrowsDataManager()
    
    func fetchTitle() {
        // Using old way
        /*
        let returnedValue = manager.getTitle()
        
        if let newTitle = returnedValue.title {
            self.text = newTitle
        } else if let error = returnedValue.error {
            self.text = error.localizedDescription
        }
        */
        
        // Using result
        /*
        let result = manager.getTitleWithResult()
        switch result {
        case let .success(newString):
            self.text = newString
        case let .failure(error):
            self.text = error.localizedDescription
        }
        */
        
        // If you don't care about the error you could make try optional.
        // Note that `foo` will now be optional string
        let foo = try? manager.getTitleWithTryAndThrow()
        text = foo ?? ""


        // If you DO care about the error then use a do/catch block
        do {
            // Can have multiple get requests but as soon as one fails
            // it will exit out and go into the catch block
            
            let newTitle = try manager.getTitleWithTryAndThrow()
            text = newTitle
            
            let finalTitle = try manager.getFinalTitle()
            text = finalTitle

        } catch {
            text = error.localizedDescription
        }
    }
}

struct DoCatchTryThrowsView: View {
    
    @StateObject private var viewModel = DoCatchTryThrowsViewModel()
    
    var body: some View {
        Text(viewModel.text)
            .onTapGesture {
                viewModel.fetchTitle()
            }
    }
}

struct ConcurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        DoCatchTryThrowsView()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
