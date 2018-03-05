//
//  Tool.swift
//  YKFSwift
//
//  Created by 魏子建 on 2017/3/22.
//  Copyright © 2017年 魏子建. All rights reserved.
//

import UIKit

let SCREEN = UIScreen.main.bounds.size

func minX(view:UIView) ->CGFloat {
    return view.frame.origin.x
}

func maxX(view:UIView) ->CGFloat {
    return view.frame.origin.x + sizeH(view: view)
}

func minY(view:UIView) ->CGFloat {
    return view.frame.origin.y
}

func maxY(view:UIView) ->CGFloat {
    return view.frame.origin.y + sizeW(view: view)
}

func sizeW(view:UIView) ->CGFloat {
    return view.frame.size.width
}

func sizeH(view:UIView) ->CGFloat {
    return view.frame.size.height
}

func RGBCOLOR(r:CGFloat, g:CGFloat, b:CGFloat) ->UIColor {
    return UIColor.init(red: r, green: g, blue: b, alpha: 1)
}

func HEXCOLOR(hexColor:String) ->UIColor {
    let hex = hexColor as NSString
    
    var color = NSString()
    if hex.length < 6 {
        return UIColor.black
    } else if hex.length == 7 {
        color = hex.substring(from: 1) as NSString
    } else if hex.length == 6 {
        color = hex
    }
    
    var red: CUnsignedInt = 0
    var green: CUnsignedInt = 0
    var blue: CUnsignedInt = 0
    
    var rang = NSRange()
    rang.length = 2
    
    rang.location = 0
    Scanner.init(string: color.substring(with: rang)).scanHexInt32(&red)
    
    rang.location = 2
    Scanner.init(string: color.substring(with: rang)).scanHexInt32(&green)
    
    rang.location = 4
    Scanner.init(string: color.substring(with: rang)).scanHexInt32(&blue)
    
    let result = UIColor.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
    return result
}


extension String {
    /**
     *  截取字符串从index开始
     */
    func substringFromIndex(index : Int) -> String {
        let str = self as NSString
        return str.substring(from:index)
    }
    
    /**
     *  截取字符串到index结束
     */
    func substringToIndex(index : Int) -> String {
        let str = self as NSString
        return str.substring(to:index)
    }
    
    /**
     *  截取字符串range范围
     */
    func substringWithRange(range : NSRange) -> String {
        let str = self as NSString
        return str.substring(with:range)
    }
    
    static func value(object : Any?) -> String {
        var str = ""
        if !NullTool.isNullOrBlank(value: object as AnyObject) {
            str = String.init(format: "%@", object as! CVarArg)
        }
        return str
    }
    
    static func valueAndDefault(object : Any?, defaultValue : String) -> String {
        var str = ""
        if !NullTool.isNullOrBlank(value: object as AnyObject) {
            str = String.init(format: "%@", object as! CVarArg)
        } else {
            if !NullTool.isNullOrBlank(value: defaultValue as AnyObject) {
                str = defaultValue
            }
        }
        return str
    }
    
    /**
     *  获取字符串宽度 高度固定
     *
     *  @param fontSize    字体大小
     *
     *  @param height    高度
     *
     *  @return 日期字符串
     */
    func getWidth(fontSize : CGFloat, height : CGFloat) -> CGFloat {
        let str = self as NSString
        let frame = str.boundingRect(with: CGSize.init(width: 0, height: height), options: [NSStringDrawingOptions.usesFontLeading, NSStringDrawingOptions.usesLineFragmentOrigin], attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: fontSize)], context: nil)
        return frame.size.width
    }
    
    /**
     *  获取字符串高度  宽度固定
     *
     *  @param fontSize    字体大小
     *
     *  @param width    宽度
     *
     *  @return 日期字符串
     */
    func getHeight(fontSize : CGFloat, width : CGFloat) -> CGFloat {
        let str = self as NSString
        let frame = str.boundingRect(with: CGSize.init(width: width, height: 0), options: [NSStringDrawingOptions.usesFontLeading, NSStringDrawingOptions.usesLineFragmentOrigin], attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: fontSize)], context: nil)
        return frame.size.width
    }
}

extension UILabel {
    
    /**
     *  自适应宽度
     */
    func autoSizeWidthWith() -> Void {
        let str = self.text! as NSString
        let frame = str.boundingRect(with: CGSize.init(width: 0, height: sizeH(view: self)), options: [NSStringDrawingOptions.usesFontLeading, NSStringDrawingOptions.usesLineFragmentOrigin], attributes: [NSFontAttributeName : self.font], context: nil)
        self.frame = CGRect.init(x: minX(view: self), y: minY(view: self), width: frame.size.width, height: sizeH(view: self))
    }
    
