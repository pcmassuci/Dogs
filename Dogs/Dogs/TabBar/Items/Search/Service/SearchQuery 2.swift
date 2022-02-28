//
//  SearchQuery.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 27/02/22.
//

import Foundation
struct SearchQuery: Encodable {
	let q: String
	
	init(searchText: String) {
		q = searchText
	}
}
