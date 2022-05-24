## Async/Await basics

#### Creating an async function
> It's nice to combine async with `do` `catch` blocks like this:

```swift
func fetchImage() async throws -> UIImage? {
    do {
        let (data, response) = try await URLSession.shared.data(from: url)
        return UIImage(data: data)
    } catch {
        throw error
    }
}
```

### Usage
```swift
let newImage = try? await loader.fetchImage()
```

### Async functions don't have to return something
> This function downloads the image and sets a local property once completed

```swift
func fetchImage() async {
    do {
        guard let url = URL(string: url) else { return }
        let (data, _) = try await URLSession.shared.data(from: url)
        self.image = UIImage(data: data)
    } catch {
      // Handle errors
        print(error.localizedDescription)
    }
}
```

### Async functions that are connected with UI (Moving to main thread)
> When an async function returns something that will be displayed on the UI 
> It's important to ensure this update happens on the main thread

 
```swift
await MainActor.run {
    image = downloadedImage
}
```




## Task
#### Creating a basic Task
> This is fine for light weight tasks 

```swift
Task {
    await viewModel.fetchImage()
}
```


#### Advanced task handling
> Tasks that take some time should be canceled when users dismisses the current view
> Assign a task to a property and call cancel in `onDisappear`


```swift
struct ImageView: View {

    // Property that's connected to the task
    @State private var task: Task<(), Never>?

    @StateObject private var viewModel = ViewModel()

    var body: some View {
         ... image logic
         
         }.onAppear {
            task = Task {
                await viewModel.fetchImage()
            }
        }
        .onDisappear {
            task?.cancel()
        }
        
    }
}
```
### Example use case
> We don't want the image to continue downloading when the user tapped back

<img width="300" src="https://user-images.githubusercontent.com/80469971/170065703-e04becee-f2dc-4d90-800a-db7509cdaa16.gif">
<img width="300" src="https://user-images.githubusercontent.com/80469971/170065733-8629b522-35b3-424c-9ef0-863e6ba9dc39.gif">


## Task Priority
> You could run multiple tasks at the same time. Hence choosing each task's priority

```swift
.onAppear {
    Task(priority: .high) {
        // Fetch important data
    }
    Task(priority: .medium) {
        // Fetch experiments to see if user falls into experiment 
    }
    Task(priority: .low) {
        // Some non-essential tasks
    }
}
```



