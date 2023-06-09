//
//  RealmHelper.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import RealmSwift

enum MessageEnum {
	case id
	case message
	case time
}

class RealmHelper {
	
	// Получить поле Реалма (не весь объект)
	static func getRealmObject(by id: Int, messageEnum: MessageEnum) -> Any? {
			let alarmObjects = RealmHelper.getRealmObjects(by: id)
			if let alarmModel = alarmObjects.first {
				switch messageEnum {
				case .id:
					return alarmModel.id
				case .message:
					return alarmModel.message
				case .time:
					return alarmModel.time
				}
			}
			return nil
		}
	
	// Получить значение Realm по id
	static func getRealmObjects(by id: Int) -> Results<MessageModel> {
		let realm = try! Realm()
		let realmObjects = realm.objects(MessageModel.self)
		let alarmObjects = realmObjects.where {
			$0.id == id
		}
		debugPrint("AlarmObjects Count:\(alarmObjects.count)" + " " + "RealmObjects Count:\(realmObjects.count)")
		return alarmObjects
	}
	
	// Получить все значения в Realm
	static func getAllRealmObjects() -> Results<MessageModel> {
		let realm = try! Realm()
		let realmObjects = realm.objects(MessageModel.self)
		return realmObjects
	}
	
	// Сохранить в Realm, но в конец, id высчитается сам
	static func pushToRealm(message: String, time: String) {
		let realm = try! Realm()
		let realmObjects = RealmHelper.getAllRealmObjects()
		let id = realmObjects.count
		let model = MessageModel(id: id, message: message, time: time)
		try! realm.write {
			realm.add(model)
		}
		debugPrint("PUSH REALM", realmObjects.count)
	}
	
	static func deleteAllModels() {
		let realm = try! Realm()
		try! realm.write {
			realm.deleteAll()
		}
	}
	
}
