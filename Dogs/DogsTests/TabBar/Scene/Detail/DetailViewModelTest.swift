//
//  DetailViewModelTest.swift
//  DogsTests
//
//  Created Paulo Cesar Morandi Massuci on 28/02/22.
//

@testable import Dogs
import XCTest

class DetailViewModelTest: XCTestCase {
	
	func testDetailModelGetVeiwData() {
		let delegateMock = DetailViewModelDelegateMock()
		
		let sut = DetailViewModel(delegate: delegateMock, item: DogItemResponse.fixture(name: "Chiauaua"))
		sut.getViewData()
		
		XCTAssertEqual(delegateMock.item?.urlImage, "url")
		XCTAssertEqual(delegateMock.item?.breedName, "Chiauaua")
		XCTAssertEqual(delegateMock.item?.breedCategory, "breedGroup")
		XCTAssertEqual(delegateMock.item?.origin, "origin")
		XCTAssertEqual(delegateMock.item?.temperament, "temperament")
	}
}

class DetailViewModelDelegateMock: DetailViewModelDelegate {
	var item: DetailView.Model?
	
	func detailViewModel(_ viewModel: DetailViewModelProtocol, didUpdateView item: DetailView.Model) {
		self.item = item
	}
}
