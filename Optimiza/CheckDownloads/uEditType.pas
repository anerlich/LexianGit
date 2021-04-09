unit uEditType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids,Clipbrd,StrUtils;

type
  TfrmEditType = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cmbType: TComboBox;
    Label1: TLabel;
    edtTrigger: TEdit;
    Label3: TLabel;
    Button2: TButton;
    Label4: TLabel;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    grdDownload: TStringGrid;
    Label2: TLabel;
    edtEmailIni: TEdit;
    Button1: TButton;
    BitBtn3: TBitBtn;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FEmailApp:String;
  end;

var
  frmEditType: TfrmEditType;

implementation

uses uSelectFolder, uFileWait;

{$R *.dfm}

procedure TfrmEditType.Button2Click(Sender: TObject);
begin
  Opendialog1.Options := [ofHideReadOnly,ofEnableSizing];

  if Opendialog1.Execute then
    edtTrigger.Text := OpenDialog1.FileName;

end;

procedure TfrmEditType.Button3Click(Sender: TObject);
begin
  Opendialog1.Options := [ofHideReadOnly,ofAllowMultiSelect,ofEnableSizing];

  if Opendialog1.Execute then
    grdDownload.Cols[0].CommaText := OpenDialog1.Files.CommaText;

end;

procedure TfrmEditType.Button1Click(Sender: TObject);
begin
  Opendialog1.Options := [ofHideReadOnly,ofEnableSizing];

  if Opendialog1.Execute then
    edtEmailIni.Text := OpenDialog1.FileName;

end;

procedure TfrmEditType.FormActivate(Sender: TObject);
begin

  if FEmailApp = '' then
  begin
    edtEmailIni.Text := 'Email application NOT defined';
    edtEmailIni.Enabled := False;
    Button1.Enabled := False;
    BitBtn3.Enabled := False;
  end
  else
  begin
    edtEmailIni.Enabled := True;
    Button1.Enabled := True;
    BitBtn3.Enabled := True;
  end;

end;

procedure TfrmEditType.BitBtn3Click(Sender: TObject);
var
  AppName,IniName:String;
begin

  //Remove all quotes in case some are erroneous
  IniName := AnsiReplaceStr(edtEmailIni.Text,'"','');
  //Then add quotes so paths that have space in the folder name
  //     sre catered for
  IniName := '"'+IniName+'"';


  AppName := FEmailApp + ' -Z -W '+IniName;
  ExecuteFileWait(AppName,'');
  if leftStr(Clipboard.AsText,9) = 'Optimiza:' then
  begin
    edtEmailIni.Text := AnsiReplaceStr(Copy(Clipboard.AsText,10,Length(Clipboard.AsText)),'"','');
  end;
  //ClipBoard

end;

end.
