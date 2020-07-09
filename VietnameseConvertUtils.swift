//
//  VietnameseConvertUtils.swift
//
//  Created by Son Nguyen on 7/7/20.
//  Copyright © 2020 All rights reserved.
//

import Foundation

class ConvertHelper {
    
    //MARK: - Vietnamese Number2ReadableCurrency
    static func convertCurrencyToReadbleString(_ pStrNumeric: String) -> String
    {
        var strNumber = ""
        var strReadNumber = ""
        var strRead3 = ""
        
        var count = 0
        var len = 0
        var len3 = 0
        var mod3 = 0
        // Loại bỏ dấu phân cách nhóm
        strNumber = pStrNumeric.replacingOccurrences(of: ",", with: "")
        strNumber = strNumber.replacingOccurrences(of: ".", with: "")
    
        print(strNumber)
        // Loại bỏ số 0 đứng đầu
        let arr = Array(strNumber)
        for i in 0..<arr.count {
            if (arr[i] == "0")
            {
                count += 1
            }
            else
            {
                break
            }
        }
        
        strNumber = String(strNumber.suffix(strNumber.count - count))
        print(strNumber)
        // Doc chuoi so
        len = strNumber.count
        // Dem bo so 3
        len3 = len / 3
        mod3 = len % 3
        
        // Neu do dai chuoi la 0 thi gan la so 0
        if (len == 0)
        {
            strNumber = "0"
            mod3 = 1
        }
        // Doc bo so dau tien
        let stringToConvert = String(strNumber.prefix(mod3))
        strRead3 = Len3ToString(stringToConvert) //.Substring(0, mod3)
        strReadNumber = strRead3
        
        for i in 0..<len3 {
            if (((3 * (len3 - i)) % 9 == 0) && (strReadNumber.count > 0))
            {
                strReadNumber += " tỷ"
            }
            if (strRead3.count > 0)
            {
                if ((3 * (len3 - i)) % 9 == 6)
                {
                    strReadNumber += " triệu"
                }
                if (((3 * (len3 - i)) % 9 == 3))
                {
                    strReadNumber += " nghìn"
                }
            }
            // Đọc chuỗi 3 kí tự
            let start = strNumber.index(strNumber.startIndex, offsetBy: mod3 + i * 3)
            let end = strNumber.index(start, offsetBy: 3)
            let range = start..<end
            let string3ToConvert = String(strNumber.substring(with: range))
            strRead3 = Len3ToString(string3ToConvert)//strNumber.Substring(mod3 + i * 3, 3))
            // Luu chuỗi còn lại
            //strNumber = strNumber.Substring(mod3 + i * 3)
            // Gán vào chuỗi kết quả đọc
            strReadNumber += strRead3
        }
        
        strReadNumber.removeFirst() // start space
        
        if let start = strReadNumber.first {
            strReadNumber.removeFirst()
            strReadNumber = start.uppercased() + strReadNumber
        }
        
        strReadNumber += " đồng"
        return strReadNumber //.Substring(1, 1).ToUpper() + strReadNumber.Substring(2)
    }
    
