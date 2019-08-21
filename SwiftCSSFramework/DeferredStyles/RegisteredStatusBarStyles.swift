//
//  RegisteredStatusBarStyles.swift
//  SwiftCSSFramework
//
//  Created by Salvador Mósca on 14/07/2016.
//  Copyright © 2017 NDrive SA. All rights reserved.
//

import Foundation

public class StatusBarStyles
{
    private static var dict: Dictionary<String, () -> StatusBarStyle> = [:]
    private static var defaultStyle: (() -> StatusBarStyle)!
    
    public static func register(dict: Dictionary<String, () -> StatusBarStyle>) throws
    {
        self.dict = dict
        
        guard let _defaultStyle = self.dict["default"] else
        {
            throw SwiftCSSErrors.MissingDefault("One style must be registered as default")
        }
        
        self.defaultStyle = _defaultStyle
    }
    
    static func get(identifier: String?) -> StatusBarStyle
    {
        // Empty identifier or key not found returns the default 
        guard identifier.exists && self.dict[identifier!].exists else { return self.defaultStyle() }
        
        return  self.dict[identifier!]!()
    }
}
