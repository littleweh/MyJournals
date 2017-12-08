//
//  EntryCreatingViewController.swift
//  MyJournals
//
//  Created by 典萱 高 on 2017/12/8.
//  Copyright © 2017年 LostRfounds. All rights reserved.
//

import UIKit

class EntryCreatingViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var journalTitleTextField: UITextField!
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    let gradientLayer = CAGradientLayer()

    @IBOutlet weak var contentTextViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.addTarget(
            self,
            action: #selector(cancelBackEntryList),
            for: .touchUpInside
        )

        saveButton.addTarget(
            self,
            action: #selector(saveInCoreData),
            for: .touchUpInside
        )

        setupUI()

        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = imageView.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func saveInCoreData(){

    }

    @objc func cancelBackEntryList() {
        dismiss(animated: true, completion: nil)
    }

    func setupUI() {

        setupImageGradientView()

        contentTextView.sizeToFit()
        contentTextView.layoutIfNeeded()
        contentTextViewHeightConstraint.constant = contentTextView.intrinsicContentSize.height
        
    }

    private func setupImageGradientView() {

        gradientLayer.colors = [
            UIColor(red: 67.0 / 255.0, green: 87.0 / 255.0, blue: 97.0 / 255.0, alpha: 1.0).cgColor,
            UIColor(red: 26.0 / 255.0, green: 34.0 / 255.0, blue: 38.0 / 255.0, alpha: 1.0).cgColor
        ]

        imageView.layer.addSublayer(gradientLayer)

    }

    



}
