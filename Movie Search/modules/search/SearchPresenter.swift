//
//  SearchPresenter.swift
//  Movie Search
//
//  Created by user on 5/5/20.
//  Copyright (c) 2020 Shalom Friss. All rights reserved.
//
//  This file was generated by the Cobra Generator
//

import UIKit

protocol SearchPresenterInterface {
    func searchForMovie(searchTerm:String, completion: @escaping (Result<ResultsVO, NetworkError>) -> Void)
    func filterResults(for searchText: String)
}

class SearchPresenter:SearchPresenterInterface {

    // MARK: - Private properties -
    
    private unowned let _view: UIViewController
    private var _model: SearchModelInterface
    private var filterString = ""
    private var filteredResults = [ResultVO]()
    
    public var results:[ResultVO]? {
        get {
             return _model.resultRows
        }
    }
    
    // MARK: - Lifecycle -
    
    init(view: UIViewController, model: SearchModelInterface) {
        _view = view
        _model = model
    }
    
    //MARK:- Utils -
    
    /// Search for a movie term
    /// - Parameter term: String - the term to search for
    public func searchForMovie(searchTerm:String, completion: @escaping (Result<ResultsVO, NetworkError>) -> Void) {
        NetworkManager.shared.searchForMovie(searchTerm: searchTerm, completion: { [weak self] result in
            switch result {
            case .success(let data):
                self?._model.results = data
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    
    /// Get filtered results for the given text
    /// - Parameter searchText: String - The text to search for
    /// - Returns: [ResultVO]
    public func filterResults(for searchText: String) {
        _model.filterResults(for: searchText)
        
    }
}
