//
//  SearchViewCell.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 27/02/22.
//

import Foundation
import UIKit

final class SearchViewCell: UITableViewCell {
	struct Model {
		let breedName: String
		let breedGroup: String
		let origin: String
	}
	
	private lazy var breedNameLabel = UILabel()
	private lazy var breedGroupLabel = UILabel()
	private lazy var originLabel = UILabel()
	
	var model: Model? {
		didSet {
			didSetModel()
		}
	}
	
	private func didSetModel() {
		breedNameLabel.text = model?.breedName
		breedGroupLabel.text = model?.breedGroup
		originLabel.text = model?.origin
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		applyViewCode()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		breedNameLabel.text = model?.breedName
		breedGroupLabel.text = model?.breedGroup
		originLabel.text = model?.origin
	}
}

extension SearchViewCell: ViewCodeConfiguration {
	func buildHierarchy() {
		breedNameLabel.setViewIsCodable()
		addSubview(breedNameLabel)
		
		breedGroupLabel.setViewIsCodable()
		addSubview(breedGroupLabel)
		
		originLabel.setViewIsCodable()
		addSubview(originLabel)
	}
	
	func setupContraints() {
		let breedNameLabelConstraints = [
			breedNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
												constant: 8),
			breedNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
													constant: 8),
			breedNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
													 constant: -8)
		]
		
		let breedGroupLabelConstraints = [
			breedGroupLabel.topAnchor.constraint(equalTo: breedNameLabel.bottomAnchor,
												 constant: 8),
			breedGroupLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
													 constant: 8),
			breedGroupLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
													  constant: -8)
		]
		
		let originLabelConstraints = [
			originLabel.topAnchor.constraint(equalTo: breedGroupLabel.bottomAnchor,
											 constant: 8),
			originLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
												 constant: 8),
			originLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
												  constant: -8),
			originLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
												constant: -8)
		]
		
		NSLayoutConstraint.activate(breedNameLabelConstraints + breedGroupLabelConstraints + originLabelConstraints)
	}
	
	func configureViews() {
		
	}
}
