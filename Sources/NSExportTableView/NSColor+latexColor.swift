//
//  NSColor+latexColor.swift
//  
//
//  Created by Bo Gustafsson on 2022-05-19.
//

import Cocoa


extension NSColor {
    var latexColor : LatexColor {
        get {
            switch self {
            case NSColor.textColor, NSColor.black:
                return .black
            case NSColor.textBackgroundColor:
                return .transparent
            case NSColor.yellow:
                return .yellow
            case NSColor.red:
                return .red
            case NSColor.orange:
                return .orange
            case NSColor.green:
                return .green
            case NSColor.white:
                return .white
            case NSColor.blue:
                return .blue
            default:
                return .none
            }
        }
    }
}

