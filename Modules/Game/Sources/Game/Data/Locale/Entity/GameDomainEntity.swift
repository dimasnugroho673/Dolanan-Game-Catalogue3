//
//  File.swift
//  
//
//  Created by Dimas Putro on 05/12/21.
//

import Foundation
import RealmSwift

public class GameDomainEntity: Object {

  @objc dynamic var id: Int = 0
  @objc dynamic var name: String = ""
  @objc dynamic var released: String = ""
  @objc dynamic var backgroundImage: String = ""
  @objc dynamic var rating: Float = 0.0
  
}
