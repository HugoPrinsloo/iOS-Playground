//
//  AsyncPlayground.swift
//  Playground App
//
//  Created by Hugo Prinsloo on 2022/05/20.
//

import SwiftUI

class AsyncPlaygroundImageDownloader {
    
    let url = URL(string: "https://images.unsplash.com/photo-1579022287310-910c9a360453?ixlib=rb-1.2.1&raw_url=true&q=80&fm=jpg&crop=entropy&cs=tinysrgb&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format")!
    
    private let shouldSucceed: Bool = true
    
    func downloadImage() async throws -> UIImage? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            throw error
        }
    }
}

class AsyncPlaygroundViewModel: ObservableObject {
    @Published var progress: Int = 0
    @Published var image: UIImage?
    @Published var errorMessage: String?
    
    private let imageDownloader = AsyncPlaygroundImageDownloader()
    
    func fetchImage() async {
        
        await mockLoader()
        
        do {
            let downloadedImage = try await imageDownloader.downloadImage()
            await MainActor.run {
                image = downloadedImage
            }
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    private func mockLoader() async {
        for i in 1...100 {
            try? await Task.sleep(nanoseconds: 50000000)
            
            await MainActor.run {
                progress = i
            }
        }
    }
}

struct AsyncPlayground: View {
    
    @StateObject private var viewModel = AsyncPlaygroundViewModel()
    
    var body: some View {
        ZStack {
            
            if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
                    .padding()
            } else if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
            } else {
                VStack {
                    Text("Large Image").font(.title)
                        .padding(.bottom)
                    if viewModel.progress == 100 {
                        ProgressView("Opening")
                    } else {
                        Text("\(viewModel.progress)%")
                            .foregroundColor(.gray)
                        ProgressView("Downloading")
                    }
                }
            }
        }.onAppear {
            Task {
               await viewModel.fetchImage()
            }
        }
    }
}

struct AsyncPlayground_Previews: PreviewProvider {
    static var previews: some View {
        AsyncPlayground()
    }
}

