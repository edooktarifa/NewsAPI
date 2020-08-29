//
//  ViewController.swift
//  NewsApi
//
//  Created by Lawencon on 27/08/20.
//  Copyright © 2020 Lawencon. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class NewsViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBars: UISearchBar!
    
    var showAllData : [NewsModel] = []
    var searchNews : [[Articles]] = []
    
    var presenter: NewsViewToPresenterProtocol?
    
    var searching = false
    var search = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NewsWireframe.createModule(news: self)
        tableView.register(UINib(nibName: "NewsCellTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsCellTableViewCell")
        searchBars.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.showSpinner(onView: self.view)
        presenter?.startFetching(data: newsListRequest.newsParam(q: "bitcoin", from: "2020-08-26", sortBy: "publishedAt", apiKey: "c766e9bd546f46f096873d6b0d53e471"))
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        if searching{
            return searchNews.count
        }else{
            return showAllData.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchNews[section].count
        }else{
            return showAllData[section].articles?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCellTableViewCell", for: indexPath) as! NewsCellTableViewCell
        
        if searching{
            
            cell.authorLbl.text = searchNews[indexPath.section][indexPath.row].author ?? "No name"
            
            let url = URL(string: searchNews[indexPath.section][indexPath.row].urlToImage ?? "")
            cell.imgView.kf.setImage(with: url, placeholder: UIImage(named: "noImages"), options: [.transition(ImageTransition.fade(1)), .scaleFactor(UIScreen.main.scale), .cacheOriginalImage], progressBlock: nil, completionHandler: nil)
            cell.imgView.kf.indicatorType = .activity
            cell.titleLbl.text = searchNews[indexPath.section][indexPath.row].title
        }else{
            cell.authorLbl.text = showAllData[indexPath.section].articles?[indexPath.row].author ?? "No name"
            let url = URL(string: showAllData[indexPath.section].articles?[indexPath.row].urlToImage ?? "")
            cell.imgView.kf.setImage(with: url, placeholder: UIImage(named: "noImages"), options: [.transition(ImageTransition.fade(1)), .scaleFactor(UIScreen.main.scale), .cacheOriginalImage], progressBlock: nil, completionHandler: nil)
            cell.imgView.kf.indicatorType = .activity
            cell.titleLbl.text = showAllData[indexPath.section].articles?[indexPath.row].title
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailNewsViewController") as! DetailNewsViewController
        
        if searching{
            vc.urlDetail = searchNews[indexPath.section][indexPath.row].url
        }else{
            vc.urlDetail = showAllData[indexPath.section].articles?[indexPath.row].url
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 10
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.isEmpty == true{
            searching = false
            tableView.reloadData()
        }else{
         searchNews = showAllData.compactMap{$0.articles?.filter{$0.author?.localizedCaseInsensitiveContains(searchBar.text!) ?? true || $0.title?.localizedCaseInsensitiveContains(searchBar.text!) ?? true}}
            
            searching = true
            tableView.reloadData()
        }
    }
    
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.searchBars.endEditing(true)
    }

}

extension NewsViewController: NewsPresenterToViewProtocol{
    func showData(data: [NewsModel]) {
        self.removeSpinner()
        showAllData = data
        tableView.reloadData()
        
    }
    
    func displayError(message: String) {
        self.removeSpinner()
        AlertView.showAlert(view: self, title: "Error", message: message)
        
    }
    
}
