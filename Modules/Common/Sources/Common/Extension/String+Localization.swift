//
//  File.swift
//  
//
//  Created by Dimas Putro on 10/12/21.
//

import Foundation

extension String {
  func localized(forLanguage language: String = Locale.preferredLanguages.first!.components(separatedBy: "-").first!) -> String {
    guard let path = Bundle.module.path(forResource: language == "en" ? "Base" : language, ofType: "lproj") else {
      let basePath = Bundle.module.path(forResource: "en", ofType: "lproj")!
      return Bundle(path: basePath)!.localizedString(forKey: self, value: "", table: nil)
    }
    return Bundle(path: path)!.localizedString(forKey: self, value: nil, table: nil)
  }
}
