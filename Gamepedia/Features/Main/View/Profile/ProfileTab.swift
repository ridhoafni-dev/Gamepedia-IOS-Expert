//
//  ProfileTab.swift
//  Gamepedia
//
//  Created by User on 10/01/26.
//

import SwiftUI

struct ProfileTab: View {
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                Image("user")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                
                Spacer().frame(height: 14)
                
                Text("Ridho Afni")
                    .foregroundColor(.gray)
                    .font(.headline)
                
                Spacer().frame(height: 14)
                
                Text("ridhoafni.dev@gmail.com")
                    .foregroundColor(.gray)
                    .font(.headline)
                
                Spacer().frame(height: 14)
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .leading
            )
            .padding(EdgeInsets.init(top: 16, leading: 20, bottom: 50, trailing: 20))
        }
        .onAppear{
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}