    private static func Len3ToString(_ pStrInt: String) -> String
    {
        var strNumber = ""
        let len = pStrInt.count
        if ((pStrInt == "000") || (pStrInt == ""))
        {
            return strNumber
        }
        else
        {
            let arr = Array(pStrInt)
            switch (arr[0])
            {
            case "0":
                if (len == 3 || len == 1)
                {
                    strNumber += " không"
                }
                break
            case "1":
                if (len == 2)
                {
                    strNumber += " mười"
                }
                else
                {
                    strNumber += " một"
                }
                break
            case "2":
                strNumber += " hai"
                break
            case "3":
                strNumber += " ba"
                break
            case "4":
                strNumber += " bốn"
                break
            case "5":
                strNumber += " năm"
                break
            case "6":
                strNumber += " sáu"
                break
            case "7":
                strNumber += " bẩy"
                break
            case "8":
                strNumber += " tám"
                break
            case "9":
                strNumber += " chín"
                break
            default:
                break
            }
            if (len == 3)
            {
                // hàng Trăm
                strNumber += " trăm"
            }
            if (len == 2)
            {
                if ((arr[0] != "0") && (arr[0] != "1"))
                {
                    strNumber += " mươi"
                }
            }
            
            // Hàng Chục
            if (len >= 2)
            {
                switch (arr[1])
                {
                case "1":
                    if (len == 3)
                    {
                        strNumber += " mười"
                    }
                    if ((len == 2) && (arr[0] != "1"))
                    {
                        strNumber += " mốt"
                    }
                    if ((len == 2) && (arr[0] == "1"))
                    {
                        strNumber += " một"
                    }
                    break
                case "2":
                    strNumber += " hai"
                    break
                case "3":
                    strNumber += " ba"
                    break
                case "4":
                    //if (len == 2)
                    //{
                    //    strNumber += " tư"
                    //}
                    //else
                    //{
                    strNumber += " bốn"
                    //}
                    break
                case "5":
                    if (len == 2)
                    {
                        strNumber += " lăm"
                    }
                    else
                    {
                        strNumber += " năm"
                    }
                    break
                case "6":
                    strNumber += " sáu"
                    break
                case "7":
                    strNumber += " bẩy"
                    break
                case "8":
                    strNumber += " tám"
                    break
                case "9":
                    strNumber += " chín"
                    break
                default:
                    break
                }
                if (len == 3)
                {
                    if ((arr[1] != "0") && (arr[1] != "1"))
                    {
                        strNumber += " mươi"
                    }
                    if ((arr[1] == "0") && (arr[2] != "0"))
                    {
                        strNumber += " linh"
                    }
                }
            }
            // Hàng đơn vị
            if (len == 3)
            {
                switch (arr[2])
                {
                case "1":
                    if (arr[1] != "0" && arr[1] != "1")
                    {
                        strNumber += " mốt"
                    }
                    else
                    {
                        strNumber += " một"
                    }
                    break
                case "2":
                    strNumber += " hai"
                    break
                case "3":
                    strNumber += " ba"
                    break
                case "4":
                    //if ((arr[1] != "0") && (arr[1] != "1"))
                    //{
                    //    strNumber += " tư"
                    //}
                    //else
                    //{
                    strNumber += " bốn"
                    //}
                    break
                case "5":
                    if (arr[1] != "0")
                    {
                        strNumber += " lăm"
                    }
                    else
                    {
                        strNumber += " năm"
                    }
                    break
                case "6":
                    strNumber += " sáu"
                    break
                case "7":
                    strNumber += " bẩy"
                    break
                case "8":
                    strNumber += " tám"
                    break
                case "9":
                    strNumber += " chín"
                    break
                default:
                    break
                }
            }
            
            return strNumber
        }
    }
    
    //MARK: - English Number2ReadableCurrency
    
    private static let specialNames = [
        "",
        " thousand",
        " million",
        " billion",
        " trillion",
        " quadrillion",
        " quintillion"
    ]
    
    
    private static let tensNames = [
        "",
        " ten",
        " twenty",
        " thirty",
        " forty",
        " fifty",
        " sixty",
        " seventy",
        " eighty",
        " ninety"
    ]
    
    private static let numNames = [
        "",
        " one",
        " two",
        " three",
        " four",
        " five",
        " six",
        " seven",
        " eight",
        " nine",
        " ten",
        " eleven",
        " twelve",
        " thirteen",
        " fourteen",
        " fifteen",
        " sixteen",
        " seventeen",
        " eighteen",
        " nineteen"
    ]
    
    private static func convertLessThanOneThousand(_ value: Int) -> String {
        var current = ""
        var number: Int = value
        
        if (number % 100 < 20) {
            current = numNames[number % 100]
            number /= 100
        }
        else {
            current = numNames[number % 10]
            number /= 10;
            
            current = tensNames[number % 10] + current
            number /= 10
        }
        if (number == 0) {
            return current
        }
        return numNames[number] + " hundred" + current
    }
    
