#SingleInstance,Force

;eg:
;offset=100001
;de961a4cad0d2f843683e45aac1e2bdb229ce354f096ae14b0532a

;offset=100005
;de96e644a11d3b9c1263c82290ee1f93e65cbf1c3c26daac54f346



Global offset:=100005
text := "Hello, secret world!你好"
MsgBox, % encrypted := encrypt(text)
Clipboard:=encrypted
MsgBox, % decripted := decrypt(encrypted)
;Clipboard:=decripted
ExitApp


encrypt(text) {
   r := 222
   ;offset := 4  ; ← 改这里测试偏移！比如改成 0 / 1 / 4 / 10 对比输出
   VarSetCapacity(buf, len := StrPut(text, "UTF-8") - 1)
   StrPut(text, &buf, len, "UTF-8")
   
   hex := Format("{:02x}", r)  ; 头字节仍只存初始 r（解密时靠 offset 同步）
   key := r

   Loop % len {
      plain := *(&buf + A_Index - 1)
      cipher := plain ^ (key & 0xFF)   ; 保证字节范围
      hex .= Format("{:02x}", cipher)
      key += offset   ; ✅ 偏移生效！
   }
   return hex
}

decrypt(hex) {
   ;offset := 4  ; ← 必须和 encrypt 里的 offset 一致！
   r := "0x" SubStr(hex, 1, 2)
   cipherHex := SubStr(hex, 3)
   len := StrLen(cipherHex) // 2
   VarSetCapacity(buf, len)

   key := r
   Loop % len {
      cipher := "0x" SubStr(cipherHex, A_Index*2 - 1, 2)
      plain := cipher ^ (key & 0xFF)
      NumPut(plain, buf, A_Index - 1, "UChar")
      key += offset   ; ✅ 同步偏移
   }
   return StrGet(&buf, len, "UTF-8")
}