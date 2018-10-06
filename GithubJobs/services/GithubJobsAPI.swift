import Foundation
import UIKit

class GithubJobsAPI {
    static let shared = GithubJobsAPI()
    
    private let originalUrlString = "https://jobs.github.com/positions.json?"
    private var urlString = "https://jobs.github.com/positions.json?"
    
    private func fetchJobsData<T: Decodable>(urlString: String, completion: @escaping (T) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            if let err = err {
                print("Failed to fetch home feed: ", err)
                return
            }
            
            guard let data = data else { return }
            do {
                let jobFeed = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(jobFeed)
                }
            } catch let jsonErr {
                print("Failed to serialize json: ", jsonErr)
            }
        }.resume()
    }
    
    func getJobs(withDescription description: String = "", location: String = "", isFullTime: Bool = false, completion: @escaping ([Job]?) -> Void) {
        
        if !description.isEmpty {
            urlString.append("description=\(description)&")
        }
        
        if !location.isEmpty {
            urlString.append("location=\(location)&")
        }
        
        if isFullTime {
            urlString.append("full_time=true")
        }
        
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        fetchJobsData(urlString: urlString) { (jobs: [Job]) in
            completion(jobs)
        }
        urlString = originalUrlString
    }
    
}
