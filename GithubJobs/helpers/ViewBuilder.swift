import Foundation
import UIKit
import BEMCheckBox

class ViewBuilder {

    private struct Constants {
        static let jobTitleHeader: String = "Title"
        static let jobTextFieldPlaceholder: String = "Enter a title.."
        static let jobLocationHeader: String = "Location"
        static let jobLocationTextFieldPlaceholder: String = "Enter a location.."
        static let titleSize: CGFloat = 20.0
        static let normalLeading: CGFloat = 10.0
        static let textFieldHeight: CGFloat = 35.0
        static let checkboxSize: CGFloat = 27.0
        static let isFullTimeText: String = "Full Time"
        static let searchButtonTitle: String = "Search"
        static let searchButtonHeight: CGFloat = 45.0
    }
    
    func buildHeaderView(withText text: String, ofSize size: CGFloat) -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let label = UILabel()
        label.font = UIFont(name: Avenir.heavy.rawValue, size: size)
        label.textAlignment = .left
        label.textColor = .black
        label.text = text
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 5).isActive = true
        
        return view
    }
    
    func buildTextInputField(withPlaceholder placeholder: String, height: CGFloat) -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        let textField = UITextField()
        textField.placeholder = placeholder
        
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.7
        textField.layer.cornerRadius = 5.0
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        textField.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        return view
    }
}
