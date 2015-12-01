//
//  ReaderPDFViewController.swift
//  PDFReaderTut
//
//  Created by Roman Rybachenko on 11/30/15.
//  Copyright © 2015 Roman Rybachenko. All rights reserved.
//

import UIKit
import CoreGraphics

class ReaderPDFViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ReaderViewControllerDelegate {
    // MARK: Properties
    var documents: Array <ReaderDocument> = [ReaderDocument]()
    
    // MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: Override funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        fetchAllDocuments()
    }
    
    
    // MARK: Delegate funcs:
    // MARR: -UICollectionViewDataSource

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return documents.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(FileIconCell.cellIdentifier(), forIndexPath: indexPath) as! FileIconCell
        
        cell.setDocument(documents[indexPath.row])
        
        return cell
    }
    
    // MARK: -UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let document = documents[indexPath.row]
        
        let readerVC: ReaderViewController = ReaderViewController(readerDocument: document)
        readerVC.delegate = self
        readerVC.modalTransitionStyle = .CrossDissolve
        readerVC.modalPresentationStyle = .FullScreen
        self.presentViewController(readerVC, animated:true, completion: nil)
    }
    
    
    // MARK: -ReaderViewControllerDelegate
    
    func dismissReaderViewController(viewController: ReaderViewController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Private funcs
    
    private func fetchAllDocuments() {
        let file1 = NSBundle.mainBundle().pathForResource("paypaking - booking-v1", ofType: "pdf")
        let readerDoc1 = ReaderDocument(filePath: file1, password: nil)
        if readerDoc1 != nil {
            documents.append(readerDoc1)
        }
        
        let file2 = NSBundle.mainBundle().pathForResource("Specifications EDIT", ofType: "pdf")
        let readerDoc2 = ReaderDocument(filePath: file2, password: nil)
        if readerDoc2 != nil {
            documents.append(readerDoc2)
        }
        
        let file3 = NSBundle.mainBundle().pathForResource("5. Annotations", ofType: "pdf")
        let readerDoc3 = ReaderDocument(filePath: file3, password: nil)
        if readerDoc3 != nil {
            documents.append(readerDoc3)
        }
    }
}
