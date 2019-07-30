import UIKit
import SwiftSoup

class JobDetailModalViewController: UIViewController {
    
    private struct Constants {
        static let leadingSpaceNormal: CGFloat = 5.0
        static let topSpaceNormal: CGFloat = 10.0
        static let headerTitleSize: CGFloat = 20.0
        static let urlLabelTextSize: CGFloat = 15.0
        static let urlLabelHeight: CGFloat = 50.0
        static let descriptionTextViewMaxHeight: CGFloat = 180.0
        static let howToApplyTextViewMaxHeight: CGFloat = 95.0
        static let exitModalButtonSize: CGFloat = 30.0
        static let descriptionHeaderText: String = "Job Description"
        static let howToApplyHeaderText: String = "How to Apply"
        static let linksHeaderText: String = "Links"
        static let exitModalImage: String = "cancel"
        static let companyUrlButtonText: String = "Company Website"
        static let jobPostingUrlButtonText: String = "View Job Posting"
        static let buttonSpacing: CGFloat = 15.0
        static let buttonWidthMultiplier: CGFloat = 0.9
        static let buttonHeight: CGFloat = 50.0
        static let buttonTextSize: CGFloat = 18.0
    }
    
    var job: Job! {
        didSet {
            titleLabel.text = job.title ?? ""
            companyLabel.text = job.company ?? ""
            locationLabel.text = job.location ?? ""
            typeLabel.text = job.type ?? ""
            
            guard let jobDescriptionDoc: Document = try? SwiftSoup.parse(job.description ?? "") else { return }
            guard let jobDescription = try? jobDescriptionDoc.text() else { return }
            descriptionContent.text = jobDescription
            
            guard let howToApplyDoc: Document = try? SwiftSoup.parse(job.howToApply ?? "") else { return }
            guard let howToApplyDescription = try? howToApplyDoc.text() else { return }
            howToApplyContent.text = howToApplyDescription
            
            if let possibleCompanyUrl = job.companyUrl {
                companyUrlButton.isHidden = false
                companyUrl = possibleCompanyUrl
            } else {
                companyUrlButton.isHidden = true
            }
            
            if let possibleJobUrl = job.url {
                jobUrlButton.isHidden = false
                jobUrl = possibleJobUrl
            } else {
                jobUrlButton.isHidden = true
            }
            
        }
    }
    
    var companyUrl: String?
    var jobUrl: String?
    
    // MARK:- View Components
    var companyLogoImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    var exitModalButton: UIButton = {
        let button = UIButton()
        let image = UIImage.init(named: Constants.exitModalImage)
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        
        return button
    }()
    
