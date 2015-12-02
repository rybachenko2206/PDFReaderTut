//
//  DetailViewController.swift
//  PDFReaderTut
//
//  Created by Roman Rybachenko on 12/1/15.
//  Copyright © 2015 Roman Rybachenko. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet var backBarButtonItem: UIBarButtonItem!
    @IBOutlet var infoBarButtonItem: UIBarButtonItem!
    
    // MARK: Properties
    var pdfDocUrl: NSURL!
    
    // MARK: overriden functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPDF()
        self.navigationItem.leftBarButtonItems = [backBarButtonItem, infoBarButtonItem]
    }
    
    
    // MARK: Action functions
    @IBAction func back(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func info(sender: AnyObject) {
    }
    
    
    // MARK: Class functions
    class func storyboardIdentifier() -> String {
        return String(DetailViewController)
    }
    
    
    // MARK: Private functions
    private func loadPDF() {
        let urlRequest = NSURLRequest(URL: pdfDocUrl)
        webView.loadRequest(urlRequest)
    }
}
