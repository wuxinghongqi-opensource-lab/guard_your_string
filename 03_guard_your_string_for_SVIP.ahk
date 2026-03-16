#SingleInstance, Force

text := "abc你好"
key  := "mypassword12!的"
enc := encrypt(text, key)
MsgBox, % "Encrypted (" . (StrLen(enc)/2) . " bytes):`n" . enc
Clipboard := enc

dec := decrypt(enc, key)
MsgBox, Decrypted:`n[%dec%]

ExitApp

encrypt(text, key) {
    r := DeriveKeyByte(key)
    len := StrPut(text, "UTF-8") - 1
    VarSetCapacity(buf, len, 0)
    StrPut(text, &buf, len + 1, "UTF-8")

    hex := ""
    Loop, %len% {
        b := NumGet(&buf + A_Index - 1, 0, "UChar")
        hex .= Format("{:02x}", b ^ r)
    }
    return hex
}

decrypt(hex, key) {
    if (hex = "" || Mod(StrLen(hex), 2))
        return ""
    r := DeriveKeyByte(key)
    len := StrLen(hex) // 2
    VarSetCapacity(buf, len, 0)
    Loop, %len% {
        byteHex := SubStr(hex, (A_Index-1)*2 + 1, 2)
        byteVal := "0x" byteHex
        NumPut(byteVal ^ r, buf, A_Index - 1, "UChar")
    }
    return StrGet(&buf, len, "UTF-8")
}


DeriveKeyByte(key) {
    hash := 5381
    Loop, Parse, key
        hash := ((hash << 5) + hash) ^ Asc(A_LoopField)  ; hash * 33 ^ c
    return hash & 0xFF
}
CRC32(string) {
    static table := ""
    if (table = "") {
        VarSetCapacity(table, 1024, 0)
        Loop, 256 {
            crc := A_Index - 1
            Loop, 8
                crc := (crc & 1) ? ((crc >> 1) ^ 0xEDB88320) : (crc >> 1)
            NumPut(crc, table, (A_Index-1)*4, "UInt")
        }
    }
    crc := 0xFFFFFFFF
    Loop, Parse, string
    {
        ch := Asc(A_LoopField)
        idx := (crc ^ ch) & 0xFF
        crc := (crc >> 8) ^ NumGet(table, idx*4, "UInt")
    }
    return 0xFFFFFFFF ^ crc
}