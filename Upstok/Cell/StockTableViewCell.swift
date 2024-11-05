//
//  StockTableViewCell.swift
//  Upstok
//
//  Created by Venkatesh Pillay on 03/11/24.
//

import UIKit

class StockTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "StockTableViewCell"
    
    let titleStackView: UIStackView = UIStackView()
    let pnlStackView: UIStackView = UIStackView()
    let conatinerStackView: UIStackView = UIStackView()
    let stockNameLabel: UILabel = UILabel()
    let ltpLabel: UILabel = UILabel()
    let quantityLabel: UILabel = UILabel()
    let pnlLabel: UILabel = UILabel()
    let dimension = CGSize(width: 100, height: 200)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCellView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCellView()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupCellView()
        // Configure the view for the selected state
    }
    
    private func setupCellView() {
        stockNameLabel.font = .boldSystemFont(ofSize: 10)
        stockNameLabel.textColor = .red
        stockNameLabel.numberOfLines = 0
        stockNameLabel.sizeToFit()
        titleStackView.alignment = .fill
        titleStackView.axis = .horizontal
        titleStackView.addArrangedSubview(stockNameLabel)
        titleStackView.addArrangedSubview(ltpLabel)
        
        pnlStackView.alignment = .fill
        pnlStackView.axis = .horizontal
        pnlStackView.addArrangedSubview(quantityLabel)
        pnlStackView.addArrangedSubview(pnlLabel)
        
        conatinerStackView.alignment = .top
        conatinerStackView.axis = .vertical
        conatinerStackView.addArrangedSubview(titleStackView)
        conatinerStackView.addArrangedSubview(pnlStackView)
        contentView.addSubview(conatinerStackView)
        
    }
    
    private func setupConstraints() {
        conatinerStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        pnlStackView.translatesAutoresizingMaskIntoConstraints = false
        stockNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stockNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        conatinerStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        conatinerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        conatinerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        conatinerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        conatinerStackView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        titleStackView.topAnchor.constraint(equalTo: conatinerStackView.topAnchor).isActive = true
        titleStackView.leadingAnchor.constraint(equalTo: conatinerStackView.leadingAnchor).isActive = true
        titleStackView.trailingAnchor.constraint(equalTo: conatinerStackView.trailingAnchor).isActive = true
        titleStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        pnlStackView.topAnchor.constraint(equalTo: titleStackView.topAnchor).isActive = true
        pnlStackView.leadingAnchor.constraint(equalTo: conatinerStackView.leadingAnchor).isActive = true
        pnlStackView.trailingAnchor.constraint(equalTo: conatinerStackView.trailingAnchor).isActive = true
        pnlStackView.bottomAnchor.constraint(equalTo: conatinerStackView.bottomAnchor).isActive = true
        pnlStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configureCell() {
        //setupCellView()
        stockNameLabel.text = "Ashok"
        ltpLabel.text = "Rs 456"
        quantityLabel.text = "50"
        pnlLabel.text = "Rs 1000"
        layoutIfNeeded()
    }
    
}
