//
//  SwitchingLayouts.swift
//  Playground App
//
//  Created by Hugo Prinsloo on 2022/06/23.
//

import SwiftUI

enum LayoutOption: String, CaseIterable, Identifiable {
    case vstack
    case hstack
    
    var id: Self { self }
    
    var layout: any Layout {
        switch self {
        case .vstack: return VStack()
        case .hstack: return HStack()
        }
    }
}

struct SwitchingLayoutsUsingIfStatement: View {
    
    @State var layoutOption: LayoutOption = .hstack
    
    var body: some View {
        VStack {
            Picker("Pick Layout", selection: $layoutOption) {
                ForEach(LayoutOption.allCases) { layout in
                    Text(layout.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            

            if layoutOption == .hstack {
                HStack {
                    ForEach(ColorManager.colors) { color in
                        ColorView(color: color)
                    }
                }
                .frame(maxHeight: .infinity)
                .animation(.default.speed(0.5), value: layoutOption)
                .border(.primary)
            } else {
                VStack {
                    ForEach(ColorManager.colors) { color in
                        ColorView(color: color)
                    }
                }
                .frame(maxHeight: .infinity)
                .animation(.default.speed(0.5), value: layoutOption)
                .border(.primary)
            }
        }
    }
}



struct SwitchingLayouts: View {
    
    @State var layoutOption: LayoutOption = .hstack
    
    var body: some View {
        VStack {
            Picker("Pick Layout", selection: $layoutOption) {
                ForEach(LayoutOption.allCases) { layout in
                    Text(layout.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            // Switch between layouts
            let layout = AnyLayout(layoutOption.layout)
            layout {
                ForEach(ColorManager.colors) { color in
                    ColorView(color: color)
                }
            }
            .frame(maxHeight: .infinity)
            .border(.primary)
            .animation(.default.speed(0.5), value: layoutOption)
        }
    }
}





































struct SwitchingLayoutsUsingIfStatement_Previews: PreviewProvider {
    static var previews: some View {
        SwitchingLayoutsUsingIfStatement()
    }
}

struct SwitchingLayouts_Previews: PreviewProvider {
    static var previews: some View {
        SwitchingLayouts()
    }
}




extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct ColorView: View {
    
    let color: ColorItem
    
    var body: some View {
        Color(hex: color.hex)
            .frame(width: 80, height: 80)
            .cornerRadius(40)
            .overlay {
                Text(color.title)
                    .font(.caption)
                    .bold()
                    .foregroundColor(.white)
            }
    }
}


struct ColorItem: Identifiable {
    let title: String
    let hex: String
    
    var id: String { return title }
}

class ColorManager {
    static var colors: [ColorItem] = [
        ColorItem(title: "#293462", hex: "293462"),
        ColorItem(title: "#F24C4C", hex: "F24C4C"),
        ColorItem(title: "#EC9B3B", hex: "EC9B3B"),
        ColorItem(title: "#F7D716", hex: "F7D716"),
    ]
    
}
