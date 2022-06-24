//
//  BuildingAPhotoGrid-SquareGridCells.swift
//  Playground App
//
//  Created by Hugo Prinsloo on 2022/06/24.
//

import SwiftUI

struct PhotoGridView: View {
    @State private var selectedPhotoID: Int?
    @State private var slowAnimations: Bool = false
    @Namespace private var namespace

    
    var body: some View {
        VStack {
            Toggle("Slow Animations", isOn: $slowAnimations).padding()
            ZStack {
                gridView
                    .opacity(selectedPhotoID == nil ? 1 : 0)
                detailView
            }.animation(.default.speed(slowAnimations ? 0.2 : 1), value: selectedPhotoID)
        }
    }
    
    @ViewBuilder
    var detailView: some View {
        if let id = selectedPhotoID {
            Image("sampleImage\(id)")
                .resizable()
                .matchedGeometryEffect(id: id, in: namespace, isSource: true)
                .aspectRatio(contentMode: .fit)
                .onTapGesture {
                    selectedPhotoID = nil
                }
        }
    }
    
    var gridView: some View {
        ScrollView {
            LazyVGrid(columns: [.init(.adaptive(minimum: 100), spacing: 3)], spacing: 3) {
                ForEach(1..<11) { index in
                    Image("sampleImage\(index)")
                        .resizable()
                        .matchedGeometryEffect(id: index, in: namespace)
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .clipped()
                        .aspectRatio(1, contentMode: .fit)
                        .onTapGesture {
                            selectedPhotoID = index
                        }
                }
            }
        }
    }
}

struct BuildingAPhotoGrid_SquareGridCells: View {
    var body: some View {
        PhotoGridView()
    }
}

struct BuildingAPhotoGrid_SquareGridCells_Previews: PreviewProvider {
    static var previews: some View {
        BuildingAPhotoGrid_SquareGridCells()
    }
}
 
