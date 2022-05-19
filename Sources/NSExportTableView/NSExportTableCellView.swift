//
//  NSExportTableCellView.swift
//  
//
//  Created by Bo Gustafsson on 2022-05-19.
//

import Cocoa

open class NSExportTableCellView: NSTableCellView {
    open var textRepresentation : String? {
        get
        {
            return textField?.cell?.title
        }
    }
    open var backgroundColor : NSColor? {
        get {
            return textField?.backgroundColor
        }
    }
    open var textColor : NSColor? {
        get {
            return textField?.textColor
        }
    }
    open var drawsBackground : Bool? {
        get {
            return textField?.drawsBackground
        }
    }
}
