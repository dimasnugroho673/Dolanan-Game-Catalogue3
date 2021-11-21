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
