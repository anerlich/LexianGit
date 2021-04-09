unit uCnv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, Db, ExtCtrls, DBCtrls, Grids,
  DBGrids;
Const
     BufSize = 16000;
     Version = 'V3.02  Copyright (c) EXECuLINK Systems 1995';
Type
    AnyStr = String[255];

    InPoint = ^Inrec;
    InRec = Record
          Fld : String[10];
          Pic : String[20];
          Len : Byte;
          Dec : Byte;
          Dot : Boolean;
          Lft : String[5];
          Rht : String[5];
          Beg : Integer;
          Cln : Boolean;
          Dat : AnyStr;
    End;

    OutPoint = ^OutRec;
    OutRec = Record
           Fld : String[10];
           Len : Byte;
           Dec : Byte;
           Pic : String[20];
           Trm : Char;
           Pad : String[2];
           Inp : Byte;
           Val : String[25];
           Dat : AnyStr;
    End;

    ExcPoint = ^ExcRec;
    ExcRec = Record
           Fld : String[10];
           Opr : Char;
           Out : Byte;
           Typ : Char;
           Val : AnyStr;
           Num : Extended;
           Inp : Byte;
    End;


type
  TfrmConvertDBF = class(TForm)
    OpenDialog1: TOpenDialog;
    StatusBar1: TStatusBar;
    DBGrid1: TDBGrid;
    tblDBF: TTable;
    srcDBF: TDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Button1: TButton;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    DBNavigator1: TDBNavigator;
    procedure Button1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    Procedure GetBuffer;
    Procedure Init;
    Procedure GetDbfInfo;
    Procedure ZapOutput;
    Procedure UpdDbfHeader(nRecords:LongInt);
    Procedure OutputData;
    Procedure Convert;
    Procedure FlushOutput;
    Procedure Output(Var cStr:AnyStr; nLen : Byte);
    Procedure DisplayError(MessageText:String);
    Function CnvPic(cVal,cPic,cInpPic:AnyStr;nLen,nDec:Byte):AnyStr;
    Function IncludeIt : Boolean;
    Procedure InputData;
    Function GetFormat(cFormat : AnyStr) : Boolean;
    Procedure GetField(cStr:AnyStr;lInp:Boolean);
    Procedure GetLine;
    Procedure GetExclude(cStr:AnyStr);
    Function PicType(cStr:AnyStr) : Char;
    Procedure MatchInputOutput;
    Function LTrim(cStr: AnyStr): AnyStr;
    Function Trim(cTrm:AnyStr):AnyStr;
    Function AllTrim(cStr:AnyStr):AnyStr;
    Function Replicate(cChr:Char;nLen:Byte):AnyStr;
    Function RPad(cStr:AnyStr;cChr:Char;nLen:Byte):AnyStr;
    Function LPad(cStr:AnyStr;cChr:Char;nLen:Byte):AnyStr;
    Function Empty(cStr : AnyStr) : Boolean;
    Function GetWord(cStr:AnyStr) : AnyStr;
    Function Upper(cStr:AnyStr):AnyStr;
    Function Between(cStr,cBeg,cEnd:AnyStr):AnyStr;
    Function Before(cStr,cUpTo:AnyStr):AnyStr;
    Function After(cStr,cFrm:AnyStr):AnyStr;
    Function From(cStr,cFrm:AnyStr):AnyStr;
    Function DelStr(cStr,cDel:AnyStr):AnyStr;
    Function RepStr(cStr,cFnd,cRep:AnyStr):AnyStr;
    Function StrOf(nNum:Extended ;nWdt,nDec:Byte):AnyStr;
    Function ValOf(cStr:AnyStr) : Extended;
    Function Power(nPwr:Integer):LongInt;
    Function CleanUp(cStr:AnyStr):AnyStr;
    Function PicLen(cPic:AnyStr):Integer;
    Function Delimiter(cStr:AnyStr):Anystr;
  public
    { Public declarations }
    procedure CreateCsv;
  end;


var
  frmConvertDBF: TfrmConvertDBF;
  hInput  : File;
  FirstLoad : Boolean;
  
  aData   : Array [1..4096]  of Char;
   aInpBuf : Array [1..BufSize] of Char;
   aOutBuf : Array [1..BufSize] of Char;
   aInp     : Array [1..200]  of InPoint;
   aOut     : Array [1..200]  of OutPoint;
   aExc     : Array [1..200]  of ExcPoint;

   hOutput : File;

   cInput  : AnyStr;
   cOutput : AnyStr;
   cPath   : AnyStr;
   nRead   : Integer;
   nLine   : Word;
   nBufPos : Word;
   nWrite  : Integer;
   nRec    : LongInt;
   nErrCnt : LongInt;
   nOutPos : Word;

   cInpDlm : AnyStr;
   cOutDlm : AnyStr;
   lDbfFlg : Boolean;
   nImport : LongInt;
   nInpCnt : Byte;
   nOutCnt : Byte;
   nExcCnt : Byte;

   nRow    : Byte;
   nCol    : Byte;
   nCnt    : Integer;
   cCrLf   : String[2];
   cDelByt : String[1];
   cCen    : String[2];
   cYear   : String[4];

   lChk    : Boolean;

implementation

{$R *.DFM}

{$V-}
Function TfrmConvertDBF.LTrim(cStr: AnyStr): AnyStr;
Var
   nCnt :Integer;
   lFlg : Boolean;
