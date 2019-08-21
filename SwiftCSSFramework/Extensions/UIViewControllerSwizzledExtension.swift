//
//  UIViewControllerSwizzledExtension.swift
//  SwiftCSSFramework
//
//  Created by Salvador Mósca on 14/07/2016.
//  Copyright © 2017 NDrive SA. All rights reserved.
//


import Foundation
import UIKit

extension UIViewController
{
    class func performSwizzling() throws
    {
        // Status bar hidden
        let originalPrefersStatusBarHiddenSelector = #selector(getter: prefersStatusBarHidden)
        let swizzledPrefersStatusBarHiddenSelector = #selector(nsh_prefersStatusBarHidden)
        
        guard let originalPrefersStatusBarHiddenMethod = class_getInstanceMethod(self, originalPrefersStatusBarHiddenSelector),
            let swizzledPrefersStatusBarHiddenMethod = class_getInstanceMethod(self, swizzledPrefersStatusBarHiddenSelector) else {
                throw SwiftCSSErrors.Swizzling("Cannot access status bar hidden instance methods")
        }
        
        let didAddPrefersStatusBarHiddenMethod = class_addMethod(self, originalPrefersStatusBarHiddenSelector, method_getImplementation(swizzledPrefersStatusBarHiddenMethod), method_getTypeEncoding(swizzledPrefersStatusBarHiddenMethod))
        
        // Status bar style
        let originalPreferredStatusBarStyleSelector = #selector(getter: preferredStatusBarStyle)
        let swizzledPreferredStatusBarStyleSelector = #selector(nsh_preferredStatusBarStyle)
        
        guard let originalPreferredStatusBarStyleMethod = class_getInstanceMethod(self, originalPreferredStatusBarStyleSelector),
            let swizzledPreferredStatusBarStyleMethod = class_getInstanceMethod(self, swizzledPreferredStatusBarStyleSelector) else {
                throw SwiftCSSErrors.Swizzling("Cannot access status bar style instance methods")
        }
        
        let didAddPreferredStatusBarStyleMethod = class_addMethod(self, originalPreferredStatusBarStyleSelector, method_getImplementation(swizzledPreferredStatusBarStyleMethod), method_getTypeEncoding(swizzledPreferredStatusBarStyleMethod))
        
        if didAddPrefersStatusBarHiddenMethod && didAddPreferredStatusBarStyleMethod
        {
            class_replaceMethod(self, swizzledPrefersStatusBarHiddenSelector, method_getImplementation(originalPrefersStatusBarHiddenMethod), method_getTypeEncoding(originalPrefersStatusBarHiddenMethod))
            
            class_replaceMethod(self, swizzledPreferredStatusBarStyleSelector, method_getImplementation(originalPreferredStatusBarStyleMethod), method_getTypeEncoding(originalPreferredStatusBarStyleMethod))
            return
        }
        
        method_exchangeImplementations(originalPrefersStatusBarHiddenMethod, swizzledPrefersStatusBarHiddenMethod)
        method_exchangeImplementations(originalPreferredStatusBarStyleMethod, swizzledPreferredStatusBarStyleMethod)
    }

    @objc func nsh_preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return StyleResolver().statusBarStyle(me: self)
    }
    
    @objc func nsh_prefersStatusBarHidden() -> Bool
    {
        guard UIApplication.shared.statusBarOrientation.isPortrait else { return true }
        return StyleResolver().hideStatusBar(me: self)
    }
}
