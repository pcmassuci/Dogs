//
//  BaseService.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 27/02/22.
//

import Foundation

class BaseService {
	
	let session: URLSession
	
	init(session: URLSession = URLSession.shared) {
		self.session = session
	}
}
