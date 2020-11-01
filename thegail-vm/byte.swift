//
//  byte.swift
//  thegail-vm
//
//  Created by Teddy Gaillard on 8/19/20.
//  Copyright © 2020 thegail. All rights reserved.
//

import Foundation

enum initError: Error {
	case lengthError
}

struct Byte {
	private var bits: Array<Bool> = [false, false, false, false, false, false, false, false]
	var bitArray: Array<Bool> {
		return self.bits
	}
	subscript(index: Int) -> Bool {
		get {
			return self.bits[index]
		}
		set(newValue) {
			self.bits[index] = newValue
		}
	}
	init(fromArray: Array<Bool>) throws {
		if fromArray.count == 8 {
			self.bits = fromArray
		} else {
			throw initError.lengthError
		}
	}
	
	private static func addFalses(array: Array<Bool>) -> Array<Bool> {
		if array.count == 8 {
			return array
		} else {
			return addFalses(array: [false]+array)
		}
	}
	
	func inverted() -> Byte {
		var arr: Array<Bool> = []
		for i in self.bits {
			arr.append(!i)
		}
		do {
			return try Byte(fromArray: arr)
		} catch {
			print("if you are reading this, something has gone catestrophically wrong. you should never see this ever. (if nobody ever sees this message, does it exist?)")
			exit(1)
		}
	}
	
	func toint() -> UInt8 {
		var power = 1
		var total = 0
		for i in self.bits.reversed() {
			if i {
				total += power
			}
			power *= 2
		}
		return UInt8(total)
	}
	
	static func tointdouble(hi: Byte, lo: Byte) -> UInt16 {
		let arr = hi.bitArray+lo.bitArray
		var power = 1
		var total = 0
		for i in arr.reversed() {
			if i {
				total += power
			}
			power *= 2
		}
		return UInt16(total)
	}
	
	private static func addZeroes(to: Int, arr: Array<String>) -> Array<String> {
		if arr.count >= to {
			return arr
		} else {
			return addZeroes(to: to, arr: (arr.reversed()+["0"]).reversed())
		}
	}
	
	static func fromdoubleint(_ u: UInt16) -> (hi: Byte, lo: Byte) {
		let a = addZeroes(to: 4, arr: Array(arrayLiteral: String(u, radix: 16)))
		let h = Byte(fromInt: UInt8(a[0]+a[1])!)
		let l = Byte(fromInt: UInt8(a[2]+a[3])!)
		return (hi: h, lo: l)
	}
	
	init(fromInt: UInt8) {
		var arr: Array<Bool> = []
		for i in String(fromInt, radix: 2) {
			if String(i) == "1" {
				arr.append(true)
			} else {
				arr.append(false)
			}
		}
		do {
			try self.init(fromArray: Byte.addFalses(array: arr))
		} catch {
			print("if you are reading this, something has gone catestrophically wrong. you should never see this ever. (if nobody ever sees this message, does it exist?)")
			exit(1)
		}
	}
}
