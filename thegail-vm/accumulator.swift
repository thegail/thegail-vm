//
//  accumulator.swift
//  thegail-vm
//
//  Created by Teddy Gaillard on 8/12/20.
//  Copyright © 2020 thegail. All rights reserved.
//

import Foundation

func halfadder(a: Bool, b: Bool) -> (s: Bool, c:Bool) {
	var s: Bool
	var c: Bool
	if a || b {
		s = true
	} else {
		s = false
	}
	if a && b {
		c = true
		s = false
	} else {
		c = false
	}
	return (s, c)
}

func fulladder(a: Bool, b: Bool, c: Bool) -> (s: Bool, c: Bool) {
	let (sumone, carryone) = halfadder(a: a, b: b)
	let (sumtwo, carrytwo) = halfadder(a: sumone, b: c)
	return (sumtwo, carryone || carrytwo)
}

func adderadd(a: Byte, b: Byte, c: Bool) -> (s: Byte, c: Bool){
	let (sumone, carryone) = fulladder(a: a[7], b: b[7], c: c)
	let (sumtwo, carrytwo) = fulladder(a: a[6], b: b[6], c: carryone)
	let (sumthree, carrythree) = fulladder(a: a[5], b: b[5], c: carrytwo)
	let (sumfour, carryfour) = fulladder(a: a[4], b: b[4], c: carrythree)
	let (sumfive, carryfive) = fulladder(a: a[3], b: b[3], c: carryfour)
	let (sumsix, carrysix) = fulladder(a: a[2], b: b[2], c: carryfive)
	let (sumseven, carryseven) = fulladder(a: a[1], b: b[1], c: carrysix)
	let (sumeight, carryeight) = fulladder(a: a[0], b: b[0], c: carryseven)
	do {
		return (s: try Byte(fromArray: [sumone, sumtwo, sumthree, sumfour, sumfive, sumsix, sumseven, sumeight].reversed()), c: carryeight)
	} catch {
		print("if you are reading this, something has gone catestrophically wrong. you should never see this ever. (if nobody ever sees this message, does it exist?)")
		exit(1)
	}
}

class Accumulator {
	var value: Byte
	var carry: Bool
	var zero: Bool
	init() {
		self.value = Byte(fromInt: UInt8(0))
		self.carry = false
		self.zero = true
	}
	func add(_ b: Byte) {
		(self.value, self.carry) = adderadd(a: self.value, b: b, c: false)
		if self.value.bitArray == [false,false,false,false,false,false,false,false] {
			self.zero = true
		}
	}
	func awc(_ b: Byte) {
		(self.value, self.carry) = adderadd(a: self.value, b: b, c: self.carry)
		if self.value.bitArray == [false,false,false,false,false,false,false,false] {
			self.zero = true
		}
	}
	
	func sub(_ b: Byte) {
		(self.value, self.carry) = adderadd(a: self.value, b: b.inverted(), c: true)
		if self.value.bitArray == [false,false,false,false,false,false,false,false] {
			self.zero = true
		}
	}
}
