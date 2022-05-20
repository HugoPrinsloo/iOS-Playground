//
//  AsyncAwait 2.0.swift
//  Playground App
//
//  Created by Hugo Prinsloo on 2022/05/20.
//

import SwiftUI

class AsyncAwait2ViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func addTitle1() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dataArray.append("Title 1 : \(Thread.current)")
        }
    }
    
    func addTitle2() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let title = "Title 2 \(Thread.current)"
            
            DispatchQueue.main.async {
                self.dataArray.append(title)
                let title2 = "Title 3 \(Thread.current)"
                self.dataArray.append(title2)
            }
        }
    }
    
    
    func addAuthor1() async {
        let author = "Author 1 : \(Thread.current)"
        dataArray.append(author)
        
        // Add delay
        // 2000000000 = 2 sec
        try? await Task.sleep(nanoseconds: 2000000000)
        
        let author2 = "Author 2 : \(Thread.current)"
        
        // Go onto main thread
        await MainActor.run {
            dataArray.append(author2)
            
            let author2 = "Author 3 : \(Thread.current)"
            dataArray.append(author2)
        }
        
        await addSomething()
    }
    
    func addSomething() async {
        try? await Task.sleep(nanoseconds: 2000000000)
        
        let something1 = "Something 1 : \(Thread.current)"
        
        // Go onto main thread
        await MainActor.run {
            dataArray.append(something1)
            
            let something2 = "Something 2 : \(Thread.current)"
            dataArray.append(something2)
        }
    }
}

struct AsyncAwait_2_0: View {
    
    @StateObject private var viewModel = AsyncAwait2ViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.dataArray, id: \.self, content: { data in
                Text(data)
            })
        }.onAppear {
//            viewModel.addTitle1()
//            viewModel.addTitle2()
            Task {
                await viewModel.addAuthor1()
            }
        }
    }
}

struct AsyncAwait_2_0_Previews: PreviewProvider {
    static var previews: some View {
        AsyncAwait_2_0()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
