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
    func presentAlarmSettingSuccessAlert()
    func presentBookmarkSettingSuccessAlert()
    func presentAlarmBookmarkSettingSuccessAlert()
    func presentSettingFailedAlert()
    func presentLocationAuthAlert()
    func presentDeleteAlert(_ deleteHandler: @escaping () -> Void)
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
    
    func presentAlarmSettingSuccessAlert() {
        let alert = UIAlertController(
            title: NameSpace.alarmSettingSuccessAlertTitle,
            message: NameSpace.alarmSettingSuccessAlertMessage,
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
    
    func presentBookmarkSettingSuccessAlert() {
        let alert = UIAlertController(
            title: NameSpace.bookmarkSettingSuccessAlertTitle,
            message: NameSpace.bookmarkSettingSuccessAlertMessage,
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
    
    func presentAlarmBookmarkSettingSuccessAlert() {
        let alert = UIAlertController(
            title: NameSpace.alarmBookmarkSettingSuccessAlertTitle,
            message: NameSpace.alarmBookmarkSettingSuccessAlertMessage,
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
    
    func presentLocationAuthAlert() {
        let alert = UIAlertController(
            title: NameSpace.locationAuthAlertTitle,
            message: NameSpace.locationAuthAlertMessage,
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
    
    func presentDeleteAlert(_ deleteHandler: @escaping () -> Void) {
        let alert = UIAlertController(
            title: NameSpace.alarmDeleteTitle,
            message: NameSpace.alarmDeleteMessage,
            preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(
            title: NameSpace.cancelTitle,
            style: .default,
            handler: nil
        )
        let deleteAction = UIAlertAction(
            title: NameSpace.deleteTitle,
            style: .destructive
        ) { _ in
            deleteHandler()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        present(alert, animated: true)
    }
}

private enum NameSpace {
    static let alarmSettingTitle = "알람 설정"
    static let bookMarkSettingTitle = "즐겨찾기 추가"
    static let alarmBookMarkSettingTitle = "알람 설정 및 즐겨찾기 추가"
    
    static let alarmSettingSuccessAlertTitle = "알람 추가 완료"
    static let alarmSettingSuccessAlertMessage = "앱을 종료해도 됩니다."
    static let bookmarkSettingSuccessAlertTitle = "즐겨찾기 추가 완료"
    static let bookmarkSettingSuccessAlertMessage = "즐겨찾기 탭에서 확인 가능합니다."
    static let alarmBookmarkSettingSuccessAlertTitle = "알람 & 즐겨찾기 추가 완료"
    static let alarmBookmarkSettingSuccessAlertMessage = "앱을 종료해도 됩니다."
    static let settingFailedAlertTitle = "알람 추가 실패"
    static let settingFailedAlertMessage = "알람 정보를 확인해주세요."
    
    static let locationAuthAlertTitle = "위치접근 권한 변경 필요"
    static let locationAuthAlertMessage = "설정에서 위치접근 권한을 '항상 허용'으로 변경해주셔야 알람을 받을 수 있습니다."
    
    static let initAlertTitle = "위치 정보"
    static let initAlertMessage = "초기화하시겠습니까?"
    static let initTitle = "초기화"
    
    static let alarmDeleteTitle = "알람 삭제"
    static let alarmDeleteMessage = "알람 정보를 삭제하시겠습니까?"
    
    static let okTitle = "확인"
    static let cancelTitle = "취소"
    static let deleteTitle = "삭제"
}
