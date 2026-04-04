//
//  HeaderOverlay.swift
//  Gamepedia
//
//  Created by User on 10/01/26.
//


import Games
import SwiftUI
struct HeaderOverlay: View {
    var game: Games.DetailGameDomainModel?

    var gradient: LinearGradient {
        .linearGradient(Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]), startPoint: .bottom, endPoint: .center)
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
          gradient
          VStack(alignment: .leading) {
            HStack{
              Text(game?.name ?? "Unknown Name")
                .foregroundColor(.white)
                .shadow(color: .black, radius: 5)

              Spacer()

              Label("", systemImage: "star.fill")
                .labelStyle(.iconOnly)
                .foregroundColor(.yellow)

              Text("\(game?.rating ?? 0.0, specifier: "%.2f")")
                .foregroundColor(.white)

                .fontWeight(.bold)
                .shadow(color: .black, radius: 5)
            }

            HStack{
              VStack(alignment: .leading){
                Text("Added to")
                  .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
                  .font(.caption)
                HStack{
                  Text("Wishlist")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                    .lineLimit(1)

                  Text("\(game?.added ?? 0)")
                    .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
                    .fontWeight(.bold)
                    .font(.system(size: 12))
                }

              }
              .padding(.horizontal, 10)
              .padding(.vertical, 10)
              .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(.white, lineWidth: 3))
              .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

              VStack(alignment: .leading){
                Text("Achievements")
                  .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
                  .font(.caption)
                HStack{
                  Text("\(game?.achievementsCount ?? 0)")
                    .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
                    .fontWeight(.bold)
                    .font(.system(size: 12))

                  Text("Achievements")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                    .lineLimit(1)
                }

              }
              .padding(.horizontal, 10)
              .padding(.vertical, 10)
              .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(.white, lineWidth: 3))
              .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

              VStack(alignment: .leading){
                Text("Rating")
                  .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
                  .font(.caption)
                HStack{
                  Text("\(game?.ratingsCount ?? 0)")
                    .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
                    .fontWeight(.bold)
                    .font(.system(size: 12))

                  Text("Rating")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                    .lineLimit(1)
                }

              }
              .padding(.horizontal, 10)
              .padding(.vertical, 10)
              .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(.white, lineWidth: 3))
              .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

              Spacer()
            }

          }
          .padding()
        }
      }
    }

