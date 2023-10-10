//
//  TextFieldWithPadding.swift
//  ozinsheDemo4
//
//  Created by Ернат on 17.08.2023.
//

import UIKit
// этот кл для того чтобы был отступ от иконке потому как икс коде нет функции от ступа и мы задаем этот от чтоб при помощи кода
class TextFieldWithPadding: UITextField {
    
//Этот код определяет пользовательский подкласс TextFieldWithPadding, который наследуется от стандартного класса UITextField. Он добавляет новую функциональность для создания текстового поля с отступами.
    var padding = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 16);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

}
