//
//  Logger.swift
//  SwiftCSS
//
//  Created by Salvador Mósca on 13/06/2016.
//  Copyright © 2017 NDrive SA. All rights reserved.
//

import Foundation

func log(text: String)
{
    if SwiftCSSFrameworkSettings.enableTrace
    {
        print(text)
    }
}

public class SwiftCSSFrameworkSettings
{
    public static var enableTrace: Bool  = true
    
    public static var version: String { get
    {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        let build = dictionary["CFBundleVersion"] as! String
        return "SwiftCSSFramework version: \(version) build: \(build)"
    }}
}

public enum SwiftCSSErrors: Error
{
    case MissingDefault(String)
    case NoStyleRegistered(String)
    case Swizzling(String)
}
