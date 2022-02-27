//
//  BreedsService.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 26/02/22.
//

import Foundation

struct PaginationRequestQuery: Encodable {
	let limit: String
	let page: String
	let order: String
	
	init(limit: Int, page: Int, order: String) {
		self.limit = String(limit)
		self.page = String(page)
		self.order = order
	}
}

typealias DogsListCompletion = (Result<[AnimalItemResponse], ServiceError>) -> Void

protocol BreedsServiceProtocol {
	func getBreedsList(completion: @escaping DogsListCompletion)
	func breedsRequest(requestHeader: PaginationRequestQuery, completion: @escaping DogsListCompletion)
}

final class BreedsService: BreedsServiceProtocol {
	private let session: URLSession

	init(session: URLSession = URLSession.shared) {
		self.session = session
	}

	func getBreedsList(completion: @escaping DogsListCompletion) {
		guard let url = URL(string: BaseUrl.breeds) else {
			completion(.failure(.emptyAPI))
			return
		}

		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		

		let task = session.dataTask(with: request) { (data, response, error) in
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
				let decoded = try decoder.decode([AnimalItemResponse].self, from: jsonData)

				completion(.success(decoded))
			} catch let error {
				completion(.failure(.decodeError(error as NSError)))
			}
		}

		task.resume()
	}
	
	func breedsRequest(requestHeader: PaginationRequestQuery, completion: @escaping DogsListCompletion) {
		let end = Endpoint(path: .breeds,
						   queryItemsEncodable: requestHeader)
		
		guard let url = end.url else {
			completion(.failure(.emptyAPI))
			return
		}

		let task = session.dataTask(with: url) { (data, response, error) in
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
				if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
				   print(JSONString)
				}
				let decoded = try decoder.decode([AnimalItemResponse].self, from: jsonData)

				completion(.success(decoded))
			} catch let error {
				completion(.failure(.decodeError(error as NSError)))
			}
		}

		task.resume()
	}
}
