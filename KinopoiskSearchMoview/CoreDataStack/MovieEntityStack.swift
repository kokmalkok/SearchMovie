//
//  MovieStack.swift
//  KinopoiskSearchMoview
//
//  Created by Константин Малков on 01.11.2022.
//  Stack class for main core data setup

import Foundation
import CoreData
import UIKit

class MovieEntityStack {
    
    static let instance = MovieEntityStack()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var vaultData = [MovieEntity]()
    
    func loadData(){
        do {
            vaultData = try context.fetch(MovieEntity.fetchRequest())
        } catch {
            print("Error loading data from core data")
        }
    }
    
    func saveData(_ data: FullMovie,image: Data){
        let movie = MovieEntity(context: context)
        movie.image = image
        movie.url = "https://www.imdb.com/title/\(data.imdbID)/"
        movie.title = data.Title
        movie.year = data.Year
        movie.rating = data.imdbRating
        movie.runtime = data.Runtime
        movie.year = data.Released
        movie.imdbLink = data.imdbID
        do {
            try context.save()
            loadData()
        } catch {
            print("Error saving data \(Date.now)")
        }
    }
    
    func deleteData(data: MovieEntity){
        context.delete(data)
        do{
            try context.save()
            loadData()
        } catch {
            print("Data did not deleted")
        }
    }
}
