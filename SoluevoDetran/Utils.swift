//
//  Utils.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 15/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import Foundation
import SwiftDate
import UIKit

extension UIViewController {
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}

extension Dictionary {
    var toJsonString: String? {
        let jsonData = try? JSONSerialization.data(withJSONObject: self, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        return jsonString
    }
    
    func merged(with another: [Key: Value]) -> [Key: Value] {
        var result = self
        for entry in another {
            result[entry.key] = entry.value
        }
        return result
    }
}

extension UIFont {
    
    class func avenirLight(_ ofSize: CGFloat? = 15.0) -> UIFont {
        return UIFont(name: "Avenir-Light", size: ofSize!)!
    }
    
    class func avenirRegular(_ ofSize: CGFloat? = 15.0) -> UIFont {
        return UIFont(name: "Avenir-Book", size: ofSize!)!
    }
    
    class func avenirMedium(_ ofSize: CGFloat? = 15.0) -> UIFont {
        return UIFont(name: "Avenir-Medium", size: ofSize!)!
    }
    
    class func avenirBlack(_ ofSize: CGFloat? = 15.0) -> UIFont {
        return UIFont(name: "Avenir-Black", size: ofSize!)!
    }
}

public enum UIColorInputError: Error {
    case missingHashMarkAsPrefix,
    unableToScanHexValue,
    mismatchedHexStringLength
}

// swiftlint:disable cyclomatic_complexity
extension UIColor {
    
    /**
     The shorthand three-digit hexadecimal representation of color.
     #RGB defines to the color #RRGGBB.
     
     - parameter hex3: Three-digit hexadecimal value.
     - parameter alpha: 0.0 - 1.0. The default is 1.0.
     */
    public convenience init(hex3: UInt16, alpha: CGFloat = 1) {
        let divisor = CGFloat(15)
        let red     = CGFloat((hex3 & 0xF00) >> 8) / divisor
        let green   = CGFloat((hex3 & 0x0F0) >> 4) / divisor
        let blue    = CGFloat( hex3 & 0x00F      ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The shorthand four-digit hexadecimal representation of color with alpha.
     #RGBA defines to the color #RRGGBBAA.
     
     - parameter hex4: Four-digit hexadecimal value.
     */
    public convenience init(hex4: UInt16) {
        let divisor = CGFloat(15)
        let red     = CGFloat((hex4 & 0xF000) >> 12) / divisor
        let green   = CGFloat((hex4 & 0x0F00) >>  8) / divisor
        let blue    = CGFloat((hex4 & 0x00F0) >>  4) / divisor
        let alpha   = CGFloat( hex4 & 0x000F       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The six-digit hexadecimal representation of color of the form #RRGGBB.
     
     - parameter hex6: Six-digit hexadecimal value.
     */
    public convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The six-digit hexadecimal representation of color with alpha of the form #RRGGBBAA.
     
     - parameter hex8: Eight-digit hexadecimal value.
     */
    public convenience init(hex8: UInt32) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
        let green   = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
        let blue    = CGFloat((hex8 & 0x0000FF00) >>  8) / divisor
        let alpha   = CGFloat( hex8 & 0x000000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The rgba string representation of color with alpha of the form #RRGGBBAA/#RRGGBB, throws error.
     
     - parameter rgba: String value.
     */
    public convenience init(rgba_throws rgba: String) throws {
        guard rgba.hasPrefix("#") else {
            throw UIColorInputError.missingHashMarkAsPrefix
        }
        
        let hexString: String = String(rgba[String.Index.init(encodedOffset: 1)...])
        var hexValue:  UInt32 = 0
        
        guard Scanner(string: hexString).scanHexInt32(&hexValue) else {
            throw UIColorInputError.unableToScanHexValue
        }
        
        switch (hexString.count) {
        case 3:
            self.init(hex3: UInt16(hexValue))
        case 4:
            self.init(hex4: UInt16(hexValue))
        case 6:
            self.init(hex6: hexValue)
        case 8:
            self.init(hex8: hexValue)
        default:
            throw UIColorInputError.mismatchedHexStringLength
        }
    }
    
    /**
     The rgba string representation of color with alpha of the form #RRGGBBAA/#RRGGBB, fails to default color.
     
     - parameter rgba: String value.
     */
    public convenience init(_ rgba: String, defaultColor: UIColor = UIColor.clear) {
        guard let color = try? UIColor(rgba_throws: rgba) else {
            self.init(cgColor: defaultColor.cgColor)
            return
        }
        self.init(cgColor: color.cgColor)
    }
    
    /**
     Hex string of a UIColor instance.
     
     - parameter includeAlpha: Whether the alpha should be included.
     */
    public func hexString(_ includeAlpha: Bool = true) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        if includeAlpha {
            return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
        } else {
            return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
        }
    }
    
    public class var greenDetran: UIColor {
        return UIColor("#03652A")
    }
    
    public class var grayDetran: UIColor {
        return UIColor("#484747")
    }
    
    public class var lightGrayDetran: UIColor {
        return UIColor("#9B9B9B")
    }
}

public struct ScreenSize {
    
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let maxLenght = max(ScreenSize.width, ScreenSize.height)
    static let minLenght = min(ScreenSize.width, ScreenSize.height)
    static let isLarge: Bool = ScreenSize.width > 320
}

public struct Utils {
    
    static let years = Array(1990...Date().year + 1)
}

extension Array {
    var toStringValues: [String] {
        return self.map{"\($0)"}
    }
}

extension String {
    
    var brazillianISODate: Date {
        guard let date = self.toISODate(region: .brazil)?.date else {
            return Date(timeIntervalSince1970: 1)
        }
        return date
    }
    
    var removeRats: String{
        return self
            .replacingOccurrences(of: "\\\"", with: "\"")
            .replacingOccurrences(of: "}\"", with: "}")
            .replacingOccurrences(of: "\"{", with: "{")
            .replacingOccurrences(of: "}\"}", with: "}}")
    }
    
    func cast(type: Any) -> Any {
        if compareType(varType: type, typeValue: Double.self) { return self.toDouble }
        else if compareType(varType: type, typeValue: Int.self) {
            return self.toInt
        }
        return self
    }
    
    var toInt: Int {
        guard let cast = Int(self) else {return 0}
        return cast
    }
    
    var toDouble: Double {
        guard let cast = Double(self) else {return 0}
        return cast
    }
    
}

extension Region {
    
    static var brazil: Region {
        return Region(calendar: Calendars.gregorian,
                      zone: TimeZone(identifier: "UTC") ?? Zones.current,
                      locale: Locales.portugueseBrazil)
    }
}

extension Date {
    var year: Int {
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        guard let year = Int(format.string(from: self)) else {return 0}
        return year
    }
}

func compareType<T>(varType: Any, typeValue: T) -> Bool {
    return "\(varType)" == "\(type(of: typeValue))"
}
