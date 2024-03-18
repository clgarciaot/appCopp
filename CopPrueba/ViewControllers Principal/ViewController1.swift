//
//  ViewController1.swift
//  CopPrueba
//
//  Created by selftisingmacmini on 29/2/24.
//

import UIKit

class ViewController1: UIViewController {
    enum MenuState{
        case opened
        case closed
    }
    
    static let identifier = "vc1"
    
    private var menuState: MenuState = .closed
    
    
    
    let story = UIStoryboard(name: "Main", bundle: nil)
    
    
    var navVc: UINavigationController?
    
    lazy var notifVc = NotViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVCs()
    }
    
    private func addChildVCs(){
        
        //Menu
        let menuVc = story.instantiateViewController(withIdentifier: "menuVc") as! MenuViewController
        menuVc.delegate = self
        addChild(menuVc)
        view.addSubview(menuVc.view)
        menuVc.didMove(toParent: self)
        
        
        //Home
        let homeVc = story.instantiateViewController(withIdentifier: "homevc") as! HomeViewController
        homeVc.delegate = self
        let navVc = UINavigationController(rootViewController: homeVc)
        addChild(navVc)
        view.addSubview(navVc.view)
        navVc.didMove(toParent: self)
        self.navVc = navVc
        
       
        
    }


}

extension ViewController1: HomeViewControllerDelegate, NotViewControllerDelegate, PerfilViewControllerDelegate{
    
    func didTapMenuButton() {
        
        toogleMenu(completion: nil)
    
    }
    func toogleMenu(completion: (() -> Void)?){
        
        switch menuState {
            case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,options: .curveEaseInOut){
                //let homeVc = self.story.instantiateViewController(withIdentifier: "homevc") as! HomeViewController
                self.navVc?.view.frame.origin.x = 270
                
                
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                    
                }
            }
            case.opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,options: .curveEaseInOut){
                
                self.navVc?.view.frame.origin.x = 0
                
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                    
                }
            }
            break
        }
        
    }
}

extension ViewController1: MenuViewControllerDelegate{
    
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        toogleMenu{ [weak self] in
            switch menuItem {
                
            case .db:
                self?.toDb()
            case .perf:
                self?.toPr()
            case .not:
                //self?.showNotifications(viewController: UIViewController.self, storyBoardId: "Main")
                self?.toNot()
            case .lg:
                let story = UIStoryboard(name: "Main", bundle: nil)
                let viewCa = story.instantiateViewController(withIdentifier: "loginVc")
                viewCa.modalPresentationStyle = .fullScreen
                self?.present(viewCa, animated: true)
            }
        }
    }
    
    func toNot(){
        //let homeVc = story.instantiateViewController(withIdentifier: "homevc") as! HomeViewController
        
        self.navVc?.view.removeFromSuperview()
        self.navVc?.removeFromParent()
        
        let viewCB = story.instantiateViewController(withIdentifier: "notifVc") as! NotViewController
        
        viewCB.delegate = self
        let navVc = UINavigationController(rootViewController: viewCB)
        addChild(navVc)
        view.addSubview(navVc.view)
        navVc.didMove(toParent: self)
        self.navVc = navVc
    
        
    }
    
    func toDb(){
        //let homeVc = story.instantiateViewController(withIdentifier: "homevc") as! HomeViewController
        
        self.navVc?.view.removeFromSuperview()
        self.navVc?.removeFromParent()
        
        let viewCB = story.instantiateViewController(withIdentifier: "homevc") as! HomeViewController
        
        viewCB.delegate = self
        let navVc = UINavigationController(rootViewController: viewCB)
        addChild(navVc)
        view.addSubview(navVc.view)
        navVc.didMove(toParent: self)
        self.navVc = navVc
    
        
    }
    
    func toPr(){
        //let homeVc = story.instantiateViewController(withIdentifier: "homevc") as! HomeViewController
        
        self.navVc?.view.removeFromSuperview()
        self.navVc?.removeFromParent()
        
        let viewCB = story.instantiateViewController(withIdentifier: "perfil") as! PerfilViewController
        
        viewCB.delegate = self
        let navVc = UINavigationController(rootViewController: viewCB)
        addChild(navVc)
        view.addSubview(navVc.view)
        navVc.didMove(toParent: self)
        self.navVc = navVc
    
        
    }
   
    
    

}
