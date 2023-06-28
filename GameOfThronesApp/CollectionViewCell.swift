//
//  CollectionViewCell.swift
//  GameOfThronesApp
//
//  Created by Harvin Shibu on 28/06/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var seasonNo: UIButton!
    var seasonDelegate: SeasonDelegate?
    var seasonTemp: Int?
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func filterBySeason(delegate: SeasonDelegate, season: Int){
        seasonDelegate = delegate
        seasonTemp = season
        
    }
    
    @IBAction func didSelectBtn(_ sender: Any){
        seasonDelegate?.filterData(season: seasonTemp ?? 1)
    }
    
}