    public static func convertEnglishReadableCurrency(_ value : Int64) -> String {
        print("sourceNumber = \(value)")

        if value == 0 { return "zero" }
        var number = value
        var prefix = ""
        var current = ""
        
        if number < 0 {
            number = -number
            prefix = "negative"
        }
        
        var place = 0
        
        repeat {
            let n = number % 1000
            if n != 0 {
                let s = convertLessThanOneThousand(Int(n))
                current = s + specialNames[place] + current
            }
            place += 1
            number /= 1000
        } while number > 0
        
        var retVal = (prefix + current).trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let start = retVal.first {
            retVal.removeFirst()
            retVal = start.uppercased() + retVal
        }
        
        retVal += " Vietnam Dong"
        return retVal
    }
    
    //MARK: - Remove accent
    private static let arrCoDau: [Character] =
        ["á","à","ả","ã","ạ",
         "ă","ắ","ằ","ẳ","ẵ","ặ",
         "â","ấ","ầ","ẩ","ẫ","ậ",
         "đ",
         "é","è","ẻ","ẽ","ẹ",
         "ê","ế","ề","ể","ễ","ệ",
         "í","ì","ỉ","ĩ","ị",
         "ó","ò","ỏ","õ","ọ",
         "ô","ố","ồ","ổ","ỗ","ộ",
         "ơ","ớ","ờ","ở","ỡ","ợ",
         "ú","ù","ủ","ũ","ụ",
         "ư","ứ","ừ","ử","ữ","ự",
         "ý","ỳ","ỷ","ỹ","ỵ",
         
         "Á","À","Ả","Ã","Ạ",
         "Ă","Ắ","Ằ","Ẳ","Ẵ","Ặ",
         "Â","Ấ","Ầ","Ẩ","Ẫ","Ậ",
         "Đ",
         "É","È","Ẻ","Ẽ","Ẹ",
         "Ê","Ế","Ề","Ể","Ễ","Ệ",
         "Í","Ì","Ỉ","Ĩ","Ị",
         "Ó","Ò","Ỏ","Õ","Ọ",
         "Ô","Ố","Ồ","Ổ","Ỗ","Ộ",
         "Ơ","Ớ","Ờ","Ở","Ỡ","Ợ",
         "Ú","Ù","Ủ","Ũ","Ụ",
         "Ư","Ứ","Ừ","Ử","Ữ","Ự",
         "Ý","Ỳ","Ỷ","Ỹ","Ỵ"]
    
    private static let arrKhongDau: [Character] =
        ["a","a","a","a","a",
         "a","a","a","a","a","a",
         "a","a","a","a","a","a",
         "d",
         "e","e","e","e","e",
         "e","e","e","e","e","e",
         "i","i","i","i","i",
         "o","o","o","o","o",
         "o","o","o","o","o","o",
         "o","o","o","o","o","o",
         "u","u","u","u","u",
         "u","u","u","u","u","u",
         "y","y","y","y","y",
         
         "A","A","A","A","A",
         "A","A","A","A","A","A",
         "A","A","A","A","A","A",
         "D",
         "E","E","E","E","E",
         "E","E","E","E","E","E",
         "I","I","I","I","I",
         "O","O","O","O","O",
         "O","O","O","O","O","O",
         "O","O","O","O","O","O",
         "U","U","U","U","U",
         "U","U","U","U","U","U",
         "Y","Y","Y","Y","Y"
    ]
    
    class func convertVietNam(_ text: String) -> String {
        var arr = Array(text.characters)
        for i in 0..<arr.count {
            for j in 0..<arrCoDau.count{
                if (arr[i] == arrCoDau[j]) {
                    arr[i] = arrKhongDau[j]
                    break
                }
            }
        }
        return String(arr)
    }
}