    /**
     *  自适应高度
     */
    func autoSizeHeight() -> Void {
        let str = self.text! as NSString
        let frame = str.boundingRect(with: CGSize.init(width: sizeW(view: self), height: 0), options: [NSStringDrawingOptions.usesFontLeading, NSStringDrawingOptions.usesLineFragmentOrigin], attributes: [NSFontAttributeName : self.font], context: nil)
        self.frame = CGRect.init(x: minX(view: self), y: minY(view: self), width: sizeW(view: self), height: frame.size.height)
    }
    
    func addAttribute(attribute : NSString, value : AnyObject, rang: NSRange) -> Void {
        let attribtedS = NSMutableAttributedString.init(attributedString: self.attributedText!)
        attribtedS.addAttributes([attribute as String : value], range: rang)
        self.attributedText = attribtedS
    }
    
    /**
     *  改变行间距
     *
     *  @param space    行间距
     *
     *  @return 日期字符串
     */
    func changeLineSpace(space : CGFloat) -> Void {
        let attribtedS = NSMutableAttributedString.init(attributedString: self.attributedText!)
        attribtedS.addAttributes([NSFontAttributeName : self.font], range: NSRange.init(location: 0, length: (self.text?.characters.count)!))
        let style = NSMutableParagraphStyle.init()
        style.lineSpacing = space
        attribtedS.addAttributes([NSParagraphStyleAttributeName : style], range: NSRange.init(location: 0, length: (self.text?.characters.count)!))
        self.attributedText = attribtedS
    }
}

extension Date {
    enum FormatType {
        case YMD
        case yMD
        case MD
        case YMDHMS
        case yMDHMS
    }
    
    /**
     *  时间戳转日期字符串
     *
     *  @param timesTamp 时间戳
     *  @param format    日期格式
     *
     *  @return 日期字符串
     */
    func string(format : FormatType) -> String {
        if NullTool.isNullOrBlank(value: self as AnyObject) {
            return ""
        }
        let formatter = DateFormatter.init()
        switch format {
        case .YMD:
            formatter.dateFormat = "yyyy-MM-dd"
        case .yMD:
            formatter.dateFormat = "yy-MM-dd"
        case .YMDHMS:
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        case .yMDHMS:
            formatter.dateFormat = "yy-MM-dd HH:mm:ss"
        case .MD:
            formatter.dateFormat = "MM-dd"
        }
        return formatter.string(from: self)
    }
    
    /**
     *  时间戳转日期字符串
     *
     *  @param timesTamp 时间戳
     *
     *  @return 日期字符串
     */
    static func string(timesTamp : CGFloat, format : FormatType) -> String {
        let date = Date.init(timeIntervalSince1970: TimeInterval(timesTamp))
        return date.string(format: format)
    }
    
    /**
     *  日期字符串转日期格式
     *
     *  @param timesTamp 时间戳
     *
     *  @return Date
     */
    static func date(dateString : String, format : FormatType) -> Date {
        let formatter = DateFormatter.init()
        switch format {
        case .YMD:
            formatter.dateFormat = "yyyy-MM-dd"
        case .yMD:
            formatter.dateFormat = "yy-MM-dd"
        case .YMDHMS:
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        case .yMDHMS:
            formatter.dateFormat = "yy-MM-dd HH:mm:ss"
        case .MD:
            formatter.dateFormat = "MM-dd"
        }
        return formatter.date(from: dateString)!
    }
    
    /**
     *  日期格式转周几
     */
    func week() -> String {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd"
        let weekDays = ["", "周日", "周一", "周二", "周三", "周四", "周五", "周六"] as [Any]
        var calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        let timeZone = TimeZone.init(identifier: "Asia/Shanghai")
        calendar.timeZone = timeZone!
        let theComponents = calendar.component(Calendar.Component.weekday, from: self)
        return weekDays[theComponents] as! String
    }
    
    /**
     *  日期字符串转周几
     */
    static func week(dateString : String, format : FormatType) -> String {
        let date = Date.date(dateString: dateString, format: format)
        return date.week()
    }
}

