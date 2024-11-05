//
//  ViewController.swift
//  Upstok
//
//  Created by Venkatesh Pillay on 03/11/24.
//

import UIKit

class ViewController: UIViewController, StockDataProtocol, UITableViewDataSource, UITableViewDelegate {
    
    private var presenter: StockDataPresenter?
    private var currentData: PortfolioInfo?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pnlLabel: UILabel!
    @IBOutlet weak var pnlValueLabel: UILabel!
    @IBOutlet weak var currentValueTextLabel: UILabel!
    @IBOutlet weak var pnlContainerView: UIView!
    @IBOutlet weak var currentValueLabel: UILabel!
    @IBOutlet weak var totalInvestmentTextLabel: UILabel!
    @IBOutlet weak var totalInvestmentValueLabel: UILabel!
    @IBOutlet weak var todayPnlTextLabel: UILabel!
    @IBOutlet weak var todayPnlValueLabel: UILabel!
    @IBOutlet weak var investmentDetailContainerView: UIView!
    @IBOutlet weak var expandCollapseButton: UIButton!
    @IBOutlet weak var currentValueTextTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var currentValueTextBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var todayPnlTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupPresenter()
        inititialiseData()
        setupView()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    private func setupView() {
        pnlContainerView.backgroundColor = .lightGray
        investmentDetailContainerView.backgroundColor = .lightGray
        collapseView()
        expandCollapseButton.addTarget(self, action: #selector(expandCollapse), for: .touchUpInside)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "StockUITableViewCell", bundle: nil), forCellReuseIdentifier: "StockUITableViewCell")
    }
    
    private func setupPresenter() {
        presenter = StockDataPresenter(stockDataProtocol: self)
    }
    
    private func inititialiseData() {
        presenter?.initializeData()
    }
    
    private func fetchData() {
        presenter?.fetchData()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.updateInvestmentvalues()
            self.tableView.reloadData()
        }
    }
    
    func updateExpandCollapseView() {
        DispatchQueue.main.async {
            if let currentValue = self.currentData, let isCollapase = currentValue.isCollapase {
                if (isCollapase) {
                    self.collapseView()
                } else {
                    self.expandView()
                }
            }
        }
    }
    
    @objc func expandCollapse() {
        presenter?.expandCollapseTapped()
    }
    
    private func collapseView() {
        self.currentValueTextLabel.text = ""
        self.currentValueLabel.text = ""
        self.totalInvestmentTextLabel.text = ""
        self.totalInvestmentValueLabel.text = ""
        self.todayPnlTextLabel.text = ""
        self.todayPnlValueLabel.text = ""
        self.expandCollapseButton.setImage(UIImage(named: "uparrow"), for: .normal)
        self.currentValueTextTopConstraint.constant = 0
        self.currentValueTextBottomConstraint.constant = 0
        self.todayPnlTopConstraint.constant = 0
    }
    
    private func expandView() {
        self.currentValueTextLabel.text = self.currentData?.currentValueText
        self.currentValueLabel.text = self.currentData?.currentValue ?? ""
        self.totalInvestmentTextLabel.text = self.currentData?.totalInvestmentText
        self.totalInvestmentValueLabel.text = self.currentData?.totalInvestment ?? ""
        self.todayPnlTextLabel.text = self.currentData?.todayPNLText
        self.todayPnlValueLabel.text = self.currentData?.todayPNL ?? ""
        self.currentValueTextTopConstraint.constant = 10
        self.currentValueTextBottomConstraint.constant = 10
        self.todayPnlTopConstraint.constant = 10
        self.expandCollapseButton.setImage(UIImage(named: "downarrow"), for: .normal)
    }
    
    private func updateInvestmentvalues() {
        pnlLabel.text = self.currentData?.totalPNLText
        pnlValueLabel.text = currentData?.totalPNL ?? ""
        collapseView()
    }
    
    func updateData(portfolioInfo: PortfolioInfo) {
        currentData = portfolioInfo
    }
    
    func getData() -> PortfolioInfo? {
        return currentData
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData?.stockInfo?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StockUITableViewCell") as? StockUITableViewCell, let data = currentData?.stockInfo?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configurCell(stockInfo: data)
        return cell
    }
    
}
