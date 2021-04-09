unit uParameters;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,Clipbrd, Buttons, Grids, ValEdit;

type
  TfrmParameters = class(TForm)
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel3: TPanel;
    Splitter1: TSplitter;
    Panel4: TPanel;
    BitBtn3: TBitBtn;
    vleParameters: TValueListEditor;
    Label1: TLabel;
    edtIniFile: TEdit;
    btnOpen: TBitBtn;
    btnSave: TBitBtn;
    btnSaveAs: TBitBtn;
    OpenDialog2: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSaveAsClick(Sender: TObject);
    procedure vleParametersEditButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure SaveParam(ShowAMessage:Boolean);
  public
    { Public declarations }
    CreateOutput:Boolean;
    procedure LoadParam;
    procedure SetParam(Name:String;ReadOnly:Boolean;EditStyle:TEditStyle);
  published
  end;

var
  frmParameters: TfrmParameters;

implementation

{$R *.dfm}

procedure TfrmParameters.BitBtn2Click(Sender: TObject);
begin
  SaveParam(False);
  Clipboard.AsText := 'Optimiza:"'+edtIniFile.Text+'"';
end;

procedure TfrmParameters.BitBtn3Click(Sender: TObject);
begin
  CreateOutput := True;
  SaveParam(False);
  Close;
end;

procedure TfrmParameters.FormActivate(Sender: TObject);
begin
  CreateOutput := False;
  LoadParam;
end;

procedure TfrmParameters.btnOpenClick(Sender: TObject);
begin
  if OpenDialog2.Execute then
  begin
    edtIniFile.Text := Opendialog2.FileName;
    LoadParam;
  end;

end;

procedure TfrmParameters.LoadParam;
begin
  if edtIniFile.Text <> '' then
  begin
    vleParameters.Strings.LoadFromFile(edtIniFile.Text);
  end;

  SetParam('Output File Name',True,esEllipsis);

end;

procedure TfrmParameters.SaveParam(ShowAMessage: Boolean);
var
  ThePath:String;
begin
  ThePath := ExtractFilePath(edtIniFile.Text);

  if Trim(ThePath) = '' then
  begin
    edtIniFile.Text := ExtractFilePath(ParamStr(0))+ edtIniFile.Text;
  end;


  vleParameters.Strings.SaveToFile(edtIniFile.Text);

  if ShowAMessage then
  begin
    MessageDlg('Parameters Saved to '+#10+
                edtIniFile.Text,mtInformation,[mbOK],0);

  end;
end;

procedure TfrmParameters.btnSaveClick(Sender: TObject);
begin
  SaveParam(True);
end;

procedure TfrmParameters.btnSaveAsClick(Sender: TObject);
var
  SaveTheFile:Boolean;
begin
  if SaveDialog1.Execute then
  begin
    SaveTheFile := True;

    if FileExists(SaveDialog1.FileName) then
    begin
      if MessageDlg(SaveDialog1.FileName +' exists. Save Anyway ?',mtConfirmation,[MbYes,mbNo],0) = mrNo then
      begin
        SaveTheFile := False;
      end;
    end;

    if SaveTheFile then
    begin
      edtIniFile.Text := SaveDialog1.FileName;
      SaveParam(True);
    end;

  end;

end;


procedure TfrmParameters.SetParam(Name: String;
  ReadOnly: Boolean;EditStyle:TEditStyle);
var
  ICount:Integer;
begin

  if vleParameters.FindRow(Name,ICount) then
  begin
    vleParameters.ItemProps[ICount-1].EditStyle :=  EditStyle;
    vleParameters.ItemProps[ICount-1].ReadOnly := True;
  end;


end;

procedure TfrmParameters.vleParametersEditButtonClick(Sender: TObject);
var
  RowNo:Integer;
begin

  RowNo := VleParameters.row;


  if RowNo = 1 then
  begin
    if opendialog1.Execute then
      VleParameters.Values['Output File Name'] := opendialog1.FileName;
  end;


end;

end.
