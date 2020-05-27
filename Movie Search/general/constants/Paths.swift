//
//  Paths.swift
//  Movie Search
//
//  Created by user on 5/4/20.
//  Copyright © 2020 Shalom Friss. All rights reserved.
//

import Foundation


/// Paths contains all the api paths in the app
enum Paths:String {
    
    case search = "https://api.themoviedb.org/3/search/movie?api_key=%@&query=%@"
    case poster = "https://image.tmdb.org/t/p/w600_and_h900_bestv2/%@"
}
