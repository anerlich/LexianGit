unit uExecuteFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,ExtActns, StdCtrls, ExtCtrls;

type
  TfrmExecuteFile = class(TForm)
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Timer1: TTimer;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    FileRun: TFileRun;
  public
    { Public declarations }
  end;

var
  frmExecuteFile: TfrmExecuteFile;
  FirstShow:Boolean;

implementation

{$R *.dfm}

procedure TfrmExecuteFile.Button1Click(Sender: TObject);
begin
  FileRun.Execute;

end;

procedure TfrmExecuteFile.FormCreate(Sender: TObject);
begin
  FirstShow := True;
  FileRun := TFileRun.Create(frmExecuteFile);

  if ParamCount > 0 then
  begin
    FileRun.FileName := ParamStr(1);
    Button1.Visible := False;
    Label1.Caption := 'Executing [' + ParamStr(1) + '] in 30 seconds';
  end
  else
  begin
    FileRun.Browse := True;
    FileRun.BrowseDlg := OpenDialog1;
    Label1.Visible := False;

  end;

end;

procedure TfrmExecuteFile.FormActivate(Sender: TObject);
begin

  if FirstShow then
  begin
    FirstShow := False;

    if ParamCount > 0 then
    begin
      Timer1.Enabled := True;
    end;

  end;

end;

procedure TfrmExecuteFile.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FileRun.Free;
  FileRun := nil;
end;

procedure TfrmExecuteFile.Timer1Timer(Sender: TObject);
begin
 FileRun.Execute;
 Close;
end;

end.
