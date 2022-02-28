//
//  DetailViewController.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 27/02/22.
//

import UIKit

class DetailViewController: UIViewController {
	var detailView: DetailView? {
		view as? DetailView
	}
	
	var viewModel: DetailViewModelProtocol?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		viewModel?.getViewData()
    }
	
	override func loadView() {
		view = DetailView()
	}
}

extension DetailViewController: DetailViewModelDelegate {
	func detailViewModel(_ viewModel: DetailViewModelProtocol, didUpdateView item: DetailView.Model) {
		detailView?.model = item
		title = item.breedName
	}
}
