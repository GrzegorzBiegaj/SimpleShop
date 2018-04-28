//
//  ProductListCell.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 24.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import UIKit

protocol ProductListCellProtocol: class {
    func didSelect(showProduct: ShowProduct?)
    func didChangeAmount(showProduct: ShowProduct?, amount: Int)
}

class ProductListCell: UITableViewCell {

    // Mark: Public interface

    weak var delegate: ProductListCellProtocol?

    var showProduct: ShowProduct? {
        didSet {
            guard let showProduct = showProduct else { return }
            let product = showProduct.product
            nameLabel.text = product.name
            descriptionLabel.text = product.description
            priceLabel.text = showProduct.shownPrice
            iconImageView.image = UIImage(named: product.imageName!)
            packageTypeLabel.text = product.packageType.getDescription
            quantityLabel.text = product.quantity
            amountStepper.value = Double(showProduct.amount)
        }
    }

    // MARK: View controller outlets

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var packageTypeLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountStepper: UIStepper! {
        didSet {
            amountStepper.maximumValue = Double((showProduct?.maxAmount ?? 10))
            amountStepper.minimumValue = 1
            amountStepper.stepValue = 1
        }
    }

    // MARK: View controller actions

    @IBAction func onStepperTap(_ sender: UIStepper) {
        amountLabel.text = String(Int(sender.value))
        showProduct?.amount = Int(sender.value)
        delegate?.didChangeAmount(showProduct: showProduct, amount: Int(sender.value))
    }

    @IBAction func onAddButtonTap(_ sender: UIButton) {
        delegate?.didSelect(showProduct: showProduct)
    }
    
}
