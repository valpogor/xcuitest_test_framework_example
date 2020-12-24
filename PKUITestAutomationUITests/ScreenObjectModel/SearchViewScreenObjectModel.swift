//
//  SearchViewScreenObjectModel.swift
//  PKUITestAutomationUITests
//
//  Created by Val Po on 11/13/20.
//  Copyright © 2020 T-Mobile Inc. All rights reserved.
//

import XCTest

class ContentScreenObjectModel {
    public static let app = XCUIApplication()
    public static let tablesQuery = app.tables
    public static let elementsQuery = app.scrollViews.otherElements
        
    enum LoginField {
        static let userField = app.textFields["Enter email"]
        static let passwordField = app.secureTextFields["Enter password"]
    }
    
    enum SettingField {
        static let name = tablesQuery.textFields["Enter Name"]
        static let profession = tablesQuery.textFields["Enter Profession"]
        static let age = tablesQuery.textFields["Enter Age"]
        static let bio = tablesQuery.textFields["Enter Bio"]
    }
    
    enum Buttons {
        static let login = app.buttons["Login"]
        static let cancel = app.buttons["Cancel"]
        static let logout = app.buttons["Logout"]
        static let albums = app.buttons["Albums"]
        static let seeall = app.buttons["See All"]
        static let save = app.buttons["Save"]
        static let selectPhoto1 = tablesQuery.children(matching: .button).matching(identifier: "Select Photo").element(boundBy: 0).staticTexts["Select Photo"]
        static let selectPhoto2 = tablesQuery.children(matching: .button).matching(identifier: "Select Photo").element(boundBy: 1).staticTexts["Select Photo"]
        static let selectPhoto3 = tablesQuery.children(matching: .button).matching(identifier: "Select Photo").element(boundBy: 2).staticTexts["Select Photo"]
        static let cancel2 = tablesQuery.children(matching: .button).matching(identifier: "Cancel").element(boundBy: 0).staticTexts["Cancel"]
    }
    
    enum Images {
        static let image1 = elementsQuery.images["Photo, March 30, 2018, 12:14 PM"]
        static let image2 = elementsQuery.images["Photo, August 08, 2012, 2:55 PM"]
        static let image3 = elementsQuery.images["Photo, August 08, 2012, 2:29 PM"]
    }
    
    enum Text {
        static let success = app.staticTexts["Success!!!"]
        static let min18 = tablesQuery.staticTexts["Min 18"]
        static let max99 = tablesQuery.staticTexts["Max 99"]

    }
    
    static func login(){
        insertEmail(email: "admin@tmobile.com")
        insertPassword(password: "HApPy_Path1")
        Buttons.login.tap()
    }
    
    static func insertEmail(email: String) {
        LoginField.userField.tap()
        LoginField.userField.typeText(email)
    }
    
    static func insertPassword(password: String) {
        LoginField.passwordField.tap()
        LoginField.passwordField.typeText(password)
    }
    
    static func enterName(name: String) {
        SettingField.name.tap()
        SettingField.name.typeText(name)
    }
    
    static func enterProfession(profession: String) {
        SettingField.profession.tap()
        SettingField.profession.typeText(profession)
    }
    
    static func enterAge(age: String) {
        SettingField.age.tap()
        SettingField.age.typeText(age)
    }
    
    static func enterBio(bio: String) {
        SettingField.bio.tap()
        SettingField.bio.typeText(bio)
    }
    
    static func selectPhoto(photo: Int) {
        tablesQuery.children(matching: .button).matching(identifier: "Select Photo").element(boundBy: photo).staticTexts["Select Photo"].tap()
    }

    static func tapPhoto(photo: Int) {
        selectPhoto(photo: photo)
        if(photo==0){Images.image1.tap()}
        else if(photo==1){Images.image2.tap()}
        else if(photo==2){Images.image3.tap()}
    }
    
    static func slider(minmax: String){
        var sl = ""
        if(minmax.contains("min")){sl="MIN_SLIDER"}
        else{sl="MAX_SLIDER"}
        let minSliderSlider = tablesQuery.sliders[sl]
        minSliderSlider.swipeUp()
        minSliderSlider.swipeRight()
        minSliderSlider.swipeLeft()
    }
}
