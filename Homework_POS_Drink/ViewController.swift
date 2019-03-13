//
//  ViewController.swift
//  Homework_POS_Drink
//
//  Created by S10414 on 2019/1/24.
//  Copyright © 2019年 S10414. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var tableView_TeaList: UITableView!
    @IBOutlet weak var segment_Tea: UISegmentedControl!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var btn_AddToCart: UIButton!
    @IBOutlet weak var textView_quantity: UITextView!
    @IBOutlet weak var stepper_quentity: UIStepper!
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//    var drinkName: String = ""
//    var drinkPrice: Int = 0
//    var drinkImage: String = ""
//    var drinkQuantity: Int = 0
//    var drinkSugar: String = ""
//    var drinkIce: String = ""
//    var drinkIngredients: String = ""
    var drinkItem: Dictionary<String,Any> = [:]
    
    ////加入購物車
    @IBAction func btn_AddToCart_Click(_ sender: Any) {
        appDelegate.arrayItemToCart.append(drinkItem)
        self.reset()
    }
    
    ////選擇飲料類別
    @IBAction func segment_Tea_ValueChanged(_ sender: Any) {
        self.tableView_TeaList.reloadData()
    }
    
    ////選擇數量
    @IBAction func stepper_quentity_valueChanged(_ sender: Any) {
        let stepperValue: Double = self.stepper_quentity.value
//        drinkQuantity = Int(stepperValue)
//        self.textView_quantity.text = "\(drinkQuantity)"
        self.drinkItem[appDelegate.Key_drinkQuantity] = Int(stepperValue)
        self.textView_quantity.text = "\(drinkItem[appDelegate.Key_drinkQuantity]!)"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "茶山01.jpg")!)
        self.segment_Tea.selectedSegmentIndex = 0
        self.tableView_TeaList.delegate = self
        self.tableView_TeaList.dataSource = self
        
        appDelegate.arrayItemTea = ["紅茶","綠茶","青茶","烏龍茶","普洱茶"]
        appDelegate.arrayPriceTea = [25,25,25,30,35]
        appDelegate.arrayImageTea = ["紅茶.jpg","綠茶.jpg","青茶.jpg","烏龍茶.jpg","普洱茶.jpg"]
        
        appDelegate.arrayItemMilkTea = ["珍珠奶茶","椰果奶茶","仙草凍奶茶","梅子凍奶茶","布丁奶茶"]
        appDelegate.arrayPriceMilkTea = [40,40,45,50,55]
        appDelegate.arrayImageMilkTea = ["珍珠奶茶.jpg","椰果奶茶.jpg","仙草凍奶茶.jpg","梅子凍奶茶.jpg","布丁奶茶.jpg"]
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        appDelegate.arraySugar = ["無糖","微糖","少糖","半糖","全糖"]
        appDelegate.arrayIce = ["去冰","微冰","少冰","全冰"]
        appDelegate.arrayIngredients = ["無","珍珠","椰果","仙草凍","梅子凍","布丁"]
        self.reset()
        
    }
    
    //選擇初始化
    func reset () {
        tableView_TeaList.selectRow(at: IndexPath?.init(IndexPath.init(row: 0, section: 0)), animated: true, scrollPosition: UITableView.ScrollPosition.top)
        pickerView.selectRow(0, inComponent: 0, animated: true)
        pickerView.selectRow(0, inComponent: 1, animated: true)
        pickerView.selectRow(0, inComponent: 2, animated: true)
//        drinkName = appDelegate.arrayItemTea[0] as! String
//        drinkPrice = appDelegate.arrayPriceTea[0]
//        drinkImage = appDelegate.arrayImageTea[0] as! String
//        drinkQuantity = 1
//        drinkSugar = appDelegate.arraySugar[0]
//        drinkIce = appDelegate.arrayIce[0]
//        drinkIngredients = appDelegate.arrayIngredients[0]
//        self.stepper_quentity.value = 1.0
//        self.textView_quantity.text = "\(drinkQuantity)"
        if self.segment_Tea.selectedSegmentIndex == 0 {
            drinkItem[appDelegate.Key_drinkName] = appDelegate.arrayItemTea[0] as! String
            drinkItem[appDelegate.Key_drinkPrice] = appDelegate.arrayPriceTea[0]
            drinkItem[appDelegate.Key_drinkImage] = appDelegate.arrayImageTea[0] as! String
        }else if self.segment_Tea.selectedSegmentIndex == 1 {
            drinkItem[appDelegate.Key_drinkName] = appDelegate.arrayItemMilkTea[0] as! String
            drinkItem[appDelegate.Key_drinkPrice] = appDelegate.arrayPriceMilkTea[0]
            drinkItem[appDelegate.Key_drinkImage] = appDelegate.arrayImageMilkTea[0] as! String
        }
        drinkItem[appDelegate.Key_drinkSugar] = appDelegate.arraySugar[0]
        drinkItem[appDelegate.Key_drinkIce] = appDelegate.arrayIce[0]
        drinkItem[appDelegate.Key_drinkIngredients] = appDelegate.arrayIngredients[0]
        self.stepper_quentity.value = 1.0
        drinkItem[appDelegate.Key_drinkQuantity] = Int(stepper_quentity.value)
        self.textView_quantity.text = "\(drinkItem[appDelegate.Key_drinkQuantity]!)"
    }

    ////PickerView Protocol
    ////幾個滾輪
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    ////每個滾輪有幾個項目
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var intRowNum: Int = 0
        
        if component == 0 {
            intRowNum = appDelegate.arraySugar.count
        }else if component == 1 {
            intRowNum = appDelegate.arrayIce.count
        }else if component == 2 {
            intRowNum = appDelegate.arrayIngredients.count
        }
        
        return intRowNum
    }
    
    ////將項目名稱放入對應的滾輪
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var strRow: String = ""
        
        if component == 0 {
            strRow = appDelegate.arraySugar[row]
        }else if component == 1 {
            strRow = appDelegate.arrayIce[row]
        }else if component == 2 {
            strRow = appDelegate.arrayIngredients[row]
        }
        
        return strRow
    }
    
    ////取得滾輪選到的項目
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //甜度
        if component == 0 {
//            self.drinkSugar = appDelegate.arraySugar[row]
            drinkItem[appDelegate.Key_drinkSugar] = appDelegate.arraySugar[row]
        }
        //冰塊
        else if component == 1 {
//            self.drinkIce = appDelegate.arrayIce[row]
            drinkItem[appDelegate.Key_drinkIce] = appDelegate.arrayIce[row]
        }
        //配料
        else if component == 2 {
//            self.drinkIngredients = appDelegate.arrayIngredients[row]
            drinkItem[appDelegate.Key_drinkIngredients] = appDelegate.arrayIngredients[row]
        }
    }
    ////end PickerView Protocol
    
    ////TableView Delegate Protocol
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    ////設定有幾個項目
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rowNum: Int = 0
        
        if self.segment_Tea.selectedSegmentIndex == 0 {
            if section == 0 {
                rowNum = appDelegate.arrayItemTea.count
            }
        }else if self.segment_Tea.selectedSegmentIndex == 1 {
            if section == 0 {
                rowNum = appDelegate.arrayItemMilkTea.count
            }
        }
        
        return rowNum
    }
    
    ////設定群組起始標題
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var strTitle: String = ""
        if self.segment_Tea.selectedSegmentIndex == 0 {
            if section == 0 {
                strTitle = "純茶類"
            }
        }else if self.segment_Tea.selectedSegmentIndex == 1 {
            if section == 0 {
                strTitle = "奶茶類"
            }
        }
        
        return strTitle
    }
    
    ////設定重複使用的儲存格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID: String = "cell_tea"
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        //如果沒有，就建立新儲存格
        if nil == cell {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellID)
        }
        
        //設定單儲存格標題
        if self.segment_Tea.selectedSegmentIndex == 0 {
            if indexPath.section == 0 {
                cell?.textLabel?.text = appDelegate.arrayItemTea[indexPath.row] as? String
                cell?.detailTextLabel?.text = "\(appDelegate.arrayPriceTea[indexPath.row])"
                cell?.imageView?.image = UIImage(named: (appDelegate.arrayImageTea[indexPath.row] as? String)!)
            }
        }else if self.segment_Tea.selectedSegmentIndex == 1 {
            if indexPath.section == 0 {
                cell?.textLabel?.text = appDelegate.arrayItemMilkTea[indexPath.row] as? String
                cell?.detailTextLabel?.text = "\(appDelegate.arrayPriceMilkTea[indexPath.row])"
                cell?.imageView?.image = UIImage(named: (appDelegate.arrayImageMilkTea[indexPath.row] as? String)!)
            }
        }
        
        return cell!
    }
    
    ////點擊儲存格
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.segment_Tea.selectedSegmentIndex == 0 {
            if indexPath.section == 0 {
//                self.drinkName = appDelegate.arrayItemTea[indexPath.row] as! String
//                self.drinkPrice = appDelegate.arrayPriceTea[indexPath.row]
//                self.drinkImage = appDelegate.arrayImageTea[indexPath.row] as! String
                drinkItem[appDelegate.Key_drinkName] = appDelegate.arrayItemTea[indexPath.row]
                drinkItem[appDelegate.Key_drinkPrice] = appDelegate.arrayPriceTea[indexPath.row]
                drinkItem[appDelegate.Key_drinkImage] = appDelegate.arrayImageTea[indexPath.row]
            }
        }else if self.segment_Tea.selectedSegmentIndex == 1 {
            if indexPath.section == 0 {
//                self.drinkName = appDelegate.arrayItemMilkTea[indexPath.row] as! String
//                self.drinkPrice = appDelegate.arrayPriceMilkTea[indexPath.row]
//                self.drinkImage = appDelegate.arrayImageMilkTea[indexPath.row] as! String
                drinkItem[appDelegate.Key_drinkName] = appDelegate.arrayItemMilkTea[indexPath.row]
                drinkItem[appDelegate.Key_drinkPrice] = appDelegate.arrayPriceMilkTea[indexPath.row]
                drinkItem[appDelegate.Key_drinkImage] = appDelegate.arrayImageMilkTea[indexPath.row]
            }
        }
    }
    
    ////end TableView Delegate protocol
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView_TeaList.reloadData()
    }
}

