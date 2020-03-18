//
//  ViewController.swift
//  XMLParsingApp
//
//  Created by 503 on 2020/03/16.
//  Copyright © 2020 ssang. All rights reserved.
//

import UIKit
//음식정보를 담게될 클래스 정의
class Food{
    var name:String!
    var price:Int!
    var category:String!
    
}
    
class ViewController: UIViewController, XMLParserDelegate {
    var foodArray:Array<Food>!
    
    //파서의 실행부가 어디를 와있는지 체크할 수 있느 논리값
    var isName = false
    var isPrice = false
    var isCategory = false
    var food:Food! // 인스턴스 하나 담을 변수 (구조체)
    
    
    //로컬 xml파일을 읽어오기
    func loadLocalXML(){
        var url = Bundle.main.url(forResource: "data", withExtension: "xml")!
        
        //ios는자체 파서가 있을까? yes
        var xmlParser = XMLParser(contentsOf: url)
        xmlParser?.delegate = self
        xmlParser?.parse() //파싱시작 !!
        
    }
    
    //문서가 시작되면
    func parserDidStartDocument(_ parser: XMLParser) {
       // print("xml문서 시작")
        foodArray = Array<Food>()
    }
    
    //시작태그를 만나면 호출하는 메서드
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        print("<",elementName,">",terminator:"")
        
        if(elementName == "food"){
            food = Food()
        }else if(elementName == "name"){
            isName = true
        }else if(elementName == "price"){
            isPrice = true
        }else if(elementName == "category"){
            isCategory = true
        }
    }
    
    //태그와 태그사이에 문자열 발견하면 호출
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //print(string, terminator:"")
        if(isName){
            food.name = string
        }else if(isPrice){
            food.price = Int(string)
        }else if(isCategory){
            food.category = string
        }
        
        
    }
    
    //끝나는 태그를 만나면 호출하는 메서드
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
       print("</",elementName,">")
        
       if(elementName == "name"){
         isName = false
       }else if(elementName == "price"){
         isPrice = false
       }else if(elementName == "category"){
         isCategory = false
       }else if(elementName == "food"){
         //하나의 음식이 완료되는 시점이므로 배열애 채워넣자
         foodArray.append(food)
       }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("배열에 최종적으로 담긴 음식 수는", foodArray.count)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLocalXML()
    }


}

