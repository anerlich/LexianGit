unit uSetAppend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;


type
  TfrmSetAppend = class(TForm)
    grpType: TRadioGroup;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    { Private declarations }
    FImportType:String;
    procedure SetImportType(const Value: String);
    function GetImportType: String;
  public
    { Public declarations }
    property ImportType: String read GetImportType write SetImportType;
  end;

var
  frmSetAppend: TfrmSetAppend;

const
  _Replace = 'Replace';
  _AppendAll = 'Append All';
  _AppendAllLast = 'Append All Last';
  _AppendAllLastUpdate = 'Append All Last and Update';


implementation

{$R *.dfm}

function TfrmSetAppend.GetImportType: String;
begin


  if grpType.ItemIndex = 0 then
    Result := _Replace;

  if grpType.ItemIndex = 1 then
    Result := _AppendAll;

  if grpType.ItemIndex = 2 then
    Result := _AppendAllLast;

  if grpType.ItemIndex = 3 then
    Result := _AppendAllLastUpdate;

end;

procedure TfrmSetAppend.SetImportType(const Value: String);
begin
  FImportType := Value;

  if Value = _Replace then
    grpType.ItemIndex := 0;

  if Value = _AppendAll then
    grpType.ItemIndex := 1;

  if Value = _AppendAllLast then
    grpType.ItemIndex := 2;

  if Value = _AppendAllLastUpdate then
    grpType.ItemIndex := 3;


end;

end.
