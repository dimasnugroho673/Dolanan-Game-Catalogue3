//
//  All.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import Foundation

extension String {
  /// filter string
  var stripped: String {
    let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890.,")
    return self.filter { okayChars.contains($0) }
  }
  
  /// first capital character
  func capitalizingFirstLetter() -> String {
    return prefix(1).capitalized + dropFirst()
  }
  
  mutating func capitalizeFirstLetter() {
    self = self.capitalizingFirstLetter()
  }
  
  /// date formatter
  func formatterDate(dateInString: String, inFormat: String, toFormat format: String) -> String? {
    let inputDateFormatter = DateFormatter()
    inputDateFormatter.dateFormat = inFormat
    
    if let date = inputDateFormatter.date(from: dateInString) {
      let outputDateFormatter = DateFormatter()
      outputDateFormatter.dateFormat = format
      
      return outputDateFormatter.string(from: date)
    }
    return nil
  }
}

extension Float {
  var clean: String {
    return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
  }
}
