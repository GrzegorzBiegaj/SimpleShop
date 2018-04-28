//
//  BasketListCell.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 25.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import UIKit

protocol BasketListCellProtocol: class {
    func didChangeAmount(showProduct: ShowBasketItem?, amount: Int)
}

class BasketListCell: UITableViewCell {

    // Mark: Public interface

    weak var delegate: BasketListCellProtocol?

    var showBasketItem: ShowBasketItem? {
        didSet {
            guard let showBasketItem = showBasketItem else { return }
            let product = showBasketItem.basketItem.product
            nameLabel.text = product.name
            descriptionLabel.text = product.description
            priceLabel.text = showBasketItem.shownPrice
            iconImageView.image = UIImage(named: product.imageName!)
            packageTypeLabel.text = product.packageType.getDescription
            quantityLabel.text = product.quantity
            amountStepper.value = Double(showBasketItem.basketItem.amount)
            amountLabel.text = String(showBasketItem.basketItem.amount)
            sumLabel.text = showBasketItem.shownSum
            amountStepper.value = Double(showBasketItem.basketItem.amount)
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
            amountStepper.maximumValue = Double((showBasketItem?.maxAmount ?? 10))
            amountStepper.minimumValue = 1
            amountStepper.stepValue = 1
        }
    }
    @IBOutlet weak var sumLabel: UILabel!

    // MARK: View controller actions
    
    @IBAction func onStepperTap(_ sender: UIStepper) {
        amountLabel.text = String(Int(sender.value))
        delegate?.didChangeAmount(showProduct: showBasketItem, amount: Int(sender.value))
    }

}
