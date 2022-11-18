//
//  FavouriteTableViewCell.swift
//  KinopoiskSearchMoview
//
//  Created by Константин Малков on 01.11.2022.
//
//Custom Cell for Movie Information. Same as Search Table View Cell ,but with more UI elements
import Foundation
import UIKit

class FavouriteTableViewCell: UITableViewCell {
    
    static let identifier = "FavouriteTableViewCell"
    
     private let movieImageView: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
         image.image = UIImage(systemName: "photo.on.rectangle.angled")
         image.image?.withTintColor(.black)
        return image
    }()
    
     private let movieLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
         label.numberOfLines = 0
         label.textAlignment = .left
         label.font = UIFont(name: "Times New Roman", size: 20)
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Movie Label"
        return label
    }()
    
    private let yearLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "Times New Roman", size: 20)
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.font = UIFont(name: label.font.fontName, size: 20)
        label.text = "Year Movie"
        return label
    }()
    
    private let ratingLabel: UILabel = {
         let label = UILabel()
         label.textColor = .black
         label.textAlignment = .left
         label.numberOfLines = 0
         label.font = UIFont(name: "Times New Roman", size: 20)
         label.font = .systemFont(ofSize: 17, weight: .medium)
        label.text = "IMDb: 10.0"
         return label
    }()
    
   private let runtimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
       label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "Times New Roman", size: 20)
        label.font = .systemFont(ofSize: 17, weight: .medium)
       label.text = "Runtime Movie: 100 min"
        return label
   }()
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(movieLabel)
        contentView.addSubview(movieImageView)
        contentView.addSubview(yearLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(runtimeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        let movieWidth = movieImageView.frame.size.width
        let contentHeight = contentView.frame.size.height/4
        movieImageView.frame = CGRect(x: 5, y: 5, width: 75, height: contentView.frame.size.height-5)
        movieLabel.frame = CGRect(x: 10+movieWidth, y: 5, width: contentView.frame.size.width-movieWidth-10, height: contentHeight)
        ratingLabel.frame = CGRect(x: 10+movieWidth, y: movieLabel.frame.size.height, width: contentView.frame.size.width-movieWidth, height: contentHeight)
        yearLabel.frame = CGRect(x: 10+movieWidth, y: movieLabel.frame.size.height+ratingLabel.frame.size.height, width: contentView.frame.size.width-movieWidth, height: contentHeight)
        runtimeLabel.frame = CGRect(x: 10+movieWidth, y: movieLabel.frame.size.height+ratingLabel.frame.size.height+yearLabel.frame.size.height, width: contentView.frame.size.width-movieWidth-10, height: contentHeight)
    }
    
    func configureCell(with model: MovieEntity){
        self.movieLabel.text = model.title
        self.ratingLabel.text = "IMDb: \(model.rating ?? "No data IMDb")"
        self.yearLabel.text = "Year release: \(model.year ?? "No data year")"
        if model.runtime == "N/A" {
            self.runtimeLabel.text = "Game"
        } else {
            self.runtimeLabel.text = "Movie: \(model.runtime ?? "No data runtime")"
        }
        if let image = UIImage(data: model.image!){
            self.movieImageView.image = image
        }
    }
}
