//
//  Structured Concurrency (Part 1).swift
//  Playground App
//
//  Created by Hugo Prinsloo on 2022/06/24.
//

import SwiftUI

fileprivate let urls = [
    URL(string: "https://www.objc.io/index.html")!,
    URL(string: "http://ftp.acc.umu.se/mirror/wikimedia.org/dumps/enwiki/20211101/enwiki-20211101-abstract.xml.gz")!
]


fileprivate class DownloadModel: ObservableObject {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    enum State {
        case notStarted
        case inProgress
        case done(URL)
    }
    
    @MainActor @Published var state = State.notStarted

    @MainActor
    func start() async throws {
        state = .inProgress
        
        // Download will still happen on background thread
        let (localURL, _) = try await URLSession.shared.download(from: url)
        state = .done(localURL)
    }
}

fileprivate struct DownloadView: View {
    @ObservedObject var model: DownloadModel
    
    var body: some View {
        VStack {
            Text("\(model.url)")
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            
            ZStack {
                switch model.state {
                case .notStarted:
                    Button("Start") {
                        Task {
                            try await model.start()
                        }
                    }
                    .buttonStyle(.bordered)
                case .inProgress:
                    ProgressView()
//                        .progressViewStyle(.linear)
                case let .done(url):
                    Text("File path: \(url)")
                }
            }
        }
    }
}


struct Structured_Concurrency__Part_1_: View {
    var body: some View {
        List(urls, id: \.self) { url in
            DownloadView(model: DownloadModel(url: url))
                .listRowSeparator(.hidden)
        }//.listStyle(.plain)
        
    }
}

struct Structured_Concurrency__Part_1__Previews: PreviewProvider {
    static var previews: some View {
        Structured_Concurrency__Part_1_()
    }
}
