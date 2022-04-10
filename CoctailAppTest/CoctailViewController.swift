//
//  CoctailViewController.swift
//  CoctailAppTest
//
//  Created by Сергей Горячев on 07.04.2022.
//

import UIKit
import SnapKit

final class CoctailViewController: UIViewController  {
    
    private var drinks = Drink()
    
    let scrollView = UIScrollView()
    
    let tagsCloud = TagsCloud()
    let networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        networkService.getDrinks() { [weak self] drinks in
            self?.drinks = drinks
            guard let scrollView = self?.scrollView else { return }
            guard let drinks = self?.drinks else { return }
            self?.tagsCloud.createTagCloud(OnView: scrollView, withArray: drinks as Drink)
        }
        
        setttingsScrollView()
    }
    
    func setttingsScrollView() {
        
        self.scrollView.frame = self.view.bounds
        self.view.addSubview(self.scrollView)
        self.scrollView.contentSize = CGSize(width: self.scrollView.bounds.width, height: 2 * self.scrollView.bounds.height)
    }
}


