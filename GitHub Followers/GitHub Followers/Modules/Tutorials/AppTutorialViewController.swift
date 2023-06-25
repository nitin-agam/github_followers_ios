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
    
    @objc private func handleSubmitClicked() {
        dismiss(animated: true)
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
        let titleLabel = UILabel(text: "GitHub Introduction", lines: 0, alignment: .center, textColor: .gradientSecond, font: .systemFont(ofSize: 28, weight: .semibold))
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
        
        let continueButton = UIButton(title: "Get Started", font: .systemFont(ofSize: 18, weight: .semibold), titleColor: .white, shouldRounded: true)
        continueButton.addTarget(self, action: #selector(handleSubmitClicked), for: .touchUpInside)
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
