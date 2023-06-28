//
//  TableViewCell.swift
//  GameOfThronesApp
//
//  Created by Harvin Shibu on 28/06/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var airDate: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var summary: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(model: Model){
        title.text = "\(model.number) - \(model.name)"
        airDate.text = convertDateFormat(dateString: model.airdate)
        img.load(url: URL(string: model.image.original)!)
        summary.text = convertHTMLToPlainText(model.summary)
        
    }

    func convertDateFormat(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd MMMM yyyy"
            let convertedDateString = dateFormatter.string(from: date)
            return convertedDateString
        }
        
        return ""
    }
    
    func convertHTMLToPlainText(_ htmlString: String) -> String? {
        guard let data = htmlString.data(using: .utf8) else {
            return nil
        }
        
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            return attributedString.string
        }
        
        return nil
    }
}
