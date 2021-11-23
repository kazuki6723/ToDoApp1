//
//  AddViewController.swift
//  ToDoApp1
//
//  Created by 千葉和貴 on 2021/05/05.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    //キーボード外をタッチした際にキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
    }
    
    //returnを押した際にキーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //ToDoの追加の処理
    @IBAction func todoAddActionButton(_ sender: Any) {
            
        let textLabel = textField.text?.trimmingCharacters(in: .whitespaces)
        if ((textLabel?.isEmpty) == true) {
            let alert = UIAlertController(title: "文字が入力されていません", message: "文字を入力してください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        //追加
        var toDoListString = [String]()
        if UserDefaults.standard.object(forKey: "ToDoList") != nil {
            toDoListString = UserDefaults.standard.object(forKey: "ToDoList") as! [String]
        }
        toDoListString.append(textLabel!)
        textField.text = ""
        UserDefaults.standard.set(toDoListString, forKey: "ToDoList" )
        
        navigationController?.popViewController(animated: true)
    }
    
    //戻る処理
    @IBAction func returnActionButton(_ sender: Any) {
        textField.text = ""
        navigationController?.popViewController(animated: true)
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
