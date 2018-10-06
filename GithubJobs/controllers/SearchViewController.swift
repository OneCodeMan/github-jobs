import UIKit
import BEMCheckBox

class SearchViewController: UIViewController {
    
    private struct Constants {
        static let viewTitle: String = "Github Jobs"
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
    
    let viewBuilder = ViewBuilder()
    
    //MARK:- View components
    func buildTextInputField(withPlaceholder placeholder: String, height: CGFloat) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.7
        textField.layer.cornerRadius = 5.0
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        
        return textField
    }
    
    var jobTextField: UITextField!
    var locationTextField: UITextField!
    var fullTimeCheckbox: BEMCheckBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK:- Setup view
    private func setupView() {
        title = Constants.viewTitle
        view.backgroundColor = .white
        
        navigationItem.hidesBackButton = true
        
        let jobHeaderView = viewBuilder.buildHeaderView(withText: Constants.jobTitleHeader, ofSize: Constants.titleSize)
        view.addSubview(jobHeaderView)
        jobHeaderView.translatesAutoresizingMaskIntoConstraints = false
        jobHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.normalLeading).isActive = true
        if #available(iOS 11.0, *) {
            jobHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            jobHeaderView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        }
        
        jobTextField = buildTextInputField(withPlaceholder: Constants.jobTextFieldPlaceholder, height: Constants.textFieldHeight)
        view.addSubview(jobTextField)
        jobTextField.isUserInteractionEnabled = true
        jobTextField.translatesAutoresizingMaskIntoConstraints = false
        jobTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.normalLeading).isActive = true
        jobTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.normalLeading).isActive = true
        jobTextField.topAnchor.constraint(equalTo: jobHeaderView.bottomAnchor, constant: 2).isActive = true
        jobTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight).isActive = true
        
        let locationHeaderView = viewBuilder.buildHeaderView(withText: Constants.jobLocationHeader, ofSize: Constants.titleSize)
        view.addSubview(locationHeaderView)
        locationHeaderView.translatesAutoresizingMaskIntoConstraints = false
        locationHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.normalLeading).isActive = true
        locationHeaderView.topAnchor.constraint(equalTo: jobTextField.bottomAnchor).isActive = true
        
        locationTextField = buildTextInputField(withPlaceholder: Constants.jobLocationTextFieldPlaceholder, height: Constants.textFieldHeight)
        view.addSubview(locationTextField)
        locationTextField.isUserInteractionEnabled = true
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        locationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.normalLeading).isActive = true
        locationTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.normalLeading).isActive = true
        locationTextField.topAnchor.constraint(equalTo: locationHeaderView.bottomAnchor, constant: 2).isActive = true
        locationTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight).isActive = true
        
        let isFullTimeLabel = UILabel()
        view.addSubview(isFullTimeLabel)
        isFullTimeLabel.font = UIFont(name: Avenir.medium.rawValue, size: Constants.titleSize)
        isFullTimeLabel.textColor = .black
        isFullTimeLabel.text = Constants.isFullTimeText
        isFullTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        isFullTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.normalLeading).isActive = true
        isFullTimeLabel.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 12).isActive = true
        
        fullTimeCheckbox = BEMCheckBox()
        view.addSubview(fullTimeCheckbox)
        fullTimeCheckbox.translatesAutoresizingMaskIntoConstraints = false
        fullTimeCheckbox.leadingAnchor.constraint(equalTo: isFullTimeLabel.trailingAnchor, constant: Constants.normalLeading).isActive = true
        fullTimeCheckbox.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 10).isActive = true
        fullTimeCheckbox.heightAnchor.constraint(equalToConstant: Constants.checkboxSize).isActive = true
        fullTimeCheckbox.widthAnchor.constraint(equalToConstant: Constants.checkboxSize).isActive = true
        
        fullTimeCheckbox.onTintColor = .black
        fullTimeCheckbox.onCheckColor = .white
        fullTimeCheckbox.onFillColor = .black
        
        let searchButton = UIButton()
        view.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setTitle(Constants.searchButtonTitle, for: .normal)
        searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        searchButton.backgroundColor = .black
        searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.normalLeading).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.normalLeading).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: Constants.searchButtonHeight).isActive = true
        searchButton.topAnchor.constraint(equalTo: fullTimeCheckbox.bottomAnchor, constant: 10).isActive = true
    }
    
    @objc func searchButtonClicked() {
        print("tapped")
        let jobTitle = jobTextField.text ?? ""
        let jobLocation = locationTextField.text ?? ""
        let isFullTime = fullTimeCheckbox.on
        
        let vc = JobsViewController()
        vc.jobTitle = jobTitle
        vc.jobLocation = jobLocation
        vc.isFullTime = isFullTime
        navigationController?.pushViewController(vc, animated: true)
    }

}