Begin
     nCnt := 0;
     lFlg := False;
     IF Length(cStr) > 0 Then
     Begin
          Repeat
                 nCnt := nCnt + 1;
                 IF not (cStr[nCnt] in [' ',#9,#0]) Then
                    Begin
                    IF (nCnt > 1) Then
                    Begin
                         Delete(cStr,1,nCnt - 1);
                    End;
                    lFlg := True;
                    ltrim := cStr
                    End;
           Until (lFlg);
      End
      Else
      ltrim := '';
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
{$V-}
Function TfrmConvertDBF.Trim(cTrm:AnyStr):AnyStr;
Var
   nCnt : Integer;
Begin
     IF Length(cTrm) <> 0 Then
     Begin
          nCnt := Length(cTrm) + 1;

          Repeat
                nCnt := nCnt -1;
          Until ((nCnt = 0) OR (not (cTrm[nCnt] in [' ',#9,#0])));

          IF nCnt = 0 Then
             Trim := ''
          Else
             Trim := Copy(cTrm,1,nCnt);
     End
     Else
         Trim := '';

End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Function TfrmConvertDBF.AllTrim(cStr:AnyStr):AnyStr;
Begin
     AllTrim := Ltrim(Trim(cStr));
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Function TfrmConvertDBF.Replicate(cChr:Char;nLen:Byte):AnyStr;
Var
   nCnt : Byte;
   cStr : AnyStr;
Begin
     cStr := '';
     For nCnt := 1 to nLen Do cStr := cStr + cChr;
     Replicate := cStr;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Function TfrmConvertDBF.RPad(cStr:AnyStr;cChr:Char;nLen:Byte):AnyStr;
Begin
     IF Length(cStr) < nLen Then
        cStr := cStr+Replicate(cChr,nLen-Length(cStr))
     Else
         cStr := Copy(cStr,1,nLen);
     RPad := cStr;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Function TfrmConvertDBF.LPad(cStr:AnyStr;cChr:Char;nLen:Byte):AnyStr;
Begin
     IF Length(cStr) < nLen Then
        cStr := Replicate(cChr,nLen-Length(cStr))+cStr
     Else
         cStr := Copy(cStr,1,nLen);
     LPad := cStr;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Function TfrmConvertDBF.Empty(cStr : AnyStr) : Boolean;
Begin
     Empty := (Length(Trim(cStr)) = 0);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Function TfrmConvertDBF.GetWord(cStr:AnyStr) : AnyStr;
Begin
     cStr := Ltrim(Trim(cStr));
     IF Pos(' ',cStr) > 0 Then
        GetWord := Copy(cStr,1,Pos(' ',cStr)-1)
     Else
         GetWord := cStr;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Function TfrmConvertDBF.Upper(cStr:AnyStr):AnyStr;
Var
   nCnt : Byte;
   nLen : Byte;
Begin
     nLen := Length(cStr);

     For nCnt := 1 to nLen Do
     Begin
          IF cStr[nCnt] > 'Z' Then
          Begin
               cStr[nCnt] := UpCase(cStr[nCnt]);
          End;
     End;
     Upper := cStr;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Function TfrmConvertDBF.Between(cStr,cBeg,cEnd:AnyStr):AnyStr;
Var
   cTmp  : AnyStr;
   nFrom : Byte;
   nTo   : Byte;
Begin
     cTmp  := Upper(cStr);
     cBeg  := Upper(cBeg);
     cEnd  := Upper(cEnd);
     nFrom := Pos(cBeg,cTmp);
     nTo   := Pos(cEnd,cTmp);
     IF (nFrom > 0) and (nTo > 0) Then
     Begin
          Between := Copy(cStr,nFrom+Length(cBeg),nTo-(nFrom+Length(cBeg)));
     End

End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Function TfrmConvertDBF.Before(cStr,cUpTo:AnyStr):AnyStr;
Begin
     Before := Copy(cStr,1,Pos(Upper(cUpTo),Upper(cStr))-1);
End;
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Function TfrmConvertDBF.After(cStr,cFrm:AnyStr):AnyStr;
Var
   nPos : Byte;
Begin
     nPos := Pos(Upper(cFrm),Upper(cStr));
     IF nPos > 0 Then
        After := Copy(cStr,nPos+Length(cFrm),255)
     Else
         After := '';
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Function TfrmConvertDBF.From(cStr,cFrm:AnyStr):AnyStr;
Begin
     From := Copy(cStr,Pos(Upper(cFrm),Upper(cStr)),255);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Function TfrmConvertDBF.DelStr(cStr,cDel:AnyStr):AnyStr;
Var
   nPos : Byte;
Begin
     nPos := Pos(Upper(cDel),Upper(cStr));
     Delete(cStr,nPos,Length(cDel));
     DelStr := cStr;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Function TfrmConvertDBF.RepStr(cStr,cFnd,cRep:AnyStr):AnyStr;
Var
   nPos : Byte;
Begin
     nPos := Pos(Upper(cFnd),Upper(cStr));
     IF nPos > 0 Then
     Begin
          Delete(cStr,nPos,Length(cFnd));
          Insert(cRep,cStr,nPos);
     End;
     RepStr := cStr;
End;
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Function TfrmConvertDBF.StrOf(nNum:Extended ;nWdt,nDec:Byte):AnyStr;
Var
   cStr : AnyStr;
Begin
     Str(nNum:nWdt:nDec,cStr);
     StrOf := cStr;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Function TfrmConvertDBF.ValOf(cStr:AnyStr) : Extended;
Var
   nErr : Integer;
   nVal : Extended;
Begin
     cStr := AllTrim(cStr);
     IF cStr[Length(cStr)] = '-' Then
     Begin
          cStr := '-'+Copy(cStr,1,Length(cStr)-1);
     End
     Else
     Begin
          IF cStr[Length(cStr)] = '+' Then
          Begin
               cStr := Copy(cStr,1,Length(cStr)-1);
          End
     End;

     Val(cStr,nVal,nErr);
     ValOf := nVal;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Function TfrmConvertDBF.Power(nPwr:Integer):LongInt;
Var
   nCnt : Byte;
   nVal : LongInt;
Begin
     nVal := 1;
     For nCnt := 1 to nPwr Do nVal := nVal * 10;
     Power := nVal;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Function TfrmConvertDBF.CleanUp(cStr:AnyStr):AnyStr;
Var
   nCnt : Byte;
Begin
     For nCnt := 1 to Length(cStr) Do
         IF Not Ord(cStr[nCnt]) in [32..126] Then cStr[nCnt] := ' ';
     CleanUp := cStr;
End;
{ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ}
Function TfrmConvertDBF.PicLen(cPic:AnyStr):Integer;
Var
   nLen : Integer;
   cStr : AnyStr;
Begin

     nLen := 0;

     IF cPic[1] in ['D','M','Y'] Then
     Begin
          nLen := Length(cPic);
     End
     Else
     Begin

          While Pos('X(',cPic) > 0 Do
          Begin
                cStr := Between(cPic,'(',')');
                nLen := nLen + Round(ValOf(cStr));
                cPic := DelStr(cPic,'X('+cStr+')');
          End;

          While Pos('9(',cPic) > 0 Do
          Begin
                cStr := Between(cPic,'(',')');
                nLen := nLen + Round(ValOf(cStr));
                cPic := DelStr(cPic,'9('+cStr+')');
          End;

          nLen := nLen + Length(cPic);

          IF Pos('V',cPic) > 0 Then Dec(nLen);
     End;

     PicLen := nLen;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Function TfrmConvertDBF.Delimiter(cStr:AnyStr):Anystr;
Var
   cTmp : AnyStr;
Begin
     IF Empty(cStr) Then
     Begin
          Delimiter := '';
          Exit
     End;

     cStr := Alltrim(cStr);
     cStr := Copy(cStr,2,Length(cStr)-2);

     While (Pos('<',cStr) > 0) and (Pos('>',cStr) > 0) Do
     Begin
          cTmp := Between(cStr,'<','>');
          cStr := RepStr(cStr,'<'+cTmp+'>',Chr(Round(ValoF(cTmp))));
     End;
     Delimiter := cStr;
End;
{ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ}
{ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ}
{ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ}
{ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ}
{ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ}
{ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ}
Procedure TfrmConvertDBF.GetBuffer;
Begin
     BlockRead(hInput,aInpBuf,BufSize,nRead);
     nBufPos := 1;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Procedure TfrmConvertDBF.GetLine;
Var
   lRead : Boolean;
   nStart: Word;
   nCrLf : Word;
Begin
     lRead  := False;
     nStart := nBufPos;
     nLine  := 0;
     nCrLf  := 0;

     While not lRead and (nRead > 0) do
     Begin
          While (nBufPos <= nRead) and (not lRead) and (nRead > 0) do
          Begin

               IF aInpBuf[nBufPos] in [#10,#13,#26] Then
               Begin
                    nCrLf := nBufPos;
                    lRead := True;
               End;

               Inc(nBufPos);
          End;

          IF lRead Then
          Begin
               Move(aInpBuf[nStart],aData[nLine+1],nCrLf-nStart);
               Inc(nLine,nCrLf-nStart);
          End
          Else
          Begin
               Move(aInpBuf[nStart],aData[nLine+1],nBufPos-nStart);
               Inc(nLine,nBufPos-nStart);
          End;

          IF nBufPos > nRead Then
          Begin
               GetBuffer;
               nStart := 1;
          End;

          IF lRead Then { Read to after the CrLf }
          Begin

               While (nCrLf > 0) and (nRead > 0) Do
               Begin

                    While (nBufPos <= nRead) and (nCrLf > 0) Do
                    Begin
                         IF not (aInpBuf[nBufPos] in [#10,#13,#26]) Then
                            nCrLf := 0
                         Else
                             Inc(nBufPos);
                    End;

                    IF nBufPos > nRead Then
                    Begin
                         GetBuffer;
                    End;

               End;

          End;

     End;

End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Procedure TfrmConvertDBF.GetExclude(cStr:AnyStr);
Var
   cFld : String[10];
   cVal : AnyStr;
   cOpr : String[2];
   cWrd : AnyStr;
Begin
     cOpr := '=';
     cVal := '';
     cFld := Upper(GetWord(cStr));
     cStr := AllTrim(After(cStr,cFld));
     cOpr := GetWord(cStr);
     cVal := lTrim(After(cStr,cOpr));

     IF cOpr = '>=' Then cOpr := 'G' Else
        IF cOpr = '<=' Then cOpr := 'L' Else
           IF cOpr = '<>' Then cOpr := '#';

     Inc(nExcCnt);
     New(aExc[nExcCnt]);

     With aExc[nExcCnt]^ Do
     Begin
          Fld := cFld;

          IF cVal[1] in ['"',''''] Then
             Val := Delimiter(cVal)
          Else
              Val := cVal;
          Num := 0;
          Opr := cOpr[1];
          Typ := 'C';
     End;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Procedure TfrmConvertDBF.GetField(cStr:AnyStr;lInp:Boolean);
Var
   lSubFlg : Boolean;
   cFld    : String[10];
   lDlm    : Boolean;
   cUpp    : AnyStr;
   cPic    : String[50];
   cLft    : String[50];
   cRht    : String[50];
   cVal    : String[50];
   nOcr    : Byte;
   nLen    : Word;
   nDec    : Byte;
   lCln    : Boolean;
   lDot    : Boolean;
   cTrm    : Char;
   cPad    : String[2];
   cTmp    : AnyStr;
Begin
     lSubFlg := False;
     lDlm    := False;
     cPic    := '';
     cLft    := '';
     cRht    := '';
     nOcr    := 1;
     cVal    := '';
     nDec    := 0;
     lCln    := False;
     lDot    := True;
     cTrm    := ' ';
     cPad    := '  ';

     cUpp := Upper(cStr);

     cFld := GetWord(cUpp);

     IF Pos(' PIC ',cUpp) > 0 Then
     Begin
          cStr := LTrim(Copy(cStr,Pos(' PIC ',cUpp)+5,255));
          cUpp := LTrim(Copy(cUpp,Pos(' PIC ',cUpp)+5,255));
          cPic := GetWord(cUpp);
     End
     Else
     Begin
          cPic := '';
     End;

     IF Pos('ALLTRIM',cUpp) > 0 Then
     Begin
          cTrm := 'A';
          cUpp := DelStr(cUpp,'ALLTRIM');
          cStr := DelStr(cStr,'ALLTRIM');
     End;

     IF Pos('LTRIM',cUpp) > 0 Then
     Begin
          cTrm := 'L';
          cUpp := DelStr(cUpp,'LTRIM');
          cStr := DelStr(cStr,'LTRIM');
     End;

     IF Pos('RTRIM',cUpp) > 0 Then
     Begin
          cTrm := 'R';
          cUpp := DelStr(cUpp,'RTRIM');
          cStr := DelStr(cStr,'RTRIM');
     End;

     IF (Pos('LPAD',cUpp) > 0) or (Pos('RPAD',cUpp) > 0) Then
     Begin
          IF (Pos('LPAD',cUpp) > 0) Then
          Begin
               cPad := 'L';
               cUpp := LTrim(After(cUpp,'LPAD'));
               cStr := LTrim(After(cStr,'LPAD'));
          End
          Else
          Begin
               cPad := 'R';
               cUpp := LTrim(After(cUpp,'RPAD'));
               cStr := LTrim(After(cStr,'RPAD'));
          End;

          cTmp := GetWord(cUpp);

          IF Pos('<',cTmp) > 0 Then
             cPad := cPad+Delimiter(cTmp)
          Else
              cPad := cPad+cTmp[2];
     End;

     IF Pos('LEFT ',cUpp) > 0 Then
     Begin
          IF Pos(' RIGHT ',cUpp) > 0 Then
          Begin
               cLft := Trim(LTrim(Between(cStr,'LEFT ',' RIGHT ')));
               cStr := LTrim(From(cStr,' RIGHT'));
               cUpp := LTrim(From(cUpp,' RIGHT'));
          End
          Else
          Begin
               cLft := LTrim(After(cStr,'LEFT '));
               cUpp := '';
               cStr := ''
          End;
     End;

     IF Pos('RIGHT ',cUpp) > 0 Then
     Begin
          cRht := LTrim(After(cStr,'RIGHT '));
          cUpp := '';
          cStr := ''
     End;

     IF Pos('VALUE ',cUpp) > 0 Then
     Begin
          cVal := Delimiter(After(cStr,'VALUE '));
          cUpp := '';
          cStr := '';
          nLen := PicLen(cVal);
     End
     Else
         nLen := PicLen(cPic);

     nDec := PicLen(After(cPic,'.'));
     lDot := (nDec > 0);

     IF nDec = 0 Then
     Begin
          nDec := PicLen(After(cPic,'V'));
     End;

     IF Pos('CLEANUP',cUpp) > 0 Then
     Begin
          lCln := True;
     End;

     cLft := Delimiter(cLft);
     cRht := Delimiter(cRht);
{     WriteLn(cFld,' ',cPic,' ',nLen,' ',nDec,' ',cLft,' ',cRht,' ', cVal);}

     IF lInp Then
     Begin
          Inc(nInpCnt);
          New(aInp[nInpCnt]);
          With aInp[nInpCnt]^ Do
          Begin
               Fld := cFld;
               Pic := cPic;
               Len := nLen;
               Dec := nDec;
               Dot := lDot;
               Lft := cLft;
               Rht := cRht;
               Beg := 0;
               Cln := lCln;
          End;
     End
     Else
     Begin
          Inc(nOutCnt);
          New(aOut[nOutCnt]);
          With aOut[nOutCnt]^ Do
          Begin
               Fld := cFld;
               Len := nLen;
               Dec := nDec;
               Pic := cPic;
               Val := cVal;
               Trm := cTrm;
               Pad := cPad;
          End;
     End;

End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Function TfrmConvertDBF.PicType(cStr:AnyStr) : Char;
Begin
     Case cStr[1] of
          '9'         : PicType := 'N';
          'X'         : PicType := 'C';
          'Y','M','D' : PicType := 'D';
     End;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Procedure TfrmConvertDBF.MatchInputOutput;
Var
   nCnt1 : Word;
   nCnt2 : Word;
Begin
     For nCnt1 := 1 to nOutCnt Do
     Begin

          aOut[nCnt1]^.Inp := 0;

          For nCnt2 := 1 to nInpCnt Do
          Begin
               IF aOut[nCnt1]^.Fld = aInp[nCnt2]^.Fld Then
                  aOut[nCnt1]^.Inp := nCnt2;
          End;

          IF (aOut[nCnt1]^.Inp = 0) and (aOut[nCnt1]^.Val = '') Then
          Begin
               MessageDlg('Output Field not found in Input',mtError,[mbOk],0);
               Application.Terminate;
          End;
     End;

     For nCnt1 := 1 to nExcCnt Do
     Begin

          aExc[nCnt1]^.Inp := 0;

          For nCnt2 := 1 to nOutCnt Do
          Begin

               IF aExc[nCnt1]^.Fld = aOut[nCnt2]^.Fld Then
               Begin
                    aExc[nCnt1]^.Inp := nCnt2;
                    aExc[nCnt1]^.Typ := PicType(aOut[nCnt2]^.Pic);

                    IF aExc[nCnt1]^.Typ = 'N' Then
                       aExc[nCnt1]^.Num := ValOf(aExc[nCnt1]^.Val);
               End;

          End;

          IF aExc[nCnt1]^.Inp = 0 Then
          Begin
               MessageDlg('Exclude Field not found in Output',mtError,[mbOk],0);
               Halt (12);
          End;

     End;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Function TfrmConvertDBF.GetFormat(cFormat : AnyStr) : Boolean;
Var
   cStr   : AnyStr;
   cWrd   : AnyStr;
   lInp   : Boolean;
   hFormat: TextFile;
Begin
     lInp := True;
{$I-}
     AssignFile(hFormat,cFormat);
     Reset(hFormat);
{$I+}
     cPath := ExtractFileDir(cFormat);
     
     If Empty(cPath) Then
       cPath := GetCurrentdir;

     cPath := cPath + '\';
     
     IF IOResult <> 0 Then
     Begin
        GetFormat := False;
        Exit
     End;

     While not Eof(hFormat) Do
     Begin
          ReadLn(hFormat,cStr);
          cStr := Trim(LTrim(cStr));

          IF not Empty(cStr) Then
          Begin
               cWrd := Upper(GetWord(cStr));

               IF cStr[1] <> '*' Then
               Begin

                    IF Pos(':'+cWrd+':',':INPUT:OUTPUT:RECORD:') > 0 Then
                    Begin

                         IF cWrd = 'INPUT' Then
                         Begin
                              cInput := cPath+Delimiter(After(cStr,'INPUT'));
                              lInp    := True;
                         End;

                         IF cWrd = 'OUTPUT' Then
                         Begin
                              cOutput := cPath+Delimiter(After(cStr,'OUTPUT'));
                              lDbfFlg := (Pos('.DBF',Upper(cOutput)) > 0);
                              lInp    := False;
                         End;

                         IF cWrd = 'RECORD' Then
                         Begin
                              IF lInp Then
                                 cInpDlm := Delimiter(After(cStr,'DELIMITER'))
                              Else
                                  cOutDlm := Delimiter(After(cStr,'DELIMITER'));
                         End;
                    End
                    Else
                    Begin
                         IF cWrd = 'EXCLUDE' Then
                            GetExclude(After(cStr,'EXCLUDE'))
                         Else
                             GetField(cStr,lInp);
                    End;
               End;
          End;

     End;

     CloseFile(hFormat);
     GetFormat := True;
End;

{ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ}
{ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ}
{ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ}
Procedure TfrmConvertDBF. InputData;
Var
   nCnt : Word;
   nCnt2: Word;
   nPos : Integer;
   nBeg : Integer;
   nEnd : Integer;
   nLen : Byte;
   lMch : Boolean;
   cStr : AnyStr;
Begin
     nPos := 1;
     nCnt := 0;
     lMch := False;

     While (nCnt < nInpCnt) and (nPos <= nLine) do
     Begin
          Inc(nCnt);

          With aInp[nCnt]^ Do
          Begin
               Dat := '';

               { Get Left Delimiter }

               IF Lft <> '' Then
               Begin
                     nLen := Length(Lft);
                     lMch := False;

                     While not lMch Do
                     Begin
                          lMch := True;

                          While ((aData[nPos] <> Lft[1]) or
                                (aData[nPos+nLen-1] <> Lft[nLen])) and
                                (nPos < nLine-nLen+1) Do
                          Begin
                               Inc(nPos);
                          End;

                          IF (aData[nPos] = Lft[1]) and
                                (aData[nPos+nLen-1] = Lft[nLen]) Then
                          Begin
                               IF nLen > 2 Then
                               Begin
                                    cStr[0] := Chr(nLen);
                                    Move(aData[nPos],cStr[1],nLen);

                                    IF cStr <> Lft Then
                                    Begin
                                         lMch := False;
                                         Inc(nPos);
                                    End
                                    Else
                                        nPos := nPos+nLen;
                               End
                               Else
                                   nPos := nPos+nLen;
                          End
                          Else
                              nPos := nLine;
                     End;
               End;

               nBeg := nPos;

               IF Rht <> '' Then
               Begin
                     nLen := Length(Rht);
                     lMch := False;

                     While not lMch Do
                     Begin
                          lMch := True;

                          While ((aData[nPos] <> Rht[1]) or
                                (aData[nPos+nLen-1] <> Rht[nLen])) and
                                (nPos < nLine-nLen+1) Do
                          Begin
                               Inc(nPos);
                          End;

                          IF (aData[nPos] = Rht[1]) and
                                (aData[nPos+nLen-1] = Rht[nLen]) Then
                          Begin
                               IF nLen > 2 Then
                               Begin
                                    cStr[0] := Chr(nLen);
                                    Move(aData[nPos],cStr[1],nLen);

                                    IF cStr <> Rht Then
                                    Begin
                                       lMch := False;
                                       Inc(nPos);
                                    End
                                    Else
                                    Begin
                                         nEnd := nPos-1;
                                         nPos := nPos+nLen-1;
                                    End;
                               End
                               Else
                               Begin
                                    nEnd := nPos-1;
                                    nPos := nPos+nLen-1;
                               End;
                          End
                          Else
                          Begin
                               nPos := nLine;
                               nEnd := nPos;
                          End;
                     End;

               End
               Else
               Begin

                    IF (nBeg+Len-1 > nLine) or (Len = 0) Then
                       nEnd := nLine
                    Else
                    Begin
                        nEnd := nBeg+Len-1;
                    End;

                    nPos := nEnd;

               End;

               IF nEnd - nBeg > 200 Then nEnd := nBeg+199;
               Dat[0] := Chr(nEnd-nBeg+1);
               Move(aData[nBeg],Dat[1],nEnd-nBeg+1);
          End;

          Inc(nPos);
     End;

     IF (nCnt <> nInpCnt)  Then
     Begin
          Inc(nErrCnt);
     End;

     For nCnt2 := nCnt+1 to nInpCnt do aInp[nCnt]^.Dat := '';

End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Function TfrmConvertDBF.CnvPic(cVal,cPic,cInpPic:AnyStr;nLen,nDec:Byte):AnyStr;
Var
   cStr : AnyStr;
   cChr : Char;
   nVal : Extended;
   nPos : Byte;
   nPos2: Byte;
   nCnt : Byte;
Begin

     IF cPic = '' Then
        cStr := AllTrim(cVal)
     Else
     Begin
          cStr := Replicate(' ',nLen);

          IF cPic[1] in ['Y','M','D'] Then
          Begin
               nPos := Length(cVal);

               For nCnt := 1 to nPos Do
                   IF cVal[nCnt] = ' ' Then cVal[nCnt] := '0';

               cStr := cPic;

               IF Pos('YYYY',cInpPic) = 0 Then
               Begin
                    nPos := Pos('YY',cInpPic);

                    IF nPos > 0 Then
                    Begin
                         Insert('YY',cInpPic,nPos);
                         Insert(cCen,cVal,nPos);
                    End
                    Else
                    Begin
                         cInpPic := 'YYYY'+cInpPic;
                         cVal   := cYear+cVal;
                    End;
               End;

               IF lDbfFlg Then
               Begin
                    cStr := '19000101';
                    nPos2 := Pos('YYYY',cInpPic);
                    Move(cVal[nPos2],cStr[1],4);
                    nPos2 := Pos('MM',cInpPic);
                    Move(cVal[nPos2],cStr[5],4);
                    nPos2 := Pos('DD',cInpPic);
                    Move(cVal[nPos2],cStr[7],4);
               End
               Else
               Begin
                    nPos := Pos('YYYY',cPic);
                    nPos2 := Pos('Y',cInpPic);

                    IF nPos > 0 Then
                    Begin
                         Move(cVal[nPos2],cStr[nPos],4);
                    End
                    Else
                    Begin
                         nPos := Pos('YY',cPic);

                         IF nPos > 0 Then
                         Begin
                              Move(cVal[nPos2+2],cStr[nPos],2);
                         End;

                    End;

                    nPos := Pos('MM',cPic);
                    nPos2 := Pos('MM',cInpPic);

                    IF (nPos > 0) and (nPos2 > 0) Then
                    Begin
                         Move(cVal[nPos2],cStr[nPos],2);
                    End;

                    nPos := Pos('DD',cPic);
                    nPos2 := Pos('DD',cInpPic);

                    IF (nPos > 0) and (nPos2 > 0) Then
                    Begin
                         Move(cVal[nPos2],cStr[nPos],2);
                    End;
               End;
          End
          Else
          Begin
               IF Pos('X',cPic) > 0 Then
                  cStr := RPad(cVal,' ',nLen)
               Else
               Begin
                    nVal := ValOf(cVal);
                    cStr := StrOf(nVal,nLen,nDec);
               End;
          End;
     End;

     CnvPic := cStr;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Function TfrmConvertDBF.IncludeIt : Boolean;
Var
   nCnt : Byte;
   lExc : Boolean;
Begin
     lExc := False;
     IncludeIt := True;

     For nCnt := 1 to nExcCnt Do
     Begin
          With aExc[nCnt]^ Do
          Begin

               Case Typ of
               'C','D' : Begin
                              Case Opr of
                              '=' : lExc := (aOut[Inp]^.Dat = Val);
                              '>' : lExc := (aOut[Inp]^.Dat > Val);
                              '<' : lExc := (aOut[Inp]^.Dat < Val);
                              '#' : lExc := (aOut[Inp]^.Dat <> Val);
                              'G' : lExc := (aOut[Inp]^.Dat >= Val);
                              'L' : lExc := (aOut[Inp]^.Dat <= Val);
                              '$' : lExc := (Pos(aOut[Inp]^.Dat,Val) > 0);
                              End;
                         End;

               'N' :     Begin
                              Case Opr of
                              '=' : lExc := (ValOf(aOut[Inp]^.Dat) = Num);
                              '>' : lExc := (ValOf(aOut[Inp]^.Dat) > Num);
                              '<' : lExc := (ValOf(aOut[Inp]^.Dat) < Num);
                              '#' : lExc := (ValOf(aOut[Inp]^.Dat) <> Num);
                              'G' : lExc := (ValOf(aOut[Inp]^.Dat) >= Num);
                              'L' : lExc := (ValOf(aOut[Inp]^.Dat) <= Num);
                              End;
                         End;
               End;
          End;

          IF lExc Then
          Begin
               IncludeIt := False;
               Exit
          End;
     End;

End;
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Procedure TfrmConvertDBF.DisplayError(MessageText:String);
Begin
  MessageDlg(MessageText,mtError,[mbOk],0);
End;
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Procedure TfrmConvertDBF.Output(Var cStr:AnyStr; nLen : Byte);
Begin
     IF nOutPos + nLen > BufSize Then
     Begin
          IF (nRec+1 = nErrCnt) Then
          Begin
               DisplayError('Input Format does not match Data');
               CloseFile(hOutPut);
               CloseFile(hInput);
               Halt (10);
          End;

          BlockWrite(hOutput,aOutBuf,nOutPos,nWrite);
          FillChar(aOutBuf,BufSize,' ');
          nOutPos := 0;
     End;

     Move(cStr[1],aOutBuf[nOutPos+1],nLen);
     Inc(nOutPos,nLen);

End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Procedure TfrmConvertDBF. FlushOutput;
Begin
     IF nOutPos > 0 Then
     Begin
          IF (nRec = nErrCnt) Then
          Begin
               DisplayError(' Input Format does not match Data');
               CloseFile(hOutPut);
               Halt (10);
          End;

          BlockWrite(hOutput,aOutBuf,nOutPos,nWrite);
     End;
     nOutPos := 0;
End;
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Procedure TfrmConvertDBF. Convert;
Var
   nCnt     : Word;
   cStr     : AnyStr;
   nInt     : LongInt;
   nExt     : Extended;
   nRecFlag : Byte;
   cChr     : Char;
   lInc     : Boolean;
Begin
     { Convert Input }
     cStr := '';
     lInc := True;
     nRecFlag := 1;

     For nCnt := 1 to nInpCnt Do
     Begin
          With aInp[nCnt]^ Do
          Begin
               cStr := Dat;

               IF (Dec > 0) and not Dot Then
               Begin
                    Str(ValOf(Dat)/Power(Dec):Length(Dat)+1:Dec,Dat);
               End;

               IF Cln Then Dat := CleanUp(Dat);
          End;
     End;

     For nCnt := 1 to nOutCnt Do
     Begin

          With aOut[nCnt]^ Do
          Begin

               IF Val = '' Then
               Begin
                    Dat := CnvPic(aInp[Inp]^.Dat,Pic,aInp[Inp]^.Pic,Len,Dec);

                    IF Trm <> ' ' Then
                    Begin

                         Case Trm of
                              'L' : Dat := LTrim(aInp[Inp]^.Dat);
                              'R' : Dat := Trim(aInp[Inp]^.Dat);
                         End;

                         Case Pad[1] of
                              'L' : Dat := LPad(LTrim(aInp[Inp]^.Dat),Pad[2],Len);
                              'R' : Dat := RPad(Trim(aInp[Inp]^.Dat),Pad[2],Len);
                         End;

                    End;
               End
               Else
               Begin
                    Dat := Val;
               End;

               IF lChk and (Ord(Dat[0]) <> Len) Then
               Begin
                    DisplayError(' Data width Error on ('+Fld+') Record ('+LTrim(StrOF(nRec+1,8,0))+')');
                    CloseFile(hInput);
                    CloseFile(hOutput);
                    Halt (13);
               End;

               IF nExcCnt = 0 Then OutPut(Dat,Len);
          End;
     End;

     IF nExcCnt > 0 Then
     Begin
          IF IncludeIt Then
          Begin


               For nCnt := 1 to nOutCnt Do
               Begin

                    With aOut[nCnt]^ Do
                    Begin
                         OutPut(Dat,Len);
                    End;
               End;
          End
          Else
              lInc := False;
     End;

     IF lInc Then
     Begin
        IF not lDbfFlg Then OutPut(cCrLf,2) Else Output(cDelByt,1);
     End
        Else
            Dec(nRec);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Procedure TfrmConvertDBF.OutputData;
Begin
     InputData;
     Convert;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Procedure TfrmConvertDBF.UpdDbfHeader(nRecords:LongInt);
Var
   n1,n2,n3,n4 : Byte;
   nDataOfs    : Word;
   nRecLen     : Integer;
   nWrite      : Integer;
   tst: Array[0..4] of Char;
Begin
     AssignFile(hOutput,cOutput);
     Reset(hOutput,1);
     Seek(hOutput,4);
     tst := '0000';

     { Set RecCount }
     BlockWrite(hOutput,nRecords,4,nWrite);

     CloseFile(hOutput);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Procedure TfrmConvertDBF.ZapOutput;
Var
   nRecCnt : LongInt;
   nDatOfs: Word;

Begin
     nRecCnt := 0;
     Seek(hOutput,4);
     BlockWrite(hOutput,nRecCnt,4);

     Seek(hOutput,8);
     BlockRead(hOutput,nDatOfs,2);
     Inc(nDatOfs);

     Seek(hOutput,0);
     BlockRead(hOutput,aData,nDatOfs);
     CloseFile(hOutput);
     Erase(hOutput);
     Rewrite(hOutput,1);
     BlockWrite(hOutput,aData,nDatOfs);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Procedure TfrmConvertDBF.GetDbfInfo;
Var
   nRecCnt : LongInt;
   nRecLen : Word;
   nDatOfs : Word;
   nInp    : Integer;
   nCnt    : Integer;
   nOutLen : Integer;
Begin
          Seek(hOutput,4);
          BlockRead(hOutput,nRecCnt,4,nInp);

          Seek(hOutput,8);
          BlockRead(hOutput,nDatOfs,2,nInp);

          Seek(hOutput,10);
          BlockRead(hOutput,nRecLen,2,nInp);

          nOutLen := 0;

          For nCnt := 1 to nOutCnt Do Inc(nOutLen,aOut[nCnt]^.Len);

          IF nOutLen+1 <> nRecLen Then
          Begin
               DisplayError('Output Format length ('+LTrim(StrOf(nOutLen,5,0))+
                       ') :  record length ('+LTrim(StrOf(nRecLen-1,5,0))+')');

               CloseFile(hInput);
               CloseFile(hOutput);
               Halt (9);
          End;

          IF nRecCnt <> 0 Then
          Begin
               ZapOutput;
          End;

          Seek(hOutput,nDatOfs+1);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
Procedure TfrmConvertDBF.Init;
Begin
     nRead   := 0;
     nErrCnt := 0;
     nLine   := 0;
     nBufPos := 1;
     nOutPos := 0;
     nRec    := 0;
     cInpDlm := '';
     cOutDlm := '';
     cCrLf   := #13+#10;
     cDelByt := ' ';
     FillChar(aOutBuf,BufSize,' ');
     FillChar(aInpBuf,BufSize,' ');

     { Initialize the Data Buffer }
     GetBuffer;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}


procedure TfrmConvertDBF.Button1Click(Sender: TObject);
begin

  With OpenDialog1 do begin
    Title := 'Select FMT File';
    FileName := Edit1.Text;
    DefaultExt := '*.fmt';
    Filter := 'FMT files (*.fmt)|*.fmt';

    if Execute then
      Edit1.text := FileName;

  end;

end;

procedure TfrmConvertDBF.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmConvertDBF.BitBtn1Click(Sender: TObject);
begin

      nImport := 99999999;
      nRow    := 1;
      nCol    := 1;

      nInpCnt := 0;
      nOutCnt := 0;
      nExcCnt := 0;

      lDbfFlg := False;
      cInput  := '';
      cOutput := '';
     cCen     := '19';
     cYear    := '1900';
     lChk     := False;

      IF ParamCount > 2 Then
      Begin

           Val(ParamStr(2),nRow,nCnt);
           Val(ParamStr(3),nCol,nCnt);

           IF ParamCount > 3 Then
           Begin
                Val(ParamStr(4),nImport,nCnt);
           End;

           IF ParamCount > 4 Then
           Begin
                cCen := Copy(ParamStr(5),1,2);
           End;

           IF ParamCount > 5 Then
           Begin
                lChk := True;
           End;
      End;

      IF ParamCount = 0 Then
      Begin
           {
           WriteLn;
           WriteLn('Version : ',Version);
           WriteLn;
           WriteLn('Format : CNV SPEC.CNV [nRow nColumn [nToConvert [Century(YY) [CKECK]]]');
           WriteLn;
           WriteLn('Error Codes:');
           WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄ');
           WriteLn('(1)  No parameters specified');
           WriteLn('(2)  Format specification not found');
           WriteLn('(3)  Input Specification not found');
           WriteLn('(4)  Output Specification not found');
           WriteLn('(5)  Input File not Specified');
           WriteLn('(6)  Output File not Specified');
           WriteLn('(7)  Could not open Input File');
           WriteLn('(8)  Could not open Output File');
           WriteLn('(9)  Output Format length differ from DBF Record length');
           WriteLn('(10) Input Format does not match Data');
           WriteLn('     This error only occurs if none of the records in');
           WriteLn('     the first 16k imported matches the input format');
           WriteLN('(11) Output Field not found in Input');
           WriteLN('(12) Exclude Field not found in Output');
           WriteLN('(13) Data Width Error only If CHECK is specified');}
           //Halt (1);
      End;


     IF not GetFormat(Edit1.text) Then
     Begin
          DisplayError('Format specification ('+Upper(ParamStr(1))+') not found !!!');
          Halt (2);
     End
     Else
     Begin
          MatchInputOutput;
     End;

      IF (nInpCnt = 0) or (nOutCnt = 0) or Empty(cInput) or Empty(cOutput) Then
      Begin
           IF nInpCnt = 0  Then
           Begin
                DisplayError('Input Specification not found !!!');
                Halt (3);
           End;

           IF (nOutCnt = 0) Then
           Begin
              DisplayError('Output Specification not found !!!');
              Halt (4);
           End;

           IF Empty(cInput) Then
           Begin
                DisplayError('Input File not Specified !!!');
                Halt (5);
           End;

           IF Empty(cOutput) Then
           Begin
                DisplayError('Output File not Specified !!!');
                Halt (6);
           End;

      End;

     { Open Input }

     {$I-}
     AssignFile(hInput,cInput);
     Reset(hInput,1);
     {$I+}
     Edit2.Text := cInput;

     IF IOResult <> 0 Then
     Begin
          DisplayError('Could not open Input File ('+Upper(cInput)+')');
          Halt (7);
     End;

     { Open Output }

     {$I-}
     AssignFile(hOutput,cOutput);

     IF not lDbfFlg Then
         Rewrite(hOutput,1)
     Else
     Begin
          Reset(hOutput,1);
     End;

     Edit3.Text := cOutput;

     IF IOResult <> 0 Then
     Begin
          DisplayError('Could not open Output File ('+Upper(cInput)+')');
          CloseFile(hInput);
          Halt (8);
     End
     Else
     Begin
          IF lDbfFlg Then GetDbfInfo;
     End;

     If Edit4.text = '' Then
     Begin
          DisplayError('No CSV File was specified');
          CloseFile(hInput);
          CloseFile(hOutput);
          Halt (8);
     end;

     {$I+}

     Init;
     StatusBar1.Panels[0].Text := 'Appending ...';
     StatusBar1.Refresh;
     panel1.Refresh;
     panel2.Refresh;
     dbgrid1.Visible := False;
     //Refresh;

     While (nRead > 0) and (nRec < nImport) do
     Begin
          GetLine;

          IF nLine > 0 Then
          Begin
               OutputData;
               Inc(nRec);

               If (nRec mod 500) = 0 Then begin
                 StatusBar1.Panels[2].Text := IntToStr(nRec);
                 StatusBar1.Refresh;
                 //Refresh;
               end;
          End;

     End;

     CloseFile(hInput);
     FlushOutput;

     CloseFile(hOutput);

     IF lDbfFlg Then
     Begin
          UpdDbfHeader(nRec);
     End;

     StatusBar1.Panels[2].Text := IntToStr(nRec);
     StatusBar1.Panels[0].Text := 'Complete...';
     StatusBar1.Refresh;
     tblDbf.TableName := cOutPut;
     tblDbf.Active := True;

end;

procedure TfrmConvertDBF.FormActivate(Sender: TObject);
begin

  If FirstLoad Then begin
    Edit1.Text := ParamStr(1);
    Edit4.Text := ParamStr(2);
    FirstLoad := False;


    If ParamCount > 0 Then begin
      BitBtn1.Click;
      Close;

    end;

  end;

end;

procedure TfrmConvertDBF.FormCreate(Sender: TObject);
begin
  FirstLoad := True;
end;

procedure TfrmConvertDBF.CreateCSV;
var
  CountF,NumFields, nRec: Integer;
  DataValue, FieldName, Rec: String;
  FieldType: TFieldType;
  NewDate: TDateTime;
  OutFile: TextFile;
begin

AssignFile(OutFile,edit4.text);
Rewrite(OutFile);
NumFields := srcDBF.Dataset.FieldCount-1;
nRec := 0;
srcDBF.DataSet.First;
dbGrid1.Visible := False;
dbNavigator1.Visible := False;

StatusBar1.Panels[0].Text := 'Writing CSV File...';
StatusBar1.Refresh;

While not srcDBF.DataSet.Eof do
begin
  Rec := '';

  For Countf := 0 to NumFields do begin
    FieldName := UpperCase(srcDBF.Dataset.Fields[CountF].FieldName);


    If Rec <> '' Then Rec := Rec + ',';

    FieldType := srcDBF.Dataset.Fields[CountF].Datatype;

    If FieldType in ([ftDate,ftDateTime]) then begin
      NewDate := srcDBF.Dataset.Fields[CountF].AsDateTime;
      Rec := Rec + FormatDateTime('dd/mm/yyyy',newDate);
    end
    Else begin
         If FieldType = ftString then begin
           Rec := Rec + '"'+ srcDBF.Dataset.Fields[CountF].asString + '"';
         end
         else begin
            Rec := rec + srcDBF.Dataset.Fields[CountF].asString;

         end;
    end;

  end;

  WriteLn(OutFile,Rec);

  Inc(nRec);

  If (nRec mod 500) = 0 Then begin
    StatusBar1.Panels[1].Text := IntToStr(nRec);
    StatusBar1.Refresh;
  end;

  srcDBF.DataSet.Next;
end;

StatusBar1.Panels[2].Text := IntToStr(nRec);
StatusBar1.Panels[0].Text := 'Complete...';
StatusBar1.Refresh;
CloseFile(OutFile);

dbGrid1.Visible := False;
dbNavigator1.Visible := False;

end;



procedure TfrmConvertDBF.Button2Click(Sender: TObject);
begin
   CreateCsv;
end;




end.
