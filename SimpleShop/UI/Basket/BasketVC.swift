//
//  BasketVC.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 25.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import UIKit

class BasketVC: UIViewController {

    let viewModel = BasketVM()
    let currentCurrencyController = CurrentCurrencyController()

    var currency: Currency? {
        didSet {
            basketCurrencyVC?.currency = currency?.name
            viewModel.refreshData()
            tableView.reloadData()
            totalPriceLabel.text = viewModel.getTotalPrice()
        }
    }

    // MARK: View controller outlets

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
        }
    }

    @IBOutlet weak var totalPriceLabel: UILabel!

    @IBOutlet var backgroundTableView: UIView!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    weak var basketCurrencyVC: BasketCurrencyVC? {
        didSet {
            basketCurrencyVC?.delegate = self
        }
    }

    // MARK: View controller actions

    @IBAction func onDeleteAllButtonTap(_ sender: UIBarButtonItem) {
        guard viewModel.showBasket.count > 0 else { return }
        showAlert(withTitle: viewModel.warningTitle,
                  message: viewModel.warningMessage,
                  confirmButtonTitle: viewModel.okButtonTitle,
                  cancelButtonTitle: viewModel.cancelButtonTitle,
                  confirmAction: { action in
                    self.deleteAll()
        })
    }
    
    @IBAction func onCheckoutButtonTap(_ sender: UIButton) {
        guard let currency = currency else { return }
        activityIndicator.startAnimating()
        viewModel.updateCurrency(currency: currency) { (response) in
            self.activityIndicator.stopAnimating()
            switch response {
            case .success(let currency):
                self.currentCurrencyController.setCurrency(currency: currency)
                self.currency = currency
                self.showOKAlert(withTitle: self.viewModel.successTitle, message: self.viewModel.successMessage, okButtonTitle: self.viewModel.okButtonTitle)
            case .error(let error):
                self.showOKAlert(withTitle: self.viewModel.errorTitle, message: self.viewModel.errorMessage(error: error), okButtonTitle: self.viewModel.okButtonTitle)
            }
        }
    }

    // MARK: View controller life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        currency = currentCurrencyController.getCurrency
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let basketCurrencyVC = segue.destination as? BasketCurrencyVC, segue.identifier == "BasketCurrency" {
            self.basketCurrencyVC = basketCurrencyVC
        }
        if let currencyListVC = segue.destination as? CurrencyListVC, segue.identifier == "CerrencyListSegue" {
            currencyListVC.delegate = self
        }
    }

    // MARK: Private methods

    fileprivate func deleteRow(indexPath: IndexPath) {
        viewModel.remove(product: viewModel.showBasket[indexPath.row].basketItem.product)
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
        totalPriceLabel.text = viewModel.getTotalPrice()
    }

    fileprivate func deleteAll() {
        viewModel.removeAll()
        tableView.reloadData()
        totalPriceLabel.text = viewModel.getTotalPrice()
    }

    fileprivate func reloadCell(product: Product) {
        guard let index = viewModel.findIndex(product: product) else { return }
        let indexPath = IndexPath(row: index, section: 0)
        tableView.reloadRows(at: [indexPath], with: .none)
        totalPriceLabel.text = viewModel.getTotalPrice()
    }

}

// MARK: ProductListCellProtocol methods

extension BasketVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = viewModel.showBasket.count == 0 ? backgroundTableView : nil
        return viewModel.showBasket.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketItemRI", for: indexPath)

        if let cell = cell as? BasketListCell {
            cell.delegate = self
            cell.showBasketItem = viewModel.showBasket[indexPath.row]
        }
        return cell
    }

}

// MARK: UITableViewDelegate methods

extension BasketVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard UITableViewCell.EditingStyle.delete == editingStyle else { return }
        deleteRow(indexPath: indexPath)
    }
}

// MARK: BasketCurrencyVCDelegate methods

extension BasketVC: BasketCurrencyVCDelegate {

    func didSelectCurrency() {
        performSegue(withIdentifier: "CerrencyListSegue", sender: self)
    }

}

// MARK: BasketListCellProtocol methods

extension BasketVC: BasketListCellProtocol {

    func didChangeAmount(showProduct: ShowBasketItem?, amount: Int) {
        guard let product = showProduct?.basketItem.product else { return }
        viewModel.addOrUpdate(product: product, amount: amount)
        reloadCell(product: product)
    }

}

// MARK: CurrencyListVCProtocol methods

extension BasketVC: CurrencyListVCProtocol {

    func didChangeCurrency() {
        currency = currentCurrencyController.getCurrency
    }
    
}
