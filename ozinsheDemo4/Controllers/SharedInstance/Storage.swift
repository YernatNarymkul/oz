//
//  Storage.swift
//  ozinsheDemo4
//
//  Created by Ернат on 17.08.2023.
//

import Foundation
import UIKit

class Storage {
    //ДляСохраниниеВводимыхДанных
    public var accessToken: String = ""
    
    //ДляСохранениеСомогоСебяЧтобыВходитьИзЛюбогоЭкрана
    static let sharedInstance = Storage()

}
