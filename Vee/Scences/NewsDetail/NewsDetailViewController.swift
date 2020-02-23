//
//  NewsDetailViewController.swift
//  News
//
//  Created by Trung Vu on 2/7/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit
import WebKit

class NewsDetailViewController: BaseViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var url: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: url) {
            webView.load(URLRequest(url: url))
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
