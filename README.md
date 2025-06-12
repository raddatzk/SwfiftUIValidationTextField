# SwiftUI Validation Text Field

Validate the content of your TextField

## Usage

Add `git@github.com:raddatzk/SwiftUIValidationTextField.git` as a package dependency to your target and you are good to go

The `ValidationTextfield` takes a binding of String and a validator callback and can be customized in certain ways

```swift
ValidationTextField(
    text: .constant(""),
    placeholder: "Test",
    background: .red.opacity(0.2),
    font: .body,
) { value in value.isEmpty ? "Must not be empty" : nil }
```

![Preview](docs/preview.gif)
