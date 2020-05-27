//
//  SearchTableDelegate.swift
//  Movie Search
//
//  Created by user on 5/6/20.
//  Copyright © 2020 Shalom Friss. All rights reserved.
//

import Foundation
import UIKit

class SearchTableDelegate:NSObject {
    weak var presenter:SearchPresenter?
}

extension SearchTableDelegate:UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! SearchTableViewCell
        cell.body.text = ""
        cell.title.text = ""
        cell.theImage.image = UIImage(named: "PosterPlaceholder")
        
        cell.body.text = "test"
        if let result = presenter?.results?[indexPath.row] {
            cell.title.text = result.title
            cell.body.text = result.overview
            if let posterPath = result.posterPath {
                DispatchQueue.global(qos: .userInitiated).async {
                    NetworkManager.shared.loadMoviePoster(posterPath: posterPath, completion: { imageResult in
                        switch(imageResult){
                        case .success(let aImage):
                            DispatchQueue.main.async {
                                cell.theImage.image = aImage
                            }
                        case .failure(_):
                            break
                        }
                        
                    })
                }
            }
            
        }
        return cell
    }
}

extension SearchTableDelegate:UITableViewDelegate {
    
}
