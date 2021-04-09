unit uParameters;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,Clipbrd, Buttons, Grids, ValEdit;

const
  _MaxParams=20;

type

  TParamType = (ptCompany, ptYesNo, ptFile, ptString, ptInfoOnly);

  TParamValues = record
    Name:String;
    ReadOnly:Boolean;
    EditOption:TEditStyle;
    Default:String;
    ParamType: TParamType;
  end;

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
    procedure FormCreate(Sender: TObject);
    procedure NewParam(Var ParamNo:Integer;Name, Default:String; ReadOnly:Boolean;EditOption:TEditStyle;
                 ParamType: TParamType);
    function ParamIndex(Name:String):Integer;
  private
    { Private declarations }
    FParamValues:Array[0.._MaxParams] of TParamValues;

    procedure SaveParam(ShowAMessage:Boolean);
    procedure SetCompanyParam;
    procedure SetYesNoParam(Name: String);
    procedure LoadDefaults;
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

uses uSelectOneLocation, uCompany;

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

procedure TfrmParameters.FormCreate(Sender: TObject);
var
  ParamNo:Integer;
begin

  for ParamNo := 0 to _MaxParams do
  begin
    FParamValues[ParamNo].Name := '';
    FParamValues[ParamNo].ParamType := ptInfoOnly;
  end;

  ParamNo := 0;
  NewParam(ParamNo,'Company','',True,esPickList,ptCompany);
  NewParam(ParamNo,'Input File Name','',False,esEllipsis,ptFile);
  NewParam(ParamNo,'Output File Name','',False,esEllipsis,ptFile);
  NewParam(ParamNo,'Lookup File','',False,esEllipsis,ptFile);
  NewParam(ParamNo,'Exclude Styles','',False,esEllipsis,ptFile);

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

    //If this Parameter passed on from Optimiza
    if UpperCase(edtIniFile.Text) = '-NF' then
      edtIniFile.Text := '';

    if FileExists(edtIniFile.Text) then
      vleParameters.Strings.LoadFromFile(edtIniFile.Text);

  end;

  LoadDefaults;

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

  //add param if needed
  if not vleParameters.FindRow(Name,ICount) then
    vleParameters.InsertRow(Name,'',True);

  if vleParameters.FindRow(Name,ICount) then
  begin
    vleParameters.ItemProps[ICount-1].EditStyle :=  EditStyle;
    vleParameters.ItemProps[ICount-1].ReadOnly := ReadOnly;
  end;



end;

procedure TfrmParameters.vleParametersEditButtonClick(Sender: TObject);
var
  RowNo:Integer;
  ParamName:String;
  ParamNo:Integer;
begin

  RowNo := VleParameters.row;
  ParamName := VleParameters.Cells[0,RowNo];
  ParamNo := ParamIndex(ParamName);

  if FParamValues[ParamNo].ParamType = ptFile then
  begin
    if opendialog1.Execute then
      VleParameters.Values[ParamName] := opendialog1.FileName;
  end;

end;

procedure TfrmParameters.SetCompanyParam;
var
  ICount,CCount:Integer;
begin

  SetParam('Company',True,esPickList);

  if vleParameters.FindRow('Company',ICount) then
  begin
    for CCount := 0 to _MaxCompany do
    begin
      vleParameters.ItemProps[ICount-1].PickList.Add(GetCompanyName(cCount));
    end;
  end;


end;

procedure TfrmParameters.SetYesNoParam(Name: String);
var
  ICount:Integer;
begin

  SetParam(Name,True,esPickList);

  if vleParameters.FindRow(Name,ICount) then
  begin
    vleParameters.ItemProps[ICount-1].PickList.Add('Yes');
    vleParameters.ItemProps[ICount-1].PickList.Add('No');
  end;

end;

procedure TfrmParameters.NewParam(Var ParamNo:Integer; Name, Default: String; ReadOnly: Boolean;
  EditOption: TEditStyle; ParamType: TParamType);
begin
  FParamValues[ParamNo].Name := Name;
  FParamValues[ParamNo].ReadOnly := ReadOnly;
  FParamValues[ParamNo].EditOption := EditOption;
  FParamValues[ParamNo].Default := Default;
  FParamValues[ParamNo].ParamType := ParamType;
  Inc(ParamNo);

end;

procedure TfrmParameters.LoadDefaults;
var
  ParamNo:Integer;
begin

  for ParamNo := 0 to _MaxParams do
  begin

    Case FParamValues[ParamNo].ParamType of
      ptCompany:SetCompanyParam;
      ptYesNo:SetYesNoParam(FParamValues[ParamNo].Name);
    else
      SetParam(FParamValues[ParamNo].Name,
             FParamValues[ParamNo].ReadOnly,
             FParamValues[ParamNo].EditOption);
    end;

  end;

end;

function TfrmParameters.ParamIndex(Name: String): Integer;
var
  ParamNo:Integer;
begin
  Result := -1;

  for ParamNo := 0 to _MaxParams do
  begin

    if Name = FParamValues[ParamNo].Name then
    begin
      Result := ParamNo;
      Break;
    end;

  end;

end;

end.


