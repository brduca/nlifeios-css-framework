//
//  SwiftCSSFramework.swift
//  SwiftCSSFramework
//
//  Created by Vitor Magalhães on 09/08/2017.
//  Copyright © 2017 Salvador Mósca. All rights reserved.
//

import Foundation

@objc public class SwiftCSSFramework: NSObject {
    
    @discardableResult
    override init() { }
    
    public static func enable() {
        _ = swizzle
    }
    
    static private let swizzle: Void =
    {
        do {
            try UIView.performSwizzling()
            try UIViewController.performSwizzling()
        } catch {
            fatalError("SwiftCSSFramework swizzling has failed!")
        }
    }()
}
