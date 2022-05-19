//
//  CellColoring.swift
//  NSExportTableView
//
//  Created by Bo Gustafsson on 2022-05-19.
//  Copyright © 2022 Bo Gustafsson. All rights reserved.
//

import Cocoa

struct CellColoring {
    var textColor = NSColor.textColor
    var backgroundColor = NSColor.textBackgroundColor
    var drawBackground = true
    static let DefaultHighlight = CellColoring(textColor: .black, backgroundColor: .yellow, drawBackground: true)
    static let DefaultError = CellColoring(textColor: .black, backgroundColor: .red, drawBackground: true)
    static let DefaultWarning = CellColoring(textColor: .black, backgroundColor: .orange, drawBackground: true)
    func latexColoredCellEntry(cellText: String) -> String {
        var outString = ""
        var closing = ""
        if self.drawBackground {
            switch self.backgroundColor.latexColor {
            case .white, .none , .transparent:
                break
            default:
                outString += "\\colorbox{\(self.backgroundColor.latexColor.rawValue)}{"
                closing += "}"
            }
        }
        switch self.textColor.latexColor {
        case .black, .none, .transparent:
            break
        default:
            outString += "\\color{\(self.textColor.latexColor.rawValue)}{"
            closing += "}"
        }
        return outString + cellText + closing
    }

}
