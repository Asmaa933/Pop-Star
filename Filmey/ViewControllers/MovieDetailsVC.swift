//
//  MovieDetails.swift
//  Filmey
//
//  Created by Asmaa Tarek on 1/6/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import UIKit
import Cosmos
import SafariServices

class MovieDetailsVC: UIViewController {
    
    @IBOutlet weak private var favouriteBtn: UIButton!
    @IBOutlet weak private var movieTitleLabel: UILabel!
    @IBOutlet weak private var overviewTxt: UITextView!
    @IBOutlet weak private var movieImg: UIImageView!
    @IBOutlet weak private var releaseDateLabel: UILabel!
    @IBOutlet weak private var trailersTable: UITableView!
    @IBOutlet weak private var rateLabel: UILabel!
    @IBOutlet weak private var starsCosmos: CosmosView!
    @IBOutlet weak private var reviewCollectionView: UICollectionView!
    
    var isFavourite = false
    var selectedMovieID = 0
    private var trailersArr = [TrailerData]()
    private var selectedMovie: MovieModel!
    private var coreMovie = [FavoriteMovies]()
    private var reviewArr = [ReviewModel]()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.reviewCollectionView.isPagingEnabled = true
        favouriteBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        trailersTable.isHidden = true
        getTrailers()
        trailersTable.tableFooterView = UIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool){
        GetMovieDetails.getMovieById(movieID: selectedMovieID) {[weak self] (responseModel, error) in
            guard let self =  self else {return}
            if responseModel != nil && error == nil{
                self.selectedMovie = responseModel
                self.updateUI()
            }
        }
        ReviewServices.getReviewById(movieID: selectedMovieID, pageNum: 1) {[weak self] (responseModel, error) in
            guard let self =  self else {return}
            if responseModel != nil && error == nil{
                self.reviewArr = responseModel!
                DispatchQueue.main.async {
                    self.reviewCollectionView.reloadData()
                }
            }
        }
        checkIsFavourite()
    }
    
    private func updateUI(){
        movieTitleLabel.text = selectedMovie.getOriginal_title()
        releaseDateLabel.text = selectedMovie.getRelease_date()
        rateLabel.text = "\(selectedMovie.getVote_average()) / 10"
        overviewTxt.text = selectedMovie.getOverview()
        movieImg.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w185/\(selectedMovie.getPoster_path())"),placeholderImage: UIImage(named: "popcorn"),completed: nil)
        starsCosmos.settings.fillMode = .precise
        starsCosmos.rating = selectedMovie.getVote_average() / 2
    }
    
    private func getTrailers(){
        TrailerServices.getTrailers(movieID: selectedMovieID) {[weak self] (responseModel, error) in
            guard let self =  self else {return}
            if responseModel != nil && error == nil{
                self.trailersArr = responseModel!
            }
            self.trailersTable.isHidden = false
            self.trailersTable.reloadData()
        }
    }
    
    @discardableResult
    private func checkIsFavourite() -> [FavoriteMovies]{
        let arr = CoreDataHandler.checkforSpecificItemFromCoreData(movieID: Int64(selectedMovieID))
        if arr.isEmpty{
            favouriteBtn.setTitle("+  Add to favourites", for: .normal)
            isFavourite =  false
        }
        else{
            favouriteBtn.setTitle("x Remove from favourites", for: .normal)
            isFavourite = true
        }
        return arr
    }
    
    @IBAction private func addToFavBtnPressed(_ sender: UIButton)
    {
        coreMovie = checkIsFavourite()
        if isFavourite{
            showAlertView(message: "Are you sure want to delete movie from favourites")
            
        }
        else{
            let favMovie = FavoriteMovies(context: CoreDataHandler.getCoreDataobject())
            favMovie.id = Int64(selectedMovie.getID())
            favMovie.original_title = selectedMovie.getOriginal_title()
            favMovie.overview = selectedMovie.getOverview()
            favMovie.release_date = selectedMovie.getRelease_date()
            favMovie.vote_average = selectedMovie.getVote_average()
            favMovie.poster_path = selectedMovie.getPoster_path()
            CoreDataHandler.saveIntoCoreData(movieItem: favMovie)
            favouriteBtn.setTitle("x Remove from favourites", for: .normal)
        }
    }
    private func showAlertView(message: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Delete", style: .destructive) {[weak self] (action) in
            guard let self = self else {return}
            CoreDataHandler.deleteObjectFromCoreData(movieItem: self.coreMovie[0])
            self.favouriteBtn.setTitle("+  Add to favourites", for: .normal)
        }
        let action2 = UIAlertAction(title: "Cancel", style: .default) {[weak self] (action) in
            self?.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action1)
        alert.addAction(action2)
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension MovieDetailsVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if trailersArr.isEmpty{
            tableView.setEmptyView(title: "No trailers found", message: "", messageImage: #imageLiteral(resourceName: "popcorn"))
        }
        else {
            tableView.restore()
        }
        return trailersArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = trailersArr[indexPath.row].getName()
        cell.textLabel?.numberOfLines = 0
        cell.imageView?.image = UIImage(named: "youtube")
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return "Trailers"
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        guard let url = URL(string: "https://www.youtube.com/watch?v=\(trailersArr[indexPath.row].getKey())") else {return}
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
}

extension MovieDetailsVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if reviewArr.isEmpty{
            collectionView.setEmptyMessage("No reviews found")
        }
        else{
            collectionView.restore()
        }
        
        return reviewArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as? ReviewCell else{
            print("can't get")
            return UICollectionViewCell()
        }
        let auther = self.reviewArr[indexPath.row].getAuther()
        let review =  self.reviewArr[indexPath.row].getContent()
        cell.configureCell(auther: auther, review: review)
        return cell
    }
}
