unit uEditSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask;

type
  TfrmEditSchedule = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    Label1: TLabel;
    lblStart: TLabel;
    Label2: TLabel;
    edtStart: TMaskEdit;
    edtDayEnd: TMaskEdit;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Label5: TLabel;
    Edit2: TEdit;
    Button2: TButton;
    Label6: TLabel;
    edtMthEnd: TMaskEdit;
    Label7: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    function checktime(str: STring):Boolean;
  public
    { Public declarations }
  end;

var
  frmEditSchedule: TfrmEditSchedule;

implementation

uses uDmdata, uSelectProcess;

{$R *.dfm}

procedure TfrmEditSchedule.Button1Click(Sender: TObject);
begin
  if frmSelectProcess.ShowModal = mrOK then
  begin
    Edit1.Text := frmSelectProcess.fDescription;
  end;

end;

procedure TfrmEditSchedule.Button2Click(Sender: TObject);
begin
  if frmSelectProcess.ShowModal = mrOK then
  begin
    Edit2.Text := frmSelectProcess.fDescription;
  end;

end;

function TfrmEditSchedule.checktime(str: STring): Boolean;
var
  strHour, strMin: String;
  PosChar: Integer;
begin
Result := True;


try
  PosChar := Pos(':',Str);
  strHour := Copy(Str,1,PosChar-1);
  strMin := Copy(Str,PosChar+1, Length(Str));

  If (StrToInt(StrHour) > 60) or (StrToInt(StrMin) > 60) then
    REsult := False;
except
  result := False;
end;

end;

procedure TfrmEditSchedule.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  ErrorTime: Boolean;
begin

 CanClose := True;
 
 if not CheckTime(edtStart.Text) then
 begin
   MessageDlg('Invalid Start Time',mtError,[mbOK],0);
   CanClose := False;
 end
 else
   if not CheckTime(edtDayEnd.Text) then
   begin
     MessageDlg('Invalid Daily End Time',mtError,[mbOK],0);
     CanClose := False;
   end
   else
     if not CheckTime(edtMthEnd.Text) then
     begin
       MessageDlg('Invalid Monthly End Time',mtError,[mbOK],0);
       CanClose := False;
     end;


end;

end.
