//
//  RealmHelper.swift
//  SoloChat
//
//  Created by Даниил Назаров on 09.06.2023.
//

import RealmSwift

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
		let id = RealmHelper.getAllRealmObjects().count
		let model = MessageModel(id: id, message: message, time: time)
		try! realm.write {
			realm.add(model)
		}
	}
	
	/// Удалить объект по id и сместить остальные id
	static func deleteModelById(by id: Int) {
		let realm = try! Realm()
		let realmObjects = RealmHelper.getAllRealmObjects()
		let objectsToDelete = realmObjects.filter("id == %@", id)
		debugPrint("TEST FOR ID \(id):", realmObjects.count, objectsToDelete.count)
		realmObjects.forEach {
			debugPrint("TEST EACH \($0.id) FOR \(id)")
		}
		objectsToDelete.forEach {
			print("TEST DELETE \(id) REALMID \($0.id) MESSAGE \($0.message)")
		}
		
		try? realm.write {
			realm.delete(objectsToDelete)
		}
		
		/// Если модель лежит в реалме то удалить
		if id >= 0 {
			let newObjects = RealmHelper.getAllRealmObjects()
			RealmHelper.updateAllRealmObjectsIdAfterDelete(realmObjects: newObjects, idToDelete: id)
		}
		
	}
	
	/// Обновить каждую ID у объектов Realm для того чтобы отсортировать правильно
	/// Вызывать ТОЛЬКО после удаления одного объекта
	private static func updateAllRealmObjectsIdAfterDelete(realmObjects: Results<MessageModel>, idToDelete: Int) {
		let realm = try! Realm()

		realm.beginWrite()

		/// Перенумерация id оставшихся объектов
		let objectsToUpdate = RealmHelper.getAllRealmObjects().filter("id > %@", idToDelete)
		for object in objectsToUpdate {
			object.id -= 1
		}

		// Завершение транзакции Realm
		try! realm.commitWrite()
	}
	
	
	static func deleteAllModels() {
		let realm = try! Realm()
		try! realm.write {
			realm.deleteAll()
		}
	}
	
}
