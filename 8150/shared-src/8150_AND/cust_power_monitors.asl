//
// Copyright (c) 2021-2022 DuoWoA authors. All Rights Reserved.
//
// Module Name:
//
//     cust_power_monitors.asl
//
// Abstract:
//
//     Contains device definitions for the Analog Devices
//     Four-Channel Power Accumulator MAX34417 Device built for
//     Microsoft Surface. This device is only present on
//     Engineering Validation Boards and should not be exposed
//     to the user on later board revisions.
//
// Environment:
//
//     Advanced Configuration and Power Interface (ACPI)
//
// Revision History:
//
//     2022-12-23 - @gus33000 - Initial revision
//
// License:
//
//     SPDX-License-Identifier: MIT
//

Device (PA01)
{
    Name (_HID, "MAX34417")
    Name (_CID, "MAX34417")
    Name (_UID, 1)
    Method (_CRS, 0x0, NotSerialized)
    {
        Name (RBUF,
            ResourceTemplate ()
            {
                // I2C
                I2CSerialBus(
                    0x0012,
                    ControllerInitiated,
                    400000,
                    AddressingMode7Bit,
                    "\\_SB.IC20",
                    ,
                    ,
                    ,
                    )
            }
        )
        Return(RBUF)
    }
    Method (_STA)
    {
        If(BDID >= 0x0D) {
            Return (0)
        }
        Return (0x0F)
    }
    // _DSM - Device-Specific Method
    //
    // Arg0: UUID Unique function identifier
    // Arg1: Integer Revision ID
    // Arg2: Integer Function Index (0 = Return Supported Functions)
    // Arg3: Package Parameters
    //
    Function(_DSM,{BuffObj, IntObj},{BuffObj, IntObj, IntObj, PkgObj}){
        If(LEqual(Arg0,ToUUID("4993a436-e1ac-4dc7-b4f8-46a5008fb9e7"))) {
            //
            // Switch on the function index
            //
            switch(Arg2) {
                case(0) {
                    switch(ToInteger(Arg1)) {
                        case (0) {
                            Return(Buffer(One) { 0x07 })
                        }
                        default {
                            Return(Buffer(One) { 0x00 })
                        }
                    }
                }
                case(1) {
                    switch(ToInteger(Arg1)) {
                        case (0) {
                            Name(PBUF, Package() {
                                "Touch_D5",
                                0x32,
                                "DISPLAY_R2",
                                0x32,
                                "WIFI_3V3_TX",
                                0x32,
                                "BOB_V3",
                                0x0A
                            })
                            Return(PBUF)
                        }
                        default {
                            Return(Buffer(One) { 0x00 })
                        }
                    }
                }
                case(2) {
                    switch(ToInteger(Arg1)) {
                        case (0) {
                            Name(CBUF, Package() {
                                0x04
                            })
                            Return(CBUF)
                        }
                        default {
                            Return(Buffer(One) { 0x00 })
                        }
                    }
                }
                default {
                    // Unsupported function index
                    return (Buffer() {0})
                }
            }
        }
        else {
            //
            // No functions are supported for this UUID.
            //
            return (Buffer() {0})
        }
    }
    // PEP Proxy Support
    Name(PGID, Buffer(10) {"\\_SB.PA01"})       // Device ID buffer - PGID (Pep given ID)
    Name(DBUF, Buffer(DBFL) {})                 // Device ID buffer - PGID (Pep given ID)
    CreateByteField(DBUF, 0x0, STAT)            // STATUS 1 BYTE
                                                // HIDDEN 1 BYTE (SIZE)
    CreateByteField(DBUF, 2, DVAL)              // Packet value, 1 BYTES Device Status
    CreateField(DBUF, 24, 160, DEID)            // Device ID, 20 BYTES (160 Bits)
    Method (_S1D, 0) { Return (3) }             // S1 => D3
    Method (_S2D, 0) { Return (3) }             // S2 => D3
    Method (_S3D, 0) { Return (3) }             // S3 => D3
    Method(_PS0, 0x0, NotSerialized)
    {
        Store(Buffer(ESNL){}, DEID)
        Store(0, DVAL)
        Store(PGID, DEID)
        If(\_SB.ABD.AVBL)
        {
            Store(DBUF, \_SB.PEP0.FLD0)
        }
    }
    Method(_PS3, 0x0, NotSerialized)
    {
        Store(Buffer(ESNL){}, DEID)
        Store(3, DVAL)
        Store(PGID, DEID)
        If(\_SB.ABD.AVBL)
        {
            Store(DBUF, \_SB.PEP0.FLD0)
        }
    }
}
Device (PA05)
{
    Name (_HID, "MAX34417")
    Name (_CID, "MAX34417")
    Name (_UID, 5)
    Method (_CRS, 0x0, NotSerialized)
    {
        Name (RBUF,
            ResourceTemplate ()
            {
                // I2C
                I2CSerialBus(
                    0x001A,
                    ControllerInitiated,
                    400000,
                    AddressingMode7Bit,
                    "\\_SB.IC20",
                    ,
                    ,
                    ,
                    )
            }
        )
        Return(RBUF)
    }
    Method (_STA)
    {
        If(BDID >= 0x0D) {
            Return (0)
        }
        Return (0x0F)
    }
    // _DSM - Device-Specific Method
    //
    // Arg0: UUID Unique function identifier
    // Arg1: Integer Revision ID
    // Arg2: Integer Function Index (0 = Return Supported Functions)
    // Arg3: Package Parameters
    //
    Function(_DSM,{BuffObj, IntObj},{BuffObj, IntObj, IntObj, PkgObj}){
        If(LEqual(Arg0,ToUUID("4993a436-e1ac-4dc7-b4f8-46a5008fb9e7"))) {
            //
            // Switch on the function index
            //
            switch(Arg2) {
                case(0) {
                    switch(ToInteger(Arg1)) {
                        case (0) {
                            Return(Buffer(One) { 0x07 })
                        }
                        default {
                            Return(Buffer(One) { 0x00 })
                        }
                    }
                }
                case(1) {
                    switch(ToInteger(Arg1)) {
                        case (0) {
                            Name(PBUF, Package() {
                                "SOC_DIGITAL_IO",
                                0x14,
                                "R2_IMEM",
                                0x19,
                                "GFX_CORE",
                                0x14,
                                "R2_DDR",
                                0x64
                            })
                            Return(PBUF)
                        }
                        default {
                            Return(Buffer(One) { 0x00 })
                        }
                    }
                }
                case(2) {
                    switch(ToInteger(Arg1)) {
                        case (0) {
                            Name(CBUF, Package() {
                                0x04
                            })
                            Return(CBUF)
                        }
                        default {
                            Return(Buffer(One) { 0x00 })
                        }
                    }
                }
                default {
                    // Unsupported function index
                    return (Buffer() {0})
                }
            }
        }
        else {
            //
            // No functions are supported for this UUID.
            //
            return (Buffer() {0})
        }
    }
    // PEP Proxy Support
    Name(PGID, Buffer(10) {"\\_SB.PA05"})       // Device ID buffer - PGID (Pep given ID)
    Name(DBUF, Buffer(DBFL) {})                 // Device ID buffer - PGID (Pep given ID)
    CreateByteField(DBUF, 0x0, STAT)            // STATUS 1 BYTE
                                                // HIDDEN 1 BYTE (SIZE)
    CreateByteField(DBUF, 2, DVAL)              // Packet value, 1 BYTES Device Status
    CreateField(DBUF, 24, 160, DEID)            // Device ID, 20 BYTES (160 Bits)
    Method (_S1D, 0) { Return (3) }             // S1 => D3
    Method (_S2D, 0) { Return (3) }             // S2 => D3
    Method (_S3D, 0) { Return (3) }             // S3 => D3
    Method(_PS0, 0x0, NotSerialized)
    {
        Store(Buffer(ESNL){}, DEID)
        Store(0, DVAL)
        Store(PGID, DEID)
        If(\_SB.ABD.AVBL)
        {
            Store(DBUF, \_SB.PEP0.FLD0)
        }
    }
    Method(_PS3, 0x0, NotSerialized)
    {
        Store(Buffer(ESNL){}, DEID)
        Store(3, DVAL)
        Store(PGID, DEID)
        If(\_SB.ABD.AVBL)
        {
            Store(DBUF, \_SB.PEP0.FLD0)
        }
    }
}
Device (PA07)
{
    Name (_HID, "MAX34417")
    Name (_CID, "MAX34417")
    Name (_UID, 7)
    Method (_CRS, 0x0, NotSerialized)
    {
        Name (RBUF,
            ResourceTemplate ()
            {
                // I2C
                I2CSerialBus(
                    0x001E,
                    ControllerInitiated,
                    400000,
                    AddressingMode7Bit,
                    "\\_SB.IC20",
                    ,
                    ,
                    ,
                    )
            }
        )
        Return(RBUF)
    }
    Method (_STA)
    {
        If(BDID >= 0x0D) {
            Return (0)
        }
        Return (0x0F)
    }
    // _DSM - Device-Specific Method
    //
    // Arg0: UUID Unique function identifier
    // Arg1: Integer Revision ID
    // Arg2: Integer Function Index (0 = Return Supported Functions)
    // Arg3: Package Parameters
    //
    Function(_DSM,{BuffObj, IntObj},{BuffObj, IntObj, IntObj, PkgObj}){
        If(LEqual(Arg0,ToUUID("4993a436-e1ac-4dc7-b4f8-46a5008fb9e7"))) {
            //
            // Switch on the function index
            //
            switch(Arg2) {
                case(0) {
                    switch(ToInteger(Arg1)) {
                        case (0) {
                            Return(Buffer(One) { 0x07 })
                        }
                        default {
                            Return(Buffer(One) { 0x00 })
                        }
                    }
                }
                case(1) {
                    switch(ToInteger(Arg1)) {
                        case (0) {
                            Name(PBUF, Package() {
                                "TOTAL_SYSTEM",
                                0x0A,
                                "WIFI_LTE_1V3",
                                0x0A,
                                "USB_VBUS",
                                0x0A,
                                "UVS_1V8",
                                0x32
                            })
                            Return(PBUF)
                        }
                        default {
                            Return(Buffer(One) { 0x00 })
                        }
                    }
                }
                case(2) {
                    switch(ToInteger(Arg1)) {
                        case (0) {
                            Name(CBUF, Package() {
                                0x04
                            })
                            Return(CBUF)
                        }
                        default {
                            Return(Buffer(One) { 0x00 })
                        }
                    }
                }
                default {
                    // Unsupported function index
                    return (Buffer() {0})
                }
            }
        }
        else {
            //
            // No functions are supported for this UUID.
            //
            return (Buffer() {0})
        }
    }
    // PEP Proxy Support
    Name(PGID, Buffer(10) {"\\_SB.PA07"})       // Device ID buffer - PGID (Pep given ID)
    Name(DBUF, Buffer(DBFL) {})                 // Device ID buffer - PGID (Pep given ID)
    CreateByteField(DBUF, 0x0, STAT)            // STATUS 1 BYTE
                                                // HIDDEN 1 BYTE (SIZE)
    CreateByteField(DBUF, 2, DVAL)              // Packet value, 1 BYTES Device Status
    CreateField(DBUF, 24, 160, DEID)            // Device ID, 20 BYTES (160 Bits)
    Method (_S1D, 0) { Return (3) }             // S1 => D3
    Method (_S2D, 0) { Return (3) }             // S2 => D3
    Method (_S3D, 0) { Return (3) }             // S3 => D3
    Method(_PS0, 0x0, NotSerialized)
    {
        Store(Buffer(ESNL){}, DEID)
        Store(0, DVAL)
        Store(PGID, DEID)
        If(\_SB.ABD.AVBL)
        {
            Store(DBUF, \_SB.PEP0.FLD0)
        }
    }
    Method(_PS3, 0x0, NotSerialized)
    {
        Store(Buffer(ESNL){}, DEID)
        Store(3, DVAL)
        Store(PGID, DEID)
        If(\_SB.ABD.AVBL)
        {
            Store(DBUF, \_SB.PEP0.FLD0)
        }
    }
}
Device (PA06)
{
    Name (_HID, "MAX34417")
    Name (_CID, "MAX34417")
    Name (_UID, 6)
    Method (_CRS, 0x0, NotSerialized)
    {
        Name (RBUF,
            ResourceTemplate ()
            {
                // I2C
                I2CSerialBus(
                    0x001C,
                    ControllerInitiated,
                    400000,
                    AddressingMode7Bit,
                    "\\_SB.I2C2",
                    ,
                    ,
                    ,
                    )
            }
        )
        Return(RBUF)
    }
    Method (_STA)
    {
        If(BDID >= 0x0D) {
            Return (0)
        }
        Return (0x0F)
    }
    // _DSM - Device-Specific Method
    //
    // Arg0: UUID Unique function identifier
    // Arg1: Integer Revision ID
    // Arg2: Integer Function Index (0 = Return Supported Functions)
    // Arg3: Package Parameters
    //
    Function(_DSM,{BuffObj, IntObj},{BuffObj, IntObj, IntObj, PkgObj}){
        If(LEqual(Arg0,ToUUID("4993a436-e1ac-4dc7-b4f8-46a5008fb9e7"))) {
            //
            // Switch on the function index
            //
            switch(Arg2) {
                case(0) {
                    switch(ToInteger(Arg1)) {
                        case (0) {
                            Return(Buffer(One) { 0x07 })
                        }
                        default {
                            Return(Buffer(One) { 0x00 })
                        }
                    }
                }
                case(1) {
                    switch(ToInteger(Arg1)) {
                        case (0) {
                            Name(PBUF, Package() {
                                "VSYS_POWER",
                                0x14,
                                "Display_Power",
                                0x32,
                                "Touch_Boost_Power",
                                0x64,
                                "Touch_1V8_Power",
                                0x32
                            })
                            Return(PBUF)
                        }
                        default {
                            Return(Buffer(One) { 0x00 })
                        }
                    }
                }
                case(2) {
                    switch(ToInteger(Arg1)) {
                        case (0) {
                            Name(CBUF, Package() {
                                0x04
                            })
                            Return(CBUF)
                        }
                        default {
                            Return(Buffer(One) { 0x00 })
                        }
                    }
                }
                default {
                    // Unsupported function index
                    return (Buffer() {0})
                }
            }
        }
        else {
            //
            // No functions are supported for this UUID.
            //
            return (Buffer() {0})
        }
    }
}