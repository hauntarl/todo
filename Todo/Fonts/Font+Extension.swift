//
//  Font+Extension.swift
//  Todo
//
//  Created by Sameer Mungole on 4/23/24.
//

import SwiftUI

extension Font {
    static func load(name: String, withExtension: String) {
        guard
            let url = Bundle.main.url(forResource: name, withExtension: withExtension),
            let dataProvider = CGDataProvider(url: url as CFURL),
            let font = CGFont(dataProvider)
        else {
            assertionFailure("Error loading Font: \(name).\(withExtension).")
            return
        }
        
        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            print("Error loading Font: \(name).\(withExtension).")
        }
    }
    
    static var interLargeTitle: Self {
        .inter(size: 30)
    }
    
    static var interTitle: Self {
        .inter(size: 20)
    }
    
    static var interTitle2: Self {
        .inter(size: 18)
    }
    
    static var interBody: Self {
        .inter(size: 16)
    }
    
    static var interMediumBody: Self {
        .interMedium(size: 16)
    }
    
    static var interCaption: Self {
        .inter(size: 14)
    }
    
    static func inter(size: CGFloat) -> Self {
        .custom("Inter-Regular", size: size)
    }
    
    static func interMedium(size: CGFloat) -> Self {
        .custom("Inter-Medium", size: size)
    }
}
