//
//  CircleButtonView.swift
//  SwiftfulCrypto
//
//  Created by Ashton Hess on 12/4/21.
//

import SwiftUI

struct CircleButtonView: View {
    
    //this allows us to pass any string into a CircleButtonView to change the icon.
    let iconName: String
    
    var body: some View {
        
        //systemName is a default apple icon
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
            //have to set frame for icon size.
            .background{
                //placing a circle in the background of the icon image.
                Circle()
                    .foregroundColor(Color.theme.background)
            }
            .shadow(color: Color.theme.accent.opacity(0.25), radius: 10, x: 0, y: 0)
            //making a shadow for the background
            //makes the circle show a little better. Makes around the circle slightly darker.
            .padding()
            //adding padding around the circle background. makes the icon much overall bigger and the slightly darker background area much bigger.
            //this is just padding for the background.
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group{
            CircleButtonView(iconName: "info")
                .previewLayout(.sizeThatFits)
            CircleButtonView(iconName: "plus")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        
    }
    
}
