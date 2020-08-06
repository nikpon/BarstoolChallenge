import Foundation
import Alamofire

class ImageDataService {
    
    static let shared = ImageDataService()
    private let cache = NSCache<NSString, DataHolder>()
    
    private init() {}
    
    private func downloadImageData(withURL url: URL, completion: @escaping (_ data: DataHolder?) -> Void) {
        AF.request(url).responseData { (response) in
            var downloadedData: DataHolder?
            
            if let data = response.data {
                downloadedData = DataHolder(data: data)
            }
            
            if let downloadedData = downloadedData {
                self.cache.setObject(downloadedData, forKey: url.absoluteString as NSString)
            }
            
            completion(downloadedData)
        }
    }
    
    func getImageDataHolder(withURL url: URL, completion: @escaping (_ data: DataHolder?) -> Void) {
        if let dataHolder = cache.object(forKey: url.absoluteString as NSString) {
            completion(dataHolder)
        } else {
            downloadImageData(withURL: url, completion: completion)
        }
    }    
    
}
