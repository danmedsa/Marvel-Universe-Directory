//
//  HeroListViewController.swift
//  MarvelHeroDirectory
//
//  Created by Daniel Medina Sada on 9/29/21.
//

import UIKit

class HeroListViewController: UIViewController, ErrorAlertControlling {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel: HeroListViewModel
    var searchText: String?
    
    var lastServiceRequestCell: HeroTableViewCell?

    init(viewModel: HeroListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = HeroListViewModel(webservice: ServiceHandler())
        super.init(coder: coder)
    }
    
    func setViewModel(_ viewModel: HeroListViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getHeroList(text: nil)
    }
    
    /// Handles segue to Detail Screen passing `Character` data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == HeroDetailsViewController.identifier {
            guard let cell = sender as? HeroTableViewCell,
                  let controller = segue.destination as? HeroDetailsViewController,
                  let character = cell.character else { return }
            let viewModel =  HeroDetailsViewModel(with: character)
            controller.configure(with: viewModel)
        }
    }

    func getHeroList(text: String?, page: Int = 0) {
        let indicatorView = LoadingIndicatorView()
        
        DispatchQueue.main.async {
            indicatorView.showLoadingIndicator(in: self)
        }
        
        self.viewModel.getHeroList(text: text, page: page) { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                indicatorView.hideLoadingIndicator()
                self.handleError(error: error)
            }
        }
    }
    
    func handleError(error: ServiceError?) {
        guard let error = error else { return }
        switch error {
        case .noData:
            self.displayConnectionAlert()
        case .decodingData, .requestError:
            self.displayHackingAlert()
        case .searchUnavailable:
            self.displayLimitedConnectivity()
        default:
            self.displayUnknownIssueAlert()
        }
    }
}

