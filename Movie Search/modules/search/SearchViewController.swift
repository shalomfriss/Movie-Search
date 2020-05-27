//
//  SearchViewController.swift
//  Movie Search
//
//  Created by user on 5/5/20.
//  Copyright © 2020 Shalom Friss. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    //MARK:- Outlets -
    @IBOutlet weak var searchTable: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    
    let searchController = UISearchController(searchResultsController: nil)
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK: - Public properties -
    var presenter: SearchPresenterInterface!
    var searchTabledelegate:SearchTableDelegate = SearchTableDelegate()
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTable.dataSource = searchTabledelegate
        searchTable.delegate = searchTabledelegate
        searchTabledelegate.presenter = (presenter as? SearchPresenter)
        
        searchController.searchBar.placeholder = "Filter"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchTable.tableHeaderView = searchController.searchBar
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        self.view.addSubview(activityIndicator)
        
        
    }
    
    //MARK:- Module method -
    
    /// Static function to construct our MVP module and return the view controller
    /// - Returns: SearchViewController
    public static func getModule() -> SearchViewController {
        let searchStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let searchViewController =  searchStoryboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        let searchModel = SearchModel()
        let searchPresenter = SearchPresenter(view: searchViewController, model: searchModel)
        searchViewController.presenter = searchPresenter
        return searchViewController
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        searchController.isActive = false
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            ac.dismiss(animated: true, completion: nil)
            guard let answer = ac.textFields![0].text else {
                return
            }
            
            self.activityIndicator.startAnimating()
            self.presenter.searchForMovie(searchTerm: answer, completion: { [weak self] results in
                DispatchQueue.main.async { [weak self] in
                    self?.activityIndicator.stopAnimating()
                    self?.searchTable.reloadData()
                }
            })
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
}


extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        presenter.filterResults(for: searchController.searchBar.text ?? "")
        DispatchQueue.main.async {
            self.searchTable.reloadData()
        }
    }
}

