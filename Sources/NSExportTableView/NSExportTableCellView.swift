//
//  NSExportTableCellView.swift
//  
//
//  Created by Bo Gustafsson on 2022-05-19.
//

import Cocoa

open class NSExportTableCellView: NSTableCellView {
    public var textRepresentation : String? {
        get
        {
            return textField?.cell?.title
        }
    }
    public var backgroundColor : NSColor? {
        get {
            return textField?.backgroundColor
        }
    }
    public var textColor : NSColor? {
        get {
            return textField?.textColor
        }
    }
    public var drawsBackground : Bool? {
        get {
            return textField?.drawsBackground
        }
    }
}
