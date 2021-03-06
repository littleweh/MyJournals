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

    @IBOutlet weak var pickImageLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var journalTitleTextField: UITextField!
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!

    let gradientLayer = CAGradientLayer()
    let imagePickerController = ImagePickerController()
    let coreDataHandler = CoreDataHandler()

    var journalID: UUID? = nil

    var journals: [Journal]? = nil {
        didSet {
            self.pickImageLabel.isHidden = true
            imageView.contentMode = .scaleAspectFill
            gradientView.isHidden = true
            self.view.reloadInputViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.journalTitleTextField.delegate = self
        self.contentTextView.delegate = self

        imagePickerController.delegate = self
        imagePickerController.imageLimit = 1

        setupUI()

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

        showJournal()

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = imageView.bounds
    }

    func showJournal() {
        if let journalId = journalID {
            journals = coreDataHandler.fetchJournalWith(journalID: journalId)

            if let myJournals = journals {
                if let imageData = myJournals[0].image {
                    let image = UIImage(data: imageData)
                    imageView.image = image
                }
                journalTitleTextField.text = myJournals[0].title
                contentTextView.text = myJournals[0].content
            }
        }
    }


    @objc func saveInCoreData(){
        if journalID == nil {
            CoreDataHandler.saveObject(
                journalTitle: journalTitleTextField.text,
                journalContent: contentTextView.text,
                image: imageView.image
            )
        } else {
            coreDataHandler.updateJournalWith(
                journalID: journalID!,
                journalTitle: journalTitleTextField.text,
                journalContent: contentTextView.text,
                image: imageView.image
            )
        }
        dismiss(animated: true, completion: nil)

    }

    @objc func cancelBackEntryList() {
        dismiss(animated: true, completion: nil)
    }

    @objc func imageTapped() {
        present(imagePickerController, animated: true, completion: nil)

    }

    func setupUI() {

        setupGradientView()

        let templateImage = imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.image = templateImage
        imageView.tintColor = .white

        pickImageLabel.text = NSLocalizedString("Tap to load photo", comment: "")

        journalTitleTextField.becomeFirstResponder()

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
        imageView.contentMode = .scaleAspectFill
        gradientView.isHidden = true
        dismiss(animated: true, completion: nil)

    }

    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        dismiss(animated: true, completion: nil)

    }


}

extension EntryCreatingViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        journalTitleTextField.resignFirstResponder()
        return true
    }
}

extension EntryCreatingViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            view.endEditing(true)
            return false
        } else {
            return true
        }
    }
}
