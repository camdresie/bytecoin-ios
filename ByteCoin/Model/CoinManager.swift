//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinMangerDelegate {
    
    func didUpdateCurrency(_ coinManager: CoinManager, coinInfo: CoinModel)
    func didFailWithError(error: Error)
    
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "E20E1F6D-5415-4CD5-B9DB-AC97E24174D6"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","INR","JPY","NOK","PLN","RUB","SGD","USD","ZAR"]
    
    var delegate: CoinMangerDelegate?
    
    func fetchCoinPrice(currency: String){
        let urlString = "\(baseURL)/\(currency)/?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        let encodedURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let url = URL(string: encodedURL!){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let coinRate = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCurrency(self, coinInfo: coinRate)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let asset = decodedData.asset_id_base
            let rate = decodedData.rate
            let currency = decodedData.asset_id_quote
            let coinRate = CoinModel(rate: rate, currency: currency, asset: asset)
            return coinRate
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}
