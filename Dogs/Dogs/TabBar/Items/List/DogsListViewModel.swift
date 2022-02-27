//
//  DogsListViewModel.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 26/02/22.
//

import Foundation

protocol DogsListViewModelProtocol {
	var hasNextPage: Bool { get }
	func getNextPage()
	func getListByOrder(isAscending: Bool)
}

protocol DogsListViewModelDelegate: AnyObject {
	func dogsListViewModel(_ viewModel: DogsListViewModelProtocol, willUpdateDataSource dataSource: [DogCollectionViewCell.Model])
}

final class DogsListViewModel: DogsListViewModelProtocol {
	private let numberOfItemsPerRequest = 20
	private let service: DogsServiceProtocol
	private var isAscending = true
	private weak var delegate: DogsListViewModelDelegate?
	var currentPage = 0
	var numberOFItems: Int?
	var hasNextPage = true
	private var dogs: [DogItemResponse] = []
	
	init(service: DogsServiceProtocol = DogsService(), delegate: DogsListViewModelDelegate) {
		self.service = service
		self.delegate = delegate
	}
	
	func getNextPage() {
		let request = PaginationRequestQuery(limit: numberOfItemsPerRequest,
											 page: currentPage,
											 isAscending: isAscending)
		
		let numberOFPages = (numberOFItems ?? .zero) / numberOfItemsPerRequest
		
		if numberOFItems != nil, currentPage > numberOFPages {
			return
		}
		
		service.breedsRequest(requestHeader: request) { [weak self] response in
			guard let self = self else { return }
			switch response {
			case .success(let paginationItem):
				self.retrieve(data: paginationItem)
			case .failure:
				()
			}
		}
	}
	
	func getListByOrder(isAscending: Bool) {
		numberOFItems = nil
		currentPage = .zero
		self.isAscending = isAscending
		dogs = []
		
		getNextPage()
	}
	
	private func retrieve(data: PaginationItem) {
		numberOFItems = data.numberOfItems
		currentPage += 1
		displayScreen(with: data.dogList)
	}
	
	private func displayScreen(with responseList: [DogItemResponse]) {
		dogs.append(contentsOf: responseList)
		let presentationArray = dogs.map { item -> DogCollectionViewCell.Model? in
			if let name = item.name {
				return DogCollectionViewCell.Model(name: name,
												   urlImage: item.image?.url)
			}
			
			return nil
		}
		
		DispatchQueue.main.async {
			self.delegate?.dogsListViewModel(self,
											 willUpdateDataSource: presentationArray.compactMap { $0 })
		}
	}
}
