//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var cryptoImage: UIImageView!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var cryptoPicker: UIPickerView!
    
    var currencyData = CurrencyData(cryp: "BTC", curr: "USD")
    
    var coinManager = CoinManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        cryptoPicker.dataSource = self
        cryptoPicker.delegate = self
        
        self.currencyPicker.selectRow(19, inComponent: 0, animated: false)
        self.cryptoPicker.selectRow(0, inComponent: 0, animated: false)
        
        coinManager.getCoinPrice(for: currencyData)
    }
}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    
    func didUpdatePrice(price: String, currency: String) {
        
        DispatchQueue.main.async {
            self.bitcoinLabel.text = price
            self.currencyLabel.text = currency
        }
    }
    
    func didFailWithError(error: Error) {
        //print(error)
    }
}

//MARK: - UIPickerView DataSource & Delegate

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // NUMBER OF COLUMNS FOR DISPLAYING DATA
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if (currencyPicker == pickerView) {
            return 1
        }
        else if (cryptoPicker == pickerView) {
            return 1
        }
        else {
          return 0
        }
      }
      
    // NUMBER OF ROWS OF DATA
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (currencyPicker == pickerView) {
            return coinManager.currencyArray.count
        }
        else if (cryptoPicker == pickerView)
        {
            return coinManager.coinArray.count
        }
        else {
            return 0
        }
      }
      
    // SETS THE TITLE FOR EACH ROW
      func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (currencyPicker == pickerView) {
            return coinManager.currencyArray[row]
        }
        else if (cryptoPicker == pickerView){
            return coinManager.coinArray[row]
        }
        else {
            return "Loading"
        }
      }
      
    
      func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (currencyPicker == pickerView) {
            let selectedCurrency = coinManager.currencyArray[row]
            currencyData.currency = selectedCurrency
            coinManager.getCoinPrice(for: currencyData)
            print(currencyData)
        }
        else if (cryptoPicker == pickerView) {
            let selectedCoin = coinManager.coinArray[row]
            currencyData.crypto = selectedCoin
            coinManager.getCoinPrice(for: currencyData)
            if (currencyData.crypto == "BTC") {
                cryptoImage.image = UIImage(systemName: "bitcoinsign.circle.fill")
            }
            else {
                print("image to change")
                print(currencyData.crypto)
                let cryptoLogo = UIImage(named: currencyData.crypto)
                cryptoImage.image = cryptoLogo
            }
            print(currencyData)
        }
        else {
            
        }
      }
}

