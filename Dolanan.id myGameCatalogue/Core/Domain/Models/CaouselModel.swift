//
//  CaouselModel.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import Foundation

struct CarouselModel {
  let id: Int
  let title: String
  let image: String
}

var dataCarousels: [CarouselModel] = [
  CarouselModel(id: 41494, title: "Cyberpunk 2077", image: "carousel"),
  CarouselModel(id: 10061, title: "Watch Dogs 2", image: "carousel4"),
  CarouselModel(id: 2828, title: "Naruto Ultimate Ninja Storm 4", image: "carousel3"),
  CarouselModel(id: 452645, title: "Hitman 3", image: "carousel2"),
  CarouselModel(id: 437059, title: "Assassin's Creed Valhalla", image: "carousel5")
]
