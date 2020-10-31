//
//  ChangerColorViewController.swift
//  RGBColor2.0
//
//  Created by Никита Гвоздиков on 31.10.2020.
//

import UIKit

class ChangerColorViewController: UIViewController {

    
    @IBOutlet var displayViewOutlet: UIView!
    
    @IBOutlet var labelesOutlet: [UILabel]!
    @IBOutlet var slidersOutlet: [UISlider]!
    @IBOutlet var textFildsOutlet: [UITextField]!
    
    private var currentIndexOfElements = 0
    private var arrayOfColors: [Float] = [0.0, 0.5, 1.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showValueOnOutlets()
        InicializeBeforeOpen()
        
    }
    
    @IBAction func slidersAction(_ sender: UISlider) {
        changeCurrentIndex(slider: sender, textField: nil)
        arrayOfColors[currentIndexOfElements] = sender.value
        changeValueAfterSliderAction(slider: sender)
        showValueOnOutlets()
        changeColorOnView()
    }
    
    @IBAction func textFieldsAction(_ sender: UITextField) {
        changeCurrentIndex(slider: nil, textField: sender)
        arrayOfColors[currentIndexOfElements] = Float(sender.text!) ?? 0.0
        changeValueAfterTextFieldAction(textField: sender)
        showValueOnOutlets()
        changeColorOnView()
    }
    
    
    @IBAction func doneButtonPressed() {
    }
    
   
    
}


//MARK - Extension
extension ChangerColorViewController {
    
    func changeCurrentIndex(slider: UISlider?, textField: UITextField?) {
        if slider != nil {
            guard let slider = slider else { return }
            currentIndexOfElements = slidersOutlet.firstIndex(of: slider) ?? 0
        } else {
            guard let textField = textField else { return }
            currentIndexOfElements = textFildsOutlet.firstIndex(of: textField) ?? 0
        }
   
    }
    
    
    func changeValueAfterSliderAction(slider: UISlider) {
        arrayOfColors[currentIndexOfElements] = slider.value
    }
    
    func changeValueAfterTextFieldAction(textField: UITextField) {
        guard let value = textField.text else { return }
        arrayOfColors[currentIndexOfElements] = Float(value) ?? 0.0
    }
    
    func showValueOnOutlets() {
        labelesOutlet[currentIndexOfElements].text = String(format: "%.2f",arrayOfColors[currentIndexOfElements])
        slidersOutlet[currentIndexOfElements].value = arrayOfColors[currentIndexOfElements]
        textFildsOutlet[currentIndexOfElements].text = String(format: "%.2f",arrayOfColors[currentIndexOfElements])
        changeColorOnView()
    }
    
    func InicializeBeforeOpen() {
        for _ in 0...2 {
            showValueOnOutlets()
            currentIndexOfElements += 1
        }
    }
    
    func changeColorOnView() {
        /* здесь не стал избавляться от индексов массива т.к получается лишний код, мне кажется, что здесь более рационально использовать индексы. Алексей, пожалуйста прокомментируйте это. Спасибо
         
         */
        displayViewOutlet.backgroundColor = UIColor(red: CGFloat(arrayOfColors[0]),
                                                    green: CGFloat(arrayOfColors[1]),
                                                    blue: CGFloat(arrayOfColors[2]),
                                                    alpha: 1)
    }
}
