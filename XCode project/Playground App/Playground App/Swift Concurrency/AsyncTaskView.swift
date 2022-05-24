//
//  AsyncTaskView.swift
//  Playground App
//
//  Created by Hugo Prinsloo on 2022/05/20.
//

import SwiftUI




class AsyncTaskViewModel: ObservableObject {
    let url = "https://picsum.photos/3000"
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil

    func fetchImage() async {
        do {
            guard let url = URL(string: url) else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            image = UIImage(data: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage2() async {
        do {
            guard let url = URL(string: url) else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            image2 = UIImage(data: data)
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct AsyncTaskView: View {
    @StateObject private var viewModel = AsyncTaskViewModel()
    var body: some View {
        VStack(spacing: 40) {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
            }
            if let image2 = viewModel.image2 {
                Image(uiImage: image2)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
            }

        }.onAppear {
            
            Task {
                await viewModel.fetchImage()
                await viewModel.fetchImage2()
            }
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
