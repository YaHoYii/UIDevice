//
//  ViewController.swift
//  DeviceOrientation
//
//  Created by 太阳在线YHY on 2017/3/22.
//  Copyright © 2017年 太阳在线. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	var deviceInfo: [String]!
	

	
	@IBOutlet weak var name: UILabel!
	
	@IBOutlet weak var model: UILabel!
	
	@IBOutlet weak var localizedModel: UILabel!
	
	@IBOutlet weak var systemName: UILabel!
	
	@IBOutlet weak var systemVersion: UILabel!
	
	@IBOutlet weak var orientation: UILabel!
	
	@IBOutlet weak var batteryState: UILabel!
	
	@IBOutlet weak var batteryLevel: UILabel!
	
	@IBOutlet weak var proximityState: UILabel!
	
	@IBOutlet weak var userInterfaceIdiom: UILabel!
	
	@IBOutlet weak var multitaskingSupported: UILabel!
	
	@IBOutlet weak var identifierForVendor: UILabel!
	
	@IBOutlet weak var proximity: UILabel!
	
	var i = 0,j = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()

		
		let device = UIDevice.current
		// 启用电池监控,启用之后有关电池的监测才可以用
		device.isBatteryMonitoringEnabled = true
		// 启用用户接近
		device.isProximityMonitoringEnabled = true
		print("设备名：" + device.name)
		print("设备型号：" + device.model)
		print("设备定位型号：" + device.localizedModel)
		print("设备系统：" + device.systemName)
		print("系统版本：" + device.systemVersion)
		print("UUID:" + String(describing: device.identifierForVendor) )
		print("电量:\(UIDevice.current.batteryLevel * 100)%")
		print("是否支持接近用户监测：" + String(device.isMultitaskingSupported))
		
		
		
        name.text = "设备名：" + device.name
		model.text = "设备型号：" + device.model
		localizedModel.text = "设备定位型号：" + device.localizedModel
        systemName.text = "设备系统：" + device.systemName
        systemVersion.text = "系统版本：" + device.systemVersion
		identifierForVendor.text = "UUID:" + String(describing: device.identifierForVendor!)
        batteryLevel.text = "电量:\(UIDevice.current.batteryLevel * 100)%"
		multitaskingSupported.text = "是否支持接近用户监测：" + String(device.isMultitaskingSupported)
		
	
		switch device.userInterfaceIdiom {
			case .carPlay:
				print("用户界面风格：车载屏")
			    userInterfaceIdiom.text = "用户界面风格：车载屏"
			case .pad:
				print("用户界面风格：iPad")
			    userInterfaceIdiom.text = "用户界面风格：iPad"
			case .phone:
				print("用户界面风格：iPhone")
			    userInterfaceIdiom.text = "用户界面风格：iPhone"
			case.tv:
				print("用户界面风格： TV")
				userInterfaceIdiom.text = "用户界面风格： TV"
			default:
				print("用户界面风格：未知")
			    userInterfaceIdiom.text = "用户界面风格：未知"
		}
	
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// 监听设备方向变化
		NotificationCenter.default.addObserver(self, selector: #selector(change), name: .UIDeviceOrientationDidChange, object: nil)
		// 监听电池状态
		NotificationCenter.default.addObserver(self, selector: #selector(battery), name: .UIDeviceBatteryStateDidChange, object: nil)
		// 监听电量
		NotificationCenter.default.addObserver(self, selector: #selector(batteryLevels), name: .UIDeviceBatteryLevelDidChange, object: nil)
		// 监听设备是否接近用户
		NotificationCenter.default.addObserver(self, selector: #selector(proximityStates), name: .UIDeviceProximityStateDidChange, object: nil)
		
	}
 
	func change() {
		let orienta = UIDevice.current.orientation
		print(orienta)
		
		switch orienta {
			case .faceDown:
				
			    orientation.text = "设备方向：脸朝地"
			case .faceUp:
			
			    orientation.text = "设备方向：脸朝上"
			case .landscapeLeft:
				
			    orientation.text = "设备方向：头朝左"
			case .landscapeRight:
				
			    orientation.text = "设备方向：头朝右"
			case .portrait:
				
			    orientation.text = "设备方向：正立"
			case .portraitUpsideDown:
				
			    orientation.text = "设备方向：倒立"
			default:
			
			    orientation.text = "设备方向：还在懵逼"
		}
		
	}
	
	func battery() {
		let batteryStatu = UIDevice.current.batteryState
		
		switch batteryStatu {
		case .charging:
			print("正在充电")
			 batteryState.text = "电池状态：正在充电"
		case .full:
			print("满电量")
			batteryState.text = "电池状态：满电量"
		case .unplugged:
			print("放电")
			batteryState.text = "电池状态：在放电"
		default:
			print("我也不知道在干嘛")
			batteryState.text = "电池状态：我也不知道在干嘛"
		}
		
	}
	
	func batteryLevels() {
		print("电量",UIDevice.current.batteryLevel)
		batteryLevel.text = "通知电量变为：\(UIDevice.current.batteryLevel * 100)%"

	}
	
	
	func proximityStates() {
		print("是否接近用户:",UIDevice.current.proximityState)
		if UIDevice.current.proximityState {
			i += 1
			proximity.text = "接近了用户\(i)次"
		
		}else {
			j += 1
			proximityState.text = "离开了\(j)次"
		}
		
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		
		UIDevice.current.endGeneratingDeviceOrientationNotifications()
		NotificationCenter.default.removeObserver(self)
	}


}











