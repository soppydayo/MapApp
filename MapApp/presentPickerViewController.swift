//
//  presentPickerViewController.swift
//  MapApp
//
//  Created by 白川創大 on 2023/05/21.
//

import UIKit
import RealmSwift

class presentPickerViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate{
    
    @IBOutlet var photoImageView: UIImageView!
    
    @IBOutlet var TitleText: UITextField!
    
    @IBOutlet var HonbunText: UITextField!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TitleText.delegate = self
        HonbunText.delegate = self
        
        let savedata: Savedata? = read()
        
        TitleText.text = savedata?.title
        HonbunText.text = savedata?.text
        
        
        // Do any additional setup after loading the view.
    }
    
    func read() -> Savedata? {
        return realm.objects(Savedata.self).first
    }
    
    //Realm
    @IBAction func postButtonTapped() {
        let title: String = TitleText.text!
        let text: String = HonbunText.text!
        
        let savedata: Savedata? = read()
        
        if savedata != nil {
            try! realm.write {
                savedata!.title = title
                savedata!.text = text
            }
        } else {
            let newSavedata = Savedata()
            newSavedata.title = title
            newSavedata.text = text
            
            try! realm.write {
                realm.add(newSavedata)
            }
            
        }
        let alert: UIAlertController = UIAlertController(title: "成功", message: "保存しました", preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: "OK", style: .default, handler:  nil)
        )
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    
    
    
    
    //カメラボタンを起動する
    @IBAction func cameraButtonTapped() {
        presentPickerController(sourceType: .camera)
    }
    
    
    func presentPickerController(sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
            
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil)
        
        photoImageView.image = info[.originalImage] as? UIImage
    }
    
    
    
    
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    
    
    
}
