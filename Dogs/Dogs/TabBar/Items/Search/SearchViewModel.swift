//
//  SearchViewModel.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 27/02/22.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
	func searchViewModel(_ viewModel: SearchViewModelProtocol, didUpdate dataSource: [SearchViewCell.Model])
}

protocol SearchViewModelProtocol {
	func searchDogsBy(breed: String)
	
	func getItem(_ index: Int) -> DogItemResponse? 
}

final class SearchViewModel: SearchViewModelProtocol {
	private var dogs: [DogItemResponse] = []
	weak var delegate: SearchViewModelDelegate?
	private let service: SearchService
	
	init(delegate: SearchViewModelDelegate, service: SearchService = SearchService()) {
		self.delegate = delegate
		self.service = service
	}
	
	func searchDogsBy(breed: String) {
		let searchQuery = SearchQuery(searchText: breed)
		service.searchRequest(requestQuery: searchQuery) { [weak self] result in
			switch result {
			case .success(let dogsList):
				self?.displayScreen(with: dogsList)
			case .failure(let error):
				print(error)
			}
		}
	}
	
	private func displayScreen(with responseList: [DogItemResponse]) {
		dogs = responseList
		let presentationArray = responseList.map { item -> SearchViewCell.Model? in
			if let name = item.name {
				return SearchViewCell.Model(breedName: name,
											breedGroup: item.breedGroup ?? "Not available",
											origin: item.origin ?? "Not available")
			}
			
			return nil
		}
		
		DispatchQueue.main.async {
			self.delegate?.searchViewModel(self,
										   didUpdate: presentationArray.compactMap { $0 })  
		}
	}
	
	func getItem(_ index: Int) -> DogItemResponse? {
		guard dogs.count > index else { return nil }
			return dogs[index]
	}
}
