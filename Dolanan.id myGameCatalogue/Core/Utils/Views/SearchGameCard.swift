//
//  SearchGameCard.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 21/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchGameCard: View {

  var game: GameModel

  var body: some View {
    VStack(alignment: .leading, spacing: 15) {
      WebImage(url: URL(string: game.backgroundImage ?? ""))
        .resizable()
        .renderingMode(.original)
        .aspectRatio(contentMode: .fill)
        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 200)
        .cornerRadius(5)

      HStack {
        VStack(alignment: .leading, spacing: 5) {
          Text(game.name ?? "")
            .foregroundColor(.primary)
            .font(.headline)
            .frame(maxHeight: 20)

//          Text(game.genres
//                .map {
//            $0.name
//          }
//                .joined(separator: ", "))
//            .foregroundColor(.gray)
//            .font(.footnote)

          HStack(spacing: 3) {
            ForEach(1...5, id: \.self) { index in
              Image(systemName: index > Int(round(game.rating ?? 0.0)) ? "star" : "star.fill")
                .resizable()
                .foregroundColor(Color.gray)
                .frame(width: 12, height: 12)
            }

            HStack {
              Text(game.released?.formatterDate(dateInString: game.released ?? "", inFormat: "yyy-MM-dd", toFormat: "dd MMM yyyy") ?? "")
                .font(.caption)
                .foregroundColor(.gray)
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
          }
        }
      }
    }
  }
}

//struct SearchGameCard_Previews: PreviewProvider {
//  static var previews: some View {
//    SearchGameCard()
//  }
//}
