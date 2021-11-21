//
//  FavoriteGameCard.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 21/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteGameCard: View {

  var game: GameModel

  var body: some View {
    VStack(alignment: .leading) {
      VStack(alignment: .leading) {
        WebImage(url: URL(string: game.backgroundImage ?? ""))
          .resizable()
          .renderingMode(.original)
          .aspectRatio(contentMode: .fill)
          .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 200)
          .clipped()
          .cornerRadius(5)

        VStack(alignment: .leading, spacing: 5) {
          Text(game.name ?? "")
            .foregroundColor(.primary)
            .font(.headline)
            .frame(maxWidth: 220, maxHeight: 20, alignment: .leading)

          HStack(spacing: 3) {
            ForEach(1...5, id: \.self) { index in
              Image(systemName: index > Int(round(Double(game.rating ?? 0.0))) ? "star" : "star.fill")
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
    }
  }
}

//struct FavoriteGameCard_Previews: PreviewProvider {
//  static var previews: some View {
//    FavoriteGameCard()
//  }
//}
