//
//  ViewController_Cart.swift
//  Homework_POS_Drink
//
//  Created by S10414 on 2019/1/24.
//  Copyright © 2019年 S10414. All rights reserved.
//

import UIKit

class ViewController_Cart: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView_cart: UITableView!
    @IBOutlet weak var btn_amount: UIButton!
    @IBOutlet weak var textView_totalMoney: UITextView!
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var money: [Int] = [0,0,0,0]  //單價，數量，單項總金額，全部合計
    var strOrder: String = ""
    
    
    ////結帳
    @IBAction func btn_amount_Click(_ sender: Any) {
        self.strOrder += "\n\n合計：\(money[3])元"
        let alertController = UIAlertController(title: "送出確認", message: "您確認要送出訂單嗎？", preferredStyle: UIAlertController.Style.actionSheet)
        //確定
        let okAction = UIAlertAction(title: "確認", style: UIAlertAction.Style.destructive, handler: {(action) -> Void in
            let alertControllerOrderForm = UIAlertController(title: "喝到飽飲料訂購單", message: self.strOrder, preferredStyle: UIAlertController.Style.alert)
            let okActionOrder = UIAlertAction(title: "確認", style: UIAlertAction.Style.default, handler: {(actionOrder) -> Void in
                self.navigationItem.prompt = "訂購成功"
                self.perform(#selector(self.clearPrompt), with: nil, afterDelay: 5.0)
                
                self.resetCart()
                
            })
            
            alertControllerOrderForm.addAction(okActionOrder)
            self.present(alertControllerOrderForm, animated: true, completion: nil)
        })
        //取消
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: {(action) -> Void in
            
        })
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func clearPrompt(){
        self.navigationItem.prompt = nil
    }
    
    //清空購物車
    func resetCart() {
        self.money = [0,0,0,0]
        self.strOrder = ""
        self.textView_totalMoney.text = "0"
        self.appDelegate.arrayItemToCart.removeAll()
        self.tableView_cart.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "茶山02.jpg")!)
        self.tableView_cart.delegate = self
        self.tableView_cart.dataSource = self
    }
    
    ////TableView Delegate Protocol
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rowNum: Int = 0
        if section == 0 {
            rowNum = appDelegate.arrayItemToCart.count
        }
        
        return rowNum
    }
    
    ////設定群組起始標題
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var strTitle: String = ""
        if section == 0 {
            strTitle = "購物清單"
        }
        
        return strTitle
    }
    
    ////設定重複使用的儲存格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID: String = "cell_cart"
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        //如果沒有，就建立新儲存格
        if nil == cell {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellID)
        }
        ////設定單儲存格標題，並計算金額
        if indexPath.section == 0 {
            //取得單價
            money[0] = (appDelegate.arrayItemToCart[indexPath.row][appDelegate.Key_drinkPrice]) as! Int
            //取得數量
            money[1] = (appDelegate.arrayItemToCart[indexPath.row][appDelegate.Key_drinkQuantity]) as! Int
            //計算單項金額
            money[2] = money[0] * money[1]
            //金額合計
            money[3] += money[2]
            self.textView_totalMoney.text = "\(money[3])"
            
            //設定單儲存格
            cell?.textLabel?.text = "\(appDelegate.arrayItemToCart[indexPath.row][appDelegate.Key_drinkName] as! String)"
            //顯示2行的subtitle
            cell?.detailTextLabel?.numberOfLines = 2
            cell?.detailTextLabel?.text = "單價：\(money[0])  數量：\(money[1])  金額：\(money[2])\n甜度：\((appDelegate.arrayItemToCart[indexPath.row][appDelegate.Key_drinkSugar]) as! String)  冰塊：\((appDelegate.arrayItemToCart[indexPath.row][appDelegate.Key_drinkIce]) as! String)  加料：\((appDelegate.arrayItemToCart[indexPath.row][appDelegate.Key_drinkIngredients]) as! String)"
            cell?.imageView?.image = UIImage(named: (appDelegate.arrayItemToCart[indexPath.row][appDelegate.Key_drinkImage] as? String)!)
            //設定列印訂購單資料
            self.strOrder += "品項：\(cell?.textLabel?.text ?? "")\n\(cell?.detailTextLabel?.text ?? "")\n\n"
        }
        
        return cell!
    }
    
    ////編輯儲存格
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            if indexPath.section == 0 {
                appDelegate.arrayItemToCart.remove(at: indexPath.row)
            }
            
            strOrder = ""
            money = [0,0,0,0]
            self.textView_totalMoney.text = "\(money[3])"
            tableView_cart.reloadData()
        }
    }
    
    ////end TableView Delegate protocol
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView_cart.reloadData()
    }

}
