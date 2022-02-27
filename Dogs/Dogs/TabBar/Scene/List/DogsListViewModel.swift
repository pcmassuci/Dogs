//
//  DogsListViewModel.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 26/02/22.
//

import Foundation

protocol DogsListViewModelProtocol {
	func getNextPage()
	func getListByOrder(isAscending: Bool)
	func getList()
}

protocol DogsListViewModelDelegate: AnyObject {
	func dogsListViewModel(_ viewModel: DogsListViewModelProtocol, willUpdateDataSource dataSource: [DogCollectionViewCell.Model])
}

final class DogsListViewModel: DogsListViewModelProtocol {
	
	private let service: BreedsServiceProtocol
	private weak var delegate: DogsListViewModelDelegate?
	
	init(service: BreedsServiceProtocol = BreedsService(), delegate: DogsListViewModelDelegate) {
		self.service = service
		self.delegate = delegate
	}
	
	func getList() {
		service.getBreedsList { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let listOfDogs):
				self.displayScreen(with: listOfDogs)
			case .failure:
				()
			}
		}
	}
	
	func getNextPage() {
		let request = PaginationRequestQuery(limit: 10,
											 page: 1,
											 order: "Desc")
		service.breedsRequest(requestHeader: request) { [weak self] response in
			guard let self = self else { return }
			switch response {
			case .success(let listOfDogs):
				self.displayScreen(with: listOfDogs)
			case .failure:
				()
			}
		}
	}
	
	func getListByOrder(isAscending: Bool) {
		
	}
	
	private func displayScreen(with responseList: [AnimalItemResponse]) {
		let presentationArray = responseList.map { item -> DogCollectionViewCell.Model? in
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
