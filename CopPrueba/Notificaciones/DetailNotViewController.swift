//
//  DetailNotViewController.swift
//  CopPrueba
//
//  Created by selftisingmacmini on 4/3/24.
//

import UIKit

class DetailNotViewController: UIViewController, UINavigationBarDelegate {

    
    @IBOutlet var navBar: UINavigationBar!
    
    @IBOutlet var navItem: UINavigationItem!
    
    
    @IBOutlet var titleLabel: UILabel!
    
    
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    
    var titleLabelText: String?
    var descriptionLabelText: String?
    var imagePlaceFinal: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.delegate = self
        navItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(didTapButton))
        navItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "logo-beetrick"), style: .done, target: self, action: nil)
        
        titleLabel.text = titleLabelText
        descriptionLabel.text = "Un texto es una composición de signos codificados en un sistema de escritura que forma una unidad de sentido. También es una composición de caracteres imprimibles (con grafema) generados por un algoritmo de cifrado que, aunque no tienen sentido para cualquier persona, sí puede ser descifrado por su destinatario original. En otras palabras, un texto es un entramado de signos con una intención comunicativa que adquiere sentido en determinado contexto. Las ideas que comunica un texto están contenidas en lo que se suele denominar «macroproposiciones», unidades estructurales de nivel superior o global, que otorgan coherencia al texto constituyendo su hilo central, el esqueleto estructural que cohesiona elementos lingüísticos formales de alto nivel, como los títulos y subtítulos, la secuencia de párrafos, etc. En contraste, las «microproposiciones» son los elementos coadyuvantes de la cohesión de un texto, pero a nivel más particular o local. Esta distinción fue realizada por Teun van Dijk en 1980."
        imageView.image = imagePlaceFinal
    }
    
    @objc func didTapButton(){
        self.dismiss(animated: true, completion: nil)
    }
    
   

}
