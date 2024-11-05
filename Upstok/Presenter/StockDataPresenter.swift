//
//  StockDataPresenter.swift
//  Upstok
//
//  Created by Venkatesh Pillay on 03/11/24.
//

import Foundation
import UIKit

protocol StockDataProtocol: AnyObject {
    func updateData(portfolioInfo: PortfolioInfo)
    func reloadData()
    func getData() -> PortfolioInfo?
    func updateExpandCollapseView()
}

struct PortfolioInfo {
    let stockInfo: [StockInfo]?
    let currentValueText: String = StringConstants.currentValueText
    let currentValue: String?
    let totalInvestmentText: String = StringConstants.totalInvestmentText
    let totalInvestment: String?
    var todayPNLText: String = StringConstants.todayPNLText
    let todayPNL: String?
    let totalPNLText: String = StringConstants.totalPNLText
    let totalPNL: String?
    let isCollapase: Bool?
}

struct StockInfo {
    let stockName: NSAttributedString
    let ltp: NSAttributedString
    let quantity: NSAttributedString
    let pnl: NSAttributedString
}

class StockDataPresenter {
    
    weak var stockDataProtocol: StockDataProtocol?
    
    init(stockDataProtocol: StockDataProtocol) {
        self.stockDataProtocol = stockDataProtocol
    }
    
    public func initializeData() {
        stockDataProtocol?.updateData(portfolioInfo: PortfolioInfo(stockInfo: nil, currentValue: nil, totalInvestment: nil, todayPNL: nil, totalPNL: nil, isCollapase: true))
    }
    
    public func fetchData() {
        NetworkManager.fetchApi(type: StockDataModel.self, urlString: StringConstants.pnlUrl, completionHandler: { [weak self] response in
            self?.formatData(stockData: response)
        })
    }
    
    private func formatData(stockData: StockDataModel) {
        var stockInfo: [StockInfo] = []
        var currentValue: Double = 0.0
        var totalInvestment: Double = 0.0
        var totalPnl: Double = 0.0
        var todayPnl: Double = 0.0
        for info in stockData.data.userHolding {
            currentValue += info.ltp * Double(info.quantity)
            totalInvestment += info.avgPrice * Double(info.quantity)
            todayPnl += (info.close - info.ltp) * Double(info.quantity)
            let stockName = NSAttributedString(string: info.symbol, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.black])
            let ltp: NSMutableAttributedString = HelperMethods.getDescriptionText(text: StringConstants.ltp)
            ltp.append(HelperMethods.getNormalFontText(text: "\(StringConstants.rupee)\(info.ltp)"))
            let quantity: NSMutableAttributedString = HelperMethods.getDescriptionText(text: StringConstants.netQuantity)
            quantity.append(HelperMethods.getNormalFontText(text: "\(info.quantity)"))
            let pnlValue = (info.ltp - info.avgPrice) * Double(info.quantity)
            let pnl: NSMutableAttributedString = HelperMethods.getDescriptionText(text: StringConstants.pnl)
            pnl.append(HelperMethods.getAmountValueFormattedText(value: pnlValue))
            stockInfo.append(StockInfo(stockName: stockName, ltp: ltp, quantity: quantity, pnl: pnl))
        }
        totalPnl = currentValue - totalInvestment
        let currentValueText = HelperMethods.getAmountValueText(value: currentValue)
        let totalInvestmentText = HelperMethods.getAmountValueText(value: totalInvestment)
        let todayPnlText = HelperMethods.getAmountValueText(value: todayPnl)
        let totalPnlText = HelperMethods.getAmountValueText(value: totalPnl)
        let portfolioInfo: PortfolioInfo = PortfolioInfo(stockInfo: stockInfo, currentValue: currentValueText, totalInvestment: totalInvestmentText, todayPNL: todayPnlText, totalPNL: totalPnlText, isCollapase: true)
        stockDataProtocol?.updateData(portfolioInfo: portfolioInfo)
        stockDataProtocol?.reloadData()
        stockDataProtocol?.updateExpandCollapseView()
    }
    
    public func expandCollapseTapped() {
        let curretData = stockDataProtocol?.getData()
        if let data = curretData, let isCollapase = data.isCollapase {
        let updatedData = PortfolioInfo(stockInfo: curretData?.stockInfo, currentValue: curretData?.currentValue, totalInvestment: curretData?.totalInvestment, todayPNL: curretData?.todayPNL, totalPNL: curretData?.todayPNL, isCollapase: !isCollapase)
               stockDataProtocol?.updateData(portfolioInfo: updatedData)
            stockDataProtocol?.updateExpandCollapseView()
        }
    }
    
}
