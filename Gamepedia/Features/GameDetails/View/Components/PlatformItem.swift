//
//  PlatformItem.swift
//  Gamepedia
//
//  Created by User on 12/01/26.
//


import Games
import SwiftUI
struct PlatformItem: View {
    var releasedAt: String?
    var platform: PlatformDetailsDomainModel?
    @State private var platformImage: String = ""
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(platform?.name ?? "-")
                    .font(.system(size: 18))
                    .foregroundColor(.yellow)

                if releasedAt != nil {
                    Text("Release on \(dateFormat(dateTxt: releasedAt!))")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                    Text("Total game in this platform are \(platform?.gamesCount ?? 0)")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                }
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
            )
        }
    }
}
