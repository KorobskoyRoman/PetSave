//
//  AnimalsNearYouViewModelTestCase.swift
//  PetSaveTests
//
//  Created by Roman Korobskoy on 08.01.2023.
//

import XCTest

@testable import PetSave

@MainActor
final class AnimalsNearYouViewModelTestCase: XCTestCase {
    let testContext = PersistenceController.shared.container.viewContext

    var viewModel: AnimalsNearYouViewModel!

    @MainActor
    override func setUp() {
        super.setUp()

        viewModel = AnimalsNearYouViewModel(
            isLoading: true,
            animalFetcher: AnimalsFetcherMock(),
            animalStorage: AnimalStorageService(context: testContext)
        )
    }

    func testFetchAnimalsLoadingState() async {
        XCTAssertTrue(viewModel.isLoading, "View model should be loading, but it isn't")
        await viewModel.fetchAnimals(location: nil)
        XCTAssertFalse(viewModel.isLoading, "View model should'nt be loading, but it is")
    }

    func testUpdatePageOnFetchMoreAnimals() async {
        XCTAssertEqual(viewModel.page, 1, "Page should be 1, but it's \(viewModel.page)")
        await viewModel.fetchMoreAnimals(location: nil)
        XCTAssertEqual(viewModel.page, 2, "Page should be 2, but it's \(viewModel.page)")
    }

    func testFetchAnimalsEmptyResponse() async {
        viewModel = AnimalsNearYouViewModel(
            isLoading: true,
            animalFetcher: EmptyResponseAnimalsFetcherMock(),
            animalStorage: AnimalStorageService(context: testContext)
        )
        await viewModel.fetchAnimals(location: nil)

        XCTAssertFalse(viewModel.hasMoreAnimals, "hasMoreAnimals should be false, but it's true")
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false, but it's true")
    }
}

struct EmptyResponseAnimalsFetcherMock: AnimalsFetcher {
    func fetchAnimals(
        page: Int,
        latitude: Double?,
        longitude: Double?
    ) async -> [Animal] {
        return []
    }
}
