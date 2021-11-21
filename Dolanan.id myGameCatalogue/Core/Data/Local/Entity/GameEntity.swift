//
//  GameEntity.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import Foundation
import RealmSwift

class GameEntity: Object, Identifiable {
  @objc dynamic var id: Int = 0
  @objc dynamic var name: String = ""
  @objc dynamic var released: String = ""
  @objc dynamic var backgroundImage: String = ""
  @objc dynamic var rating: Float = 0.0
}

