//
//  AppTutorialViewController.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 23/06/23.
//

import UIKit

class AppTutorialViewController: UITableViewController {
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(cellWithClass: AppTutorialTableCell.self)
    }
    
    @objc private func goToNextPage() {
        
    }
}

extension AppTutorialViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        AppTutorial.tutorials.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: AppTutorialTableCell.self)
        cell.tutorial = AppTutorial.tutorials[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 18
        let greetingText = NSMutableAttributedString(string: "GitHub Introduction",
                                                     attributes: [.font: UIFont.systemFont(ofSize: 28, weight: .semibold), .foregroundColor: UIColor.gradientSecond])
        
        let titleLabel = UILabel()
        titleLabel.attributedText = greetingText
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.centerY.equalToSuperview()
        }
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView()
        
        let continueButton = UIButton()
        continueButton.setTitle("GET STARTED", for: .normal)
        continueButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.layer.cornerRadius = LayoutConstant.defaultCornerRadius
        continueButton.layer.masksToBounds = true
        continueButton.addTarget(self, action: #selector(goToNextPage), for: .touchUpInside)
        footerView.addSubview(continueButton)
        
        continueButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(LayoutConstant.defaultHeight)
            make.width.equalTo(LayoutConstant.defaultWidth)
        }
        
        continueButton.makeGradient(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: LayoutConstant.defaultWidth,
                                                   height: LayoutConstant.defaultHeight))
        return footerView
    }
}

