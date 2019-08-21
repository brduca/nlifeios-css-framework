# Publish new tags

Update the podspec accordingly with the new version reference.

```
git commit ...
git tag <new_version>
git push --tags
```

# Add private repo and publish the new podspec
```
pod repo add cocoapods https://gitlab.ndrive.com/nlife/cocoapods
pod repo push cocoapods SwiftCSSFramework.podspec
```

[![Build Status](https://jenkins.ndrive.com/buildStatus/icon?job=ios-swift-css-framework)](https://jenkins.ndrive.com/view/iOS/job/ios-swift-css-framework/)

## CocoaPods install

Add source to your podfile

```
source 'git@gitlab.ndrive.com:nlife/cocoapods.git'
```

Remember to add
```
use_frameworks! 
```

Then reference the pod
```
pod 'SwiftCSSFramework'
```

## Usage

In order to stylize UIView elements you must create an array of stylizable elements.
Ex:  Stylizing all UILabels 

```swift
class Global
{
    static let style : [RegistrableStyle] =
    [
        // Applies to all UILabels
        Stylize<UILabel>.all()
        {(elem: UILabel) in
            
            elem.textColor = UIColor.grayColor()
            
        },
        
        // Applies to all UILabels having the CSS property set on storyboard (or programmatically)
        Stylize<UILabel>.elem("MyLabel")
        {(elem: UILabel) in
                
            elem.textColor = UIColor.blueColor()
                
        },
        
        // Applies to all labels nested in ViewController
        Stylize<UILabel>.nestedIn([ViewController.self])
        {(elem: UILabel) in
                
                elem.textColor = UIColor.redColor()
                
        },
        
        // Applies to all labels with the CSS property ´MyLabel´nested in ViewController
        Stylize<UILabel>.elem("MyLabel", childOf: [ViewController.self])
        {(elem: UILabel) in
                
            elem.textColor = UIColor.cyanColor()
                
        }
        
    ]
}

// NOTE:
// Having this array static will prevent having to identify the items
// so removing this registered styles relies on a more simple implementation
```

This array of styles must be registered following the priority (the last setted property will prevail)

```swift
Styles.register(Global.style)
```

In order to change styles is also possible to unregister styles

```swift
Styles.unregister(Global.style)
```

It's possible to force styles to be applied.
By default the style is applied by Swizzling the UIView.willMoveToWindow(_:) in runtime.

**Therefore using  UIView.willMoveToWindow(_:) will be void when using Swift CSS Framework**

```swift
// The rest of the code was suppressed
import SwiftCSSFramework

class ViewController: UIViewController
{
    @IBOutlet weak var myLabelOutlet: UILabel!
    
    func dummyReload()
    {
        // CSS properties can be set/overridden in runtime
        myLabelOutlet.CSS = "myStyle"
        
        // It is also possible to force styles to be applied
        myLabelOutlet.resolveStyle()
    }
}
```
