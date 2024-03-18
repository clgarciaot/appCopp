//
//  HomeViewController.swift
//  CopPrueba
//
//  Created by selftisingmacmini on 29/2/24.
//

import UIKit

struct APIResponse: Codable{
    let total: Int
    let total_pages: Int
    let results: [Result]
}

struct Result: Codable{
    let id: String
    let urls: URLS
}

struct URLS: Codable{
    let regular: String
}

protocol HomeViewControllerDelegate: AnyObject {
    
    func didTapMenuButton()
}

class HomeViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate{
    
    weak var delegate: HomeViewControllerDelegate?
    
    @IBOutlet var collectionView: UICollectionView!
    
    var results: [Result] = []
    
    let searchBar = UISearchBar()
    
    var items: [UIBarButtonItem]?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "Dashboard"
        view.addSubview(searchBar)
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageCollectionCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionCollectionViewCell.identifier )
        
        items = [UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .done, target: self, action: #selector(didTapMenuButton)),UIBarButtonItem(title: "Dashboard", style: .done, target: self, action: nil)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image:  UIImage(named: "logo-beetrick"), style: .done, target: self, action: nil)
        navigationItem.setLeftBarButtonItems(items, animated: true)
        
    }
    
  
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchBar.frame = CGRect(x: 10, y: view.safeAreaInsets.top, width: view.frame.size.width-20 , height: 50)
    }
    
    @objc func didTapMenuButton(){
        
        delegate?.didTapMenuButton()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text{
            results = []
            collectionView?.reloadData()
            fetchPhotos(query: text)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let imageURLString = results[indexPath.row].urls.regular
        
        guard let cell = collectionView.dequeueReusableCell (
            withReuseIdentifier: ImageCollectionCollectionViewCell.identifier, for: indexPath)
                as? ImageCollectionCollectionViewCell else {
                return UICollectionViewCell()
                }
        cell.configure(with: imageURLString)
        return cell
    }
    
    func fetchPhotos(query: String){
        
        let urlString = "https://api.unsplash.com/search/photos?page=1&per_page=30&query=\(query)&client_id=_xxvYH9kjAt2_QAuVcOOIP3WwIC0t-ThaTYj7466icU"
        
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ [weak self] data,  _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.results = jsonResult.results
                    self?.collectionView.reloadData()
                }
            }
            catch{
                print(error)
            }
            
        }
        task.resume()
    }

}
