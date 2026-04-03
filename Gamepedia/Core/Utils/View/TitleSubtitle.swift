//
//  TitleSubtitle.swift
//  Gamepedia
//
//  Created by User on 04/01/26.
//

import Foundation
import SwiftUI

struct TitleSubtitle: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.gameTitle)
                .bold()
                .foregroundColor(.yellow)
            Text(subtitle)
                .font(.gameSubtitle)
                .foregroundColor(.gray)
        }
    }
}
