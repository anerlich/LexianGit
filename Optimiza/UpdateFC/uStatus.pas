unit uStatus;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TfrmStatus = class(TForm)
    ListBox1: TListBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStatus: TfrmStatus;

implementation

{$R *.DFM}

procedure TfrmStatus.BitBtn1Click(Sender: TObject);
var
  FileName: String;
  TimeDateStamp:TTimeStamp;
begin
  TimeDateStamp :=DateTimeToTimeStamp(Now());
  
  FileName := ExtractFilePath(ParamStr(0))+'Update_FC_'+
              IntToStr(TimeDateStamp.Time) +
              IntToStr(TimeDateStamp.Date) +
              '.log';

  ListBox1.Items.SaveToFile(FileName);
  ListBox1.Items.Clear;
  Close;
end;

end.
