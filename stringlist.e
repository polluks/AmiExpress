/*

string list class that manages the freeing of its own strings and hides access to the underlying list implementation

*/

OPT MODULE

EXPORT OBJECT stringlist
  PRIVATE items:PTR TO LONG
  PRIVATE initialMax:LONG
ENDOBJECT

EXPORT PROC end() OF stringlist				-> destructor
  self.clear()
  DisposeLink(self.items)
ENDPROC

EXPORT PROC stringlist(maxSize=-1) OF stringlist  ->constructor
  IF maxSize=-1 THEN maxSize:=100
  self.initialMax:=maxSize
  self.items:=List(maxSize)
ENDPROC

EXPORT PROC item(n) OF stringlist
ENDPROC self.items[n]

EXPORT PROC clear() OF stringlist
  DEF i
  FOR i:=0 TO ListLen(self.items)-1
    DisposeLink(self.items[i])
  ENDFOR
  IF ListMax(self.items)>self.initialMax
    DisposeLink(self.items)
    self.items:=List(self.initialMax)
  ELSE  
    SetList(self.items,0)
  ENDIF
ENDPROC

EXPORT PROC expand() OF stringlist
  DEF old,len,inc
  old:=self.items
  len:=ListLen(old)
  inc:=Shr(len,2)
  IF inc<5 THEN inc:=5
  len:=len+inc
  self.items:=List(len)
  ListAdd(self.items,old)
  DisposeLink(old)
ENDPROC len

EXPORT PROC add(stringVal:PTR TO CHAR) OF stringlist
  DEF s,c
  
  c:=ListLen(self.items)
  IF c=ListMax(self.items) THEN self.expand()
  
  s:=String(StrLen(stringVal))
  StrCopy(s,stringVal)
  ListAdd(self.items,[0])
  self.items[c]:=s
ENDPROC c

EXPORT PROC setItem(n,stringVal:PTR TO CHAR) OF stringlist
  DEF s
  
  WHILE n>=ListLen(self.items) DO self.add('')
  s:=String(StrLen(stringVal))
  StrCopy(s,stringVal)
  DisposeLink(self.items[n])
  self.items[n]:=s
ENDPROC
  
EXPORT PROC remove(n) OF stringlist
  DEF i,t
  DisposeLink(self.items[n])
  t:=ListLen(self.items)
  FOR i:=n TO t-2
    self.items[i]:=self.items[i+1]
  ENDFOR
  SetList(self.items,t-1)
ENDPROC

EXPORT PROC setSize(n) OF stringlist
  DEF i
  FOR i:=n TO ListLen(self.items)-1
    DisposeLink(self.items[i])
  ENDFOR
  SetList(self.items,n)
ENDPROC

EXPORT PROC count() OF stringlist IS ListLen(self.items)

EXPORT PROC maxSize() OF stringlist IS ListMax(self.items)


/*

 list class that holds long values

*/

EXPORT OBJECT stdlist
  PRIVATE items:PTR TO LONG
  PRIVATE initialMax:LONG
ENDOBJECT

EXPORT PROC end() OF stdlist				-> destructor
  DisposeLink(self.items)
ENDPROC

EXPORT PROC stdlist(maxSize=-1) OF stdlist  ->constructor
  IF maxSize=-1 THEN maxSize:=100
  self.initialMax:=maxSize
  self.items:=List(maxSize)
ENDPROC

EXPORT PROC item(n) OF stdlist
ENDPROC self.items[n]

EXPORT PROC clear() OF stdlist
  DEF i
  IF ListMax(self.items)>self.initialMax
    DisposeLink(self.items)
    self.items:=List(self.initialMax)
  ELSE  
    SetList(self.items,0)
  ENDIF
ENDPROC

EXPORT PROC expand() OF stdlist
  DEF old,len,inc
  old:=self.items
  len:=ListLen(old)
  inc:=Shr(len,2)
  IF inc<5 THEN inc:=5
  len:=len+inc
  self.items:=List(len)
  ListAdd(self.items,old)
  DisposeLink(old)
ENDPROC len

EXPORT PROC add(v:LONG) OF stdlist
  DEF s,c
  
  c:=ListLen(self.items)
  IF c=ListMax(self.items) THEN self.expand()
  
  ListAdd(self.items,[0])
  self.items[c]:=v
ENDPROC c

EXPORT PROC setItem(n,v) OF stdlist  
  WHILE n>=ListLen(self.items) DO self.add(0)
  self.items[n]:=v
ENDPROC

EXPORT PROC remove(n) OF stdlist
  DEF i,t
  t:=ListLen(self.items)
  FOR i:=n TO t-2
    self.items[i]:=self.items[i+1]
  ENDFOR
  SetList(self.items,t-1)
ENDPROC

EXPORT PROC setSize(n) OF stdlist
  SetList(self.items,n)
ENDPROC

EXPORT PROC count() OF stdlist IS ListLen(self.items)

EXPORT PROC maxSize() OF stdlist IS ListMax(self.items)

