//
//  AlertPresentable.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/04/04.
//

import UIKit

protocol AlertPresentable: UIViewController {
    func presentAlarmSettingActionSheet(alarm alarmHandler: @escaping () -> Void,
                                        bookMark bookMarkHandler: @escaping () -> Void,
                                        alarmAndBookMark alarmAndBookMarkHandler: @escaping () -> Void)
    func presentInitAlert(_ initHandler: @escaping () -> Void)
    func presentSettingSuccessAlert()
    func presentSettingFailedAlert()
}

extension AlertPresentable {
    func presentAlarmSettingActionSheet(alarm alarmHandler: @escaping () -> Void,
                                        bookMark bookMarkHandler: @escaping () -> Void,
                                        alarmAndBookMark alarmAndBookMarkHandler: @escaping () -> Void) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let alarmAction = UIAlertAction(title: NameSpace.alarmSettingTitle, style: .default) { _ in
            alarmHandler()
        }
        let bookMarkAction = UIAlertAction(title: NameSpace.bookMarkSettingTitle, style: .default) { _ in
            bookMarkHandler()
        }
        let alarmAndBookMarkAction = UIAlertAction(title: NameSpace.alarmBookMarkSettingTitle, style: .default) { _ in
            alarmAndBookMarkHandler()
        }
        let cancelAction = UIAlertAction(title: NameSpace.cancelTitle, style: .cancel, handler: nil)
        
        actionSheet.addAction(alarmAction)
        actionSheet.addAction(bookMarkAction)
        actionSheet.addAction(alarmAndBookMarkAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true)
    }
    
    func presentSettingSuccessAlert() {
        let alert = UIAlertController(
            title: NameSpace.settingSuccessAlertTitle,
            message: NameSpace.settingSuccessAlertMessage,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: NameSpace.okTitle,
            style: .default,
            handler: nil
        )
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    func presentSettingFailedAlert() {
        let alert = UIAlertController(
            title: NameSpace.settingFailedAlertTitle,
            message: NameSpace.settingFailedAlertMessage,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: NameSpace.okTitle,
            style: .default,
            handler: nil
        )
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    func presentInitAlert(_ initHandler: @escaping () -> Void) {
        let alert = UIAlertController(
            title: NameSpace.initAlertTitle,
            message: NameSpace.initAlertMessage,
            preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(
            title: NameSpace.cancelTitle,
            style: .default,
            handler: nil
        )
        let initAction = UIAlertAction(
            title: NameSpace.initTitle,
            style: .destructive
        ) { _ in
            initHandler()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(initAction)
        
        present(alert, animated: true)
    }
}

private enum NameSpace {
    static let alarmSettingTitle = "알람 설정"
    static let bookMarkSettingTitle = "즐겨찾기 추가"
    static let alarmBookMarkSettingTitle = "알람 설정 및 즐겨찾기 추가"
    
    static let settingSuccessAlertTitle = "알람 추가 완료"
    static let settingSuccessAlertMessage = "앱을 종료해도 됩니다."
    static let settingFailedAlertTitle = "알람 추가 실패"
    static let settingFailedAlertMessage = "알람 정보를 확인해주세요."
    
    static let initAlertTitle = "위치 정보"
    static let initAlertMessage = "초기화하시겠습니까?"
    static let initTitle = "초기화"
    
    static let okTitle = "확인"
    static let cancelTitle = "취소"
}
