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
    
    var delegate: ChangeColorViewControllerDelegate!
    var arrayOfColors: [Float] = [0.0, 0.5, 1.0]
    
    private var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showValueOnOutlets()
        initializationBeforeOpen()
    }
    
    @IBAction func slidersAction(_ sender: UISlider) {
        changeCurrentIndex(slider: sender, textField: nil)
        arrayOfColors[index] = sender.value
        changeValueAfterSliderAction(slider: sender)
        showValueOnOutlets()
        changeColorOnView()
    }
    
    @IBAction func textFieldsAction(_ sender: UITextField) {
        changeCurrentIndex(slider: nil, textField: sender)
        arrayOfColors[index] = Float(sender.text!) ?? 0.0
        changeValueAfterTextFieldAction(textField: sender)
        showValueOnOutlets()
        changeColorOnView()
    }
    
    
    @IBAction func doneButtonPressed() {
        delegate.changeBackground(arrayWithColors: arrayOfColors)
        dismiss(animated: true)
    }
}


//MARK - Extension
extension ChangerColorViewController: UITextFieldDelegate {
    
    func changeCurrentIndex(slider: UISlider?, textField: UITextField?) {
        if slider != nil {
            guard let slider = slider else { return }
            index = slidersOutlet.firstIndex(of: slider) ?? 0
        } else {
            guard let textField = textField else { return }
            index = textFildsOutlet.firstIndex(of: textField) ?? 0
        }
   
    }
    
    
    func changeValueAfterSliderAction(slider: UISlider) {
        arrayOfColors[index] = slider.value
    }
    
    func changeValueAfterTextFieldAction(textField: UITextField) {
        guard let value = textField.text else { return }
        arrayOfColors[index] = Float(value) ?? 0.0
    }
    
    func showValueOnOutlets() {
        labelesOutlet[index].text = String(format: "%.2f",arrayOfColors[index])
        slidersOutlet[index].value = arrayOfColors[index]
        textFildsOutlet[index].text = String(format: "%.2f",arrayOfColors[index])
        changeColorOnView()
    }
    
    func initializationBeforeOpen() {
        for _ in 0...2 {
            showValueOnOutlets()
            index += 1
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
    
    //MARK - Text Field Delegate
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super .touchesBegan(touches, with: event)
                view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return false;
    }
}
