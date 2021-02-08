//
//  Book.swift
//  EBOOKAPP
//
//  Created by Cem Sertkaya on 9.02.2021.
//

import Foundation
 class Book
 {
    private var mainId : String
    private var languageId : String
    private var languageTitle : String

    init(mainId:String, languageId:String, languageTitle:String)
    {
        self.mainId = mainId
        self.languageId = languageId
        self.languageTitle = languageTitle
    }
    
    func getMainId() -> String
    {
        self.mainId
    }
    
    func getLanguageId() -> String
    {
        self.languageId
    }
    
    func getLanguageTitle() -> String
    {
        self.languageTitle
    }
    
    func toString() -> String
    {
        let toString = getMainId() + getLanguageId() + getLanguageTitle()
        return toString
        
    }
 }

