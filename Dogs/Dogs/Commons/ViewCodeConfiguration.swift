//
//  ViewCodeConfiguration.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 26/02/22.
//

import Foundation

protocol ViewCodeConfiguration {
	func buildHierarchy()
	func setupContraints()
	func configureViews()
}

extension ViewCodeConfiguration {
	func applyViewCode() {
		buildHierarchy()
		setupContraints()
		configureViews()
	}
}
