//
//  SubwayViewModel.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/02/23.
//

//import Foundation
//import RxSwift
//import RxCocoa
//import AVKit
//import UserNotifications
//
//class SubwayViewModel {
//    
//    let disposeBag = DisposeBag()
//    var arrivalTime: String = String()
//    var nowStationCode: Int = 0
//    var targetStationCode: Int = 0
//    
//    // MARK: Input
//    
//    let fetchSubwayInfo: AnyObserver<Void>
//    let fetchStart: AnyObserver<Void>
//    
//    // MARK: Output
//    
//    let startInfo: Observable<RealTimeStationArrivalDTO>
//    let travelInfo: Observable<SubwayRouteSearchDTO>
//    
//    init(domain: SubwayService = SubwayService()) {
//        let fetchingTravel = PublishSubject<Void>()
//        let fetchingStart = PublishSubject<Void>()
//        let fetch = PublishSubject<Void>()
//        let start = PublishSubject<RealTimeStationArrivalDTO>()
//        let travel = PublishSubject<SubwayRouteSearchDTO>()
//        
//        fetchSubwayInfo = fetch.asObserver()
//        fetchStart = fetchingStart.asObserver()
//        startInfo = start.asObserver()
//        travelInfo = travel.asObserver()
//    }
//    
//    private func checkValidCode() -> Bool {
//        return nowStationCode != 0 && targetStationCode != 0
//    }
//    
//    private func checkAlarmEnable() {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (didAllow, error) in
//            guard let err = error else {
//                print(didAllow)
//                return
//            }
//            
//            print(err.localizedDescription)
//        }
//    }
//    
//    private func pushArriveAlarm() {
//        let content = UNMutableNotificationContent()
//        
//        content.title = "⏰ 목적지 근접 알림"
//        content.body = "목적지 근처에 도착하였습니다. 하차 준비해주세요. 😃"
//        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//        let request = UNNotificationRequest(identifier: "timer", content: content, trigger: trigger)
//        
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
//    }
//}
