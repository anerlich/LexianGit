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
    function GetParam(Name:String):String;
  published
  end;

var
  frmParameters: TfrmParameters;

implementation

uses uSelectOneLocation, uSelectLocationList, uCompany, uFilter;

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
  ICount,cCount:Integer;
begin

  try
  if edtIniFile.Text <> '' then
  begin
    vleParameters.Strings.LoadFromFile(edtIniFile.Text);
  end;

  SetParam('Output File Name',True,esEllipsis);
  SetParam('Location Codes',True,esEllipsis);
  except
    MessageDlg('Failed to Open ' +edtIniFile.Text,mtError,[mbOK],0);
  end;

  if not vleParameters.FindRow('Company',ICount) then
    vleParameters.InsertRow('Company','',True);

  SetParam('Company',True,esPickList);

  if vleParameters.FindRow('Company',ICount) then
  begin
    for CCount := 0 to _MaxCompany do
    begin
      vleParameters.ItemProps[ICount-1].PickList.Add(GetCompanyName(cCount));
    end;
  end;

  if not vleParameters.FindRow('Use Filter',ICount) then
    vleParameters.InsertRow('Use Filter','No',True);

  SetParam('Use Filter',True,esEllipsis);

  if not vleParameters.FindRow('Filter - Add Fields',ICount) then
    vleParameters.InsertRow('Filter - Add Fields','',True);

  SetParam('Filter - Add Fields',True,esEllipsis);

  if not vleParameters.FindRow('Filter - Join SQL',ICount) then
    vleParameters.InsertRow('Filter - Join SQL','',True);

  SetParam('Filter - Join SQL',True,esEllipsis);

  if not vleParameters.FindRow('Filter - Where SQL',ICount) then
    vleParameters.InsertRow('Filter - Where SQL','',True);

  SetParam('Filter - Where SQL',True,esEllipsis);


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

  if RowNo = 2 then
  begin
    frmSelectLocationList.SelectedLocationCodes := VleParameters.Values['Location Codes'];

    if frmSelectLocationList.ShowModal = mrOK then
      VleParameters.Values['Location Codes'] := frmSelectLocationList.SelectedLocationCodes;
  end;

  if (RowNo in [5,6,7,8]) then
  begin
    frmFilter.CheckBox1.Checked := VleParameters.Values['Use Filter'] = 'Yes';
    frmFilter.memFields.Lines.CommaText := VleParameters.Values['Filter - Add Fields'];
    frmFilter.memJoin.Lines.CommaText := VleParameters.Values['Filter - Join SQL'];
    frmFilter.memWhere.Lines.CommaText := VleParameters.Values['Filter - Where SQL'];
    frmFilter.EnableIt;

    if frmFilter.ShowModal = mrOK then
    begin
      if frmFilter.CheckBox1.Checked then
        VleParameters.Values['Use Filter'] := 'Yes'
      else
        VleParameters.Values['Use Filter'] := 'No';

      VleParameters.Values['Filter - Add Fields'] := frmFilter.memFields.Lines.CommaText;
      VleParameters.Values['Filter - Join SQL'] := frmFilter.memJoin.Lines.CommaText;
      VleParameters.Values['Filter - Where SQL'] := frmFilter.memWhere.Lines.CommaText;


    end;

  end;

end;

function TfrmParameters.GetParam(Name: String): String;
begin
  Result := VleParameters.Values[Name];

end;

end.
