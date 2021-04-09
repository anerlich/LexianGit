unit uParameters1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,Clipbrd, Buttons, Grids, ValEdit;

type
  TfrmParameters = class(TForm)
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    vleParameters: TValueListEditor;
    Label1: TLabel;
    edtIniFile: TEdit;
    btnSave: TBitBtn;
    OpenDialog2: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Panel5: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel6: TPanel;
    BitBtn4: TBitBtn;
    Label2: TLabel;
    edtEmail: TEdit;
    vleEmail: TValueListEditor;
    btnSaveAs: TBitBtn;
    BitBtn3: TBitBtn;
    btnOpen: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSaveAsClick(Sender: TObject);
    procedure vleParametersEditButtonClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure vleEmailEditButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure SaveParam(ShowAMessage,Email:Boolean);
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

uses uSelectOneLocation;

{$R *.dfm}

procedure TfrmParameters.BitBtn2Click(Sender: TObject);
begin
  SaveParam(False,True);
  Clipboard.AsText := 'Optimiza:"'+edtEmail.Text+'"';
end;

procedure TfrmParameters.BitBtn3Click(Sender: TObject);
begin
  CreateOutput := True;
  SaveParam(False,False);
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
    edtEmail.Text := Opendialog2.FileName;
    LoadParam;
  end;

end;

procedure TfrmParameters.LoadParam;
begin

  if edtIniFile.Text <> '' then
  begin
    vleParameters.Strings.LoadFromFile(edtIniFile.Text);
  end;

  if edtEmail.Text <> '' then
  begin
    vleEmail.Strings.LoadFromFile(edtEmail.Text);
  end;

end;

procedure TfrmParameters.SaveParam(ShowAMessage,Email: Boolean);
var
  ThePath,FFileName:String;
begin

  if Email then
    FFileName := edtEmail.Text
  else
    FFileName := edtIniFile.Text;

  ThePath := ExtractFilePath(FFileName);

  if Trim(ThePath) = '' then
  begin

    if Email then
      edtEmail.Text := ExtractFilePath(ParamStr(0))+ edtEmail.Text
    else
      edtIniFile.Text := ExtractFilePath(ParamStr(0))+ edtIniFile.Text;

  end;

  if Email then
  begin
    FFileName := edtEmail.Text;
    vleEmail.Strings.SaveToFile(FFileName);
  end
  else
  begin
    FFileName := edtIniFile.Text;
    vleParameters.Strings.SaveToFile(FFileName);
  end;



  if ShowAMessage then
  begin
    MessageDlg('Parameters Saved to '+#10+
                FFileName,mtInformation,[mbOK],0);

  end;
end;

procedure TfrmParameters.btnSaveClick(Sender: TObject);
begin
  SaveParam(True,False);
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
      SaveParam(True,True);
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


end;

procedure TfrmParameters.BitBtn4Click(Sender: TObject);
begin
  SaveParam(True,True);
end;

procedure TfrmParameters.vleEmailEditButtonClick(Sender: TObject);
var
  RowNo:Integer;
begin

  RowNo := VleParameters.row;


  if (RowNo >= 1) and (Rowno <= 3) then
  begin
    ShowDefault(RowNo,vleParameters.Keys[RowNo]);
  end;

  if (RowNo = 4) or (RowNo = 5) then
  begin

    frmSelectSender.Edit1.Text :=  VleParameters.Values['Sender Name'];
    frmSelectSender.Edit2.Text :=   VleParameters.Values['Sender Email'] ;

    if frmSelectSender.showModal = mrOK then
    begin
      VleParameters.Values['Sender Name'] :=  frmSelectSender.Edit1.Text;
      VleParameters.Values['Sender Email'] := frmSelectSender.Edit2.Text;
    end;

  end;

  if RowNo in [6,7,8,10,11] then
  begin
    GetMessageInfo;
  end;


  if RowNo = 9 then
  begin
    if opendialog1.Execute then
      VleParameters.Values['Attachments'] := opendialog1.Files.DelimitedText;

  end;


end;

end.
