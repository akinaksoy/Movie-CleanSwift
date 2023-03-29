//
//  BaseViewController.swift
//  BeinSports
//
//  Created by Akın Aksoy on 28.03.2023.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func configure(title : String) {
        self.title = title
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = UIColor.black
        view.backgroundColor = UIColor.black
    }
    
}
