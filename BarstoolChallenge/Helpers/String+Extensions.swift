import Foundation

extension String {
    
    public func convertToHTMLAttrStr() -> NSAttributedString {
        let attributedStr = try! NSAttributedString(
            data: self.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options:[NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        return attributedStr
    }
    
}
