//
//  ServiceError.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 26/02/22.
//

import Foundation

enum ServiceError: Error {
	case decodeError(NSError)
	case emptyAPI
	case wrongData
}
