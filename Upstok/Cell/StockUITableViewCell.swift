//
//  StockUITableViewCell.swift
//  Upstok
//
//  Created by Venkatesh Pillay on 03/11/24.
//

import UIKit

class StockUITableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var stockName: UILabel!
    
    @IBOutlet weak var ltpText: UILabel!
    
    @IBOutlet weak var quantity: UILabel!
    
    @IBOutlet weak var pnl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configurCell(stockInfo: StockInfo) {
        stockName.attributedText = stockInfo.stockName
        ltpText.attributedText = stockInfo.ltp
        quantity.attributedText = stockInfo.quantity
        pnl.attributedText = stockInfo.pnl
    }
    
}
