//
//  main.swift
//  thegail-vm
//
//  Created by Teddy Gaillard on 8/12/20.
//  Copyright © 2020 thegail. All rights reserved.
//

import Foundation

let processor = CPU()

// This example program adds two 16 bit numbers, stored at 0100-0101 and 0102-0103 and outputs the result at 0100-0101

// Assembly instructions for this program:
// LOD 0101
// ADD 0103
// STO 0101
// LOD 0100
// AWC 0102
// STO 0100
// HLT

processor.memory.write(addr: 0x0000, c: Byte(fromInt: 0x10))
processor.memory.write(addr: 0x0001, c: Byte(fromInt: 0x01))
processor.memory.write(addr: 0x0002, c: Byte(fromInt: 0x01))

processor.memory.write(addr: 0x0003, c: Byte(fromInt: 0x20))
processor.memory.write(addr: 0x0004, c: Byte(fromInt: 0x01))
processor.memory.write(addr: 0x0005, c: Byte(fromInt: 0x03))

processor.memory.write(addr: 0x0006, c: Byte(fromInt: 0x11))
processor.memory.write(addr: 0x0007, c: Byte(fromInt: 0x01))
processor.memory.write(addr: 0x0008, c: Byte(fromInt: 0x01))

processor.memory.write(addr: 0x0009, c: Byte(fromInt: 0x10))
processor.memory.write(addr: 0x000A, c: Byte(fromInt: 0x01))
processor.memory.write(addr: 0x000B, c: Byte(fromInt: 0x00))

processor.memory.write(addr: 0x000C, c: Byte(fromInt: 0x21))
processor.memory.write(addr: 0x000D, c: Byte(fromInt: 0x01))
processor.memory.write(addr: 0x000E, c: Byte(fromInt: 0x02))

processor.memory.write(addr: 0x000F, c: Byte(fromInt: 0x11))
processor.memory.write(addr: 0x0010, c: Byte(fromInt: 0x01))
processor.memory.write(addr: 0x0011, c: Byte(fromInt: 0x00))

processor.memory.write(addr: 0x0012, c: Byte(fromInt: 0xFF))

processor.memory.write(addr: 0x0100, c: Byte(fromInt: 0x11))
processor.memory.write(addr: 0x0101, c: Byte(fromInt: 0xEB))
processor.memory.write(addr: 0x0102, c: Byte(fromInt: 0x01))
processor.memory.write(addr: 0x0103, c: Byte(fromInt: 0x26))

processor.start()

print(String(processor.memory.read(addr: 0x0100).toint(), radix: 16), String(processor.memory.read(addr: 0x0101).toint(), radix: 16), separator: "")
