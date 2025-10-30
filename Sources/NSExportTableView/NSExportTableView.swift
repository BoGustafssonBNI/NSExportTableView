import Cocoa

open class NSExportTableView: NSTableView {

    open var exportTableViewDelegate : NSExportTableViewDelegate?
    
    public func getCSV(delimiter: String = ",") -> String {
        let BOM = "\u{FEFF}"
        var outString = BOM
        if let rows = dataSource?.numberOfRows?(in: self) {
            for column in tableColumns {
                if let exporterColumn = column as? NSExportTableColumn, let export = exporterColumn.export, export {
                    //                    outString += column.identifier.rawValue + delimiter
                    outString += column.headerCell.title + delimiter
                }
            }
            outString.removeLast()
            outString += "\n"
            for row in 0..<rows {
                var writeRow = true
                if let write = exportTableViewDelegate?.tableView(self, writeForRow: row) {
                    writeRow = write
                }
                if writeRow {
                    for column in tableColumns {
                        if let exporterColumn = column as? NSExportTableColumn, let export = exporterColumn.export, export {
                            var skipValue = false
                            if let skip = exportTableViewDelegate?.tableView(self, skipValueFor: column, row: row) {
                                skipValue = skip
                            }
                            if !skipValue {
                            if let cellString = dataSource?.tableView?(self, objectValueFor: column, row: row) as? String {
                                outString += cellString + delimiter
                            } else if let cell = delegate?.tableView?(self, viewFor: column, row: row), let view = cell as? NSExportTableCellView, let cellString = view.textRepresentation {
                                outString += cellString + delimiter
                            } else {
                                outString += delimiter
                            }
                            } else {
                                outString += delimiter

                            }
                        }
                    }
                    outString.removeLast()
                    outString += "\n"
                }
            }
        }
        return outString
    }
    
    open var headerMaxChars = 7
    open var entryMaxChars = 14
    
    public func getLatex(shortTable: Bool, name: String) -> String {
        let delimiter = "&"
        var outdata = String()
        var ncols = 0
        var formatString = ""
        var header = ""
        for column in tableColumns {
            if let exporterColumn = column as? NSExportTableColumn, let export = exporterColumn.export, export {
                ncols += 1
                formatString += "l"
//                header += column.identifier.rawValue.trunc(length: headerMaxChars, trailing: "") + delimiter
                header += column.headerCell.title.components(separatedBy: "_").joined() + delimiter
            }
        }
        header.removeLast()
        if shortTable {
            outdata = "\\begin{table}[h]\n \\caption{" + name + "} \n"
            outdata += "\\footnotesize \n"
            outdata += "\\begin{center}\n"
            outdata += "\\begin{tabular}{" + formatString + "}\n"
            outdata += "\\toprule\n"
            outdata += header + "\\\\ \n"
            outdata += "\\midrule\n"
        } else {
            outdata = "\\begin{center}\n \\footnotesize \n"
            
            outdata += "\\begin{longtable}{" + formatString + "} \n"
            outdata += "\\caption{" + name + "} \\label{" + name + "}\\\\ \n"
            
            outdata += "\\hline\n"
            outdata += header + "\\\\ \n"
            outdata += "\\hline\n"
            outdata += "\\endfirsthead\n"
            
            outdata += "\\multicolumn{" + String(ncols) + "}{c}{{\\bfseries \\tablename\\ \\thetable{} -- continued from previous page}} \\\\ \n"
            outdata += "\\hline\n"
            outdata += header + "\\\\ \n"
            outdata += "\\hline\n"
            outdata += "\\endhead\n"
            
            outdata += "\\hline\n"
            outdata += "\\multicolumn{" + String(ncols) + "}{c}{{continued on next page}} \\\\ \n"
            outdata += "\\hline\n"
            outdata += "\\endfoot\n"
            outdata += "\\hline\n"
            outdata += "\\endlastfoot\n"
        }
        
        if let rows = dataSource?.numberOfRows?(in: self) {
            for row in 0..<rows {
                var writeRow = true
                if let write = exportTableViewDelegate?.tableView(self, writeForRow: row) {
                    writeRow = write
                }
                if writeRow {
                    for column in tableColumns {
                        if let exporterColumn = column as? NSExportTableColumn, let export = exporterColumn.export, export {
                            var skipValue = false
                            if let skip = exportTableViewDelegate?.tableView(self, skipValueFor: column, row: row) {
                                skipValue = skip
                            }
                            if !skipValue {
                                if let cellString = dataSource?.tableView?(self, objectValueFor: column, row: row) as? String {
                                    if let del = delegate {
                                        let cell = NSTextFieldCell()
                                        cell.title = cellString
                                        del.tableView!(self, willDisplayCell: cell, for: column, row: row)
                                        if let background = cell.backgroundColor, let textColor = cell.textColor {
                                            let drawBackground = cell.drawsBackground
                                            let cellColoring = CellColoring(textColor: textColor, backgroundColor: background, drawBackground: drawBackground)
                                            let latexString = LatexUtils.toLatex(cellString)
                                            outdata += cellColoring.latexColoredCellEntry(cellText: LatexUtils.trunc(latexString, length: entryMaxChars)) + delimiter
                                        } else {
                                            let latexString = LatexUtils.toLatex(cellString)
                                            outdata += LatexUtils.trunc(latexString, length: entryMaxChars) + delimiter
                                        }
                                    } else {
                                        let latexString = LatexUtils.toLatex(cellString)
                                        outdata += LatexUtils.trunc(latexString, length: entryMaxChars) + delimiter
                                    }
                                } else if let cell = delegate?.tableView?(self, viewFor: column, row: row), let view = cell as? NSExportTableCellView, let cellString = view.textRepresentation {
                                    if let background = view.backgroundColor, let textColor = view.textColor {
                                        let drawBackground = view.drawsBackground ?? false
                                        let cellColoring = CellColoring(textColor: textColor, backgroundColor: background, drawBackground: drawBackground)
                                        let latexString = LatexUtils.toLatex(cellString)
                                        outdata += cellColoring.latexColoredCellEntry(cellText: LatexUtils.trunc(latexString, length: entryMaxChars)) + delimiter
                                    } else {
                                        let latexString = LatexUtils.toLatex(cellString)
                                        outdata += LatexUtils.trunc(latexString, length: entryMaxChars) + delimiter
                                    }
                                } else {
                                    outdata += delimiter
                                }
                            } else {
                                outdata += delimiter
                            }
                        }
                    }
                    outdata.removeLast()
                    outdata += "\\\\ \n"
                }
            }
        }
        if shortTable {
            outdata += "\\bottomrule\n"
            outdata += "\\end{tabular}\n"
            outdata += "\\end{center}\n"
            outdata += "\\normalsize\n"
            outdata += "\\end{table}\n"
        } else {
            outdata += "\\normalsize\n"
            outdata += "\\end{longtable}\n"
            outdata += "\\end{center}\n"
        }
        return outdata
    }
    

}
