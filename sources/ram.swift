//
//  ram.swift
//  thegail-vm
//
//  Created by Teddy Gaillard on 8/19/20.
//  Copyright © 2020 thegail. All rights reserved.
//

import Foundation

class RAMArray {
	private var contents: Array<Byte>
	init(addrspace: Int) {
		let size = pow(Double(2), Double(addrspace))
		self.contents = []
		for _ in 0...Int(size-1) {
			self.contents.append(Byte(fromInt: UInt8(0)))
		}
	}
	func read(addr: UInt16) -> Byte {
		return self.contents[Int(addr)]
	}
	func write(addr: UInt16, c: Byte) {
		self.contents[Int(addr)] = c
	}
}
