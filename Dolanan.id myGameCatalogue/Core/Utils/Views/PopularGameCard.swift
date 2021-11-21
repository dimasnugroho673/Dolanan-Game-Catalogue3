//
//  PopularGameCard.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct PopularGameCard: View {

  var game: GameModel
  var isLastItem: Bool = false

  var body: some View {
    Spacer()
    Spacer()
    VStack(alignment: .leading, spacing: 10) {
      WebImage(url: URL(string: game.backgroundImage ?? ""))
        .resizable()
        .renderingMode(.original)
        .aspectRatio(contentMode: .fill)
        .frame(width: 220, height: 120)
        .clipped()
        .cornerRadius(5)

      VStack(alignment: .leading, spacing: 5) {
        Text(game.name ?? "")
          .foregroundColor(.primary)
          .font(.headline)
          .frame(maxWidth: 220, maxHeight: 20, alignment: .leading)

//        HStack {
//          Text(game.genres ?? nil
//                .map {
//            $0.name ?? ""
//          }
//                .joined(separator: ", "))
//            .foregroundColor(.gray)
//            .font(.subheadline)
//            .frame(maxWidth: 220, maxHeight: 20, alignment: .leading)
//        }

        HStack(spacing: 3) {
          ForEach(1...5, id: \.self) { index in
            Image(systemName: index > Int(round(game.rating ?? 0.0)) ? "star" : "star.fill")
              .resizable()
              .foregroundColor(Color.gray)
              .frame(width: 12, height: 12)
          }

          Text("\(game.rating?.clean ?? "")")
            .font(.caption)
            .foregroundColor(.gray)
            .padding(.leading, 3)
            .padding(.top, 2)

          HStack {
            Text(game.released?.formatterDate(dateInString: game.released ?? "", inFormat: "yyy-MM-dd", toFormat: "dd MMM yyyy") ?? "")
              .font(.caption)
              .foregroundColor(.gray)
          }
          .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)

        }
      }
    }
    if isLastItem {
      Spacer()
      Spacer()
    }
  }
}

//struct PopularGameCard_Previews: PreviewProvider {
//  static var previews: some View {
//    PopularGameCard()
//  }
//}
