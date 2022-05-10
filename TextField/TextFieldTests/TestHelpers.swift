//
//  TestHelpers.swift
//  ButtonTapTests
//
//  Created by Tobias Hähnel on 29.12.21.
//

import UIKit

// MARK: Buttons

func tap(_ button: UIButton) {
    button.sendActions(for: .touchUpInside)
}

func tap(_ button: UIBarButtonItem) {
    _ = button.target?.perform(button.action, with: nil)
}

// MARK: TextFields

func shouldChangeCharacters(in textField: UITextField, range: NSRange = NSRange(), replacement: String) -> Bool? {
    textField.delegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: replacement)
}

@discardableResult
func shouldReturn(in textField: UITextField) -> Bool? {
    textField.delegate?.textFieldShouldReturn?(textField)
}

// MARK: Run Loop

// some of UIKit’s actions aren’t immediate but add an event to the run loop. F.E.: Pushing a ViewController
func executeRunLoop() {
    RunLoop.current.run(until: Date())
}

// MARK: View Hirarchy

// for testing segues
func putInWindow(_ vc: UIViewController) {
    let window = UIWindow()
    window.rootViewController = vc
    window.isHidden = false
}


/// Adds the given ViewController view as a subView to the Window. This allows testing of some UIKit specific routines.
/// If you add anything to a temporary UIWindow, call `executeRunLoop()` in tearDown() so that UIKit releases the window. This avoids memory leaks.
/// - Parameter vc: The ViewController which view is then added.
func putInViewHierarchy(_ vc: UIViewController) {
    let window = UIWindow()
    window.addSubview(vc.view)
}

// MARK: Logging Helper
extension UITextContentType: CustomStringConvertible {
    public var description: String { rawValue }
}

extension UITextAutocorrectionType: CustomStringConvertible {
    public var description: String {
        switch self {
            case .default: return "default"
            case .no: return "no"
            case .yes: return "yes"
            @unknown default:
                fatalError("Unknown UITextAutocorrectionType")
        }
    }
}

extension UIReturnKeyType: CustomStringConvertible {
    public var description: String {
        switch self {
            case .default: return "default"
            case .go: return "go"
            case .google: return "google"
            case .join: return "join"
            case .next: return "next"
            case .route: return "route"
            case .search: return "search"
            case .send: return "send"
            case .yahoo: return "yahoo"
            case .done: return "done"
            case .emergencyCall: return "emergencyCall"
            case .continue: return "continue"
            @unknown default:
                fatalError("Unknown UIReturnKeyType")
        }
    }
}
