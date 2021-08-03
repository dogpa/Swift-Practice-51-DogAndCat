//
//  ViewController.swift
//  Swift Practice # 51 DogAndCat
//
//  Created by CHEN PEIHAO on 2021/8/3.
//

import UIKit
import CoreImage.CIFilterBuiltins

class ViewController: UIViewController {
    //任意區域消除鍵盤
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        }
        @objc func dismissKeyboard() {
        view.endEditing(true)
        }
    //選照片
    @IBOutlet weak var dogSelectSegmentController: UISegmentedControl!
    //顯示圖片的uiimage
    @IBOutlet weak var animailsUIImageView: UIImageView!
    //照片上方label
    @IBOutlet weak var upOfImageViewLabel: UILabel!
    //照片下方label
    @IBOutlet weak var downOfImageView: UILabel!
    //ciimage顏色濾鏡segmentcontroller
    @IBOutlet weak var CIColorSegmentedController: UISegmentedControl!
    //兩個slider
    @IBOutlet weak var upWordSizeSlider: UISlider!
    @IBOutlet weak var downWordSizwSilder: UISlider!
    
    //定義照片名稱的Array
    let petPhotoNameArray = ["0.jpg","1.jpg","2.jpg","3.jpg","4.jpg"]
    //定義文字顏色的Array
    let labelColorArray = [UIColor.black, UIColor.white, UIColor.red, UIColor.green, UIColor.blue, UIColor.purple]
    let randomUIColorArray = [UIColor.black, UIColor.white, UIColor.red, UIColor.green, UIColor.blue, UIColor.purple, UIColor.brown, UIColor.magenta, UIColor.cyan, UIColor.darkGray]
    //定義濾鏡顏色的Array
    let CIFilterColorArray = [CIColor.gray, CIColor.red, CIColor.yellow, CIColor.blue, CIColor.green]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //收鍵盤
        hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        //照片開始先隨機顯示
        animailsUIImageView.image = UIImage(named: "0.jpg")
    }
    
    //選擇寵物的照片
    @IBAction func petSelect(_ sender: UISegmentedControl) {
        animailsUIImageView.image = UIImage(named: "\(petPhotoNameArray[sender.selectedSegmentIndex])")
    }
    

    //上層的textField與上層Label連動
    @IBAction func UpWordSet(_ sender: UITextField) {
        upOfImageViewLabel.text = sender.text
    }
    
    //下層的textField與下層Label連動
    @IBAction func downWordSet(_ sender: UITextField) {
        downOfImageView.text = sender.text
    }
    
    //上方label文字大小
    @IBAction func upWordSizeChange(_ sender: UISlider) {
        upOfImageViewLabel.font = UIFont.systemFont(ofSize: CGFloat(sender.value))
    }
    
    //上方label大小隨機按鈕
    @IBAction func upWordSizeRandomSet(_ sender: UIButton) {
        let random = CGFloat.random(in: 10...50)
        upOfImageViewLabel.font = UIFont.systemFont(ofSize: random)
        upWordSizeSlider.value = Float(random)
    }
    
    //下方label文字大小
    @IBAction func downWordSizeSet(_ sender: UISlider) {
        downOfImageView.font = UIFont.systemFont(ofSize: CGFloat(sender.value))
        
    }
    
    //下方label大小隨機按鈕
    @IBAction func downWordFontSizeSet(_ sender: UIButton) {
        let random = CGFloat.random(in: 10...50)
        downOfImageView.font = UIFont.systemFont(ofSize: random)
        downWordSizwSilder.value = Float(random)
    }
    
    //字體顏色segmentedController設定
    @IBAction func wordColorSet(_ sender: UISegmentedControl) {
        func SelectColor () {
            let index = sender.selectedSegmentIndex
            upOfImageViewLabel.textColor = labelColorArray[index]
            downOfImageView.textColor  = labelColorArray[index]
        }
        if sender.selectedSegmentIndex < 6 {
            SelectColor()
        }else{
            upOfImageViewLabel.textColor = randomUIColorArray[Int.random(in: 0...randomUIColorArray.count-1)]
            downOfImageView.textColor = randomUIColorArray[Int.random(in: 0...randomUIColorArray.count-1)]
        }
    }
    
    @IBAction func CIColorSet(_ sender: UISlider) {

        func SelectCIColor (index:Int) {
            if let goToCIImage = UIImage(named: "\(petPhotoNameArray[dogSelectSegmentController.selectedSegmentIndex])") {
                let ciImage = CIImage(image: goToCIImage)
                let filter = CIFilter.colorMonochrome()
                filter.inputImage = ciImage
                filter.intensity = sender.value
                filter.color = CIFilterColorArray[index]
                if let showImageView = filter.outputImage{
                    let filterImage = UIImage(ciImage: showImageView)
                    animailsUIImageView.image = filterImage
                }
            }
        }

        if CIColorSegmentedController.selectedSegmentIndex < 5 {
            SelectCIColor(index: CIColorSegmentedController.selectedSegmentIndex)
        }else{
            SelectCIColor(index: Int.random(in: 0...CIFilterColorArray.count-1))
        }

    }

}

