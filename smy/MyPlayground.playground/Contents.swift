//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//字符串变量
var str1 = "hello"
//字符串常量
let str2 = "swift3.0"
//声明为nil，
var str3:String?
//空字符串
let str4 = String()
//空字符串 提倡用这样的字面量语法声明,类型可不指定，swift自动识别
let str5 = ""
//字符
var char1:Character = "m"


var p_str1 = str1+str2
p_str1 = String(format:"%@~%@",str1,str2)
p_str1 = String(format:"%@~%@-%d",str1,str2,456)
//这种拼接方式方便地组合多种类型
p_str1 = "\(str1)\(str2)\(456)"
p_str1 = "\(str1)\(str2)\(char1)"
//在后面添加
p_str1.append(char1)
p_str1 += str2
//与数组的组合
var strArray = ["hello", "swift", "3.0"]
p_str1 = strArray.joined(separator: "-")//数组通过指定字符拼接
strArray = p_str1.components(separatedBy: "-")//拆分为数组
//枚举字符
for ch in p_str1.characters{
    print(ch)
    switch ch {
    case "0":
        print("有")
    default:
        break
    }
}
