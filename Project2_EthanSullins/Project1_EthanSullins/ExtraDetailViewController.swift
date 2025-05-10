//
//  ExtraDetailViewController.swift
//  Project1_EthanSullins
//
//  Created by Ethan Sullins on 12/4/24.
//

import Foundation
import UIKit
import WebKit

class ExtraDetailController: UIViewController {
    
    @IBOutlet weak var WVmlbbracket: WKWebView!
    @IBOutlet weak var AED1: UIScrollView!
    @IBOutlet weak var AED2: UIScrollView!
    
    func setLabels() {
        // decorate boxes
        AED1.layer.cornerRadius = 10
        AED1.layer.borderWidth = 1
        AED1.layer.borderColor = UIColor.darkGray.cgColor
        
        AED2.layer.cornerRadius = 10
        AED2.layer.borderWidth = 1
        AED2.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
        let url = URL(string: "https://www.espn.com/mlb/playoff-bracket")!
        let request = URLRequest(url: url)
        WVmlbbracket.load(request)
    }
}
