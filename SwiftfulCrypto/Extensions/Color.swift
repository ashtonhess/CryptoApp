//
//  Color.swift
//  SwiftfulCrypto
//
//  Created by Ashton Hess on 12/4/21.
//

import Foundation
import SwiftUI

//extension created to extend Color class.
//Color class already exists in source code, so this is retractive modeling, extending type Color.
//DOCS:
//Extensions add new functionality to an existing class, structure, enumeration, or protocol type. This includes the ability to extend types for which you don’t have access to the original source code (known as retroactive modeling)
extension Color {
    
    static let theme = ColorTheme()
    
}

//These colors are also adaptive to light and dark mode. set in assets.
//Can easily add more colors to this theme.
//Can easily make another color theme and switch between them. Just copy this color theme again and rename, also setting new colors for new themes.

struct ColorTheme{
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
    
}
