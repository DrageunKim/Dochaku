//
//  SubWayRequest.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/02/23.
//


struct SubwayRequest: Request {
    typealias Response = SubwayRouteSearch
    
    let method: HTTPMethod = .get
    let key: String = "?apiKey=" + "DnMRoATHlXeGpeewYG0b6A"
    let sopt: String = "&Sopt=" + "2"
    let lang: String = "&lang=" + "0"
    let cid: String
    let sid: String
    let eid: String
    let path: String
    
    init(city: CID, start: Int, end: Int) {
        self.cid = "&CID=" + "\(city.rawValue)"
        self.sid = "&SID=" + "\(start)"
        self.eid = "&EID=" + "\(end)"
        
        self.path = key + lang + cid + sid + eid + sopt
    }
}

enum Lang: Int {
    case korean = 0
    case english
    case japanese
    case chinese_simplified
    case chinese_traditional
    case vietnamese
}

enum CID: Int {
    case capital = 1000
    case daejeon = 3000
    case daegu = 4000
    case gwangju = 5000
    case busan = 7000
}
