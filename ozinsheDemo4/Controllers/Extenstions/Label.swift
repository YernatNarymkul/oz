//
//  Label.swift
//  ozinsheDemo4
//
//  Created by Ернат on 26.09.2023.
//

import UIKit
//Для посчета линий лейбла на экране (сколько он будет использовать)
extension UILabel {
    var maxNumberOfLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
}
