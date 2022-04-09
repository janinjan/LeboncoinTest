//
//  UIColor+Extension.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import UIKit

extension UIColor {

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }

    static var lbcWhite: UIColor {
        return UIColor(named: "lbcWhite") ?? UIColor(rgb: 0xFFFFFF)
    }

    static var lbcBlack: UIColor {
        return UIColor(named: "lbcBlack") ?? UIColor(rgb: 0x000000)
    }

    static var lbcGrey900: UIColor {
        return UIColor(named: "lbcGrey900") ?? UIColor(rgb: 0x1C1C1C)
    }

    static var lbcGrey800: UIColor {
        return UIColor(named: "lbcGrey800") ?? UIColor(rgb: 0x3C3C3C)
    }

    static var lbcGrey700: UIColor {
        return UIColor(named: "lbcGrey700") ?? UIColor(rgb: 0x626262)
    }

    static var lbcGrey600: UIColor {
        return UIColor(named: "lbcGrey600") ?? UIColor(rgb: 0x828282)
    }
    
    static var lbcPaleOrange: UIColor {
        return UIColor(named: "lbcPaleOrange") ?? UIColor(rgb: 0xFA7F2E)
    }

    static var lbcOrange: UIColor {
        return UIColor(named: "lbcOrange") ?? UIColor(rgb: 0xFB6401)
    }
}
