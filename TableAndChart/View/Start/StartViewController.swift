//
//  StartViewController.swift
//  TableAndChart
//
//  Created by Mikhail on 08.10.2022.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var inputField: UITextField!
    
    @IBAction func buttonPressed(_ sender: Any) {
        presenter?.buttonPressed(count: Int(inputField.text ?? "") ?? 0)
    }
    
    var presenter: StartPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputField.delegate = self
        inputField.addDoneButtonOnKeyboard()
        setupButton()
        setDataToUI()
    }
    
    private func setupButton() {
        goButton.layer.cornerRadius = 10
    }
    
    private func setDataToUI() {
        descriptionLabel.text = "Приложение запрашивает у сервера определённое количество координат точек (x,\u{00a0}y), а затем отображает полученный ответ в виде таблицы и графика. \n\nСколько вы хотите точек?"
        goButton.setTitle("Поехали!", for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension StartViewController {
    func set(presenter: StartPresenterProtocol) {
        self.presenter = presenter
    }
}

extension StartViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        let maxLength = 2
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        
        return allowedCharacters.isSuperset(of: characterSet) && newString.count <= maxLength
    }
}
