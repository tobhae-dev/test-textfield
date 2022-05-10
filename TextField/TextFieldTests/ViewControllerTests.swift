//
//  ViewControllerTests.swift
//  TextFieldTests
//
//  Created by Tobias Hähnel on 01.01.22.
//

@testable import TextField
import XCTest

class ViewControllerTests: XCTestCase {

    private var sut: ViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        executeRunLoop()
    }


    func test_outlets_shouldBeConnected() throws {
        XCTAssertNotNil(sut.usernameField, "usernameField")
        XCTAssertNotNil(sut.passwordField, "passwordField")
    }

    func test_usernameField_attributesShouldBeSet() throws {
        let textField = sut.usernameField!

        XCTAssertEqual(textField.textContentType, .username, "textContentType")
        XCTAssertEqual(textField.autocorrectionType, .no, "autocorrectionType")
        XCTAssertEqual(textField.returnKeyType, .next, "returnKeyType")
    }

    func test_passwordField_attributesShouldBeSet() {
        let textField = sut.passwordField!
        XCTAssertEqual(textField.textContentType, .password, "textContentType")
        XCTAssertEqual(textField.returnKeyType, .go, "returnKeyType")
        XCTAssertTrue(textField.isSecureTextEntry, "isSecureTextEntry")
    }

    func test_textFieldDelegates_shouldBeConnected() {
        XCTAssertNotNil(sut.usernameField.delegate, "usernameField")
        XCTAssertNotNil(sut.passwordField.delegate, "passwordField")
    }

    func test_shouldChangeCharacters_usernameWithSpaces_shouldPreventChange() throws {
        let allowChange = shouldChangeCharacters(in: sut.usernameField, replacement: "a b")
        let allow = try XCTUnwrap(allowChange, "allowChange is nil")

        XCTAssertFalse(allow, "allowChange is True")
    }

    func test_shouldChangeCharacters_passwordWithSpaces_shouldAllowChange() {
        let allowChange = shouldChangeCharacters(in: sut.passwordField, replacement: "a b")

        XCTAssertEqual(allowChange, true)
    }
    func test_shouldChangeCharacters_passwordWithoutSpaces_shouldAllowChange() {
        let allowChange = shouldChangeCharacters(in: sut.passwordField, replacement: "abc")

        XCTAssertEqual(allowChange, true)
    }

    func test_shouldReturn_withPassword_shouldPerformLogin() {
        sut.usernameField.text = "USERNAME"
        sut.passwordField.text = "PASSWORD"

        shouldReturn(in: sut.passwordField)

            // Normally, assert something
    }
    
    // MARK: This test passes
    
    func test_becomeFirstResponder_withPasswordField_shouldMakePasswordFieldFirstResponder() {
        putInViewHierarchy(sut)
        
        sut.passwordField.becomeFirstResponder()

        XCTAssertTrue(sut.passwordField.isFirstResponder)
    }

}
