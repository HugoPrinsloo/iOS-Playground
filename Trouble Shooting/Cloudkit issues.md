# Cloudkit - Invalid bundle ID for container

### Code setup
```swift
enum Config {
    /// iCloud container identifier.
    static let containerIdentifier = "iCloud.app bundle.."
}
```

```swift
final class ViewModel: ObservableObject {
    /// The CloudKit container we'll use.
    private lazy var container = CKContainer(identifier: Config.containerIdentifier)
    

    func saveData(_ data: SomeObject, completion: @escaping (_ success: Bool) -> Void) {
        let record = CKRecord(recordType: "Object")
        record.setValuesForKeys([
            "Item": "Value"
        ])
        
        container.privateCloudDatabase.save(record) { record, error in }
    }
}
```

### Project settings

> Signing & Capabilities

![CleanShot 2022-04-21 at 16 07 37@2x](https://user-images.githubusercontent.com/80469971/164476383-e25149af-6fef-4ea2-bff3-68a247930cd7.png)


# Error: `Invalid bundle ID for container`

### The fix: 

Replace `$(PRODUCT_BUNDLE_IDENTIFIER)` with your actual bundleID in: 

![CleanShot 2022-04-21 at 16 11 57@2x](https://user-images.githubusercontent.com/80469971/164477247-98e3d831-a261-4c9f-a36f-f2f034ee13fb.png)





