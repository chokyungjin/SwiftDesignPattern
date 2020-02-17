//
//  ManagedOrder+CoreDataProperties.swift
//  CleanStoreClone
//
//  Created by 조경진 on 2020/02/17.
//  Copyright © 2020 조경진. All rights reserved.
//

import Foundation
import CoreData

extension ManagedOrder
{
    //@nonobjc 붙은 속성은 Objc-C에 노출되지 않는다
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedOrder>
    {
        return NSFetchRequest<ManagedOrder>(entityName: "ManagedOrder")
    }

    @NSManaged public var billingAddressCity: String?
    @NSManaged public var billingAddressState: String?
    @NSManaged public var billingAddressStreet1: String?
    @NSManaged public var billingAddressStreet2: String?
    @NSManaged public var billingAddressZIP: String?
    @NSManaged public var date: Date?
    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var id: String?
    @NSManaged public var lastName: String?
    @NSManaged public var paymentMethodCreditCardNumber: String?
    @NSManaged public var paymentMethodCVV: String?
    @NSManaged public var paymentMethodExpirationDate: Date?
    @NSManaged public var phone: String?
    @NSManaged public var shipmentAddressCity: String?
    @NSManaged public var shipmentAddressState: String?
    @NSManaged public var shipmentAddressStreet1: String?
    @NSManaged public var shipmentAddressStreet2: String?
    @NSManaged public var shipmentAddressZIP: String?
    @NSManaged public var shipmentMethodSpeed: NSNumber?
    @NSManaged public var total: NSDecimalNumber?
}

//코어데이터는 고정된 저장소와 메모리상의 스크래치 보드를 연결하여,
//마치 어떤 데이터 클래스 객체들의 배열을 다루는 코드로 데이터를 생성, 편집, 삭제하며 저장할 수 있는 기능을 제공하는 프레임워크이다.
