//
//  CurrencyListVC.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 25.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import UIKit

protocol CurrencyListVCProtocol: class {
    func didChangeCurrency()
}

class CurrencyListVC: UIViewController {

    let viewModel = CurrencyListVM()
    let currentCurrencyController = CurrentCurrencyController()

    weak var delegate: CurrencyListVCProtocol?
    var modelData: [ShowCurrency] = []

    // MARK: View controller outlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: View controller actions

    @IBAction func onSegmentedControlTap(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: modelData = viewModel.getData(type: .top10)
        case 1: modelData = viewModel.getData(type: .full)
        default: modelData = viewModel.getData(type: .top10)
        }
        self.tableView.reloadData()
    }

    // MARK: View controller life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        requestData(type: .top10)
    }

    // MARK: Private methods

    fileprivate func requestData(type: CurrencyListType) {
        self.activityIndicator.startAnimating()
        viewModel.requestData { (response) in
            self.activityIndicator.stopAnimating()
            switch response {
            case .success:
                self.modelData = self.viewModel.getData(type: type)
                self.tableView.reloadData()
            case .error(let error):
                self.showOKAlert(withTitle: self.viewModel.errorTitle, message: self.viewModel.errorMessage(error: error), okButtonTitle: self.viewModel.errorButton)
            }
        }
    }

}

// MARK: UITableViewDataSource methods

extension CurrencyListVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyRI", for: indexPath)
        cell.textLabel?.text = modelData[indexPath.row].shownName
        cell.detailTextLabel?.text = String(modelData[indexPath.row].currency.rate)
        return cell
    }

}

// MARK: UITableViewDelegate methods

extension CurrencyListVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        currentCurrencyController.setCurrency(currency: modelData[indexPath.row].currency)
        delegate?.didChangeCurrency()
        navigationController?.popViewController(animated: true)
    }

}
