//
//  DogsListViewModel.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 26/02/22.
//

import Foundation

protocol DogsListViewModelProtocol {
	func getList() 
}

final class DogsListViewModel {
	private let service: BreedsServiceProtocol
	init(service: BreedsServiceProtocol = BreedsService()) {
		self.service = service
	}
	
	func getList() {
		service.getBreedsList { [weak self] result in
			switch result {
			case .success(let obj):
				print(obj)
			case .failure:
				()
			}
		}
	}
}
