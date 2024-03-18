//
//  MenuViewController.swift
//  CopPrueba
//
//  Created by selftisingmacmini on 29/2/24.
//

import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    func didSelect(menuItem: MenuViewController.MenuOptions)
}


class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    weak var delegate: MenuViewControllerDelegate?
    
    
    enum MenuOptions: String, CaseIterable {
        
        case db = "Dashboard"
        case perf = "Perfil"
        case not = "Lista Notificaciones"
        case lg = "Logout"
    
        //Para añadir una imagen diferente a cada línea
        //var imageName: String {
            //switch self {
            //case .db:
                //return "pizarra" debe ser un nombre valido de la librería
            //case .perf:
                //return "perfil"
            //case .not:
                //return "notificaciones"
            //case .lg:
                //return "logout"
            //}
        //}
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor(red: 32/255.0, green: 33/255.0, blue: 33/250.0, alpha: 1)
        //view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        
       
    }
    
    /*override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: 750)
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
        //Para añadir a cada fila la iamgen correspondiente
        //cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName )
        cell.imageView?.image = UIImage(systemName: "pencil")
        cell.imageView?.tintColor = .white
        cell.backgroundColor = .gray
        cell.contentView.backgroundColor = .gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
    


}
