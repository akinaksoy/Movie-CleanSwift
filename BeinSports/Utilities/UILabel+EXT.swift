//
//  UILabel+EXT.swift
//  BeinSports
//
//  Created by Akın Aksoy on 29.03.2023.
//

import Foundation

import UIKit

extension UILabel {

    convenience init(text: String?,
                     fontSize: CGFloat,
                     fontColor: UIColor,
                     fontTypes: Constants.fontTypes) {
        self.init()
        self.font = UIFont().setUIFont(fontTypes, fontSize: fontSize)
        self.text = text ?? ""
        self.textColor = .white
        self.numberOfLines = 0
        self.textAlignment = .center
    }

}

extension UIFont {
    func setUIFont(_ type: Constants.fontTypes, fontSize: CGFloat) -> UIFont {
        switch type {
        case .bold :
            return .boldSystemFont(ofSize: fontSize)
        case .italic :
            return .italicSystemFont(ofSize: fontSize)
        default :
            return .systemFont(ofSize: fontSize)
        }
    }
}
