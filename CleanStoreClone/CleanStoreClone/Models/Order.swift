//
//  Order.swift
//  CleanStoreClone
//
//  Created by 조경진 on 2020/02/17.
//  Copyright © 2020 조경진. All rights reserved.
//

import Foundation

// Equatable 프로토콜을 준수하는 타입은 그 타입끼리 동등성 비교(!= 혹은 ==)가 가능
struct Order: Equatable
{
    
    // Contact 정보들
    var firstName: String
    var lastName: String
    var phone: String
    var email: String
    
    // 지불 정보들
    var billingAddress: Address
    var paymentMethod: PaymentMethod
    
    // 배송 정보들
    var shipmentAddress: Address
    var shipmentMethod: ShipmentMethod
    
    //Misc..
    var id : String?
    var date: Date
    var total: NSDecimalNumber
}
func ==(lhs: Order, rhs: Order) -> Bool {
    return lhs.firstName == rhs.firstName
        && lhs.firstName == rhs.firstName
        && lhs.phone == rhs.phone
        && lhs.email == rhs.email
        && lhs.billingAddress == rhs.billingAddress
        && lhs.paymentMethod == rhs.paymentMethod
        && lhs.shipmentMethod == rhs.shipmentMethod
        && lhs.shipmentAddress == rhs.shipmentAddress
        && lhs.id == rhs.id
        && lhs.date.timeIntervalSince(rhs.date) < 1.0
        && lhs.total == rhs.total
}


struct Address
{
    
    var street1: String
    var street2: String?
    var city: String
    var state: String
    var zip: String
    
}

func ==(lhs: Address, rhs: Address) -> Bool
{
  return lhs.street1 == rhs.street1
    && lhs.street2 == rhs.street2
    && lhs.city == rhs.city
    && lhs.state == rhs.state
    && lhs.zip == rhs.zip
}

struct ShipmentMethod
{
  enum ShippingSpeed: Int {
    case Standard = 0 // "Standard Shipping"
    case OneDay = 1 // "One-Day Shipping"
    case TwoDay = 2 // "Two-Day Shipping"
  }
  var speed: ShippingSpeed
  
  func toString() -> String
  {
    switch speed {
    case .Standard:
      return "Standard Shipping"
    case .OneDay:
      return "One-Day Shipping"
    case .TwoDay:
      return "Two-Day Shipping"
    }
  }
}

func ==(lhs: ShipmentMethod, rhs: ShipmentMethod) -> Bool
{
  return lhs.speed == rhs.speed
}

struct PaymentMethod
{
  var creditCardNumber: String
  var expirationDate: Date
  var cvv: String
}

func ==(lhs: PaymentMethod, rhs: PaymentMethod) -> Bool
{
  return lhs.creditCardNumber == rhs.creditCardNumber
    && lhs.expirationDate.timeIntervalSince(rhs.expirationDate) < 1.0
    && lhs.cvv == rhs.cvv
}

