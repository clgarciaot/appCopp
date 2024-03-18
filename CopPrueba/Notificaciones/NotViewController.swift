//
//  NotViewController.swift
//  CopPrueba
//
//  Created by selftisingmacmini on 4/3/24.
//

import UIKit

protocol NotViewControllerDelegate: AnyObject {
    
    func didTapMenuButton()
}

struct NoticiasModelo: Codable{
    
    let articles: [Noticia]
}

struct Noticia: Codable{
    let title: String
    let description: String
    let url: String?
    let urlToImage: String?
}

class NotViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet var tableView: UITableView!
    
    weak var delegate: NotViewControllerDelegate?
    
    var message: [Noticia] = []
    
    var items: [UIBarButtonItem]?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Notificaciones"

        items = [UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .done, target: self, action: #selector(didTapMenuButton)),UIBarButtonItem(title: "Notificaciones", style: .done, target: self, action: nil)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image:  UIImage(named: "logo-beetrick"), style: .done, target: self, action: nil)
        navigationItem.setLeftBarButtonItems(items, animated: true)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        buscarNoticias()
        
    }
    
    @objc func didTapMenuButton(){
        delegate?.didTapMenuButton()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaNoticia", for: indexPath)
        cell.textLabel?.text = message[indexPath.row].title
        //cell.detailTextLabel?.text = message[indexPath.row].description
        let story = UIStoryboard(name: "Main", bundle: nil)
        let viewCB = story.instantiateViewController(withIdentifier: "detailNot") as! DetailNotViewController
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        buscarNoticias()
        let story = UIStoryboard(name: "Main", bundle: nil)
        let viewCB = story.instantiateViewController(withIdentifier: "detailNot") as! DetailNotViewController
        viewCB.modalPresentationStyle = .fullScreen
        viewCB.titleLabelText = message[indexPath.row].title
        viewCB.descriptionLabelText = message[indexPath.row].description
        if let url = URL (string: message[indexPath.row].urlToImage ?? ""){
            if let imageData = try? Data(contentsOf: url){
                viewCB.imagePlaceFinal = UIImage(data: imageData)
            }
        }
    
        //self.performSegue(withIdentifier: "ViewToDetails", sender: self)
        self.present(viewCB, animated: true)
    }
    
    func buscarNoticias(){
        
        let urlString = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=51bf528c3acb4f94bb9bdb44f56c22fd"
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url){
                let decodificador = JSONDecoder()
                if let datosDecodificados = try? decodificador.decode(NoticiasModelo.self, from: data){
                    message = datosDecodificados.articles
                    tableView.reloadData()
                }
            }
        }
    }
}
