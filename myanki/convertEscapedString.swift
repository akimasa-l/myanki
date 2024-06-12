//
//  convertEscapedString.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/12.
//

import Foundation

func convertEscapedString(_ string: String) -> String {
    var newString = string
    let escapeSequences = [
        "\\n": "\n",
        "\\t": "\t",
        "\\r": "\r",
        "\\\\": "\\",
        "\\\"": "\"",
        "\\'": "'"
    ]
    
    for (escaped, unescaped) in escapeSequences {
        newString = newString.replacingOccurrences(of: escaped, with: unescaped)
    }
    
    return newString
}
