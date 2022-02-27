//
//  EncodableExtension.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 27/02/22.
//

import Foundation

extension Encodable {
	  var dictionary: [String: Any]? {
		guard let data = try? JSONEncoder().encode(self) else { return nil }
		return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
	  }
	
	var queryParams: [URLQueryItem]? {
		guard let dictionary = dictionary else { return nil }
		return dictionary.map { URLQueryItem(name: $0.key,
											 value: ($0.value as? String))}
	}
}
