//
//  AnimalItemResponse.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 26/02/22.
//

struct DogItemResponse: Decodable {
	enum CodingKeys: String, CodingKey {
		case idDog = "id"
		case name
		case bredFor = "bred_for"
		case breedGroup = "breed_group"
		case lifeSpan = "life_span"
		case temperament
		case origin
		case height
		case weight
		case referenceImageId = "reference_image_id"
		case image
	}
	
	let idDog: Int?
	let name: String?
	let bredFor: String?
	let breedGroup: String?
	let lifeSpan: String?
	let temperament: String?
	let origin: String?
	let height: Height?
	let weight: Weight?
	let referenceImageId: String?
	let image: Image?
}

extension DogItemResponse {
	struct Image: Decodable {
		enum CodingKeys: String, CodingKey {
			case idImage = "id"
			case width
			case height
			case url
		}
		
		let idImage: String?
		let width: Int
		let height: Int
		let url: String?
	}
	struct Weight: Decodable {
		var imperial: String?
		var metric: String?
	}
	
	struct Height: Decodable {
		var imperial: String?
		var metric: String?
	}
}

/* {
 "weight": {
 "imperial": "6 - 13",
 "metric": "3 - 6"
 },
 "height": {
 "imperial": "9 - 11.5",
 "metric": "23 - 29"
 },
 "id": 1,
 "name": "Affenpinscher",
 "bred_for": "Small rodent hunting, lapdog",
 "breed_group": "Toy",
 "life_span": "10 - 12 years",
 "temperament": "Stubborn, Curious, Playful, Adventurous, Active, Fun-loving",
 "origin": "Germany, France",
 "reference_image_id": "BJa4kxc4X",
 "image": {
 "id": "BJa4kxc4X",
 "width": 1600,
 "height": 1199,
 "url": "https://cdn2.thedogapi.com/images/BJa4kxc4X.jpg"
 }
 }
 */
