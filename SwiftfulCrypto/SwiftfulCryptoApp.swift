//
//  SwiftfulCryptoApp.swift
//  SwiftfulCrypto
//
//  Created by Ashton Hess on 12/2/21.
//

import SwiftUI

@main
struct SwiftfulCryptoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
