//
//  LatexUtils.swift
//  
//
//  Created by Bo Gustafsson on 2022-05-19.
//

import Foundation

struct LatexUtils {
    static func removingWhitespaces(_ string: String) -> String {
        return string.components(separatedBy: .whitespaces).joined()
    }
    static func trunc(_ string: String, length: Int, trailing: String = "...") -> String {
        return (string.count > length) ? string.prefix(length) + trailing : string
    }
    static func removeUnderstrike(_ string: String) -> String {
        return string.components(separatedBy: "_").joined()
    }
    static func removeSwedish(_ string: String) -> String {
        var temp = string
        temp = temp.replacingOccurrences(of: "å", with: "aa")
        temp = temp.replacingOccurrences(of: "ä", with: "ae")
        temp = temp.replacingOccurrences(of: "ö", with: "oe")
        temp = temp.replacingOccurrences(of: "õ", with: "oe")
        temp = temp.replacingOccurrences(of: "Å", with: "AA")
        temp = temp.replacingOccurrences(of: "Ä", with: "AE")
        temp = temp.replacingOccurrences(of: "Ö", with: "OE")
        temp = temp.replacingOccurrences(of: "Õ", with: "OE")
        return temp
    }
    static func removeDanish(_ string: String) -> String {
        var temp = string
        temp = temp.replacingOccurrences(of: "å", with: "aa")
        temp = temp.replacingOccurrences(of: "æ", with: "ae")
        temp = temp.replacingOccurrences(of: "ø", with: "oe")
        temp = temp.replacingOccurrences(of: "Å", with: "AA")
        temp = temp.replacingOccurrences(of: "Æ", with: "AE")
        temp = temp.replacingOccurrences(of: "Ø", with: "OE")
        return temp
    }
    static func removeGerman(_ string: String) -> String {
        var temp = string
        temp = temp.replacingOccurrences(of: "ü", with: "u")
        temp = temp.replacingOccurrences(of: "Ü", with: "U")
        return temp
    }
    static func swedishToLatex(_ string: String) -> String {
        var temp = string
        temp = temp.replacingOccurrences(of: "å", with: "{\\aa}")
        temp = temp.replacingOccurrences(of: "ä", with: "{\\\"a}")
        temp = temp.replacingOccurrences(of: "ö", with: "{\\\"o}")
        temp = temp.replacingOccurrences(of: "õ", with: "{\\\"o}")
        temp = temp.replacingOccurrences(of: "Å", with: "{\\AA}")
        temp = temp.replacingOccurrences(of: "Ä", with: "{\\\"A}")
        temp = temp.replacingOccurrences(of: "Ö", with: "{\\\"O}")
        temp = temp.replacingOccurrences(of: "Õ", with: "{\\\"O}")
        return temp
    }
    static func danishToLatex(_ string: String) -> String {
        var temp = string
        temp = temp.replacingOccurrences(of: "å", with: "{\\aa}")
        temp = temp.replacingOccurrences(of: "æ", with: "{\\ae}")
        temp = temp.replacingOccurrences(of: "ø", with: "{\\oe}")
        temp = temp.replacingOccurrences(of: "Å", with: "{\\AA}")
        temp = temp.replacingOccurrences(of: "Æ", with: "{\\AE}")
        temp = temp.replacingOccurrences(of: "Ø", with: "{\\OE}")
        return temp
    }
    static func germanToLatex(_ string: String) -> String {
        var temp = string
        temp = temp.replacingOccurrences(of: "ü", with: "{\\\"u}")
        temp = temp.replacingOccurrences(of: "Ü", with: "{\\\"U}")
        return temp
    }
    static func toLatex(_ string: String) -> String {
        var temp = string
        temp = swedishToLatex(temp)
        temp = danishToLatex(temp)
        temp = germanToLatex(temp)
        return temp
    }
}
