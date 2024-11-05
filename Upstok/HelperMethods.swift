//
//  HelperMethods.swift
//  Upstok
//
//  Created by Venkatesh Pillay on 04/11/24.
//

import Foundation
import UIKit

class HelperMethods {
    static func getAmountValueText(value: Double) -> String {
        var valueText = value < 0 ? "-" : ""
        valueText += "\(StringConstants.rupee)\(String(format: "%.2f", abs(value)))"
        return valueText
    }
    
    static func getDescriptionText(text: String) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    
    static func getNormalFontText(text: String) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.black])
    }
    
    static func getAmountValueFormattedText(value: Double) -> NSMutableAttributedString {
        var valueText: String = value < 0 ? "-" : ""
        valueText += "\(StringConstants.rupee)\(String(format: "%.2f", abs(value)))"
        let textColor: UIColor = value < 0 ? UIColor.red : UIColor.systemGreen
        return NSMutableAttributedString(string: valueText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: textColor])
    }
}