extension UIAlertController {
    typealias callBack = ()->Void
    static func alertShow(viewController : UIViewController, title : String, message : String, determineAction : String, cancelAction : String, determine : @escaping callBack, cancel : @escaping callBack) -> Void {
        let alertC = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAC = UIAlertAction.init(title: cancelAction, style: UIAlertActionStyle.cancel) { (action) in
            cancel()
        }
        let determineAC = UIAlertAction.init(title: determineAction, style: UIAlertActionStyle.default) { (action) in
            determine()
        }
        if !NullTool.isNullOrBlank(value: cancelAction as AnyObject) {
            alertC.addAction(cancelAC)
        }
        if !NullTool.isNullOrBlank(value: determineAction as AnyObject) {
            alertC.addAction(determineAC)
        }
        viewController.present(alertC, animated: true, completion: nil)
    }
}

extension UIImage {
    /*  压缩成指定大小的图片
    *
    *  @param newSize 需要压缩的图片尺寸
    *  @param image   需要压缩的图片
    *
    *  @return 压缩后的图片
    */
    static func imageByScaleAndCroping(size : CGSize, image : UIImage) -> UIImage {
        var newImage : UIImage
        //创建一个bitmap 的context ，并把它设置成当前正在使用的context ，
        UIGraphicsBeginImageContext(size);
        //绘制改变大小的图片，
        image.drawAsPattern(in: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        //从当前的context 中创建一个改变大小后的图片，
        newImage = UIGraphicsGetImageFromCurrentImageContext()!;
        //让当前的context出堆栈，
        UIGraphicsEndImageContext();
        return newImage
    }
    
    /**
     *  等比例压缩
     *
     *  @param image 需要压缩的图片
     *  @param size  <#size description#>
     *
     *  @return 压缩后的图片
     */
    static func imageCompress(size : CGSize, image : UIImage) -> UIImage {
        var newImage : UIImage
        let imageSize = image.size
        let width = imageSize.width
        let height  = imageSize.height
        let targetWidth = size.width
        let targetHeight = size.height
        var scaleFactor : CGFloat
        var scaleWidth = targetWidth
        var scaleHeight = targetHeight
        var thumbnailPoint = CGPoint.init(x: 0, y: 0)
        if __CGSizeEqualToSize(imageSize, size) == false {
            let widthFactor = targetWidth / width
            let heightFactor = targetHeight / height
            if widthFactor > heightFactor {
                scaleFactor = CGFloat(widthFactor)
            } else {
                scaleFactor = CGFloat(heightFactor)
            }
            scaleWidth = width * scaleFactor
            scaleHeight = height * scaleFactor
            if widthFactor > heightFactor {
                thumbnailPoint.y = (targetHeight - scaleHeight) * 0.5
            } else if widthFactor < heightFactor {
                thumbnailPoint.x = (targetWidth - scaleWidth) * 0.5
            }
        }
  
        UIGraphicsBeginImageContext(size)
        var thumbnailRect = CGRect.zero
        thumbnailRect.origin = thumbnailPoint
        thumbnailRect.size.width = scaleWidth
        thumbnailRect.size.height = scaleHeight
        image.draw(in: thumbnailRect)
        newImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return newImage;
    }
    
    static func fixOrientation(image : UIImage) -> UIImage {
        //判断图片是否被旋转
        if image.imageOrientation == .up {
            return image
        }
        var transform = CGAffineTransform.identity
        
        switch image.imageOrientation {
        case .down: break
        case .downMirrored:
            transform = transform.translatedBy(x: image.size.width, y: image.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        case .left: break
        case .leftMirrored:
            transform = transform.translatedBy(x: image.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2))
        case .right: break
        case .rightMirrored:
            transform = transform.translatedBy(x: 0, y: image.size.height)
            transform = transform.rotated(by: CGFloat(-Double.pi / 2))
        default: break
        }
        switch (image.imageOrientation) {
        case .upMirrored: break
        case .down:
            transform = transform.translatedBy(x: image.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored: break
        case .rightMirrored:
            transform = transform.translatedBy(x: 0, y: image.size.height)
            transform = transform.scaledBy(x: -1, y: 1)
        default: break
        }
        
        let ctx = CGContext.init(data: nil, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: image.cgImage!.bitsPerComponent, bytesPerRow: 0, space: image.cgImage!.colorSpace!, bitmapInfo: image.cgImage!.bitmapInfo.rawValue)
        ctx?.concatenate(transform)
        switch image.imageOrientation {
        case .left: break
        case .leftMirrored: break
        case .right: break
        case .rightMirrored:
            ctx?.draw(image.cgImage!, in: CGRect.init(x: 0, y: 0, width: image.size.height, height: image.size.width))
        default:
            ctx?.draw(image.cgImage!, in: CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height))
            break;
        }
        let cgImage = ctx?.makeImage()
        let newImage = UIImage.init(cgImage: cgImage!)
        return newImage
    }
}

