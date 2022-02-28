//
//  DetailViewModel.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 27/02/22.
//

import Foundation

protocol DetailViewModelProtocol {
	func getViewData()
}

protocol DetailViewModelDelegate: AnyObject {
	func detailViewModel(_ viewModel: DetailViewModelProtocol, didUpdateView item: DetailView.Model)
}

final class DetailViewModel: DetailViewModelProtocol {
	private weak var delegate: DetailViewModelDelegate?
	private var item: DogItemResponse
	
	init(delegate: DetailViewModelDelegate, item: DogItemResponse) {
		self.delegate = delegate
		self.item = item
	}
	
	func getViewData() {
		let defaultString = "Not Availiable"
		let model = DetailView.Model(breedName: item.name ?? defaultString,
									 breedCategory: item.breedGroup
									 ?? defaultString,
									 origin: item.origin ?? defaultString,
									 temperament: item.temperament ?? defaultString)
		delegate?.detailViewModel(self, didUpdateView: model)
	}
}
