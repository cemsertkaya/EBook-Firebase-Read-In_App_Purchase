//
//  PdfReaderController.swift
//  EBOOKAPP
//
//  Created by Cem Sertkaya on 28.01.2021.
//

import UIKit
import PDFKit


class PdfReaderController: UIViewController {

    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var viewMain: PDFView!
    @IBOutlet weak var label: UILabel!
    var isLocked = false //if user presses stop button, pdf is locked on the page
    var document = PDFDocument()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Pdf demo
        //label.text = pdfView.currentPage?.pageRef.pageNumber.stringValue
        
        //pdfView = PDFView(frame: self.viewMain.bounds)
        //pdfView.autoScales = true
        //pdfView.displayMode = .singlePageContinuous
        //pdfView.usePageViewController(true)
        //viewMain.addSubview(pdfView)
        guard let path = Bundle.main.url(forResource: "resume", withExtension: "pdf")
        else {return}
        document = PDFDocument(url:path)!
        viewMain.document = document
        /*viewMain.autoScales = true
        viewMain.usePageViewController(true)
        viewMain.displayMode = PDFDisplayMode.singlePage
        viewMain.displayDirection = .vertical
        viewMain.maxScaleFactor = 4.0
        viewMain.minScaleFactor = viewMain.scaleFactorForSizeToFit*/
        //viewMain.autoresizesSubviews = true
        viewMain.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleLeftMargin]
        viewMain.displayDirection = .vertical
        viewMain.autoScales = true
        viewMain.displayMode = .singlePageContinuous
        viewMain.usePageViewController(true)
        viewMain.displaysPageBreaks = true
        viewMain.maxScaleFactor = 4.0
        viewMain.minScaleFactor = viewMain.scaleFactorForSizeToFit
        viewMain.backgroundColor = UIColor.white
        //viewMain.setValue(true, forKey: "forcesTopAlignment")
        
        //viewMain.scaleFactor = 1.0
        
    }
    
    @IBAction func stopButtonAction(_ sender: Any)
    {
        if(!isLocked)
        {
            isLocked = true
            //let currentPageIndex = document.index(for: pdfView.currentPage!)
            //label.text = String(currentPageIndex)
        }
        else
        {
            isLocked = false
            
        }
    }
    

    
}
