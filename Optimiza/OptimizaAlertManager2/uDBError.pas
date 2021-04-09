unit uDBError;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, afpEventLog, Buttons;

type
  TfrmDBError = class(TForm)
    BitBtn1: TBitBtn;
    EventLog: TafpEventLog;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDBError: TfrmDBError;

implementation

{$R *.dfm}

end.
