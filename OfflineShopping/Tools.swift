import Foundation
import UIKit

func resizeImageToNSData(image:UIImage, maxHeight: Float, maxWidth: Float) -> NSData?
{
    var actualHeight:Float = Float(image.size.height)
    var actualWidth:Float = Float(image.size.width)
    
    var imgRatio:Float = actualWidth/actualHeight
    let maxRatio:Float = maxWidth/maxHeight
    
    if (actualHeight > maxHeight) || (actualWidth > maxWidth)
    {
        if(imgRatio < maxRatio)
        {
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio)
        {
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else
        {
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    let rect:CGRect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
    UIGraphicsBeginImageContext(rect.size)
    image.draw(in: rect)
    
    
    
    let img:UIImage? = UIGraphicsGetImageFromCurrentImageContext()
    guard let theImg = img else {
        UIGraphicsEndImageContext()
        return nil
    }
    
    let imageData: Data? = UIImagePNGRepresentation(theImg)
    UIGraphicsEndImageContext()
    
//  return UIImage(data: imageData)
    return imageData as NSData?
}
