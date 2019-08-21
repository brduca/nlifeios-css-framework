//
//  UIViewControllerExtensions.swift
//  SwiftCSSFramework
//
//  Created by Salvador Mósca on 14/07/2016.
//  Copyright © 2017 NDrive SA. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    private struct AssociatedKeys
    {
        static var DescriptiveName = ""
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
    open var StatusBarStyleId: String?
    {
        set
        {
            self.identifier = newValue
        }
        get
        {
            return self.identifier
        }
    }
    
    internal func getIdentifier() -> String?
    {
        var me: UIViewController? = self
        
        while me != nil
        {
            if me!.StatusBarStyleId == "inherit"
            {
                me = me!.parent
                continue
            }
            
            return me!.StatusBarStyleId
        }
        
        return nil
    }
}
