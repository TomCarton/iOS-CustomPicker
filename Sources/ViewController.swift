//
//  ViewController.swift
//  CustomPicker
//
//  Created by Thomas CARTON
//

import UIKit

class ViewController: UIViewController {

    var picker: CustomPicker?
    var picker2: CustomPicker?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        picker = CustomPicker(frame: CGRect(x: 120, y: 100, width: 160, height: 40))
        if let picker {
            picker.shouldBeSelected = false
            picker.text1 = "First"
            picker.text2 = "Second"

            picker.addTarget(self, action: #selector(choiceControlValueChanged(_:)), for: .valueChanged)

            view.addSubview(picker)
        }

        picker2 = CustomPicker(frame: CGRect(x: 100, y: 160, width: 200, height: 40))
        if let picker2 {
            picker2.text1 = "Enabled"
            picker2.text2 = "Disabled"

            picker2.setSelectedIndex(0)
            picker2.addTarget(self, action: #selector(choiceControlValueChanged(_:)), for: .valueChanged)

            view.addSubview(picker2)
        }
    }

    @objc private func choiceControlValueChanged(_ sender: CustomPicker) {

        if sender == picker {
            // Handle value changes here
            let selectedIndex = (sender as CustomPicker).selectedIndex
            if let selectedIndex {
                if selectedIndex == 0 {
                    print("Option 1 selected")
                } else if selectedIndex == 1 {
                    print("Option 2 selected")
                }
            } else {
                print("None selected")
            }
        } else if sender == picker2 {
            if let index = picker2?.selectedIndex {
                picker?.isEnabled = index == 0
            }
        }
    }
}
