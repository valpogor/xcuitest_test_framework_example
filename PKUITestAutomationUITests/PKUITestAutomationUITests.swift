import XCTest

class PKUITestAutomationUITests: XCTestCase {
    
    override func setUpWithError() throws {
        let app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
       }
    
    func testLoginUI() {
        XCTAssert(ContentScreenObjectModel.LoginField.userField.exists)
        XCTAssert(ContentScreenObjectModel.LoginField.passwordField.exists)
        XCTAssert(ContentScreenObjectModel.Buttons.login.exists)
    }
    
    func testSettingUI(){
        ContentScreenObjectModel.login()
        XCTAssert(ContentScreenObjectModel.SettingField.profession.exists)
        XCTAssert(ContentScreenObjectModel.SettingField.name.exists)
        XCTAssert(ContentScreenObjectModel.SettingField.age.exists)
        XCTAssert(ContentScreenObjectModel.SettingField.bio.exists)
        XCTAssert(ContentScreenObjectModel.Buttons.cancel.exists)
        XCTAssert(ContentScreenObjectModel.Buttons.logout.exists)
        XCTAssert(ContentScreenObjectModel.Buttons.save.exists)
        XCTAssert(ContentScreenObjectModel.Buttons.selectPhoto1.exists)
        XCTAssert(ContentScreenObjectModel.Buttons.selectPhoto2.exists)
        XCTAssert(ContentScreenObjectModel.Buttons.selectPhoto3.exists)
    }
    
    func testLogout(){
        ContentScreenObjectModel.login()
        ContentScreenObjectModel.Buttons.logout.tap()
        testLoginUI()
    }
    
    func testSelectPhoto() throws {
        ContentScreenObjectModel.login()
        ContentScreenObjectModel.selectPhoto(photo: 0)
        XCTAssert(ContentScreenObjectModel.Buttons.albums.waitForExistence(timeout: 2))
        XCTAssert(ContentScreenObjectModel.Buttons.cancel.exists)
        XCTAssert(ContentScreenObjectModel.Buttons.albums.exists)
        ContentScreenObjectModel.Buttons.albums.tap()
        XCTAssert(ContentScreenObjectModel.Buttons.seeall.exists)
        XCTAssert(ContentScreenObjectModel.Buttons.cancel.waitForExistence(timeout: 2))
    }
    
    func testAllFlowWith() throws {
        ContentScreenObjectModel.login()
        ContentScreenObjectModel.tapPhoto(photo: 0)
        ContentScreenObjectModel.tapPhoto(photo: 1)
        ContentScreenObjectModel.tapPhoto(photo: 2)
        XCTAssert(ContentScreenObjectModel.SettingField.name.waitForExistence(timeout: 2))
        ContentScreenObjectModel.enterName(name: "Mr.Mask")
        ContentScreenObjectModel.enterProfession(profession: "teacher")
        ContentScreenObjectModel.enterAge(age:"30")
        ContentScreenObjectModel.enterBio(bio: "traveler")
        XCTAssert(ContentScreenObjectModel.Text.min18.exists)
        XCTAssert(ContentScreenObjectModel.Text.max99.exists)
        ContentScreenObjectModel.slider(minmax: "min")
        ContentScreenObjectModel.slider(minmax: "max");
        XCTAssert(!ContentScreenObjectModel.Text.min18.exists)
        XCTAssert(!ContentScreenObjectModel.Text.max99.exists)
        ContentScreenObjectModel.Buttons.save.tap()
        XCTAssert(ContentScreenObjectModel.Text.success.exists)
    }
}
