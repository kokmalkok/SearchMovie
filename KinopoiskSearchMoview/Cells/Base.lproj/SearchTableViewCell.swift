//
//  SearchTableViewCell.swift
//  KinopoiskSearchMoview
//
//  Created by Константин Малков on 26.10.2022.
//
//
//This subclass for SearchViewController for custom table view cell. Cell displaying image,title,type and year release
import UIKit

class SearchTableViewCell: UITableViewCell {

    static let identifier = "SearchTableViewCell"
    
    private let movieImageView: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .systemBackground
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let movieLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let yearLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17, weight: .thin)
        return label
    }()
    
    private let typeLabel: UILabel = {
         let label = UILabel()
         label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17, weight: .thin)
        label.text = "Type Movie"
         return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(movieLabel)
        contentView.addSubview(movieImageView)
        contentView.addSubview(yearLabel)
        contentView.addSubview(typeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    //MARK: - Size settings
    override func layoutSubviews(){
        super.layoutSubviews()
        movieImageView.frame = CGRect(x: 5, y: 5, width: 200, height: contentView.frame.size.height-10)
        movieLabel.frame = CGRect(x: 10+movieImageView.frame.size.width, y: 5, width: contentView.frame.size.width-10-movieImageView.frame.size.width , height: contentView.frame.size.height/2)
        typeLabel.frame = CGRect(x: 10+movieImageView.frame.size.width, y: movieLabel.frame.size.height, width: contentView.frame.size.width-10-movieImageView.frame.size.width, height: contentView.frame.size.height/4)
        yearLabel.frame = CGRect(x: 10+movieImageView.frame.size.width, y: movieLabel.frame.size.height+typeLabel.frame.size.height, width: contentView.frame.size.width-10-movieImageView.frame.size.width, height: contentView.frame.size.height/4-5)
    }
    //MARK: - Downloading main data except images
    //configuration func for processing data from API to UI elements
    func configureCell(with model: Movie){
        self.movieLabel.text = model.Title
        self.typeLabel.text = model._Type
        self.yearLabel.text = model.Year
        guard let url = URL(string: model.Poster) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.movieImageView.image = image
            }
        }
        .resume()
    }

}
