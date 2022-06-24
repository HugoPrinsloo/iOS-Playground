//
//  HomeView.swift
//  Playground App
//
//  Created by Hugo Prinsloo on 2022/05/24.
//

import SwiftUI


enum Category: String, CaseIterable {
    case swiftUI = "SwiftUI"
    case asyncAwait = "Async await"
}

struct Demo: Identifiable {
    let title: String
    let section: Category
    let destinationView: any View
        
    var id: String {
        return self.title
    }
}

struct HomeView: View {
    
    private let itemsToShow: [Demo] = [
        Demo(title: "TextField updates (iOS16)", section: .swiftUI, destinationView: LoginForm()),
        Demo(title: "AsyncImageLoading", section: .asyncAwait, destinationView: AsyncImageLoading()),
        Demo(title: "AttributedStringView", section: .swiftUI, destinationView: AttributedStringView()),
        Demo(title: "DoCatchTryThrowsView", section: .asyncAwait, destinationView: DoCatchTryThrowsView()),
        Demo(title: "AsyncTaskView", section: .asyncAwait, destinationView: AsyncTaskView()),
        Demo(title: "Async Let", section: .asyncAwait, destinationView: AsyncLetView()),
        Demo(title: "Image Grid View", section: .swiftUI, destinationView: BuildingAPhotoGrid_SquareGridCells()),
        Demo(title: "Structured Concurrency Part 1", section: .asyncAwait, destinationView: Structured_Concurrency__Part_1_()),
    ]
        
    var body: some View {
        NavigationStack {
            List {
                ForEach(Category.allCases, id: \.self) { category in
                    Section(category.rawValue) {
                        ForEach(demos(for: category)) { demo in
                            NavigationLink(demo.title, destination: destination(for: demo))
                        }
                    }
                }
            }
            .navigationTitle("Playground")
        }
    }
    
    private func demos(for section: Category) -> [Demo] {
        return itemsToShow.filter { $0.section == section }
    }
    
    private func destination(for demo: Demo) -> some View {
        VStack {
            AnyView(demo.destinationView)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
