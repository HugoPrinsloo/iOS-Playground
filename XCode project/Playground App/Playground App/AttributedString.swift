//
//  AttributedStringView.swift
//  Playground App
//
//  Created by Hugo Prinsloo on 2022/05/19.
//

import Foundation
import SwiftUI

struct AttributedStringView: View {
    
    var body: some View {
        Group {
            attributedView()
            
            Text("They *work on **multiple** lines! Very cool.* Lorem ipsum dolor sit amet, ~consectetur adipiscing elit, sed do eiusmod tempor incididunt.~")
                .multilineTextAlignment(.center)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(16)
                .padding()
            
            Text(attributedString)
        }
    }
    
    private var attributedString: AttributedString = {
        var t = AttributedString("This is so much better")
        let range = t.range(of: "so")!
        t[range].foregroundColor = .red
        t[range].font = .system(size: 24).bold()
        return t

    }()
    
    private func attributedView() -> some View {
        VStack {
            Text("Regular")
            Text("*Italics*")
            Text("**Bold**")
            Text("~Strikethrough~")
            Text("`Code`")
            Text("[Link](https://apple.com)")
            Text("***[They](https://apple.com) ~are~ `combinable`***")
        }
    }
}


struct AttributedString_Previews: PreviewProvider {
    static var previews: some View {
        AttributedStringView()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
