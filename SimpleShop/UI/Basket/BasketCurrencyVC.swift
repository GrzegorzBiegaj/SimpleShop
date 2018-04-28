//
//  BasketCurrencyVC.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 25.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import UIKit

protocol BasketCurrencyVCDelegate: class {
    func didSelectCurrency()
}

class BasketCurrencyVC: UITableViewController {

    // MARK: View controller outlets
    
    @IBOutlet weak var currencyLabel: UILabel!

    weak var delegate: BasketCurrencyVCDelegate?

    var currency: String? {
        didSet {
            currencyLabel.text = currency
        }
    }

    // MARK: View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: UITableViewDataSource methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath), cell.reuseIdentifier == "CurrencyRI" else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectCurrency()
    }

}
