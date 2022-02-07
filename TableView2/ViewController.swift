//
//  ViewController.swift
//  TableView2
//
//  Created by 中野翔太 on 2022/02/03.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!


    let realm = try! Realm()
    var number = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    // 戻る画面
    @IBAction func exit(segue: UIStoryboardSegue) {

    }




    @IBAction func deleteButton(_ sender: Any) {
        try! realm.write({
            realm.deleteAll()
        })
        tableView.reloadData()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNext" {
            let navigationController = segue.destination as! UINavigationController
            let secondViewController = navigationController.topViewController as! SecondViewController
            let userDate = realm.objects(User.self)
            secondViewController.secondText = "\(userDate[number].text)"
        }
    }

}
    extension ViewController: UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let userDate = realm.objects(User.self)
            return userDate.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CoustomCell", for: indexPath) as! CoustomCell
            let userDate = realm.objects(User.self)
            cell.configur(title: userDate[indexPath.row].text)
            // タグ管理をやめる
    //        let titleLbel = cell.viewWithTag(2) as! UILabel
    //        titleLbel.text = userDate[indexPath.row].text

            return cell
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            guard textField.text != "" else {  return false }
            let user = User()
            try! realm.write({
                user.text = textField.text ?? ""
                realm.add(user.self)
            })
            tableView.reloadData()
            textField.text = ""
            return true
        }


        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            number = indexPath.row
     
            //　画面遷移
            performSegue(withIdentifier: "toNext", sender: indexPath.row)

        }
        // 横スワイプ削除機能
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          if editingStyle == .delete {
              let userDate = realm.objects(User.self)
              print(userDate)
              try! realm.write {
                  realm.delete(userDate[indexPath.row])
              }
              tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }



    }





