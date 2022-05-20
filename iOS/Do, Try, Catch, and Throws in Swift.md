# Do, Try, Catch, and Throws in Swift
> Perform asynchronous and parallel operations.

### Inside a data manager 

```swift
class DataManager {

  // Using this to mock failures
    var shouldSucceed: Bool = true

```

## Returning Tuple 
An "okay" way to write a fetch function would be to return title (optional) and error (optional)
like this: (But we can do better) 
```swift
func getTitle() -> (title: String?, error: Error?) {
    if shouldSucceed {
        return ("New Text!", nil)
    } else {
        return (nil, URLError(...))
    }
}
```

#### Usage example 
```swift
let returnedValue = manager.getTitle()

if let newTitle = returnedValue.title {
    self.text = newTitle
} else if let error = returnedValue.error {
    self.text = error.localizedDescription
}
```

## Using Result 
Returning result is much better than returning a tuple because you get a clear `success` / `failure` result back which you can switch on. 
```swift
func getTitle() -> Result<String, Error> {
    if shouldSucceed {
        return .success("New Text!")
    } else {
        return .failure(URLError(...))
    }
}

```

#### Usage example 
```swift
let result = manager.getTitle()

switch result {
case let .success(newString):
    self.text = newString
case let .failure(error):
    self.text = error.localizedDescription
}
```

## Using Throw
By adding `throw` to our function, it will give us a string back or throw us an error if its unable to do so.  

```swift
func getTitle() throws -> String {
    if shouldSucceed {
        return "Final text!"
    } else {
        throw URLError(...)
    }
}
```

#### Usage example

If you care about the error then you'd want to make use of a `do/catch` block

```swift
do {
    let newTitle = try manager.getTitle()
    text = newTitle
} catch {
    // handle error
    text = error.localizedDescription
}
```

#### Multiple requests in the same `do` block
```swift
do {
    let newTitle = try manager.getTitle()
    text = newTitle
    
    // you can have multiple get requests but as soon as one fails
    // it will exit out and go into the catch block
    let fetchOtherThings = try manager.fetch...
} catch {
    // handle error
    text = error.localizedDescription
}
```

If you don't care about the error then you could just mark `try` as optional and it will return an optional value
```swift
let newTitle = try? manager.getTitle()
text = newTitle ?? ""
```