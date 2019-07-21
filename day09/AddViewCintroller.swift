//
//  AddViewCintroller.swift
//  day09
//
//  Created by Yolankyi SERHII on 7/6/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import UIKit
import yserhii2019

class addViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var articleManager = ArticleManager()
    var doneButton: UIBarButtonItem?
    let pickerController = UIImagePickerController()
    var edit: Bool = false
    var article: Article?

    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var titleView: UITextField!
    @IBOutlet weak var text: UITextView!
    
    @IBAction func takePicture(_ sender: UIButton) {
        showPickerCamera()
    }
    @IBAction func choosePicture(_ sender: Any) {
        showPickerLibrary()
    }
    
    func showPickerLibrary() {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            pickerController.sourceType = .photoLibrary
            present(pickerController, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Alert", message: "No Library available", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showPickerCamera() {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            pickerController.sourceType = .camera
            present(pickerController, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Alert", message: "No Camera available", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            picture.image = image
        } else {
            print("Something went wrong")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func setfields() {
        print("setting up fields")
        titleView.text = article?.title
        text.text = article?.content
        if let image = article?.image {
            picture.image = UIImage(data: image as Data)
        }
    }
    
    func createArticle() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    @objc func editingHasStarted(){
        if (titleView.text != nil && titleView.text != ""){
            doneButton!.isEnabled = true
        } else {
            doneButton!.isEnabled = false
        }
    }
    
    @objc func doneAction() {
        if (edit) {
            article?.modification_date = NSDate()
            article?.title = titleView.text
            article?.content = text.text
            if picture.image != nil {
                if let imageUI = picture.image, let selectedImage = imageUI.pngData() as NSData? {
                    article?.image = selectedImage
                } else {
                    print("saveArticle : error")
                }
            }
            article?.modification_date = NSDate()
            article?.language = Locale.current.languageCode!
        } else {
            let newarticle = articleManager.newArticle()
            newarticle.creation_date = NSDate()
            newarticle.modification_date = NSDate()
            newarticle.title = titleView.text
            newarticle.content = text.text
            if picture.image != nil {
                if let imageUI = picture.image, let selectedImage = imageUI.pngData() as NSData? {
                    newarticle.image = selectedImage
                } else {
                    print("saveArticle : error")
                }
            }
            newarticle.modification_date = NSDate()
            newarticle.language = Locale.current.languageCode!
        }
        articleManager.save()
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerController.delegate = self
        doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneAction))
        navigationItem.rightBarButtonItem = doneButton
        doneButton!.isEnabled = false
        titleView.addTarget(self, action: #selector(editingHasStarted), for: .editingChanged)
        if (edit) {
            self.setfields()
            doneButton!.isEnabled = true
        }
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
