//
//  Protocols.swift
//  SwiftCSS
//
//  Created by Salvador Mósca on 06/06/2016.
//  Copyright © 2017 NDrive SA. All rights reserved.
//

import Foundation

public protocol Brandable { }

extension UIView : Brandable {}

@objc public protocol RegistrableStyle
{
    var elemName: String { get set}
    var parents: [String] { get set}
    var type: String { get set}
    var styleId: Int { get set} // <- Just for checking the apply of the styles
    
    func process(elem: AnyObject)
}
