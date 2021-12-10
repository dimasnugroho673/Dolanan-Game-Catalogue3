//
//  TopRatingGames.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 21/11/21.
//

import Foundation

struct TopRatingGamesModel: Codable, Identifiable {
  var id = UUID().uuidString
  let title: String?
}

var dataTopRatingGames: [TopRatingGamesModel] = [
  TopRatingGamesModel(title: "Cyberpunk 2077"),
  TopRatingGamesModel(title: "Final Fantasy VII Remake Intergrade"),
  TopRatingGamesModel(title: "Hitman 3"),
  TopRatingGamesModel(title: "Watch Dogs 2"),
  TopRatingGamesModel(title: "Assassin's Creed Valhalla")
]
