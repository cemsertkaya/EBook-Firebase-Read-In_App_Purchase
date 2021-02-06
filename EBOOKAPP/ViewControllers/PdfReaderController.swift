//
//  PdfReaderController.swift
//  EBOOKAPP
//
//  Created by Cem Sertkaya on 28.01.2021.
//

import UIKit
import PDFKit


class PdfReaderController: UIViewController {

    @IBOutlet weak var viewSub: UIView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Pdf demo
        let pdfView = PDFView()
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        viewSub.addSubview(pdfView)
        pdfView.leadingAnchor.constraint(equalTo: viewSub.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: viewSub.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: viewSub.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: viewSub.safeAreaLayoutGuide.bottomAnchor).isActive = true
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        guard let path = Bundle.main.url(forResource: "sample", withExtension: "pdf")
        else {return}
        let document = PDFDocument(url:path)
        pdfView.document = document

    }
    

    
}
