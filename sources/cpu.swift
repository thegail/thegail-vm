//
//  cpu.swift
//  thegail-vm
//
//  Created by Teddy Gaillard on 8/12/20.
//  Copyright © 2020 thegail. All rights reserved.
//

import Foundation

class CPU {
	let memory: RAMArray
	let accumulator: Accumulator
	var counter: UInt16
	
	init() {
		self.memory = RAMArray(addrspace: 16)
		self.accumulator = Accumulator()
		self.counter = 0x0000
	}
	
	private func increment() {
		if self.counter == 0xFFFF {
			self.counter = 0
		} else {
			self.counter += 1
		}
	}
	
	private func clock() -> Bool {
		let instruction = self.memory.read(addr: self.counter)
		self.increment()
		let memhi = self.memory.read(addr: self.counter)
		self.increment()
		let memlo = self.memory.read(addr: self.counter)
		let memaddr = Byte.tointdouble(hi: memhi, lo: memlo)
		switch instruction.toint() {
		case 0x10:
			self.accumulator.value = self.memory.read(addr: memaddr)
		case 0x11:
			self.memory.write(addr: memaddr, c: self.accumulator.value)
		case 0x20:
			self.accumulator.add(self.memory.read(addr: memaddr))
		case 0x21:
			self.accumulator.awc(self.memory.read(addr: memaddr))
		case 0x22:
			self.accumulator.sub(self.memory.read(addr: memaddr))
		case 0x30:
			self.counter = memaddr
		case 0x31:
			if self.accumulator.zero {
				self.counter = memaddr
			}
		case 0x32:
			if !self.accumulator.zero {
				self.counter = memaddr
			}
		case 0x33:
			if self.accumulator.carry {
				self.counter = memaddr
			}
		case 0x34:
			if !self.accumulator.carry {
				self.counter = memaddr
			}
		case 0xFF:
			return true
		default:
			break
		}
		self.increment()
		return false
	}
	
	func start() {
		var halted = false
		repeat {
			halted = self.clock()
		} while !halted
	}
}
