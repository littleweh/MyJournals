//
//  EntryCreatingViewController.swift
//  MyJournals
//
//  Created by 典萱 高 on 2017/12/8.
//  Copyright © 2017年 LostRfounds. All rights reserved.
//

import UIKit
import CoreData
import ImagePicker

class EntryCreatingViewController: UIViewController {



    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var journalTitleTextField: UITextField!
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    let gradientLayer = CAGradientLayer()
    let imagePickerController = ImagePickerController()

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

        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true


        imagePickerController.delegate = self
        imagePickerController.imageLimit = 1


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

        setupGradientView()

    }

    private func setupGradientView() {

        gradientLayer.colors = [
            UIColor(red: 67.0 / 255.0, green: 87.0 / 255.0, blue: 97.0 / 255.0, alpha: 1.0).cgColor,
            UIColor(red: 26.0 / 255.0, green: 34.0 / 255.0, blue: 38.0 / 255.0, alpha: 1.0).cgColor
        ]

        gradientView.layer.addSublayer(gradientLayer)

    }

    



}

extension EntryCreatingViewController: ImagePickerDelegate {
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        dismiss(animated: true, completion: nil)
    }

    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imageView.image = images[0]
        dismiss(animated: true, completion: nil)

    }

    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        dismiss(animated: true, completion: nil)

    }

    @objc func imageTapped() {
        present(imagePickerController, animated: true, completion: nil)

    }
}
