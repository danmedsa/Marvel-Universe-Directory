//
//  HeroListViewControllerTests.swift
//  MarvelHeroDirectoryTests
//
//  Created by Daniel Medina Sada on 10/4/21.
//

import XCTest

class HeroListViewControllerTests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication(bundleIdentifier: "com.DanielMedinaSada.MarvelHeroDirectory")
        app.launch()
        sleep(10) // wait for response
    }
    
    func testHeroCellDisplaying() throws {
        XCTAssert(app.tables.cells.staticTexts["3-D Man"].exists)
    }
    
    func testHeroDetailsDisplaying() throws {
        app.tables.cells.staticTexts["3-D Man"].tap()
        XCTAssert(app.staticTexts["3-D Man"].exists)
        XCTAssert(app.images["imageView.3-DMan"].exists)
    }
}
