unit utstcnv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses uCnv;

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
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
           WriteLn('컴컴컴컴컴컴');
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
           Halt (1);
      End;


     IF not GetFormat(ParamStr(1)) Then
     Begin
          WriteLn('Format specification ('+Upper(ParamStr(1))+') not found !!!');
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
                WriteLn('Input Specification not found !!!');
                Halt (3);
           End;

           IF (nOutCnt = 0) Then
           Begin
              WriteLn('Output Specification not found !!!');
              Halt (4);
           End;

           IF Empty(cInput) Then
           Begin
                WriteLn('Input File not Specified !!!');
                Halt (5);
           End;

           IF Empty(cOutput) Then
           Begin
                WriteLn('Output File not Specified !!!');
                Halt (6);
           End;

      End;

     { Open Input }

     {$I-}
     Assign(hInput,cInput);
     Reset(hInput,1);
     {$I+}

     IF IOResult <> 0 Then
     Begin
          WriteLn('Could not open Input File ('+Upper(cInput)+')');
          Halt (7);
     End;

     { Open Output }

     {$I-}
     Assign(hOutput,cOutput);

     IF not lDbfFlg Then
         Rewrite(hOutput,1)
     Else
     Begin
          Reset(hOutput,1);
     End;

     IF IOResult <> 0 Then
     Begin
          WriteLn('Could not open Output File ('+Upper(cInput)+')');
          Close(hInput);
          Halt (8);
     End
     Else
     Begin
          IF lDbfFlg Then GetDbfInfo;
     End;

     {$I+}

     Init;

     While (nRead > 0) and (nRec < nImport) do
     Begin
          GetLine;

          IF nLine > 0 Then
          Begin
               OutputData;
               Inc(nRec);
               GotoXY(nCol,nRow); Write(nRec:6);
          End;

     End;

     Close(hInput);
     FlushOutput;

     Close(hOutput);

     IF lDbfFlg Then
     Begin
          UpdDbfHeader(nRec);
     End;


end;

end.
