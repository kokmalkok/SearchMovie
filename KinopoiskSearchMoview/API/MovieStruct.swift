//
//  MovieStruct.swift
//  KinopoiskSearchMoview
//
//  Created by Константин Малков on 26.10.2022.
//
//API Struct for base display info's about movies. Showing only 10 request
import Foundation

var kinopoiskLink = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword=Matrix&page=1"
var omdbLink = "http://www.omdbapi.com/?apikey=8e9fef78&t=Matrix&plot=full"//вместо t можно использовать s для поиска, но без плота
var omdbLinkSearch = "http://www.omdbapi.com/?apikey=8e9fef78&s=matrix"

struct Root: Decodable {
    let Search: [Movie]
    enum CodingKeys: String, CodingKey {
        case Search = "Search"
    }
}

struct Movie: Codable {
    let Title: String
    let Year: String
    let imdbID: String
    let _Type: String
    let Poster: String
    
    private enum CodingKeys: String, CodingKey {
        case Title, Year, imdbID, _Type = "Type", Poster
    }
}


