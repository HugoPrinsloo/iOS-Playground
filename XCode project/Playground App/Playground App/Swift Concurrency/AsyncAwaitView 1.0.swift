//
//  AsyncAwaitView.swift
//  Playground App
//
//  Created by Hugo Prinsloo on 2022/05/20.
//

import SwiftUI

class DownloadImageAsyncLoader {
    
    let url = URL(string: "https://images.unsplash.com/photo-1652987543455-ec604a99c397?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyN3x8fGVufDB8fHx8&auto=format&fit=crop&w=900")!
    
    // Using completion handler
    func downloadWithEscaping(completion: @escaping (_ image: UIImage?, _ error: Error? ) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil, error)
                return
            }
            completion(image, nil)
        }.resume()
    }
    
    // Using async/await
    func downloadWithAsync() async throws -> UIImage? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            throw error
        }
    }
}

class DownloadImageAsyncViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    
    private let loader = DownloadImageAsyncLoader()
    
    func fetchImage() async {
        // Fetch with completion handler
        /*
        loader.downloadWithEscaping { [weak self] image, error in
            // Check for errors
            
            // UI updates to be made on main thread
            DispatchQueue.main.async {
                self?.image = image
            }
        }
         */
        
        // Async await
        let newImage = try? await loader.downloadWithAsync()
        
        // Moving to main thread
        await MainActor.run {
            image = newImage
        }
    }
    
    
}



struct AsyncAwaitView: View {
    
    @StateObject private var viewModel = DownloadImageAsyncViewModel()
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }.onAppear {
//            viewModel.fetchImage()
            
            // Add task to use async functions
            Task {
                await viewModel.fetchImage()
            }
        }
    }
}

struct AsyncAwaitView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncAwaitView()
            .frame(width: 220, height: 220)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

