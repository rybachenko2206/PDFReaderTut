//
//  FileIconCell.swift
//  PDFReaderTut
//
//  Created by Roman Rybachenko on 11/30/15.
//  Copyright © 2015 Roman Rybachenko. All rights reserved.
//

import UIKit
import Foundation

class FileIconCell: UICollectionViewCell {
    //MARK: Outlets
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    //MARK: Interface funcs
    func setDocument(document: ReaderDocument) {
        let image = getThumbnail(document.fileURL, pageNumber: 1)
        iconImageView.image = image
    }
    
    // MARK: Class methods
    class func cellIdentifier() -> String {
        return String(FileIconCell)
    }
    
    //MARK: Private funcs
    
    private func getThumbnail(url:NSURL, pageNumber:Int) -> UIImage {
        
        let pdf:CGPDFDocumentRef = CGPDFDocumentCreateWithURL(url as CFURLRef)!;
        
        let firstPage = CGPDFDocumentGetPage(pdf, pageNumber)
        
        let width:CGFloat = iconImageView.frame.size.width;
        
        var pageRect:CGRect = CGPDFPageGetBoxRect(firstPage, CGPDFBox.MediaBox);
        let pdfScale:CGFloat = width/pageRect.size.width;
        pageRect.size = CGSizeMake(pageRect.size.width*pdfScale, pageRect.size.height*pdfScale);
        pageRect.origin = CGPointZero;
        
        UIGraphicsBeginImageContext(pageRect.size);
        
        let context:CGContextRef = UIGraphicsGetCurrentContext()!;
        
        // White BG
        CGContextSetRGBFillColor(context, 1.0,1.0,1.0,1.0);
        CGContextFillRect(context,pageRect);
        
        CGContextSaveGState(context);
        
        // ***********
        // Next 3 lines makes the rotations so that the page look in the right direction
        // ***********
        CGContextTranslateCTM(context, 0.0, pageRect.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextConcatCTM(context, CGPDFPageGetDrawingTransform(firstPage, .MediaBox, pageRect, 0, true));
        
        CGContextDrawPDFPage(context, firstPage);
        CGContextRestoreGState(context);
        
        let thm:UIImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        return thm;
    }

}
