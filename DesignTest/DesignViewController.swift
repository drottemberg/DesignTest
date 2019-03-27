import UIKit

class DesignViewController: UIViewController {

    let labelHeight: CGFloat = 35.0
    let rowSpace: CGFloat = 10.0
    let fontSize: CGFloat = 27.0
    let leftSpace: CGFloat = 8.0
    let bottomSpace: CGFloat = 8.0
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    // MARK: - Overriden Methods
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        highlight(text: "CHARLOTTE PERRIAND'S \"La maison au bord de l’eau\"", label: textLabel)
    }

    // MARK: - Private Methods
    
    private func highlight(text: String, label: UILabel) {
//        let font = UIFont(name: "HiraMinProN-W3", size: 32.0)!
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = rowSpace
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.foregroundColor: UIColor.clear,
                          NSAttributedString.Key.backgroundColor: UIColor.clear,
                          NSAttributedString.Key.paragraphStyle: paragraphStyle]
        let str = NSAttributedString(string: text.uppercased(), attributes: attributes)

        label.attributedText = str
        
        let lines: [String] = getLinesArrayOfString(in: label)
        print("lines count: \(lines.count)")
        var count: CGFloat = 1.0
        for line in lines.reversed() {
            var rowString = " " + line
            if(rowString.last != " ")
            {
                rowString = rowString + " "
            }
            let width = rowString.width(withConstrainedHeight: 0, font: font)
            var origin = bgImageView.bounds.origin
            origin.x = leftSpace
            origin.y = bgImageView.frame.height - bottomSpace - (labelHeight + rowSpace) * count
            let reck = CGRect(origin: origin, size: CGSize(width: width, height: labelHeight))
            let lineLabel = UILabel(frame: reck)
            lineLabel.font = font
            lineLabel.text = rowString
            lineLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            bgImageView.addSubview(lineLabel)
            count = count + 1
        }
    }

    func getLinesArrayOfString(in label: UILabel) -> [String] {
        
        /// An empty string's array
        var linesArray = [String]()
        
        guard let text = label.text, let font = label.font else {return linesArray}
        
        let rect = label.frame
        
        let myFont: CTFont = CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil)
        let attStr = NSMutableAttributedString(string: text)
        attStr.addAttribute(kCTFontAttributeName as NSAttributedString.Key, value: myFont, range: NSRange(location: 0, length: attStr.length))
        
        let frameSetter: CTFramesetter = CTFramesetterCreateWithAttributedString(attStr as CFAttributedString)
        let path: CGMutablePath = CGMutablePath()
        path.addRect(CGRect(x: 0, y: 0, width: rect.size.width, height: 100000), transform: .identity)
        
        let frame: CTFrame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)
        guard let lines = CTFrameGetLines(frame) as? [Any] else {return linesArray}
        
        for line in lines {
            let lineRef = line as! CTLine
            let lineRange: CFRange = CTLineGetStringRange(lineRef)
            let range = NSRange(location: lineRange.location, length: lineRange.length)
            let lineString: String = (text as NSString).substring(with: range)
            linesArray.append(lineString)
        }
        return linesArray
    }
    
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
