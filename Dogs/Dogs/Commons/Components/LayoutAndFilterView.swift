//
//  LayoutAndFilterView.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 26/02/22.
//

import UIKit


protocol LayoutAndFilterViewDelegate: AnyObject {
	
	func layoutAndFilterView(_ view: LayoutAndFilterView, orderIsSelected: LayoutAndFilterView.Alphabetic)
	
	func layoutAndFilterView(_ view: LayoutAndFilterView, layoutIsSelected: LayoutAndFilterView.LayoutFormat)
}

final class LayoutAndFilterView: UIView {
	enum Alphabetic {
		case ascending
		case descending
		case none
	}
	
	enum LayoutFormat {
		case list
		case grid
	}
	
	private(set) var alphabeticState: Alphabetic = .none {
		didSet {
			delegate?.layoutAndFilterView(self,
										  orderIsSelected: alphabeticState)
		}
	}
	
	private(set) var layoutFormat: LayoutFormat = .grid {
		didSet {
			delegate?.layoutAndFilterView(self,
										  layoutIsSelected: layoutFormat)
		}
	}
	
	weak var delegate: LayoutAndFilterViewDelegate?
	
	private lazy var alphabeticButton = UIButton()
	private lazy var layoutButton = UIButton()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		applyViewCode()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc
	private func alphabeticButtonSelected() {
		switch alphabeticState {
		case .ascending:
			alphabeticState = .descending
		case .descending:
			alphabeticState = .ascending
		case .none:
			alphabeticState = .ascending
		}
	}
	
	@objc
	private func layoutButtonSelected() {
		switch layoutFormat {
		case .list:
			layoutFormat = .grid
		case .grid:
			layoutFormat = .list
		}
	}
}

extension LayoutAndFilterView: ViewCodeConfiguration {
	func buildHierarchy() {
		alphabeticButton.setViewIsCodable()
		addSubview(alphabeticButton)
		
		layoutButton.setViewIsCodable()
		addSubview(layoutButton)
	}
	
	func setupContraints() {
		let alphabeticButtonConstraints = [
			alphabeticButton.topAnchor.constraint(equalTo: topAnchor,
												  constant: 8),
			alphabeticButton.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor,
													 constant: -8),
			alphabeticButton.leadingAnchor.constraint(equalTo: leadingAnchor,
													  constant: 8),
			alphabeticButton.heightAnchor.constraint(equalToConstant: 20)
		]
		
		let layoutButtonConstraints = [
			layoutButton.topAnchor.constraint(equalTo: topAnchor,
											  constant: 8),
			layoutButton.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor,
												 constant: -8),
			layoutButton.leadingAnchor.constraint(greaterThanOrEqualTo: alphabeticButton.trailingAnchor,
												  constant: 8),
			layoutButton.trailingAnchor.constraint(equalTo: trailingAnchor,
												   constant: -8),
			layoutButton.heightAnchor.constraint(equalToConstant: 20)
		]
		
		NSLayoutConstraint.activate(alphabeticButtonConstraints + layoutButtonConstraints)
	}
	
	func configureViews() {
		backgroundColor = .systemPink
		layoutButton.setTitle("L", for: .normal)
	
		layoutButton.addTarget(self,
							   action: #selector(layoutButtonSelected),
							   for: .touchUpInside)
		alphabeticButton.setTitle("A", for: .normal)
		alphabeticButton.addTarget(self,
							   action: #selector(alphabeticButtonSelected),
							   for: .touchUpInside)
	}
}
