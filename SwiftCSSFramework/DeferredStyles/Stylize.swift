//
//  Stylize.swift
//  SwiftCSS
//
//  Created by Salvador Mósca on 13/06/2016.
//  Copyright © 2017 NDrive SA. All rights reserved.
//

import Foundation

public class Stylize<T:Brandable>
{
    public class func all(_ style: @escaping (T) -> Void) -> DeferredStyle<T>
    {
        return DeferredStyle<T>(elemName: nil, style: style)
    }
    
    public class func nestedIn(_ parents: [String], style: @escaping (T) -> Void) -> DeferredStyle<T>
    {
        return DeferredStyle<T>(parents: parents, style: style)
    }
    
    public class func elem(_ elemName: String, childOf: [String]? = nil, style: @escaping (T) -> Void) -> DeferredStyle<T>
    {
        return DeferredStyle<T>(elemName: elemName, parents: childOf, style: style)
    }
}
