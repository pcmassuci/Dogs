//
//  BreedsService.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 26/02/22.
//

import Foundation

typealias DogsListCompletion = (Result<[AnimalItemResponse], ServiceError>) -> Void

protocol BreedsServiceProtocol {
	func getBreedsList(completion: @escaping DogsListCompletion)
}

final class BreedsService: BreedsServiceProtocol {
	private let session: URLSession

	init(session: URLSession = URLSession.shared) {
		self.session = session
	}

	func getBreedsList(completion: @escaping DogsListCompletion) {
		guard let url = URL(string: BaseUrl.breeds.rawValue) else {
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
				let decoded = try decoder.decode([AnimalItemResponse].self, from: jsonData)

				completion(.success(decoded))
			} catch let error {
				completion(.failure(.decodeError(error as NSError)))
			}
		}

		task.resume()
	}
}
