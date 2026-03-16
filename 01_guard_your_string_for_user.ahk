#SingleInstance,Force
text := "Hello, secret world!你好"

MsgBox, % encrypted := encrypt(text)
Clipboard:=encrypted
MsgBox, % decripted := decrypt(encrypted)
Clipboard:=decripted
ExitApp


decrypt(hex) {
   m := ""
   VarSetCapacity(buf, len := (StrLen(hex) - 2)//2)
   while RegExMatch(hex, "O)..", m, m ? m.Pos + m.Len : 1) {
      byte := "0x" . m[0]
      if (A_Index = 1)
         r := byte  
      else {
         pos := A_Index - 2          
         key := Mod(r + pos, 256)    
         NumPut(byte ^ key, buf, pos, "UChar")
      }
   }
   return StrGet(&buf, len, "UTF-8")
}

encrypt(text) {
    ;;;setit
   r := 111
   ;;;setit
   VarSetCapacity(buf, len := StrPut(text, "UTF-8") - 1)
   StrPut(text, &buf, len, "UTF-8")
   
   hex := Format("{:02x}", r)
   Loop % len {
      pos := A_Index - 1             
      key := Mod(r + pos, 256)       
      b := NumGet(&buf + pos, 0, "UChar")
      hex .= Format("{:02x}", b ^ key)
   }
   return hex
}