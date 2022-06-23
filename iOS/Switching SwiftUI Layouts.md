# Switching between Layouts

Imagine we have to switch between **HStack** & **VStack** using a segment control. 

<img width="400" src="https://user-images.githubusercontent.com/80469971/175284283-d92c89c8-c808-46b4-ba02-910e39d81e85.jpg">



## Using if statement (meh)
1. We would create an enum with the two cases
```swift
enum LayoutOption: String, CaseIterable, Identifiable {
    case vstack
    case hstack
    
    var id: Self { self }
}
```

2. Using an `if` statement to determine which layout to use. 


```swift
struct SwitchingLayoutsUsingIfStatement: View {
    
    @State var layoutOption: LayoutOption = .hstack
    
    var body: some View {
        VStack {
        Picker("Pick Layout", selection: $layoutOption) { ... }

        // Switching between layoutOption
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
```

### Cons
- End up with a large view because of the code duplication
- Even though we call animate, the view redraws all views inside (because it's essentially two different views we coded) and therefore ignores the animation


<img width="300" src="https://user-images.githubusercontent.com/80469971/175282053-d1e3f079-e4fd-47b2-abc1-549160f586b3.gif">



## Using **Layout** 🎉
1. We would create that same enum with the two cases but add a layout property to it
> This property returns **HStack** or **VStack** depending on the current option 

```swift
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
```


2. Using **AnyLayout** we can reuse the same inner views and wrap them in the selected LayoutOption **Layout**  


```swift
struct SwitchingLayoutsUsingIfStatement: View {
    
    @State var layoutOption: LayoutOption = .hstack
    
    var body: some View {
        VStack {
        Picker("Pick Layout", selection: $layoutOption) { ... }

        // Create Layout based on selected option 
        // that will wrap inner views
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
```

### Pros
- It's much easier to read because there are no duplicated inner views needed
- We can actually animate all changes because we're using the same inner views and only updating the Layout



<img width="300" src="https://user-images.githubusercontent.com/80469971/175282232-d8ac733d-e431-4b54-9226-1340e1ef2405.gif">




