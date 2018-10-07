import UIKit
import SwiftSoup

class JobCell: UITableViewCell {
    
    private struct Constants {
        static let leadingSpaceNormal: CGFloat = 5.0
        static let dateFormat: String = "EEE MMM dd HH:mm:ss ZZZZ yyyy"
        static let dateLocale: String = "en_US_POSIX"
        static let secondsInADay: Double = 86400
    }
    
    var job: Job! {
        didSet {
            jobTitleLabel.text = job.title ?? ""
            companyNameLabel.text = job.company ?? ""
            locationLabel.text = job.location ?? ""
            
            guard let doc: Document = try? SwiftSoup.parse(job.description ?? "") else { return }
            guard let jobDescription = try? doc.text() else { return }
            descriptionLabel.text = jobDescription 
            datePostedLabel.text = "Posted \(timeFrom(date: job.createdAt ?? ""))"
        }
    }
    
    // MARK:- View Components
    var jobTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Avenir.medium.rawValue, size: 19.0)
        label.numberOfLines = 2
        return label
    }()
    
    var companyNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Avenir.lightOblique.rawValue, size: 17.0)
        return label
    }()
    
    var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Avenir.light.rawValue, size: 17.0)
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Avenir.light.rawValue, size: 15.0)
        label.numberOfLines = 4
        return label
    }()
    
    var datePostedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Avenir.lightOblique.rawValue, size: 15.0)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    private func setupView() {
        addSubview(jobTitleLabel)
        jobTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        jobTitleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        jobTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingSpaceNormal).isActive = true
        jobTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        addSubview(companyNameLabel)
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        companyNameLabel.topAnchor.constraint(equalTo: jobTitleLabel.bottomAnchor).isActive = true
        companyNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingSpaceNormal).isActive = true
        companyNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingSpaceNormal).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingSpaceNormal).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        addSubview(datePostedLabel)
        datePostedLabel.translatesAutoresizingMaskIntoConstraints = false
        datePostedLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        datePostedLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingSpaceNormal).isActive = true
        datePostedLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func timeFrom(date: String) -> String {
        let currentCalendar = NSCalendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Constants.dateLocale)
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = Constants.dateFormat
        let datePosted = dateFormatter.date(from: date) ?? Date()
        
        if currentCalendar.isDateInToday(datePosted) {
            return "Today"
        } else if currentCalendar.isDateInYesterday(datePosted) {
            return "Yesterday"
        } else {
            let timeInterval = -datePosted.timeIntervalSinceNow
            let daysAgo = Int(timeInterval / Constants.secondsInADay)
            return "\(daysAgo) days ago"
        }
        
    }
    
}
