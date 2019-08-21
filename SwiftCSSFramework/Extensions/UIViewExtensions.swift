//
//  UIViewExtensions.swift
//  SwiftCSS
//
//  Created by Salvador Mósca on 09/06/2016.
//  Copyright © 2017 NDrive SA. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    private struct AssociatedKeys
    {
        static var DescriptiveName = ""
        static var AppliedStyles: Bool = false
        static var ForceApply: Bool = false
        static var MyParent: UIView? = nil
    }
    
    public var hasAppliedStyles: Bool
        {
        get
        {
            return (objc_getAssociatedObject(self, &AssociatedKeys.AppliedStyles) as? Bool) ?? false
        }
        
        set
        {
            objc_setAssociatedObject(self, &AssociatedKeys.AppliedStyles, newValue as Bool, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var childOf: UIView?
        {
        get
        {
            return self.superview ?? objc_getAssociatedObject(self, &AssociatedKeys.MyParent) as? UIView
        }
        
        set
        {
            objc_setAssociatedObject(self, &AssociatedKeys.MyParent, newValue as UIView?, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    private var identifier: String?
        {
        get
        {
            return objc_getAssociatedObject(self, &AssociatedKeys.DescriptiveName) as? String
        }
        
        set
        {
            if let newValue = newValue
            {
                objc_setAssociatedObject(self, &AssociatedKeys.DescriptiveName, newValue as NSString?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    @IBInspectable
    public var CSS: String?
        {
        set
        {
            if self.identifier != newValue
            {
                self.hasAppliedStyles = false
            }
            
            self.identifier = newValue
            self.resolveStyle(injectedSuperview: self.superview)
        }
        
        get { return self.identifier }
    }
    
    func getIdentifier() -> String?
    {
        return self.identifier
    }
    
    public func resolveStyle(injectedSuperview: UIView? = nil)
    {
        self.childOf = injectedSuperview
        
        guard !self.hasAppliedStyles && injectedSuperview.exists else { return }
        
        StyleResolver().resolve(elemName: self.CSS, me: self)
        
        for subView in self.subviews
        {
            subView.hasAppliedStyles = false
            subView.resolveStyle(injectedSuperview: self)
        }
        
        self.hasAppliedStyles = true
    }
    
    func matchesViewStack(parents: [String]) -> Bool
    {
        // No parents, if matches type style must be applied
        if parents.count == 0
        {
            return true
        }
        
        var context: UIView? = self.childOf
        
        var index = parents.count - 1
        
        while context != nil
        {
            if (context!.CSS.exists && parents[index] == context!.CSS!) {
                index -= 1
            }
            
            guard index >= 0 else { return true }
            
            context = context!.childOf ?? nil
        }
        
        return false
    }
}
