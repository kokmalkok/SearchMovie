//
//  MovieInformationViewController.swift
//  KinopoiskSearchMoview
//
//  Created by Константин Малков on 03.11.2022.
//

import UIKit
import SafariServices
//protocol for delegating data from other class to current class
protocol MovieInformationDelegate {
    func transferLink(imdb: String)
}

class MovieInformationViewController: UIViewController {
    
    var structData: FullMovie? //inherit struct movie data
    var structImageData: Data? //variable for saving image to configure data
    var imdbLinkInherit: String = "" //variable for saving link from parent class
    private let data = MovieEntityStack() //main constant for using Core Data
    
    var delegate: MovieInformationDelegate? //delegate variable
    
    private let scrollView = UIScrollView()
    //user elements
    private lazy var rightActionButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
        button.tintColor = .black
        button.backgroundImage(for: .normal ,style: .done, barMetrics: .default)
        return button
    }()
    
    lazy var actionButton : UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.addTarget(self, action: #selector(didTapAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        return button
    }()
    
    private var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Title loading..."
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private var movieImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private var shortDescriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "Short Description loading"
        label.textColor = .black
        label.numberOfLines = 4
        label.sizeToFit()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .thin)
        return label
    }()
    
    private var fullDescriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "Full Description Movie loading"
        label.textColor = .black
        label.sizeToFit()
        label.numberOfLines = 30
        label.textAlignment = .justified
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private var actorsLabel: UILabel = {
       let label = UILabel()
        label.text = "Actors cast loading"
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .justified
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private var awardsLabel: UILabel = {
       let label = UILabel()
        label.text = "Awards loading"
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .justified
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private var rightSegueNavigationButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .done, target: MovieInformationViewController.self, action: #selector(didTapAction))
        return button
    }()
    
    private var customButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.addTarget(MovieInformationViewController.self, action: #selector(didTapAction), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        movieDescription(imdbLinkInherit)
        setupNavigationController()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width-10, height: view.frame.size.height-20)
        actionButton.frame = CGRect(x: view.safeAreaInsets.left+view.frame.size.width-75, y: view.safeAreaInsets.top+50, width: 50, height: 50)
        titleLabel.frame = CGRect(x: scrollView.safeAreaInsets.left, y: 50, width: scrollView.frame.size.width, height: 80)
        movieImageView.frame = CGRect(x: scrollView.safeAreaInsets.left, y: 50+titleLabel.frame.size.height, width: scrollView.frame.size.width-20, height: 300)
        shortDescriptionLabel.frame = CGRect(x: scrollView.safeAreaInsets.left, y: 50+titleLabel.frame.size.height+movieImageView.frame.size.height, width: scrollView.frame.size.width, height: 90)
        fullDescriptionLabel.frame = CGRect(x: scrollView.safeAreaInsets.left+10, y:  50+titleLabel.frame.size.height+movieImageView.frame.size.height+shortDescriptionLabel.frame.size.height, width: scrollView.frame.size.width-20, height: 500)
        actorsLabel.frame = CGRect(x: scrollView.safeAreaInsets.left+20, y:  50+titleLabel.frame.size.height+movieImageView.frame.size.height+shortDescriptionLabel.frame.size.height+fullDescriptionLabel.frame.size.height, width: scrollView.frame.size.width-40, height: 60)
        awardsLabel.frame = CGRect(x: scrollView.safeAreaInsets.left+20, y:  50+titleLabel.frame.size.height+movieImageView.frame.size.height+shortDescriptionLabel.frame.size.height+fullDescriptionLabel.frame.size.height+actorsLabel.frame.size.height, width: scrollView.frame.size.width-40, height: 40)
    }
    //MARK: - Objc methods
    //target action on button. Include segue to safari by movie link, save in core data and share link in messangers
    @objc private func didTapAction(){
        guard let url = URL(string: "https://www.imdb.com/title/\(self.imdbLinkInherit)") else { return }
        let alert = UIAlertController(title: "Choose Action", message: "What do you want me to do?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Open in Browser", style: .default,handler: { _ in
            let safari = SFSafariViewController(url: url)
            self.present(safari, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Share Movie", style: .default,handler: { _ in
            var share: [URL] = []
            share.append(url)
            let shareVC = UIActivityViewController(activityItems: share, applicationActivities: nil)
            shareVC.popoverPresentationController?.permittedArrowDirections = .any
            self.present(shareVC, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Add to Favourite", style: .default,handler: { [self] _ in
            self.data.saveData(structData!, image: structImageData!)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    //MARK: - View Setup
    private func setupScrollView(){
        view.addSubview(scrollView)
        view.backgroundColor = .systemBackground
        view.addSubview(actionButton)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(movieImageView)
        scrollView.addSubview(shortDescriptionLabel)
        scrollView.addSubview(fullDescriptionLabel)
        scrollView.addSubview(actorsLabel)
        scrollView.addSubview(awardsLabel)
        scrollView.backgroundColor = .systemBackground
        scrollView.contentSize = CGSize(width: view.frame.size.width-20, height: 1200)
        scrollView.showsHorizontalScrollIndicator = false
    }
    //this func didn't work. Try to fix it
    private func setupNavigationController(){
        self.navigationController?.navigationBar.barTintColor = .systemGray
        self.navigationController?.navigationBar.tintColor = .black
        let customButtonBar = UIBarButtonItem(customView: customButton)
        self.navigationController?.navigationItem.rightBarButtonItems = [customButtonBar, rightSegueNavigationButton]
    }
    //MARK: - API Responder
    //func for configure data from api into image
    func transformData(with model: FullMovie) {
        guard let url = URL(string: model.Poster) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data , error == nil else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.movieImageView.image = image
                self.structImageData = data
            }
        }.resume()
    }
    //func for upload full information about current movie
    func movieDescription(_ link: String){
        guard let url = URL(string: "https://www.omdbapi.com/?apiKey=8e9fef78&i=\(link)&plot=full") else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let result = try JSONDecoder().decode(FullMovie.self, from: data)
                DispatchQueue.main.async { [weak self] in
                    self?.structData = result
                    self?.titleLabel.text = result.Title
                    self?.shortDescriptionLabel.text = "\(result.Released), \(result.Genre)\n \(result.Country)\n \(result.Runtime), Rate-\(result.Rated)\nBox Office: \(result.BoxOffice)"
                    self?.fullDescriptionLabel.text = result.Plot
                    self?.actorsLabel.text = "Actors cast: \(result.Actors)"
                    self?.awardsLabel.text = "Awards: \(result.Awards)"
                    self?.transformData(with: result)
                }
            }
            catch {
                print("error of trends \(error)")
                let alert = UIAlertController(title: "Error of page", message: "We could not download full information about choosed product. Please, choose another!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
                self?.present(alert, animated: true)
            }
        }.resume()
    }
}
