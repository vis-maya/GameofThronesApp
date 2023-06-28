//
//  ViewController.swift
//  GameOfThronesApp
//
//  Created by Harvin Shibu on 28/06/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    var dataVModel = ViewModel()
    var dataArray = [Model]()
    var filterArray = [Model]()
    var selectedNo = 1
    let arrayCol = Array(1...8)
    @IBOutlet weak var seasonTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataVModel.loadData(handler: { data in
            self.dataArray = data
            self.filterModelsBySeason(season: 1)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRightGesture(_:)))
        swipeRightGesture.direction = .left
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeftGesture(_:)))
        swipeLeftGesture.direction = .right
        
        self.tableView.addGestureRecognizer(swipeRightGesture)
        
        self.tableView.addGestureRecognizer(swipeLeftGesture)
        
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.estimatedRowHeight = 50
    }
    
    @objc func handleSwipeRightGesture(_ gesture: UISwipeGestureRecognizer) {
            if gesture.state == .ended {
                
                if selectedNo < 8{
                    
                    filterModelsBySeason(season: selectedNo + 1)
                    
                }
            }
        }
    
    @objc func handleSwipeLeftGesture(_ gesture: UISwipeGestureRecognizer) {
            if gesture.state == .ended {
                
                if selectedNo > 1{
                    
                    filterModelsBySeason(season: selectedNo - 1)
                }
            }
        }


}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filterArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! TableViewCell
        
        cell.configureCell(model: filterArray[indexPath.row])
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         
        return UITableView.automaticDimension
    }
 
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayCol.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collCell", for: indexPath) as! CollectionViewCell
        
        cell.seasonNo.layer.cornerRadius = cell.seasonNo.frame.width / 2
        
        cell.seasonNo.setTitle("\(arrayCol[indexPath.row])", for: .normal)
        
        if selectedNo == arrayCol[indexPath.row]{
            print(selectedNo)
            
            cell.seasonNo.tintColor = .orange
        }
        else{
            cell.seasonNo.tintColor = .darkGray
        }
        
        cell.filterBySeason(delegate: self, season: arrayCol[indexPath.row])
        
        return cell
    }
    
    func filterModelsBySeason(season: Int){
        
        filterArray = dataArray.filter { $0.season == season }
        selectedNo = season
        seasonTitle.text = "Season \(season)"
        
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.collectionView.reloadData()
        }
    }
   
}

extension ViewController: SeasonDelegate{
    
    func filterData(season: Int) {
        filterModelsBySeason(season: season)
    }
}

protocol SeasonDelegate{
    
    func filterData(season: Int)
}

class CustomLabel: UILabel {
    @IBInspectable var borderBottomWidth: CGFloat = 1.0
    @IBInspectable var borderBottomColor: UIColor = .black
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let borderRect = CGRect(x: 0, y: rect.height - borderBottomWidth, width: rect.width, height: borderBottomWidth)
        let borderLayer = CALayer()
        borderLayer.backgroundColor = borderBottomColor.cgColor
        borderLayer.frame = borderRect
        layer.addSublayer(borderLayer)
    }
}
