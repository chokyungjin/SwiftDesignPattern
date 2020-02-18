//
//  ListOrdersRouter.swift
//  CleanStorePractice
//
//  Created by 조경진 on 2020/02/18.
//  Copyright (c) 2020 조경진. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol ListOrdersRoutingLogic
{
  func routeToCreateOrder(segue: UIStoryboardSegue?)
  func routeToShowOrder(segue: UIStoryboardSegue?)
}
//데이터 전달을 위한 프로토콜
protocol ListOrdersDataPassing
{
  var dataStore: ListOrdersDataStore? { get }
}

class ListOrdersRouter: NSObject, ListOrdersRoutingLogic, ListOrdersDataPassing
{
  weak var viewController: ListOrdersViewController?
  var dataStore: ListOrdersDataStore?   //프로토콜 상속
  
  // MARK: Routing
  
  func routeToCreateOrder(segue: UIStoryboardSegue?)
  {
    if let segue = segue {
      let destinationVC = segue.destination as! CreateOrderViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToCreateOrder(source: dataStore!, destination: &destinationDS)
    } else {
      let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "CreateOrderViewController") as! CreateOrderViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToCreateOrder(source: dataStore!, destination: &destinationDS)    //DataStore
      navigateToCreateOrder(source: viewController!, destination: destinationVC)    //ViewController
    }
  }
  
  func routeToShowOrder(segue: UIStoryboardSegue?)
  {
    if let segue = segue {
      let destinationVC = segue.destination as! ShowOrderViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToShowOrder(source: dataStore!, destination: &destinationDS)
    } else {
      let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "ShowOrderViewController") as! ShowOrderViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToShowOrder(source: dataStore!, destination: &destinationDS)
      navigateToShowOrder(source: viewController!, destination: destinationVC)
    }
  }
  
  // MARK: Navigation
  
  func navigateToCreateOrder(source: ListOrdersViewController, destination: CreateOrderViewController)
  {
    source.show(destination, sender: nil)
  }
  
  func navigateToShowOrder(source: ListOrdersViewController, destination: ShowOrderViewController)
  {
    source.show(destination, sender: nil)
  }
  
  // MARK: Passing data
  // 함수가 호출되고 종료될 때, 함수 내부에서 변경된 값은 함수 외부의 값에는 영향을 끼칠 수 없습니다.
  // 하지만 함수 호출이 종료된 후에도 변경 사항을 유지해야할 경우, inout 파라미터를 사용합니다.


  func passDataToCreateOrder(source: ListOrdersDataStore, destination: inout CreateOrderDataStore)
  {
  }
  
  func passDataToShowOrder(source: ListOrdersDataStore, destination: inout ShowOrderDataStore)
  {
    let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
    destination.order = source.orders?[selectedRow!]
  }
}
