//
//  PerfilViewController.swift
//  CopPrueba
//
//  Created by selftisingmacmini on 1/3/24.
//

import UIKit

protocol PerfilViewControllerDelegate: AnyObject {
    
    func didTapMenuButton()
}


class PerfilViewController: UIViewController {
    
    weak var delegate: PerfilViewControllerDelegate?
    
    var items: [UIBarButtonItem]?

    override func viewDidLoad() {
        super.viewDidLoad()

        items = [UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .done, target: self, action: #selector(didTapMenuButton)),UIBarButtonItem(title: "Perfil", style: .done, target: self, action: nil)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image:  UIImage(named: "logo-beetrick"), style: .done, target: self, action: nil)
        navigationItem.setLeftBarButtonItems(items, animated: true)
        
    }
    

    
    @objc func didTapMenuButton(){
        
        delegate?.didTapMenuButton()
        
    }

}
