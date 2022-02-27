//
//  Endpoint.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 27/02/22.
//

import Foundation

struct Endpoint {
	enum Path: String {
		case breeds = "/v1/breeds"
		case searchBreeds = "/v1/breeds/search"
	}
	
	let path: String
	let queryItems: [URLQueryItem]
	
	init(path: Path, queryItemsEncodable: Encodable) {
		self.path = path.rawValue
		queryItems = queryItemsEncodable.queryParams ?? []
	}
}

extension Endpoint {
	var url: URL? {
		var components = URLComponents()
		components.scheme = "https"
		components.host = "api.thedogapi.com"
		components.path = path
		components.queryItems = queryItems

		return components.url
	}
}
