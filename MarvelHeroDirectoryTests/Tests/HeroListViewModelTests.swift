//
//  HeroListViewModelTests.swift
//  MarvelHeroDirectoryTests
//
//  Created by Daniel Medina Sada on 10/4/21.
//

import XCTest
@testable import MarvelHeroDirectory

class HeroListViewModelTests: XCTestCase {
    var viewModel: HeroListViewModel!
    let webService = MockServiceHandler()
    override func setUp() {
        super.setUp()
        
        viewModel = HeroListViewModel(webservice: webService)
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    func testGetHeroListSuccess() {
        viewModel.getHeroList(text: nil, page: 0, completionHandler: { error in
            XCTAssertNil(error)
        })
    }
    
    func testGetHeroListDecodingError() {
        let errorTest = ServiceError.decodingData
        webService.sendResponseError = errorTest
        viewModel.getHeroList(text: nil, page: 0, completionHandler: { error in
            XCTAssertEqual(error, errorTest)
        })
    }
    
    func testGetHeroListNoDataError() {
        let errorTest = ServiceError.noData
        webService.sendResponseError = errorTest
        viewModel.getHeroList(text: nil, page: 0, completionHandler: { error in
            XCTAssertEqual(error, errorTest)
        })
    }
    
    func testGetHeroListRequestError() {
        let errorTest = ServiceError.requestError
        webService.sendResponseError = errorTest
        viewModel.getHeroList(text: nil, page: 0, completionHandler: { error in
            XCTAssertEqual(error, errorTest)
        })
    }
    func testGetHeroListSearchUnavailableError() {
        let errorTest = ServiceError.searchUnavailable
        webService.sendResponseError = errorTest
        viewModel.getHeroList(text: nil, page: 0, completionHandler: { error in
            XCTAssertEqual(error, errorTest)
        })
    }
    
    func testGetHeroListURLMalformationError() {
        let errorTest = ServiceError.urlMalformation
        webService.sendResponseError = errorTest
        viewModel.getHeroList(text: nil, page: 0, completionHandler: { error in
            XCTAssertEqual(error, errorTest)
        })
    }
}
