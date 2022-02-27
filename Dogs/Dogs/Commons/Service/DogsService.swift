//
//  BreedsService.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 26/02/22.
//

import Foundation

typealias DogsListPaginationCompletion = (Result<PaginationItem, ServiceError>) -> Void

protocol DogsServiceProtocol {
	func breedsRequest(requestHeader: PaginationRequestQuery, completion: @escaping DogsListPaginationCompletion)
}

final class DogsService: DogsServiceProtocol {
	private let session: URLSession
	
	init(session: URLSession = URLSession.shared) {
		self.session = session
	}
		
	func breedsRequest(requestHeader: PaginationRequestQuery, completion: @escaping DogsListPaginationCompletion) {
		let endpoint = Endpoint(path: .breeds,
								queryItemsEncodable: requestHeader)
		
		guard let url = endpoint.url else {
			completion(.failure(.emptyAPI))
			return
		}
		
		let task = session.dataTask(with: url) { [weak self] (data, response, error) in
			guard let self = self else { return }
			
			if let error = error {
				completion(.failure(.decodeError(error as NSError)))
				return
			}
			
			guard let jsonData = data else {
				completion(.failure(.wrongData))
				return
			}
			
			let numberOFItens = self.getNumberOfItems(response: response)
	
			do {
				let decoder = JSONDecoder()
				let decoded = try decoder.decode([DogItemResponse].self, from: jsonData)
				let item = PaginationItem(numberOfItems: numberOFItens,
										  dogList: decoded)
				completion(.success(item))
			} catch let error {
				completion(.failure(.decodeError(error as NSError)))
			}
		}
		
		task.resume()
	}
		
	func getNumberOfItems(response: URLResponse?) -> Int? {
		if let httpResponse = response as? HTTPURLResponse,
		   let pagination = httpResponse.value(forHTTPHeaderField: "Pagination-Count") {
			return Int(pagination)
		}
		
		return nil
	}
}
