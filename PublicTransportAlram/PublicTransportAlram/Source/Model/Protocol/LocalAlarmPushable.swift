//
//  LocalAlarmPushable.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/04/04.
//

import CoreLocation
import UserNotifications

protocol LocalAlarmPushable {
    func checkAlarmEnable()
    func pushArriveAlarm(latitude: String, longitude: String, times: String, radius: String) -> Bool
}

extension LocalAlarmPushable {
    func checkAlarmEnable() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (didAllow, error) in
            guard let err = error else { return }
            
            print(err.localizedDescription)
        }
    }
    
    func pushArriveAlarm(latitude: String, longitude: String, times: String, radius: String) -> Bool {
        if let latitude = Double(latitude),
           let longitude = Double(longitude),
           let times = Int(times),
           let radius = Double(radius) {
            let content = UNMutableNotificationContent()
            
            content.title = "⏰ 목적지 도착"
            content.body = "설정하신 위치에 근접하였습니다."
            content.sound = .default
            
            let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let region = CLCircularRegion(center: center, radius: radius, identifier: "settingLocation")

            region.notifyOnEntry = true
            region.notifyOnExit = false
            
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let trigger = UNLocationNotificationTrigger(region: region, repeats: false)
            var requestList: [UNNotificationRequest] = []
            var requestIdentifierList: [String] = []
            
            for i in 0..<times {
                requestIdentifierList.append("timer" + String(i))
                requestList.append(
                    UNNotificationRequest(identifier: requestIdentifierList[i], content: content, trigger: trigger)
                )
                
                UNUserNotificationCenter.current().add(requestList[i], withCompletionHandler: nil)
            }
            
            return true
        } else {
            return false
        }
    }
}
