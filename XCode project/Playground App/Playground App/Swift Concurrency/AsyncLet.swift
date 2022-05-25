//
//  AsyncLet.swift
//  Playground App
//
//  Created by Hugo Prinsloo on 2022/05/25.
//

import SwiftUI

struct AsyncLetView: View {
    @State private var images: [UIImage] = []
    @State private var username: String = ""
    @State private var isSubscribed: Bool = false
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ZStack {
            if username.isEmpty {
                ProgressView()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        Text(isSubscribed ? "You are Subscribed" : "Upgrade now")
                        LazyVGrid(columns: columns) {
                            ForEach(images, id: \.self) { image in
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 150)
                            }
                        }
                        
                    }.padding(.horizontal, 16)
                }.navigationTitle("Welcome back \(username)!")
                
            }
        }.onAppear {
            Task {
                
                // `async let` lets you group a bunch of functions that will
                // execute at the same time and will wait for all to finish before continuing
                async let getUsername = getUsername()
                async let getStatus = getSubscriptionStatus()
                
                let (name, subscriptionStatus) = await (getUsername, getStatus)
                username = name
                isSubscribed = subscriptionStatus == "PRO"
                
                
                // Whereas these will not do the next `fetchImage` until the previous is completed
                if let image1 = try? await fetchImage() {
                    images.append(image1)
                }
                
                // Whereas these will not do the next `fetchImage` until the previous is completed
                if let image2 = try? await fetchImage() {
                    images.append(image2)
                }

                // Whereas these will not do the next `fetchImage` until the previous is completed
                for _ in 1...10 {
                    if let image = try? await fetchImage() {
                        images.append(image)
                    }
                }

            }
        }
    }
    
    let url = URL(string: "https://picsum.photos/2000")!

    func fetchImage() async throws -> UIImage {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError(.badURL)
            }
        } catch {
            throw error
        }
    }
    
    private func getUsername() async -> String {
        return "hloo"
    }
    
    private func getSubscriptionStatus() async -> String {
        try? await Task.sleep(nanoseconds: 2000000000)
        return "PRO"
    }


}

struct AsyncLet_Previews: PreviewProvider {
    static var previews: some View {
        AsyncLetView()
    }
}
