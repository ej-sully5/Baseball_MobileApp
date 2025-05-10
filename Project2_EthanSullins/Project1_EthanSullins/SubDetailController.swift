//
//  SubDetailController.swift
//  Project1_EthanSullins
//
//  Created by Ethan Sullins on 12/3/24.
//

import Foundation
import UIKit
import WebKit

class SubDetailController: UIViewController {
    
    @IBOutlet weak var WVmlbsite: WKWebView!
    @IBOutlet weak var A1: UIScrollView!
    
    func setLabels() {
        // decorate boxes
        A1.layer.cornerRadius = 10
        A1.layer.borderWidth = 1
        A1.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
        let url = URL(string: "https://www.mlbshop.com")!
        let request = URLRequest(url: url)
        WVmlbsite.load(request)
    }
}

