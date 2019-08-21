//
//  OptionalExtensions.swift
//  SwiftCSS
//
//  Created by Salvador Mósca on 09/06/2016.
//  Copyright © 2017 NDrive SA. All rights reserved.
//

import Foundation
import UIKit

extension Optional
{
    var exists:Bool { get { return self != nil }}
}
