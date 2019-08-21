//
//  StyleResover.swift
//  SwiftCSS
//
//  Created by Salvador Mósca on 07/06/2016.
//  Copyright © 2017 NDrive SA. All rights reserved.
//

import Foundation
import UIKit

class StyleResolver
{
    func resolve(elemName: String?, me: UIView)
    {
        guard let registeredStyles = Styles.getCandidateStylesFor(elem: me, elemName: elemName) else { return }
        
        registeredStyles.forEach({
            
            if me.matchesViewStack(parents: $0.parents)
            {
                $0.process(elem: me)
            }
        })
    }
    
    func  hideStatusBar(me: UIViewController) -> Bool
    {
        return StatusBarStyles.get(identifier: me.getIdentifier()).hide
    }
    
    func statusBarStyle(me: UIViewController) -> UIStatusBarStyle
    {
        return StatusBarStyles.get(identifier: me.getIdentifier()).style
    }
}
