//
//  AsyncImageLoading.swift
//  Playground App
//
//  Created by Hugo Prinsloo on 2022/05/19.
//

import SwiftUI

struct AsyncImageLoading: View {
    var body: some View {
        LazyScrollableVStack(spacing: 16) { proxy in
            ForEach(ImageProvider.images, id: \.self) { imageName in
                AsyncImage(url: URL(string: imageName)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: proxy.size.width)
                } placeholder: {
                    ProgressView()
                }
            }
        }
    }
}

struct AsyncImageLoading_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageLoading()
    }
}


struct ImageProvider {
    
    static let images: [String] = [
        "https://images.unsplash.com/photo-1503899036084-c55cdd92da26?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dG9reW98ZW58MHx8MHx8&auto=format&fit=crop&w=1600",
        "https://images.unsplash.com/photo-1554797589-7241bb691973?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dG9reW98ZW58MHx8MHx8&auto=format&fit=crop&w=900",
        "https://images.unsplash.com/photo-1536098561742-ca998e48cbcc?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8dG9reW98ZW58MHx8MHx8&auto=format&fit=crop&w=900",
        "https://images.unsplash.com/photo-1503899036084-c55cdd92da26?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dG9reW98ZW58MHx8MHx8&auto=format&fit=crop&w=1600",
        "https://images.unsplash.com/photo-1554797589-7241bb691973?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dG9reW98ZW58MHx8MHx8&auto=format&fit=crop&w=900",
        "https://images.unsplash.com/photo-1536098561742-ca998e48cbcc?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8dG9reW98ZW58MHx8MHx8&auto=format&fit=crop&w=900",
        "https://images.unsplash.com/photo-1503899036084-c55cdd92da26?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dG9reW98ZW58MHx8MHx8&auto=format&fit=crop&w=1600",
        "https://images.unsplash.com/photo-1554797589-7241bb691973?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dG9reW98ZW58MHx8MHx8&auto=format&fit=crop&w=900",
        "https://images.unsplash.com/photo-1536098561742-ca998e48cbcc?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8dG9reW98ZW58MHx8MHx8&auto=format&fit=crop&w=900",
        "https://images.unsplash.com/photo-1503899036084-c55cdd92da26?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dG9reW98ZW58MHx8MHx8&auto=format&fit=crop&w=1600",
        "https://images.unsplash.com/photo-1554797589-7241bb691973?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dG9reW98ZW58MHx8MHx8&auto=format&fit=crop&w=900",
        "https://images.unsplash.com/photo-1536098561742-ca998e48cbcc?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8dG9reW98ZW58MHx8MHx8&auto=format&fit=crop&w=900",
        "https://images.unsplash.com/photo-1503899036084-c55cdd92da26?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dG9reW98ZW58MHx8MHx8&auto=format&fit=crop&w=1600",
        "https://images.unsplash.com/photo-1554797589-7241bb691973?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dG9reW98ZW58MHx8MHx8&auto=format&fit=crop&w=900",
        "https://images.unsplash.com/photo-1536098561742-ca998e48cbcc?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8dG9reW98ZW58MHx8MHx8&auto=format&fit=crop&w=900",
        "https://images.unsplash.com/photo-1503899036084-c55cdd92da26?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dG9reW98ZW58MHx8MHx8&auto=format&fit=crop&w=1600",
        "https://images.unsplash.com/photo-1554797589-7241bb691973?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dG9reW98ZW58MHx8MHx8&auto=format&fit=crop&w=900",
        "https://images.unsplash.com/photo-1536098561742-ca998e48cbcc?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8dG9reW98ZW58MHx8MHx8&auto=format&fit=crop&w=900",
        "https://images.unsplash.com/photo-1503899036084-c55cdd92da26?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dG9reW98ZW58MHx8MHx8&auto=format&fit=crop&w=1600",
        "https://images.unsplash.com/photo-1554797589-7241bb691973?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dG9reW98ZW58MHx8MHx8&auto=format&fit=crop&w=900",
        "https://images.unsplash.com/photo-1536098561742-ca998e48cbcc?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8dG9reW98ZW58MHx8MHx8&auto=format&fit=crop&w=900",
        "https://images.unsplash.com/photo-1503899036084-c55cdd92da26?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dG9reW98ZW58MHx8MHx8&auto=format&fit=crop&w=1600",
        "https://images.unsplash.com/photo-1554797589-7241bb691973?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dG9reW98ZW58MHx8MHx8&auto=format&fit=crop&w=900",
        "https://images.unsplash.com/photo-1536098561742-ca998e48cbcc?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8dG9reW98ZW58MHx8MHx8&auto=format&fit=crop&w=900",
    ]
    
}
