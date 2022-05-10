//
//  TableViewController.swift
//  TextField
//
//  Created by Tobias Hähnel on 05.05.22.
//

import Foundation
import UIKit

class TableViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var passwordCell: UITableViewCell!
    @IBOutlet private(set) var passwordField: UITextField!
}
