//
//  MovieFullStruct.swift
//  KinopoiskSearchMoview
//
//  Created by Константин Малков on 03.11.2022.
//
//Struct display full information about choosen movie
import Foundation

let exampleLink = "http://www.omdbapi.com/?apiKey=8e9fef78&i=tt0133093&plot=full"

struct FullMovie: Codable {
    let Title: String
    let Year: String
    let Rated: String
    let Released: String
    let Runtime: String
    let Genre: String
    let Director: String
    let Actors: String
    let Plot: String
    let Country: String
    let Awards: String
    let Poster: String
    let imdbID: String
    let BoxOffice: String
    let imdbRating: String
    
    private enum CodingKeys: String, CodingKey {
        case Title, Year, Rated, Released, Runtime, Genre, Director, Actors, Plot, Country, Awards, Poster, imdbID, BoxOffice, imdbRating
    }
}
