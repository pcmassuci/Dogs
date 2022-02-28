//
//  PaginationRequestQuery.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 27/02/22.
//

import Foundation

struct PaginationRequestQuery: Encodable {
	let limit: String
	let page: String
	let order: String
	
	init(limit: Int, page: Int, isAscending: Bool) {
		self.limit = String(limit)
		self.page = String(page)
		self.order = isAscending ? String() : "Desc"
	}
}
