//
//  SearchService.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 27/02/22.
//

import Foundation

typealias SearchDogCompletion = (Result<[DogItemResponse], ServiceError>) -> Void

final class SearchService: BaseService {
	func searchRequest(requestQuery: SearchQuery, completion: @escaping SearchDogCompletion) {
		let endpoint = Endpoint(path: .searchBreeds,
								queryItemsEncodable: requestQuery)
		
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
			
			do {
				let decoder = JSONDecoder()
				let decoded = try decoder.decode([DogItemResponse].self, from: jsonData)
				completion(.success(decoded))
			} catch let error {
				completion(.failure(.decodeError(error as NSError)))
			}
		}
		
		task.resume()
	}
}
