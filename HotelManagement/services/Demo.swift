
import Foundation
import RealmSwift

func defaultFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    return formatter
}

func setupRealm() {
    let realm = getRealm()
//    clearRealm(realm)
    addRooms(realm)
    addReservations(realm)
    realm.refresh()
}

func realmInMemory(_ name: String) -> Realm {
    var conf = Realm.Configuration()
    conf.inMemoryIdentifier = name
    return try! Realm(configuration: conf)
}

func clearRealm(_ realm: Realm) {
    try! realm.write {
        realm.deleteAll()
    }
}

func addRooms(_ realm: Realm) {
    let rooms: [Room] = [Room(id: 1, roomNumber: "1"), Room(id: 2, roomNumber: "2"),
                         Room(id: 3, roomNumber: "5"), Room(id: 4, roomNumber: "6")]
    
    try! realm.write {
        realm.add(rooms)
    }
}

func addReservations(_ realm: Realm) {
    addReservationForPeriod(period: Period(dateFrom: defaultFormatter().date(from: "08.11.2017")!,
                                           dateTo: defaultFormatter().date(from: "13.11.2017")!),
                            room: DataService.getRoom(id: 1)!)
    
    addReservationForPeriod(period: Period(dateFrom: defaultFormatter().date(from: "14.11.2017")!,
                                           dateTo: defaultFormatter().date(from: "16.11.2017")!),
                            room: DataService.getRoom(id: 2)!)
    
    addReservationForPeriod(period: Period(dateFrom: defaultFormatter().date(from: "13.11.2017")!,
                                           dateTo: defaultFormatter().date(from: "14.11.2017")!),
                            room: DataService.getRoom(id: 3)!)
    
    addReservationForPeriod(period: Period(dateFrom: defaultFormatter().date(from: "16.11.2017")!,
                                           dateTo: defaultFormatter().date(from: "20.11.2017")!),
                            room: DataService.getRoom(id: 4)!)
}

func addReservationForPeriod(period: Period, room: Room) {
    let realm = realmInMemory("HotelManagement")
    
    let roomRes = RoomReservation()
    roomRes.dateFrom = period.dateFrom
    roomRes.dateTo = period.dateTo
    roomRes.room = room
    
    do {
        try realm.write() {
            realm.add(roomRes)
        }
    } catch let error as NSError {
        print(error)
    }
}

