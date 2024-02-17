# Modal

`Modal` is a Swift class that provides a modal view to display terms and conditions using a `WKWebView`. It includes a dismiss button, a loading indicator, and smooth appearance/dismissal animations.

## Usage

To use `TermsConditionModal` in your project, follow these steps:

1. **Integration:**
   - Add the `CustomModal.swift` file to your Xcode project.

2. **Initialization:**
   - Create an instance of `CustomModal` and set the `webViewURL` property to the URL of your terms and conditions web page.
   let termsModal = CustomModal()
   termsModal.webViewURL = "https://example.com/terms"

Presentation:
To display the modal, call the show(in:) method, passing the parent view controller.
termsModal.show(in: self)

Dismissal:
The modal can be dismissed programmatically using the dismiss() method.
termsModal.dismiss()
Example

// Import the module
import UIKit

// Create an instance of TermsConditionModal
let termsModal = TermsConditionModal()

// Set the URL for the terms and conditions
termsModal.webViewURL = "https://example.com/terms"

// Show the modal in the current view controller
termsModal.show(in: self)
Customization

You can customize the appearance of the modal by modifying the properties and layout constraints within the TermsConditionModal class.
Dependencies

This class relies on UIKit and WebKit frameworks.
