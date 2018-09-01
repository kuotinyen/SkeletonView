//
//  ViewController.swift
//  SkeletonView
//
//  Created by TING YEN KUO on 2018/8/31.
//  Copyright © 2018年 TING YEN KUO. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    // ----------------------------------------------------------------------------------
    /// Variables
    //  MARK: - Variables
    // ----------------------------------------------------------------------------------
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 14
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowRadius = 6.0
        view.layer.shadowOpacity = 0.6
        return view
    }()
    
    lazy var skeletonView: SkeletonView = {
        let view = SkeletonView()
        view.backgroundColor = .clear
        return view
    }()
    
    let profileImageViewPlaceholder = UIView()
    lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = iv.frame.size.height / 2
        return iv
    }()
    
    let nameLabelPlaceholder = UIView()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let jobTitleLabelPlaceholder = UIView()
    lazy var jobTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let locationLabelPlaceholder = UIView()
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    lazy var loadButton: UIButton = {
        let button = UIButton()
        button.setTitle("load profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleLoadData), for: .touchUpInside)
        return button
    }()
    
    @objc func handleLoadData() {
        loadData()
    }
    
    // ----------------------------------------------------------------------------------
    /// Life Cycle
    //  MARK: - Life Cycle
    // ----------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupCardViewAndSkeletonView()
        setupProfileImageView()
        setupLabels()
        setupLoadButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let viewsShouldLoad = [profileImageViewPlaceholder, nameLabelPlaceholder, jobTitleLabelPlaceholder, locationLabelPlaceholder]
        skeletonView.setMaskingViews(viewsShouldLoad)
    }
    
    fileprivate func loadData() {
        skeletonView.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.skeletonView.stopAnimating()
            self.skeletonView.layer.mask = nil
            
            self.nameLabel.text = "Ayal Komod"
            self.jobTitleLabel.text = "Singer"
            self.locationLabel.text = "Taipei, Taiwan"
            
            UIView.animate(withDuration: 0.3, animations: {
                self.profileImageView.image = #imageLiteral(resourceName: "singer")
                self.nameLabel.alpha = 1
                self.jobTitleLabel.alpha = 1
                self.locationLabel.alpha = 1
            })
        }
    }

}

// ----------------------------------------------------------------------------------
/// UI
//  MARK: - UI
// ----------------------------------------------------------------------------------

extension ViewController {
    
    fileprivate func setupCardViewAndSkeletonView() {
        
        view.addSubview(cardView)
        cardView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.right.equalTo(view).inset(16)
            make.height.equalTo(128)
        }
        
        cardView.addSubview(skeletonView)
        skeletonView.snp.makeConstraints { (make) in
            make.edges.equalTo(cardView)
        }
    }
    
    fileprivate func setupProfileImageView() {
        
        skeletonView.addSubview(profileImageViewPlaceholder)
        profileImageViewPlaceholder.snp.makeConstraints { (make) in
            make.top.left.equalTo(skeletonView).offset(8)
            make.width.height.equalTo(60)
        }
        
        skeletonView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(skeletonView).offset(8)
            make.width.height.equalTo(60)
        }
    }
    
    fileprivate func setupLabels() {
        
        nameLabel.alpha = 0.0
        jobTitleLabel.alpha = 0.0
        locationLabel.alpha = 0.0
        
        // name label
        skeletonView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView)
            make.left.equalTo(profileImageView.snp.right).offset(8)
            make.right.equalTo(skeletonView).offset(-8)
            make.height.equalTo(20)
        }
        
        skeletonView.addSubview(nameLabelPlaceholder)
        nameLabelPlaceholder.snp.makeConstraints { (make) in
            make.width.equalTo(160)
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(nameLabel)
            make.height.equalTo(9)
        }
        
        // job title label
        skeletonView.addSubview(jobTitleLabel)
        jobTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.equalTo(profileImageView.snp.right).offset(8)
            make.right.equalTo(skeletonView).offset(-8)
            make.height.equalTo(20)
        }
        
        skeletonView.addSubview(jobTitleLabelPlaceholder)
        jobTitleLabelPlaceholder.snp.makeConstraints { (make) in
            make.width.equalTo(240)
            make.centerY.equalTo(jobTitleLabel)
            make.left.equalTo(jobTitleLabel)
            make.height.equalTo(9)
        }
        
        // location label
        skeletonView.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(jobTitleLabel.snp.bottom)
            make.left.equalTo(profileImageView.snp.right).offset(8)
            make.right.equalTo(skeletonView).offset(-8)
            make.height.equalTo(20)
            make.bottom.equalTo(profileImageView)
        }
        
        skeletonView.addSubview(locationLabelPlaceholder)
        locationLabelPlaceholder.snp.makeConstraints { (make) in
            make.width.equalTo(160)
            make.centerY.equalTo(locationLabel)
            make.left.equalTo(locationLabel)
            make.height.equalTo(9)
        }
    }
    
    fileprivate func setupLoadButton() {
        view.addSubview(loadButton)
        loadButton.snp.makeConstraints { (make) in
            make.center.equalTo(view)
        }
    }
    
}

