//
//  PopularGamesUseCaseTest.swift
//  Dolanan.id myGameCatalogueTests
//
//  Created by Dimas Putro on 24/11/21.
//

import XCTest
import RxSwift
@testable import Dolanan_id_myGameCatalogue

class FavoriteGameUseCaseTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

      let popularGamesModel: [GameModel] = [
        GameModel(id: 1, name: "Game 1", released: "24-11-2021", backgroundImage: "dummy.png", rating: 0.0, genres: [], screenshots: [])
      ]

      let gameModelToEntities = GameMapper.mapGameModelToEntities(input: popularGamesModel[0])
      let gameEntitiesToDomains = GameMapper.mapGameEntitiesToDomains(input: [gameModelToEntities])

      XCTAssertEqual(gameModelToEntities.id, gameEntitiesToDomains[0].id)
      XCTAssertEqual(gameModelToEntities.name, gameEntitiesToDomains[0].name)
      XCTAssertEqual(gameModelToEntities.released, gameEntitiesToDomains[0].released)
      XCTAssertEqual(gameModelToEntities.backgroundImage, gameEntitiesToDomains[0].backgroundImage)
      XCTAssertEqual(gameModelToEntities.rating, gameEntitiesToDomains[0].rating)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
