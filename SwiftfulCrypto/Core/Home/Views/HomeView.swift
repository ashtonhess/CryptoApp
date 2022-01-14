//
//  HomeView.swift
//  SwiftfulCrypto
//
//  Created by Ashton Hess on 12/4/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    
    
    var body: some View {
        ZStack{
            //background layer
            Color.theme.background
                .ignoresSafeArea()
            //content layer
            VStack{
                //SEE EXTENSIONS BELOW
                //This HStack is the Custom Navigation Header.
                //Circle button, spacer, header text, spacer, circle button
                homeHeader
                
                columnTitles
                
                if !showPortfolio{
                    allCoinsList
                        .transition(.move(edge: .leading))
                    //this transition makes the rows swipe left and right when changing views.
                }
                if showPortfolio{
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                
                
                //This spacer makes the nav header go to the top.
                //Min length spacer can be shrunk to, along the axis or axes of expansion.
                //spacer cannot be shrunk to less than 0 length.
                //will serve max length possible
                Spacer(minLength: 0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
        
    }
}


//this extension is an extension of this very class.
//First, we are moving the HStack for the header to the extension.
//This makes it so we can just use the name homeHeader to refer to this HStack.
//cleans up the body of theis view alot.
extension HomeView{
    private var homeHeader: some View{
        HStack{
            
            //If we are showing portfolio, this button icon is plus. If we are not showing portfolio, this button icon is info.
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: showPortfolio)
                //.none is the animation that applys.
                //value is the value to monitor for changes. If the value changes, this animation applys.
                .background(CircleButtonAnimationView(animate: $showPortfolio))
            
            Spacer()
            Text(showPortfolio ? "Portfolio":"Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none, value: showPortfolio)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                //adding ability for the icon to turn depending on if showPortfolio is true or not
                //if true, angle is 180, else, angle is 0
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                //listener for a tap on the icon
                .onTapGesture{
                    withAnimation(.spring()){
                        //when icon is tapped, showPortfolio toggled.
                        //when showPortfolio toggled, .rotationEffect changes the rotation of icon.
                        showPortfolio.toggle()
                    }
                        
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List{
            //This was for populating one test coin into the view. Now using data from the arrays in HomeViewModel
            //CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingsColumn: false)
            
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
    private var portfolioCoinsList: some View {
        List{
            //This was for populating one test coin into the view. Now using data from the arrays in HomeViewModel
            //CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingsColumn: false)
            
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
    private var columnTitles: some View {
        HStack{
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
