//
//  DogCollectionViewCell.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 26/02/22.
//

import UIKit
import Kingfisher

final class DogCollectionViewCell: UICollectionViewCell {
	struct Model {
		var name: String
		var urlImage: String?		
	}

	private lazy var breedLabel = UILabel()
	private lazy var breedImage = UIImageView()

	var model: Model? {
		didSet {
			didSetModel()
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		applyViewCode()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		breedLabel.text = String()
		breedImage.image = nil
	}
	
	private func didSetModel() {
		breedLabel.text = model?.name
		
		if let urlPhoto = URL(string: model?.urlImage ?? String()) {
			breedImage.kf.setImage(with: urlPhoto)
		}
	}
}

extension DogCollectionViewCell: ViewCodeConfiguration {
	func buildHierarchy() {
		breedLabel.setViewIsCodable()
		addSubview(breedLabel)
		breedImage.setViewIsCodable()
		addSubview(breedImage)
	}

	func setupContraints() {
		setupListConstraint()
	}
	
	private func setupListConstraint() {
		let breedImageConstraints = [
			breedImage.topAnchor.constraint(greaterThanOrEqualTo: topAnchor,
											constant: 8),
			breedImage.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor,
											constant: -8),
			breedImage.leadingAnchor.constraint(equalTo: leadingAnchor,
											constant: 8),
			breedImage.widthAnchor.constraint(equalToConstant: 80),
			breedImage.heightAnchor.constraint(equalToConstant: 80),
			breedImage.centerYAnchor.constraint(equalTo: centerYAnchor)
		]
		
		let breedLabelConstraints = [
			breedLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor,
											constant: 8),
			breedLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor,
											constant: -8),
			breedLabel.leadingAnchor.constraint(equalTo: breedImage.trailingAnchor,
											constant: 8),
			breedLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
											constant: -8),
			breedLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
		]
		
		NSLayoutConstraint.activate(breedImageConstraints + breedLabelConstraints)
	}
	
	func configureViews() {
		breedLabel.numberOfLines = .zero
		breedImage.contentMode = .scaleAspectFit
		breedImage.clipsToBounds = true
	}
}
