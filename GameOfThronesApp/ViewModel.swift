//
//  ViewModel.swift
//  GameOfThronesApp
//
//  Created by Harvin Shibu on 28/06/23.
//

import Foundation
import UIKit
import Alamofire

class ViewModel{
    
    
    let urlString: String
    
    init(){
        urlString = "https://api.tvmaze.com/shows/82/episodes"
    }
    
    func loadData(handler: @escaping ([Model]) -> Void){
        
        let urlAPI = URL(string: urlString)
        var dataFeed: [Model]?
        
        AF.request(urlAPI!).response { response in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    dataFeed = try decoder.decode([Model].self, from: data!)
                    handler(dataFeed!)
                } catch {
                    print("Error parsing JSON\n\(error)")
                }
            case .failure(let error):
                print("Error retrieving data\n\(error)")
            }
        }
    }
 
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

