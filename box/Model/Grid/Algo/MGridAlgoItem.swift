import UIKit
import CoreLocation

class MGridAlgoItem
{
    let firebaseId:String
    let location:CLLocation
    let created:TimeInterval
    var multipliedHeading:Float
    private(set) var distance:CLLocationDistance?
    private(set) var heading:Float
    private let k180:Double = 180
    private let kHour:TimeInterval = 3600
    
    init(
        firebaseId:String,
        latitude:Double,
        longitude:Double,
        created:TimeInterval)
    {
        location = CLLocation(latitude:latitude, longitude:longitude)
        heading = 0
        multipliedHeading = 0
        self.firebaseId = firebaseId
        self.created = created
    }
    
    //MARK: private
    
    private func degreesToRadians(degrees:Double) -> Double
    {
        return degrees * Double.pi / k180
    }
    
    private func radiansToDegrees(radians:Double) -> Double
    {
        return radians * k180 / Double.pi
    }
    
    private func headingFrom(reference:CLLocationCoordinate2D) -> Float
    {
        let referenceLatitude:Double = degreesToRadians(
            degrees:reference.latitude)
        let referenceLongitude:Double = degreesToRadians(
            degrees:reference.longitude)
        let latitude:Double = degreesToRadians(
            degrees:location.coordinate.latitude)
        let longitude:Double = degreesToRadians(
            degrees:location.coordinate.longitude)
        
        let deltaLongitude:Double = longitude - referenceLongitude
        let sinDeltaLongitude:Double = sin(deltaLongitude)
        let cosLatitude:Double = cos(latitude)
        let cosReferenceLatitude:Double = cos(referenceLatitude)
        let sinLatitude:Double = sin(latitude)
        let sinReferenceLatitude:Double = sin(referenceLatitude)
        let cosDeltaLongitude:Double = cos(deltaLongitude)
        
        let yPoint:Double = sinDeltaLongitude * cosLatitude
        let xPoint:Double = cosReferenceLatitude * sinLatitude - sinReferenceLatitude * cosLatitude * cosDeltaLongitude
        let radiansBearing:Double = atan2(yPoint, xPoint)
        let degreesBearing:Double = radiansToDegrees(
            radians:radiansBearing)
        let floatBearing:Float = Float(degreesBearing)
        
        return floatBearing
    }
    
    //MARK: public
    
    func firebasePath() -> String
    {
        return firebaseId
    }
    
    func distanceTo(
        location:CLLocation,
        renderReady:Bool)
    {
        distance = self.location.distance(from:location)
    
        if renderReady
        {
            heading = headingFrom(reference:location.coordinate)
        }
    }
    
    func imageStandby() -> UIImage?
    {
        return nil
    }
    
    func imageTargeted() -> UIImage?
    {
        return nil
    }
    
    func imageDetail() -> UIImage?
    {
        return nil
    }
    
    func annotationImageOn() -> UIImage?
    {
        return nil
    }
    
    func annotationImageOff() -> UIImage?
    {
        return nil
    }
    
    func detail() -> MGridVisorDetail
    {
        let model:MGridVisorDetail = MGridVisorDetail()
        
        return model
    }
    
    func titleAnnotation() -> String?
    {
        return nil
    }
    
    //MARK: final
    
    final func age() -> String
    {
        let stringTime:String
        let timestamp:TimeInterval = Date().timeIntervalSince1970
        let deltaTime:TimeInterval = timestamp - created
        let twoHours:TimeInterval = kHour + kHour
        
        if deltaTime < twoHours
        {
            stringTime = NSLocalizedString("MGridAlgoItem_justNow", comment:"")
        }
        else
        {
            let hoursSince:Int = Int(deltaTime / kHour)
            let hoursSinceNumber:NSNumber = hoursSince as NSNumber
            
            stringTime = String(
                format:NSLocalizedString("MGridAlgoItem_hoursAgo", comment:""),
                hoursSinceNumber)
        }
        
        return stringTime
    }
}
