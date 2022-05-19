//
//  NSExportTableViewDelegate.swift
//  
//
//  Created by Bo Gustafsson on 2022-05-19.
//

import Cocoa

public protocol NSExportTableViewDelegate {
    func tableView(_ tableView: NSTableView, writeForRow row: Int) -> Bool
    func tableView(_ tableView: NSTableView, skipValueFor column: NSTableColumn, row: Int) -> Bool
}
