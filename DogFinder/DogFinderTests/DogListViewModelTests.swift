//
//  DogFinderTests.swift
//  DogFinderTests
//
//  Created by José Marques on 14/01/2023.
//

import XCTest
import Combine
@testable import DogFinder

final class DogListViewModelTests: XCTestCase {

    var viewModel: DogListViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = DogListViewModel(repository: MockRepository())
    }

    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }

    func testViewModelGetResponse() throws {
        let dogs = viewModel.response
        XCTAssertTrue(dogs.count == 10)
    }

    func testViewModelNotdDuplicatedData() throws {
        let dogs = viewModel.availableDogs
        XCTAssertTrue(dogs.count == 9)
    }

    func testViewModelSearchFilter() throws {
        let results = viewModel.searchResults
        XCTAssertTrue(results.count == 0)
        viewModel.filterResultsFor("a")
        let results2 = viewModel.searchResults
        XCTAssertTrue(results2.count == 5)
    }

    func testViewModelSort() throws {
        let firstItem = try XCTUnwrap(viewModel.availableDogs.first)
        XCTAssertEqual(firstItem.breedName, "Bichon Frise")
        viewModel.sortListOfdogs()
        let newFirstItem = try XCTUnwrap(viewModel.availableDogs.first)
        XCTAssertEqual(newFirstItem.breedName, "Afghan Hound")
    }
}
