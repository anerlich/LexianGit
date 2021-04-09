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
    procedure ShowDefault(ParamNo:Integer;DisplStr:String);
    procedure GetMessageInfo;
    procedure LoadMessageForm;
  public
    { Public declarations }
    CreateOutput:Boolean;
    procedure LoadParam;
    procedure SaveParam(ShowAMessage:Boolean);
    procedure SetParam(Name:String;ReadOnly:Boolean;EditStyle:TEditStyle);
  published
  end;

var
  frmParameters: TfrmParameters;

implementation

uses udefault, uSelectSender, uRecipient, uMessage,
  udmData, uSelectUser;

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
var
  ICount:Integer;
begin

  if edtIniFile.Text <> '' then
  begin
    if FileExists(edtIniFile.Text) then
      vleParameters.Strings.LoadFromFile(edtIniFile.Text);
  end;

  SetParam('Host',True,esEllipsis);
  SetParam('Port',True,esEllipsis);
  SetParam('User ID',True,esEllipsis);
  SetParam('Password',True,esEllipsis);
  SetParam('Sender Name',True,esEllipsis);
  SetParam('Sender Email',True,esEllipsis);
  SetParam('TO',True,esEllipsis);
  SetParam('CC',True,esEllipsis);
  SetParam('BCC',True,esEllipsis);
  SetParam('Attachments',False,esEllipsis);
  SetParam('Subject',True,esEllipsis);
  SetParam('Message',True,esEllipsis);
  SetParam('Use Gmail SMTP',False,esEllipsis);


  if not vleParameters.FindRow('Distribution Lists',ICount) then
    vleParameters.InsertRow('Distribution Lists','',True);

  SetParam('Distribution Lists',True,esEllipsis);


end;

procedure TfrmParameters.SaveParam(ShowAMessage: Boolean);
var
  ThePath:String;
begin

  if edtIniFile.Text = '' then
  begin
    if MessageDlg('Parameter File Name NOT Specified. Saved to '+#10+
                ExtractFilePath(ParamStr(0))+'Email1.ini',mtInformation,[mbYes,mbNo],0) = mrYes then
      edtIniFile.Text := ExtractFilePath(ParamStr(0))+'Email1.ini'
    else
      MessageDlg('Please Enter a valid Parameter Filename',mtError,[mbOK],0);

  end;

  if edtIniFile.Text <> '' then
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
    vleParameters.ItemProps[ICount-1].ReadOnly := ReadOnly;
  end;


end;

procedure TfrmParameters.vleParametersEditButtonClick(Sender: TObject);
var
  RowNo:Integer;
begin

  RowNo := VleParameters.row;


  if (RowNo >= 1) and (Rowno <= 4) then
  begin
    ShowDefault(RowNo,vleParameters.Keys[RowNo]);
  end;

  if (RowNo = 5) or (RowNo = 6) then
  begin

    frmSelectSender.Edit1.Text :=  VleParameters.Values['Sender Name'];
    frmSelectSender.Edit2.Text :=   VleParameters.Values['Sender Email'] ;

    if frmSelectSender.showModal = mrOK then
    begin
      VleParameters.Values['Sender Name'] :=  frmSelectSender.Edit1.Text;
      VleParameters.Values['Sender Email'] := frmSelectSender.Edit2.Text;
    end;

  end;

  if RowNo in [7,8,9,11,12] then
  begin
    GetMessageInfo;
  end;


  if RowNo = 10 then
  begin
    if opendialog1.Execute then
      VleParameters.Values['Attachments'] := opendialog1.Files.DelimitedText;

  end;

  if RowNo = 13 then
  begin
    //if frmFolder.ShowModal = mrOK then
    //  VleParameters.Values['Distribution Lists'] := frmFolder.FolderPath;

  end;


end;

procedure TfrmParameters.ShowDefault(ParamNo: Integer; DisplStr: String);
begin
  with frmDefault do
  begin
    Caption := DisplStr;
    Label1.Caption := Caption+' :';
    FParamNo := ParamNo;
    Edit1.Text := VleParameters.Values[DisplStr];
    CheckBox1.Checked := (UpperCase(Edit1.Text) = '[DEFAULT]');

    if ParamNo = 2 then
      Label2.Caption := '(25)';

    if ParamNo = 3 then
      Label2.Caption := '('+dmData.GetUserID+')';

    if ParamNo = 1 then
      Label2.Caption := '('+dmData.GetHostName+')';


    if ShowModal = mrOK then
    begin
      VleParameters.Values[DisplStr] := Edit1.Text;

    end;
  end;

end;


procedure TfrmParameters.GetMessageInfo;
begin
  LoadMessageForm;

  with frmMessage do
  begin

    if ShowModal = mrOK then
    begin
      VleParameters.Values['TO'] := edtTo.Text;
      VleParameters.Values['CC'] := edtCC.Text;
      VleParameters.Values['BCC'] := edtBCC.Text;
      VleParameters.Values['Attachments'] := edtAttach.Text;
      VleParameters.Values['Subject'] := edtSubject.Text;
      VleParameters.Values['Message'] := edtMessage.Lines.CommaText;
    end;

  end;

end;

procedure TfrmParameters.LoadMessageForm;
begin

  with frmMessage do
  begin
    edtTo.Text := VleParameters.Values['TO'];
    edtCC.Text := VleParameters.Values['CC'];
    edtBCC.Text := VleParameters.Values['BCC'];
    edtAttach.Text := VleParameters.Values['Attachments'];
    edtSubject.Text := VleParameters.Values['Subject'];
    edtMessage.Lines.CommaText := VleParameters.Values['Message'];
  end;


end;

end.
