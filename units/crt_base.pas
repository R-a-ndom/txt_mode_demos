{
  --- CRT_BASE.PAS ---

  Screen coordinates with CRT unit
  for *NIX terminals

  (c) Alexey Sorokin, 2018
}


Unit CRT_Base;


INTERFACE


USES
  CRT;

TYPE

Point=record
  Col,Row:Word
end;

CONST

{ CRT unit keyboard values }

kbdUp=#72;
kbdDown=#80;
kbdLeft=#75;
kbdRight=#77;

kbdENTER=#13;
kbdTAB=#9;
kbdBackspace=#8;
kbdSpace=#32;
kbdESC=#27;

{ PROCEDURES AND FUNCTIONS}

Function MiddleCol:Word;

Function MiddleRow:Word;

Function GetScreenMiddle:Point;

Function GetMidRectLeftTop(RectWidth,RectHeight:Word):Point;

Procedure ClearLine(Num:Word);

Procedure ClearRect(LeftTop:Point;ColNum,RowNum:Word);

Function ClearRectInMid(ColNum,RowNum:Word):Point;

Procedure CursorOut;

Procedure ResetTerminal;


IMPLEMENTATION


Function MiddleCol:Word;
begin
  MiddleCol:=ScreenWidth div 2;
end;

{ --- }

Function MiddleRow:Word;
begin
  MiddleRow:=ScreenHeight div 2;
end;

{ --- }

Function GetScreenMiddle:Point;
var
  A:Point;
begin
  A.Col:=MiddleCol;
  A.Row:=MiddleRow;
  GetScreenMiddle:=A;
end;

{ --- }

Function GetMidRectLeftTop(RectWidth,RectHeight:Word):Point;
var
  A,M:Point;
begin
  M:=GetScreenMiddle;
  A.Col := M.Col - ( RectWidth  div 2 );
  A.Row := M.Row - ( RectHeight div 2 );
  GetMidRectLeftTop:=A;
end;

{ --- }

Procedure ClearLine(Num:Word);
begin
  While Num>0 do
  begin
    Write(#32);
    dec(Num);
  end;
end;

{ --- }

Procedure ClearRect(LeftTop:Point;ColNum,RowNum:Word);
var
  i:Word;
begin
  for i:=0 to RowNum-1 do
  begin
    GotoXY(LeftTop.Col,LeftTop.Row+i);
    ClearLine(ColNum);
  end;
end;

{ --- }

Function ClearRectInMid(ColNum,RowNum:Word):Point;
var
  MidLeftTop:Point;
begin
  MidLeftTop:=GetMidRectLeftTop(ColNum,RowNum);
  ClearRect(MidLeftTop,ColNum,RowNum);
  ClearRectInMid:=MidLeftTop;
end;

{ --- }

Procedure CursorOut;
begin
  GotoXY(ScreenWidth,1);
end;

{ --- }

Procedure ResetTerminal;
begin
  Write(#27,'[0m');
end;

{ --- *** --- }

END.