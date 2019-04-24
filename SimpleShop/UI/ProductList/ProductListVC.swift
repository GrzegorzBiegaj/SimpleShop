//
//  ProductListVC.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 24.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import UIKit

class ProductListVC: UITableViewController {

    let viewModel = ProductListVM()
    let basketController = BasketController()

    // MARK: View controller life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = tableView.rowHeight
        title = viewModel.title
    }

    // MARK: UITableViewDataSource methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.showProducts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductRI", for: indexPath)

        if let cell = cell as? ProductListCell {
            cell.delegate = self
            cell.showProduct = viewModel.showProducts[indexPath.row]
        }
        return cell
    }

}

// MARK: ProductListCellProtocol methods

extension ProductListVC: ProductListCellProtocol {
    
    func didSelect(showProduct: ShowProduct?) {
        guard let showProduct = showProduct else { return }
        guard let existingAmount = basketController.getValue(product: showProduct.product) else {
            basketController.addOrUpdate(product: showProduct.product, amount: showProduct.amount)
            showOKAlert(withTitle: viewModel.messageTitle, message: viewModel.confirmationMessage(value: showProduct.amount), okButtonTitle: viewModel.okButtonTitle)
            return
        }

        guard viewModel.canIncreaseProduct(showProduct: showProduct) else {
            showOKAlert(withTitle: viewModel.alertTitle, message: viewModel.errorMessage, okButtonTitle: viewModel.okButtonTitle)
            return
        }

        showAlert(withTitle: viewModel.alertTitle,
                  message: viewModel.alertMessage(value: existingAmount),
                  confirmButtonTitle: viewModel.okButtonTitle,
                  cancelButtonTitle: viewModel.cancelButtonTitle,
                  confirmAction: { action in
                    self.basketController.addOrUpdate(product: showProduct.product, amount: existingAmount + showProduct.amount)
            })
    }

    func didChangeAmount(showProduct: ShowProduct?, amount: Int) {
        guard let showProduct = showProduct else { return }
        viewModel.updateAmount(showProduct: showProduct, amount: amount)
    }
}
