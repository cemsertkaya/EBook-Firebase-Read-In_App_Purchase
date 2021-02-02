//
//  CurrentUser.swift
//  EBOOKAPP
//
//  Created by Cem Sertkaya on 2.02.2021.
//

import Foundation

 class CurrentUser
{
    private var userId: String
    private var email: String
    private var age: String
    private var country: String
    private var language: String
    private var gender: String
    
    
    init(userId:String, email:String, age:String, country:String, language:String, gender:String)
    {
        self.userId = userId
        self.email = email
        self.age = age
        self.country = country
        self.language = language
        self.gender = gender
    }
    
    init()
    {
        userId = String()
        email = String()
        age = String()
        country = String()
        language = String()
        gender = String()
    }
    
    func setUserId(userId : String) {self.userId = userId}
    func setEmail(email : String) {self.email = email}
    func setAge(age: String) {self.age = age}
    func setCountry(country : String) {self.country = country}
    func setLanguage(language : String) {self.language = language}
    func setGender(gender : String) {self.gender = gender}
    
    func getUserId() -> String {return self.userId}
    func getEmail() -> String {return self.email}
    func getAge() -> String {return self.age}
    func getCountry() -> String {return self.country}
    func getLanguage() -> String {return self.language}
    func getGender() -> String {return self.gender}
    
    func toString() -> String
    {
        let toString = getUserId() + getEmail() + getAge() + getCountry() + getLanguage() + getGender()
        return toString
    }
}
