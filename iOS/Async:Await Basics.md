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

#### Async functions don't have to return something
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





