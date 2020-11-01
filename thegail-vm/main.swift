//
//  main.swift
//  thegail-vm
//
//  Created by Teddy Gaillard on 8/12/20.
//  Copyright © 2020 thegail. All rights reserved.
//

import Foundation

let processer = CPU()

// LOD 0101
// ADD 0103
// STO 0101
// LOD 0100
// AWC 0102
// STO 0100
// HLT

try assemble(processer: processer, startPointer: 0x0000, instructions: [
	.LOD(0x0101),
	.ADD(0x0103),
	.STO(0x0101),
	.LOD(0x0100),
	.AWC(0x0102),
	.STO(0x0100),
	.HLT
])

processer.memory.write(addr: 0x0100, c: Byte(fromInt: 0x11))
processer.memory.write(addr: 0x0101, c: Byte(fromInt: 0xEB))
processer.memory.write(addr: 0x0102, c: Byte(fromInt: 0x01))
processer.memory.write(addr: 0x0103, c: Byte(fromInt: 0x26))

processer.start()

print("actual", String(0x11EB+0x0126, radix: 16))

print(String(processer.memory.read(addr: 0x0100).toint(), radix: 16), String(processer.memory.read(addr: 0x0101).toint(), radix: 16), separator: "")
