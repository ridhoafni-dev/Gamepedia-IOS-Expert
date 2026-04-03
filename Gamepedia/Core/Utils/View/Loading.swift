//
//  Loading.swift
//  Gamepedia
//
//  Created by User on 09/01/26.
//

import SwiftUI

struct Loading: View {
    var body: some View {
        ZStack {
            ProgressView()
        }
        .frame(
            minWidth: 200,
            maxWidth: .infinity,
            minHeight: 230,
            maxHeight: .infinity,
            alignment: .center
        )
        .background(.black)
    }
}
