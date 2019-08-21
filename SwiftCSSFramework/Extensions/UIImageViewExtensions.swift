//
//  UITableViewExtension.swift
//  SwiftCSSFramework
//
//  Created by Salvador Mósca on 27/06/2016.
//  Copyright © 2017 NDrive SA. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView
{
    private struct AssociatedKeys
    {
        static var RenderingMode: Int = 0
    }
    
    @objc public var renderingMode: UIImage.RenderingMode
    {
        get
        {
            let enumValue = (objc_getAssociatedObject(self, &AssociatedKeys.RenderingMode) as? Int) ?? UIImage.RenderingMode.automatic.rawValue
            return UIImage.RenderingMode(rawValue: enumValue)!
        }
        
        set
        {
            objc_setAssociatedObject(self, &AssociatedKeys.RenderingMode, newValue.rawValue , .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
