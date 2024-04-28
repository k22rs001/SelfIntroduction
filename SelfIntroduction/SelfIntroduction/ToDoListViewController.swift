//
//  ToDoListViewController.swift
//  SelfIntroduction
//
//  Created by Takayuki Aoyagi   on 2024/04/28.
//

import UIKit

class ToDoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    // Todoリスト
    let todoList:[[String]] = [
        ["風呂そうじ","お迎え",],       // 月曜日のタスク
        ["洗濯","買い物","飲み会"],     // 火曜日のタスク
    ]
    
    // セクションのヘッダー
    let sectionHeader:[String] = ["月曜日","火曜日"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // セクション数を設定する
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeader.count
    }

    // セクションヘッダーを設定する
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeader[section]
    }

    // セクションヘッダーの高さを設定する
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    // セクション毎のセル数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList[section].count
    }

    // セクション毎のセルの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath)
        cell.textLabel?.text = todoList[indexPath.section][indexPath.row]
        return cell
    }
}
