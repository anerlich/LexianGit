unit uFieldSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;


type
  TImportFileType = (ftCSV, ftFixedLength);

  TfrmFieldSetup = class(TForm)
    Label1: TLabel;
    lblField: TLabel;
    edtFieldName: TEdit;
    Label2: TLabel;
    edtFieldLen: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    lblCalculation: TLabel;
    edtCalculation: TEdit;
    chkCalculated: TCheckBox;
    procedure BitBtn2Click(Sender: TObject);
    procedure chkCalculatedClick(Sender: TObject);
  private
    { Private declarations }
    FFieldName:String;
    FFieldLen:Integer;
    FImportFileType: TImportFileType;
    FCalculated:Boolean;
    procedure SetFieldName(const Value: String);
    procedure SetFieldLen(const Value: Integer);

    procedure SetImportFileType(const Value: TImportFileType);
    function GetCalculated: Boolean;
    procedure SetCalculated(const Value: Boolean);

  public
    { Public declarations }

    procedure SetAllData(aString:String);
    property FieldName:String read FFieldName write SetFieldName;
    property FieldLen: Integer read FFieldLen write SetFieldLen;
    property ImportFileType: TImportFileType read FImportFileType write SetImportFileType;
    property Calculated:Boolean read GetCalculated write SetCalculated;
  end;

var
  frmFieldSetup: TfrmFieldSetup;

implementation

{$R *.dfm}

{ TfrmFieldSetup }

procedure TfrmFieldSetup.SetAllData(aString: String);
var
  TempStr:String;
begin

  FieldName := Copy(aString,1,Pos(',',aString)-1);
  TempStr := Copy(aString,Pos(',',aString)+1,Length(aString));

  if Pos(',',TempStr)<=0 then
    FieldLen := 0
  else
  begin
    FieldLen := StrToInt(Copy(TempStr,1,Pos(',',TempStr)-1));
  end;

  if Pos(',',TempStr)<=0 then
  begin
    Calculated := False;
    chkCalculated.Checked := False;
  end
  else
  begin
    TempStr := Copy(TempStr,Pos(',',TempStr)+1,Length(TempStr));
    chkCalculated.Checked := True;
    Calculated := True;
    edtCalculation.Text := TempStr;
  end;

end;

procedure TfrmFieldSetup.SetFieldLen(const Value: Integer);
begin
  FFieldLen := Value;
  edtFieldLen.Text := IntToStr(Value);
end;

procedure TfrmFieldSetup.SetFieldName(const Value: String);
begin
  FFieldName := Value;
  edtFieldName.Text := Value;
end;

procedure TfrmFieldSetup.SetImportFileType(const Value: TImportFileType);
begin
  FImportFileType := Value;
  edtFieldLen.Visible := (Value = ftFixedLength);
end;

procedure TfrmFieldSetup.BitBtn2Click(Sender: TObject);
begin
  FFieldName := edtFieldName.Text;

  if edtFieldLen.Text = '' then
    FFieldLen := 0
  else
    FFieldLen := StrToInt(edtFieldLen.Text);

end;

procedure TfrmFieldSetup.chkCalculatedClick(Sender: TObject);
begin
  Calculated := chkCalculated.Checked;
end;

function TfrmFieldSetup.GetCalculated: Boolean;
begin
  Result := FCalculated;

end;

procedure TfrmFieldSetup.SetCalculated(const Value: Boolean);
begin
  FCalculated := Value;
  lblCalculation.Visible := Value;
  edtCalculation.Visible := Value;
end;

end.
