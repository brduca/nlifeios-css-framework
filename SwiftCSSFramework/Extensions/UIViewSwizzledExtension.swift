//
//  UIViewSwizzledExtension.swift
//  SwiftCSS
//
//  Created by Salvador Mósca on 07/06/2016.
//  Copyright © 2017 NDrive SA. All rights reserved.
//
// Reference from NSHipster: http://nshipster.com/swift-objc-runtime/

import Foundation
import UIKit

extension UIView
{
    class func performSwizzling() throws
    {
        // Move to window methods
        let originalMoveToWindowsSelector = #selector(UIView.willMove(toWindow:))
        let swizzledMoveToWindowsSelector = #selector(UIView.nsh_willMove(toWindow:))
        
        guard let originalMoveToWindowsMethod = class_getInstanceMethod(self, originalMoveToWindowsSelector),
            let swizzledMoveToWindowsMethod = class_getInstanceMethod(self, swizzledMoveToWindowsSelector) else {
                throw SwiftCSSErrors.Swizzling("Cannot access instance methods for move to window selectors")
        }
        
        // Move to superview methods
        let originalMoveToSuperviewSelector = #selector(UIView.willMove(toSuperview:))
        let swizzledMoveToSuperviewSelector = #selector(UIView.nsh_willMove(toSuperview:))
        
        guard let originalMoveToSuperviewMethod = class_getInstanceMethod(self, originalMoveToSuperviewSelector),
            let swizzledMoveToSuperviewMethod = class_getInstanceMethod(self, swizzledMoveToSuperviewSelector) else {
                throw SwiftCSSErrors.Swizzling("Cannot access instance methods for move to superview selectors")
        }
        
        let didAddMoveToWindowsMethod = class_addMethod(self, originalMoveToWindowsSelector, method_getImplementation(swizzledMoveToWindowsMethod), method_getTypeEncoding(swizzledMoveToWindowsMethod))
        
        let didAddMoveToSuperviewMethod = class_addMethod(self, originalMoveToSuperviewSelector, method_getImplementation(swizzledMoveToSuperviewMethod), method_getTypeEncoding(swizzledMoveToSuperviewMethod))
        
        
        if didAddMoveToWindowsMethod && didAddMoveToSuperviewMethod
        {
            class_replaceMethod(self, swizzledMoveToWindowsSelector, method_getImplementation(originalMoveToWindowsMethod), method_getTypeEncoding(originalMoveToWindowsMethod))
            
            class_replaceMethod(self, swizzledMoveToSuperviewSelector, method_getImplementation(originalMoveToSuperviewMethod), method_getTypeEncoding(originalMoveToSuperviewMethod))
            
            return
        }
        
        method_exchangeImplementations(originalMoveToWindowsMethod, swizzledMoveToWindowsMethod)
        method_exchangeImplementations(originalMoveToSuperviewMethod, swizzledMoveToSuperviewMethod)
    }
    
    //MARK: - Method Swizzling
    @objc func nsh_willMove(toWindow: UIWindow?)
    {
        if(!toWindow.exists)
        {
            self.hasAppliedStyles = false
            return
        }
        
        self.resolveStyle(injectedSuperview: self.superview)
    }
    
    @objc func nsh_willMove(toSuperview: UIView?)
    {
        if(!toSuperview.exists)
        {
            self.hasAppliedStyles = false
        }
        
        self.resolveStyle(injectedSuperview: toSuperview)
    }
}
