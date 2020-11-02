//
//  ViewController.swift
//  RGBColor2.0
//
//  Created by Никита Гвоздиков on 31.10.2020.
//

import UIKit


protocol ChangeColorViewControllerDelegate {
    func changeBackground(arrayWithColors: [Float])
}


class MainViewController: UIViewController {
    
    private var arrayOfBackgroundColor: [Float] = [0.0, 0.5, 1.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeBackground(arrayWithColors: arrayOfBackgroundColor)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newchangerColorVC = segue.destination as! ChangerColorViewController
        newchangerColorVC.delegate = self
        newchangerColorVC.arrayOfColors = arrayOfBackgroundColor
    }
}

extension MainViewController: ChangeColorViewControllerDelegate {
    func changeBackground(arrayWithColors: [Float]) {
        arrayOfBackgroundColor = arrayWithColors
        super.view.backgroundColor = UIColor(red: CGFloat(arrayOfBackgroundColor[0]),
                                             green: CGFloat(arrayOfBackgroundColor[1]),
                                             blue: CGFloat(arrayOfBackgroundColor[2]),
                                             alpha: 1)
    }
    
    
   
}
