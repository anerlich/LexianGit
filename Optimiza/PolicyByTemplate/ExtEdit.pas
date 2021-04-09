{TExtEdit
Version 1.0.0
By Victor Serrato
E-mail virrato@yahoo.com
This component can be freely used, besides you are invited to
distribute it in commercial and private environments. I am sure of
this component could be better, if you have any suggestion or you
find any bug, please send me it to virrato@yahoo.com}

unit ExtEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

{The TKind defines either the option for the numerical value,
 used in the procedure Change}
type
   TKind = (eekNone, eekInteger, eekFloat);

{The TValidType defines the option for the valid value used in the
 procedure ValidText}
type
   TValidType = (valNone, valMinValue, valMaxValue, valInterval);

type
  TExtEdit = class(TEdit)
  private
    { Private declarations }
     FKind: TKind;
     FValid: TValidType;
     FFormat: String;
     FMinValue: double;
     FMaxValue: double;
     FValue: double;
     FValidOnExit: boolean;
     FFormatOnExit: boolean;
     FPlaneOnEnter: boolean;

     {Procedures for set the value of the properties}
     procedure SetKind(NewKind: TKind);
     procedure SetValid(NewValid: TValidType);
     procedure SetMinValue(NewMinValue: double);
     procedure SetMaxValue(NewMaxValue: double);
     procedure SetValue(NewValue: double);

  protected
     { Protected declarations }
     procedure Change; override;
     procedure WMKillFocus(var Msg: TMessage); message WM_KILLFOCUS;
     procedure WMSetFocus(var Msg: TMessage); message WM_SETFOCUS;

     {These functions are used for validing text. You can declare them
     as public functions, because them don't modify global variables}
     {These functions returns the position of the invalid character in
     strText}
     function ValChanFloat(var strText: string): integer;
     function ValFloat(var strText: string): integer;
     function ValChanInt(var strText: string): integer;
     function ValInteger(var strText: string): integer;

  public
     { Public declarations }
     constructor Create(AOwner: TComponent); override;
     procedure ValidText;

     {If the value of FKind is diferent of eekFloat these
     procedure won't have effect on the property Text}
     {The procedure FormatText uses the value of FFormat, for
      formating the value of the property Text}
     procedure FormatText;
     procedure PlaneText;

  published
    { Published declarations }
     property Format: string read FFormat write FFormat;
     property Kind: TKind read FKind write SeTKind;
     property Valid: TValidType read FValid write SetValid;
     property MinValue: double read FMinValue write SetMinValue;
     property MaxValue: double read FMaxValue write SetMaxValue;
     property Value: double read FValue write SetValue;
     property FormatOnExit: boolean read FFormatOnExit  write FFormatOnExit;
     property PlaneOnEnter: boolean read FPlaneOnEnter write FPlaneOnEnter;
     property ValidOnExit: boolean  read FValidOnExit write FValidOnExit;
  end;

procedure Register;

implementation

constructor TExtEdit.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   FValue:= 0;
   FMinValue:= 0;
   FMaxValue:= 0;
   FFormat:= '';
   {$IFDEF VER140}
      DecimalSeparator:= '.';
   {$ELSE}
      FormatSettings.DecimalSeparator:= '.';
   {$ENDIF}
   {Some compiler uses ',' as DecimalSeparator, if you had any problem with
    the float values, you should watch this code line and use '.' for decimal
    separetor in all units. Beside if you are using ',', you should have
    problems with the functions StrToFloat and FloatToStr}
end;

procedure TExtEdit.Change;
var
   strText: String;
   intError: integer;
begin
   if(FKind = eekNone) then
   begin
      inherited Change;
      Exit;
   end;

   strText:= Text;

   if(FKind = eekinteger) then
      intError:= ValChanInt(strText)
   else
      intError:= ValChanFloat(strText);

   if(intError <> 0) then
   begin
      Text:= strText;
      SelStart:= Length(Text) + 1;
   end;

   inherited Change;
end;

procedure TExtEdit.WMKillFocus;
begin
   if(FValidOnExit) then ValidText;
   if(FFormatOnExit) then FormatText;
   inherited;
end;

procedure TExtEdit.WMSetFocus;
begin
   if(FPlaneOnEnter) then PlaneText;
   SelectAll;
   inherited;
end;

procedure TExtEdit.ValidText;
var
   strText: String;
   dbeValue: double;
   i: integer;
begin
   if(FKind <> eekinteger) and (FKind <> eekFloat) then Exit;

   strText:= Text;

   if(FKind = eekinteger) then
      Valinteger(strText)
   else
      ValFloat(strText);

   Val(strText, dbeValue, i);

   {I use the next code lines for validing the correct value, depending
   of the value of FValid (valNone, valMinValue, valMaxValue or
   valInterval}
   Value:= dbeValue;
   Text:= FloatToStr(Value);
end;

procedure TExtEdit.FormatText;
var
   strText: String;
begin
   if(FKind <> eekFloat) then Exit;

   strText:= Text;
   ValFloat(strText);
   Value:= StrToFloat(strText);
   Text:= FormatFloat(FFormat, FValue);
end;

procedure TExtEdit.PlaneText;
var
   strText: String;
begin
   if(FKind <> eekFloat) then Exit;

   strText:= Text;
   ValFloat(strText);
   Value:= StrToFloat(strText);
   Text:= FormatFloat('', FValue);
end;

procedure TExtEdit.SeTKind(NewKind: TKind);
var
   dbeValue: double;
begin
   if(FKind = NewKind) then Exit;

   FKind:= NewKind;
   {This procedure could modify the value of the properties Text and
      Value}

  dbeValue:= FValue;
  Value:= dbeValue;
end;

procedure TExtEdit.SetValid(NewValid: TValidType);
var
   dbeValue: double;
begin
   dbeValue:= FValue;
   FValid:= NewValid;
   {This procedure could modify the value of the properties Text and
   Value}
   Value:= dbeValue;
end;

procedure TExtEdit.SetMinValue(NewMinValue: double);
begin
   FMinValue:= NewMinValue;

   if(FKind = eekinteger) then FMinValue:= Int(FMinValue);
end;

procedure TExtEdit.SetMaxValue(NewMaxValue: double);
begin
   FMaxValue:= NewMaxValue;

   if(FKind = eekinteger) then FMaxValue:= Int(FMaxValue);
end;

procedure TExtEdit.SetValue(NewValue: double);
begin
   case FValid of
      valMaxValue:
         if(NewValue > FMaxValue) then NewValue:= FMaxValue;

      valMinValue:
         if(NewValue < FMinValue) then NewValue:= FMinValue;

      valInterval:
      begin
         if(NewValue > FMaxValue) then NewValue:= FMaxValue;

         if(NewValue < FMinValue) then NewValue:= FMinValue;
      end;
   end;

   FValue:= NewValue;

   if(FKind <> eekinteger) and (FKind <> eekFloat) then Exit;

   if(FKind = eekinteger) then FValue:= Int(FValue);

   Text:= FloatToStr(FValue);
   SelStart:= Length(Text) + 1;
end;

function TExtEdit.ValChanFloat(var strText: string): integer;
var
   strError: string;
   i: integer;
   dbeVal: double;
begin
   if strText  = '' then
   begin
      result := -1;
      Exit;
   end;

   Val(strText, dbeVal, I);

   if i <> 0 then
   begin
      {The next if - else stament is necesary, because your compiler
       is using either ',' or '.' as DecimalSeparetor, but no both}

      if strText[i] = ',' then
         strText[i]:= '.'
      else
         if strText[i] = '.' then  strText[i]:= ',';

      Val(strText, dbeVal, i);
   end;

   if i <> 0 then
   begin
      strError:= strText + '1';
      Val(strError, dbeVal, i);

      if i <> 0 then  strText:=copy(strText, 1, i-1);
   end;

   result:= i;
end;

function TExtEdit.ValFloat(var strText: string): integer;
var
   i: integer;
   dbeVal: double;
begin
   if strText = '' then
   begin
      strText:= '0';
      result:= -1;
      Exit;
   end;

   Val(strText, dbeVal, i);

   {The next if - else stament is necesary, because your compiler
       is using either ',' or '.' as DecimalSeparetor, but no both}
   if i <> 0 then
   begin
      if strText[i] = ',' then
         strText[i]:= '.'
      else
         if strText[i] = '.' then strText[i]:= ',';

      Val(strText, dbeVal, i);
   end;

   if i <> 0 then
   begin
      strText:= Copy(strText, 1, i - 2);

      if i <> 0 then  strText:= Copy(strText, 1, i - 2);
   end;

   result:= i;
end;

function TExtEdit.ValChanInt(var strText: string): integer;
var
   strError: string;
   i, intVal: integer;
begin
   if strText  = '' then
   begin
      result := -1;
      Exit;
   end;

   Val(strText, intVal, i);

   if i <> 0 then
   begin
      strError:= strText + '1';
      Val(strError, intVal, i);

      if i <> 0 then  strText:=copy(strText, 1, i-1);

   end;

   result:= i;
end;

function TExtEdit.Valinteger(var strText: string): integer;
var
   intVal: integer;
   i: integer;
begin
   Val(strText, intVal, i);

   if(i <> 0) then  strText:= Copy(strText, 1, i - 1);

   if(strText = '') then strText:= '0';

   result:= i;
end;

procedure Register;
begin
  RegisterComponents('Hades', [TExtEdit]);
end;

end.
