//
//  ViewController.swift
//  ToDoApp1
//
//  Created by 千葉和貴 on 2021/05/05.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //編集ボタンのインスタンス
    @IBOutlet weak var editButton: UIButton!
    
    private var toDoListString = [String]()
    private var toDoCell: UITableViewCell = UITableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableViewにデリゲートを設定
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //今までに保存したToDoがあるなら読み込む
        if UserDefaults.standard.object(forKey: "ToDoList") != nil {
            toDoListString = UserDefaults.standard.object(forKey: "ToDoList") as! [String]
        }
        
        //tableViewの再読み込み
        tableView.reloadData()
    }
    
    //AddViewControllerへの遷移
    @IBAction func goNextViewAction(_ sender: Any) {
        //遷移する前に編集モードだったら戻す
        if editButton.titleLabel?.text == "完了" {
            tableView.isEditing = false
            editButton.setTitle("編集", for: .normal)
        }
        //AddViewControllerのインスタンス化
        let addVC = storyboard?.instantiateViewController(withIdentifier: "addVC") as! AddViewController
        //遷移
        navigationController?.pushViewController(addVC, animated: true)

    }
    
    @IBAction func editCellButton(_ sender: UIButton) {
        //編集を始める、終わる際のボタンの表示と編集モードの切り替え
        if sender.titleLabel?.text == "編集" {
            tableView.isEditing = true
            editButton.setTitle("完了", for: .normal)
        } else {
            tableView.isEditing = false
            editButton.setTitle("編集", for: .normal)
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    //toDoListStringの要素数分のcellを作る
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoListString.count
    }
    
    //cell一つひとつを作成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //storyBoardのtableViewと紐付け
        toDoCell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        //tableViewのテキストにtoDoListStringの内容を表示させる
        toDoCell.textLabel?.text = toDoListString[indexPath.row]
        return toDoCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //cellの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //編集を許可している
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //tableViewからの削除処理をしている
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            toDoListString.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
        UserDefaults.standard.set(toDoListString, forKey: "ToDoList")
    }
    
    //cellの並び替えを許可している
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //cellの並び替え
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let toDo = toDoListString[sourceIndexPath.row]
        //sourceIndexPath にデータの元の位置、destinationIndexPath に移動先の位置
        //元の位置のデータを配列から削除
        toDoListString.remove(at:sourceIndexPath.row)
        //移動先の位置にデータを配列に挿入
        toDoListString.insert(toDo, at: destinationIndexPath.row)
        UserDefaults.standard.set(toDoListString, forKey: "ToDoList")
    }
    
}
