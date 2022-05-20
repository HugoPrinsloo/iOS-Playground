//
//  ScrollableVStack.swift
//  Playground App
//
//  Created by Hugo Prinsloo on 2022/05/19.
//

import Foundation
import SwiftUI

/// A scrollable view that arranges its children in a vertical line.
///
/// VStack inside a ScrollView that's correctly framed by a GeometryReader to create the correct sizing setup out of the box.
///
/// # example
/// ```
/// var body: some View {
///    ScrollableVStack(alignment: .center, spacing: 16, showsIndicators: true) { proxy in
///        Image(headerImage)
///        Text(description)
///        Button("Continue", action: {})
///    }
/// }
/// ```

public struct ScrollableVStack<Content: View>: View {

    private let alignment: HorizontalAlignment
    private let spacing: CGFloat?
    private let showsIndicators: Bool
    private let content: (GeometryProxy) -> Content

    public init(alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil, showsIndicators: Bool = true, @ViewBuilder content: @escaping (GeometryProxy) -> Content) {
        self.alignment = alignment
        self.spacing = spacing
        self.showsIndicators = showsIndicators
        self.content = content
    }

    public var body: some View {
        GeometryReader { proxy in
            ScrollView(showsIndicators: showsIndicators) {
                VStack(alignment: alignment, spacing: spacing) {
                    content(proxy)
                }
                .frame(minHeight: proxy.size.height)
            }.frame(width: proxy.size.width)
        }
    }
}

/// A scrollable view that arranges its children in a vertical line that gets lazely loaded
///
/// LazyVStack inside a ScrollView that's correctly framed by a GeometryReader to create the correct sizing setup out of the box.
///
/// ## Example
/// ```swift
/// var body: some View {
///      LazyScrollableVStack(alignment: .center, spacing: 16, showsIndicators: true) { proxy in
///         Image(headerImage)
///         Text(description)
///         Button("Continue", action: {})
///     }
/// }
/// ```
///

public struct LazyScrollableVStack<Content: View>: View {

    private let alignment: HorizontalAlignment
    private let spacing: CGFloat?
    private let showsIndicators: Bool
    private let content: (GeometryProxy) -> Content

    public init(alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil, showsIndicators: Bool = true, @ViewBuilder content: @escaping (GeometryProxy) -> Content) {
        self.alignment = alignment
        self.spacing = spacing
        self.showsIndicators = showsIndicators
        self.content = content
    }

    public var body: some View {
        GeometryReader { proxy in
            ScrollView(showsIndicators: showsIndicators) {
                LazyVStack(alignment: alignment, spacing: spacing) {
                    content(proxy)
                }
            }
        }
    }
}
