//
//  AsyncTaskView.swift
//  Playground App
//
//  Created by Hugo Prinsloo on 2022/05/20.
//

import SwiftUI

class AsyncTaskViewModel: ObservableObject {
    let url = "https://picsum.photos/5000"
    
    @Published var image: UIImage? = nil
    
    func fetchImage() async {
        do {
            guard let url = URL(string: url) else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            await MainActor.run {
                image = UIImage(data: data)
                print("📝 AsyncTaskViewModel - Image Downloaded")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct AsyncTaskView: View {
    @StateObject private var viewModel = AsyncTaskViewModel()
    
    @State private var task: Task<(), Never>?
    
    var body: some View {
        VStack(spacing: 40) {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
            } else {
                ProgressView()
            }
        }.onAppear {
            task = Task(priority: .high) {
                await viewModel.fetchImage()
            }
        }
        .onDisappear {
            task?.cancel()
        }
        
    }
}




struct AsyncTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncTaskView()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

