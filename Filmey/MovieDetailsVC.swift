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
    
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var overviewTxt: UITextView!
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var trailersTable: UITableView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var starsCosmos: CosmosView!
    var isFavourite = false
    var selectedMovie: MovieModel!
    var trailer = TrailerServices()
    var trailersArr = [TrailerData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getTrailers()
        trailersTable.tableFooterView = UIView()
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        movieTitleLabel.text = selectedMovie.original_title
        releaseDateLabel.text = selectedMovie.release_date
        rateLabel.text = "\(selectedMovie.vote_average) / 10"
        overviewTxt.text = selectedMovie.overview
        movieImg.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w185/\(selectedMovie.poster_path)"), placeholderImage: UIImage(named: "popcorn"),completed: nil)
        starsCosmos.settings.fillMode = .precise
        starsCosmos.rating = selectedMovie.vote_average / 2
        if trailersArr.isEmpty
        {
            trailersTable.isHidden = true
        }else
        {
            trailersTable.isHidden = false
            
        }
        checkIsFavourite()
        
    }
    func getTrailers()
    {
        trailer.getTrailers(movieID: selectedMovie.id) { (responseModel, error) in
            if responseModel.isEmpty == false && error == nil
            {
                for i in 0..<responseModel.count
                {
                    if responseModel[i].site == "YouTube" && responseModel[i].type == "Trailer"
                    {
                        self.trailersArr.append(responseModel[i])
                    }
                    
                }
                DispatchQueue.main.async
                    {
                        self.trailersTable.reloadData()
                        
                }
            }
            
        }
        
    }
    func checkIsFavourite() -> [FavouriteMovies]
    {
        let arr = CoreDataHandler.checkforSpecificItemFromCoreData(movieID: Int64(selectedMovie.id))
        if arr.isEmpty
        {
            favouriteBtn.setTitle("+  Add to favourites", for: .normal)
            isFavourite =  false
        }
        else
        {
            favouriteBtn.setTitle("x Remove from favourites", for: .normal)
            isFavourite = true
            
        }
        return arr
    }
    
    @IBAction func addToFavBtnPressed(_ sender: UIButton)
    {
       let coreMovie = checkIsFavourite()
        if isFavourite
        {
            let _ = CoreDataHandler.deleteObjectFromCoreData(movieItem: coreMovie[0]) ?? []
            favouriteBtn.setTitle("+  Add to favourites", for: .normal)

        }
        else
        {
            let favMovie = FavouriteMovies(context: CoreDataHandler.getCoreDataobject())
            favMovie.id = Int64(selectedMovie.id)
            favMovie.original_title = selectedMovie.original_title
            favMovie.overview = selectedMovie.overview
            favMovie.release_date = selectedMovie.release_date
            favMovie.vote_average = selectedMovie.vote_average
            favMovie.poster_path = selectedMovie.poster_path
            CoreDataHandler.saveIntoCoreData(movieItem: favMovie)

            favouriteBtn.setTitle("x Remove from favourites", for: .normal)

        }
        
        //        if favouriteBtn.titleLabel?.text == "+  Add to favourites" && CoreDataHandler.checkforSpecificItemFromCoreData(movieID: selectedMovie.id)
        //        {
        //            favouriteBtn.setTitle("x Remove from favourites", for: .normal)
        //
        //            CoreDataHandler.saveIntoCoreData(movieItem: favMovie)
        //
        //        }else if favouriteBtn.titleLabel?.text == "x Remove from favourites"
        //
        //        {
        //            favouriteBtn.setTitle("+  Add to favourites", for: .normal)
        //     CoreDataHandler.deleteObjectFromCoreData(movieItem: favMovie) ?? []
        //            print("aaaa")
        //        }
        //
        
    }
    
    
    
    
}
extension MovieDetailsVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trailersArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = trailersArr[indexPath.row].name
        cell.textLabel?.numberOfLines = 0
        cell.imageView?.image = UIImage(named: "youtube")
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Trailers"
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: "https://www.youtube.com/watch?v=\(trailersArr[indexPath.row].key)") else {return}
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    
}
