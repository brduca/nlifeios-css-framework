//
//  RegisteredStyles.swift
//  SwiftCSS
//
//  Created by Salvador Mósca on 14/06/2016.
//  Copyright © 2017 NDrive SA. All rights reserved.
//

import Foundation

public class Styles
{
    private static private(set) var all: [RegistrableStyle] = []
    private static var stylesDictionary = Dictionary<String, Dictionary<String,[RegistrableStyle]>>()
    private static var typeMapping = Dictionary<String, ClassMapping>()
    private static var isReady = false
    
    public static func register(array: [RegistrableStyle])
    {
        self.all += array
    }
    
    public static func getCandidateStylesFor(elem: AnyObject, elemName: String?) -> [RegistrableStyle]?
    {
        if !self.isReady { return nil }
        
        let localElemName  = elemName ?? ""
        let myType = "\(type(of: elem))"
        
        if let mappedType = typeMapping[myType]
        {
            return mappedType.isBlacklisted ? nil : (mappedType.cachedStyles![localElemName] ?? mappedType.cachedStyles![""])
        }
        
        let myTypes = myType.components(separatedBy: "_")
        
        var foundType = false
        
        for type in myTypes
        {
            if let value = self.stylesDictionary[type]
            {
                typeMapping[myType] = ClassMapping(isBlacklisted: false, mappedClassName: type, cachedStyles: value)
                foundType = true
                
                return value[localElemName] ?? value[""]
            }
        }
        
        if !foundType
        {
            typeMapping[myType] = ClassMapping(isBlacklisted: true, mappedClassName: nil, cachedStyles: nil)
        }
        
        return nil
    }
    
    public static func build()
    {
        for style in self.all
        {
            if stylesDictionary[style.type].exists
            {
                if !(stylesDictionary[style.type]![style.elemName].exists)
                {
                    stylesDictionary[style.type]![style.elemName] = []
                }
            }
            else
            {
                stylesDictionary[style.type] = [ style.elemName :[]]
            }
        }
        
        for style in self.all
        {
            if !(stylesDictionary[style.type].exists)
            {
                continue // Just in case....
            }
            
            if style.elemName == ""
            {
                for (key, _) in  stylesDictionary[style.type]!
                {
                    stylesDictionary[style.type]![key]!.append(style)
                }
            }
                
            else if stylesDictionary[style.type]![style.elemName].exists
            {
                stylesDictionary[style.type]![style.elemName]!.append(style)
            }
        }
        
        self.isReady = true
    }
}

private struct ClassMapping
{
    var isBlacklisted: Bool
    var mappedClassName: String?
    var cachedStyles: Dictionary<String,[RegistrableStyle]>?
}