    @objc func dismissModal() {
        dismiss(animated: true, completion: nil)
    }
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Avenir.heavy.rawValue, size: 22.0)
        label.numberOfLines = 2
        return label
    }()
    
    var companyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Avenir.lightOblique.rawValue, size: 17.0)
        return label
    }()
    
    var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Avenir.lightOblique.rawValue, size: 17.0)
        return label
    }()
    
    var typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Avenir.light.rawValue, size: 15.0)
        return label
    }()
    
    var descriptionLabelHeader: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Avenir.medium.rawValue, size: Constants.headerTitleSize)
        label.text = Constants.descriptionHeaderText
        return label
    }()
    
    var descriptionContent: UITextView = {
        let textView = UITextView()
        textView.flashScrollIndicators()
        textView.font = UIFont(name: Avenir.light.rawValue, size: 15.0)
        textView.isEditable = false
        return textView
    }()
    
    var howToApplyLabelHeader: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Avenir.medium.rawValue, size: Constants.headerTitleSize)
        label.text = Constants.howToApplyHeaderText
        return label
    }()
    
    var howToApplyContent: UITextView = {
        let textView = UITextView()
        textView.flashScrollIndicators()
        textView.font = UIFont(name: Avenir.light.rawValue, size: 15.0)
        textView.isEditable = false
        textView.dataDetectorTypes = UIDataDetectorTypes.all
        return textView
    }()
    
    var companyUrlButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.companyUrlButtonText, for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.font = UIFont(name: Avenir.medium.rawValue, size: Constants.buttonTextSize)
        button.addTarget(self, action: #selector(goToCompanyUrl), for: .touchUpInside)
        return button
    }()
    
    @objc func goToCompanyUrl() {
        if let url = URL(string: companyUrl ?? "") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    var jobUrlButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.jobPostingUrlButtonText, for: .normal)
        button.titleLabel?.font = UIFont(name: Avenir.mediumOblique.rawValue, size: Constants.buttonTextSize)
        button.addTarget(self, action: #selector(goToJobUrl), for: .touchUpInside)
        button.backgroundColor = .black
        return button
    }()
    
    @objc func goToJobUrl() {
        if let url = URL(string: jobUrl ?? "") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        descriptionContent.setContentOffset(CGPoint.zero, animated: false)
    }
    
    // MARK:- Setup view
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(exitModalButton)
        exitModalButton.translatesAutoresizingMaskIntoConstraints = false
        exitModalButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.leadingSpaceNormal).isActive = true
        if #available(iOS 11.0, *) {
            exitModalButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            exitModalButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        }
        exitModalButton.heightAnchor.constraint(equalToConstant: Constants.exitModalButtonSize).isActive = true
        exitModalButton.widthAnchor.constraint(equalToConstant: Constants.exitModalButtonSize).isActive = true
        
        view.addSubview(titleLabel)
        if #available(iOS 11.0, *) {
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        }
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingSpaceNormal).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: exitModalButton.leadingAnchor, constant: -3).isActive = true
        
        view.addSubview(companyLabel)
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        companyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        companyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingSpaceNormal).isActive = true
        companyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.leadingSpaceNormal).isActive = true
        
        view.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingSpaceNormal).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.leadingSpaceNormal).isActive = true
        
        view.addSubview(typeLabel)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor).isActive = true
        typeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingSpaceNormal).isActive = true
        typeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.leadingSpaceNormal).isActive = true
        
        view.addSubview(descriptionLabelHeader)
        descriptionLabelHeader.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabelHeader.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: Constants.topSpaceNormal).isActive = true
        descriptionLabelHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingSpaceNormal).isActive = true
        descriptionLabelHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.leadingSpaceNormal).isActive = true
        
        view.addSubview(descriptionContent)
        descriptionContent.translatesAutoresizingMaskIntoConstraints = false
        descriptionContent.topAnchor.constraint(equalTo: descriptionLabelHeader.bottomAnchor, constant: Constants.topSpaceNormal).isActive = true
        descriptionContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingSpaceNormal).isActive = true
        descriptionContent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.leadingSpaceNormal).isActive = true
        descriptionContent.heightAnchor.constraint(lessThanOrEqualToConstant: Constants.descriptionTextViewMaxHeight).isActive = true
        
        view.addSubview(howToApplyLabelHeader)
        howToApplyLabelHeader.translatesAutoresizingMaskIntoConstraints = false
        howToApplyLabelHeader.topAnchor.constraint(equalTo: descriptionContent.bottomAnchor, constant: Constants.topSpaceNormal).isActive = true
        howToApplyLabelHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingSpaceNormal).isActive = true
        howToApplyLabelHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.leadingSpaceNormal).isActive = true
        
        view.addSubview(howToApplyContent)
        howToApplyContent.translatesAutoresizingMaskIntoConstraints = false
        howToApplyContent.topAnchor.constraint(equalTo: howToApplyLabelHeader.bottomAnchor, constant: Constants.topSpaceNormal).isActive = true
        howToApplyContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingSpaceNormal).isActive = true
        howToApplyContent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.leadingSpaceNormal).isActive = true
        howToApplyContent.heightAnchor.constraint(lessThanOrEqualToConstant: Constants.howToApplyTextViewMaxHeight).isActive = true
        
        view.addSubview(companyUrlButton)
        companyUrlButton.translatesAutoresizingMaskIntoConstraints = false
        companyUrlButton.topAnchor.constraint(equalTo: howToApplyContent.bottomAnchor, constant: Constants.topSpaceNormal).isActive = true
        companyUrlButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        companyUrlButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.buttonWidthMultiplier).isActive = true
        companyUrlButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
        
        view.addSubview(jobUrlButton)
        jobUrlButton.translatesAutoresizingMaskIntoConstraints = false
        jobUrlButton.topAnchor.constraint(equalTo: companyUrlButton.bottomAnchor, constant: Constants.buttonSpacing).isActive = true
        jobUrlButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        jobUrlButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.buttonWidthMultiplier).isActive = true
        jobUrlButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
        
    }
}
