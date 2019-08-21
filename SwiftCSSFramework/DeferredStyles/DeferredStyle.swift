//
//  DeferredStyle.swift
//  SwiftCSS
//
//  Created by Salvador Mósca on 06/06/2016.
//  Copyright © 2017 NDrive SA. All rights reserved.
//

import Foundation
import UIKit

public class DeferredStyle<T: Brandable>: RegistrableStyle
{
    @objc public var elemName: String
    @objc public var parents : [String]
    @objc public var type: String
    @objc public var styleId: Int
    private var style: (T) -> Void
    
    init(elemName : String? = nil, parents: [String]? = nil,  style: @escaping (T) -> Void)
    {
        self.elemName = elemName ?? ""
        self.parents = parents ?? []
        self.type = "\(T.self)"
        self.style = style
        self.styleId = 0
    }
    
    @objc public func process(elem: AnyObject)
    {
        guard let b = elem as? T else { return }
        self.style(b)
    }
}

public class StatusBarStyle
{
    public var style: UIStatusBarStyle
    public var hide: Bool
    
    public init(style: UIStatusBarStyle, hide: Bool)
    {
        self.style = style
        self.hide = hide
    }
}
