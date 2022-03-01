//
//  DogItemResponseExtension.swift
//  DogsTests
//
//  Created by Paulo Cesar Morandi Massuci on 28/02/22.
//

@testable import Dogs
import Foundation

extension DogItemResponse {
	static func fixture(name: String) -> DogItemResponse {
		return DogItemResponse(idDog: 1,
							   name: name,
							   bredFor: "bredFor",
							   breedGroup: "breedGroup",
							   lifeSpan: "lifeSpan",
							   temperament: "temperament",
							   origin: "origin",
							   height: nil,
							   weight: nil,
							   referenceImageId: "referenceImageId",
							   image: DogItemResponse.Image(idImage: nil,
															width: 12, height: 12,
															url: "url"))
	}
}
