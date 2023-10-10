//
//  LanguageViewController.swift
//  ozinsheDemo4
//
//  Created by Ернат on 13.08.2023.
//
//MARK: Импорт необходимых библиотек
//библиотека, содержащая основные классы и значения, используемые для создания пользовательского интерфейса.
import UIKit
//библиотека, позволяющая легко добавлять и управлять разными языками в приложении.
import Localize_Swift

//MARK: Создание протокола
// протокол, который определяет стандартный интерфейс для объектов, которые хотят обновлять язык в приложении.
protocol LanguageProtocol {
    func languageDidChange()
}
//MARK: Создание класса LanguageViewController
//класс, который наследует функциональность от класса UIViewController и используется для управления языками в приложении.
class LanguageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
 //MARK: Переменные и константы
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var tabelview: UITableView!
    @IBOutlet weak var backgroundView: UIView!
    var viewTranslation = CGPoint(x: 0, y: 0)
    // переменная, которая будет хранить ссылку на объект, реализующий протокол LanguageProtocol.
    var delegate: LanguageProtocol?
    //константа, которая хранит массив с доступными языками в приложении.
    let languageArray = [["English", "en"], ["Қазақша", "kk"], ["Русский", "ru"]]
    //MARK: Метод viewDidLoad()
    //метод, который вызывается при загрузке экрана и используется для настройки интерфейса.
    override func viewDidLoad() {
        //вызов базовой реализации метода
        super.viewDidLoad()
        //MARK: Настройка таблицы и интерфейса
        //установка делегата для таблицы, который будет отвечать за обработку действий пользователя в таблице.
        tabelview.delegate = self
        //установка источника данных для таблицы, который будет предоставлять данные для отображения в ячейках.
        tabelview.dataSource = self
        // Do any additional setup after loading the view.
        //настройка скругления углов для фона нашего экрана.
        backgroundView.layer.cornerRadius = 32
        backgroundView.clipsToBounds = true
        // определение, какие углы необходимо скруглить.
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        //создание жеста нажатия на экран.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        //установка делегата для обработки жеста нажатия.
        tap.delegate = self
        //добавление жеста нажатия на наш экран.
        view.addGestureRecognizer(tap)
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
    }
    //MARK: Метод dismissView()
    //метод, который вызывается при нажатии на экран и закрывает текущий экран.
    @objc func dismissView() {
        //закрытие текущего экрана с анимацией.
        self.dismiss(animated: true, completion: nil)
    }
   
    //MARK: Метод gestureRecognizer()
    //метод, который проверяет, нужно ли обрабатывать жест нажатия.
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        //проверка, является ли вью, на которое нажали, дочерним для нашего фона.
        if (touch.view?.isDescendant(of: backgroundView))! {
            return false
        }
        //возвращаем значение true, если нужно обрабатывать жест нажатия.
        return true
    }
    
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
        switch sender.state {
            case .changed:
                viewTranslation = sender.translation(in: view)
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.backgroundView.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
                })
            case .ended:
                if viewTranslation.y < 100 {
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        self.backgroundView.transform = .identity
                    })
                } else {
                    dismiss(animated: true, completion: nil)
                }
            default:
                break
        }
    }
    
    
    //MARK: Методы для работы с таблицей
    //метод, который возвращает количество строк в таблице.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageArray.count
    }
    //метод, который возвращает ячейку для определенной строки.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = languageArray[indexPath.row][0]
        
        let checkImageView = cell.viewWithTag(1001) as! UIImageView
        
        if Localize.currentLanguage() == languageArray[indexPath.row][1] {
            checkImageView.image = UIImage(named: "Check")
        } else {
            checkImageView.image = nil
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    //MARK: Метод для смены языка
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //установка выбранного языка.
        Localize.setCurrentLanguage(languageArray[indexPath.row][1])
        //вызов метода для обновления языка в приложении.
        delegate?.languageDidChange()
        //закрытие текущего экрана с анимацией.
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//1. Импортируются необходимые библиотеки: UIKit для работы с пользовательским интерфейсом и Localize_Swift для управления поддерживаемыми языками приложения.
//
//2. Создается протокол `LanguageProtocol`, который содержит `languageDidChange()`. Этот метод будет вызываться у объектов, которые реализуют этот протокол, когда в приложении изменится язык.
//
//3. Создается класс `LanguageViewController`, который наследует от `UIViewController` и реализует протоколы `UITableViewDelegate` и `UIGestureRecognizerDelegate`.
//
//4. Объявляются аутлеты для элементов интерфейса: для отображения текущего языка (`languageLabel`), для отображения списка языков (`tabelview`), и фонового вида (`backgroundView`).
//
//5. Создается переменная `delegate`, которая будет хранить ссылку на объект, реализующий протокол `LanguageProtocol`, и создается массив `languageArray`, который содержит список поддерживаемых языков приложения.
//
//6. Настройка экрана производится в методе `viewDidLoad()`.
//
//7. Создается метод `dismissView()`, который обрабатывает жест тапа (нажатия) по экрану и закрывает текущий экран.
//
//8. В методе `gestureRecognizer(_, shouldReceive:)` определяется, как реагировать на жест: если требуется обработать нажатие или ему нужно просто проигнорировать.
//
//9. Конфигурируются методы для работы с таблицей: `tableView(_, numberOfRowsInSection)` определяет количество строк в таблице, `tableView(_, cellForRowAt)` настраивает внешний вид каждой ячейки, `tableView(_, heightForRowAt:)` определяет высоту ячейки, и `tableView(_, didSelectRowAt:)` обрабатывает выбор определенной ячейки и обновляет язык приложения.
//
