//
//  AlertPresentable.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/04/04.
//

import UIKit

protocol AlertPresentable: UIViewController {
    func presentActionSheet(_ alarmHandler: @escaping () -> Void,
                            _ bookMarkHandler: @escaping () -> Void)
    func presentInitAlert(_ cancelHandler: @escaping () -> Void)
}

extension AlertPresentable {
    func presentActionSheet(_ alarmHandler: @escaping () -> Void,
                            _ bookMarkHandler: @escaping () -> Void) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let alarmAction = UIAlertAction(title: NameSpace.shareTitle, style: .default) { _ in
            alarmHandler()
        }
        let bookMarkAction = UIAlertAction(title: NameSpace.deleteTitle, style: .default) { _ in
            bookMarkHandler()
        }
        let cancelAction = UIAlertAction(title: NameSpace.cancelTitle, style: .cancel, handler: nil)
        
        actionSheet.addAction(alarmAction)
        actionSheet.addAction(bookMarkAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true)
    }
    
    func presentInitAlert(_ initHandler: @escaping () -> Void) {
        let alert = UIAlertController(
            title: NameSpace.alertTitle,
            message: NameSpace.alertMessage,
            preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(
            title: NameSpace.cancelKoreanTitle,
            style: .default,
            handler: nil
        )
        let initAction = UIAlertAction(
            title: NameSpace.deleteKoreanTitle,
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
    static let shareTitle = "알람 설정"
    static let deleteTitle = "알람 설정 및 즐겨찾기 추가"
    static let cancelTitle = "취소"
    
    static let alertTitle = "위치정보"
    static let alertMessage = "초기화하시겠습니까?"
    static let cancelKoreanTitle = "취소"
    static let deleteKoreanTitle = "초기화"
}
