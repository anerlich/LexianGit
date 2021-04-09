unit uParameters;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,Clipbrd, Buttons, Grids, ValEdit, ComCtrls,DateUtils;

type
  TReturnStatus = (rtAllMonthly);

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
    Label1: TLabel;
    edtIniFile: TEdit;
    btnOpen: TBitBtn;
    btnSave: TBitBtn;
    btnSaveAs: TBitBtn;
    OpenDialog2: TOpenDialog;
    SaveDialog1: TSaveDialog;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    cmbDailyStart: TComboBox;
    dteDailyStart: TDateTimePicker;
    dteDailyEnd: TDateTimePicker;
    grdFile: TStringGrid;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    vleParameters: TValueListEditor;
    edtEmailApp: TEdit;
    Button1: TButton;
    Label9: TLabel;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    edtDailyTrig: TEdit;
    Button2: TButton;
    edtMonthlyTrig: TEdit;
    Button3: TButton;
    Panel7: TPanel;
    Panel8: TPanel;
    GroupBox6: TGroupBox;
    Label8: TLabel;
    Label10: TLabel;
    edtDailyLoop: TEdit;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSaveAsClick(Sender: TObject);
    procedure vleParametersEditButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    procedure SaveParam(ShowAMessage:Boolean);
    function CountComma(AStr:String):Integer;
  public
    { Public declarations }
    CreateOutput:Boolean;
    procedure LoadParam;
    procedure SetParam(Name:String;ReadOnly:Boolean;EditStyle:TEditStyle);
    function GetStartTime(DailyMonthly:String):TDateTime;
    function GetEndTime(DailyMonthly:String):TDateTime;
  published
  end;

var
  frmParameters: TfrmParameters;

implementation

uses uSelectOneLocation, uEditType, udmData;

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
  Caption := 'Parameter Setup - Check Downloads (ver '+ dmData.kfVersionInfo+')';
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
  RowNo:Integer;
begin
  if edtIniFile.Text <> '' then
  begin
    vleParameters.Strings.LoadFromFile(edtIniFile.Text);

    cmbDailyStart.ItemIndex := StrToInt(vleParameters.Values['Daily Day']);
    dteDailyStart.Time := StrToTime(vleParameters.Values['Daily Start']);
    dteDailyEnd.Time := StrToTime(vleParameters.Values['Daily End']);
    edtEmailApp.Text := vleParameters.Values['Email Application'];
    edtDailyTrig.Text := vleParameters.Values['Daily Trigger'];
    edtMonthlyTrig.Text := vleParameters.Values['Monthly Trigger'];

    RowNo := CountComma(vleParameters.Values['Grid Type']);
    grdFile.RowCount := RowNo+1;
    grdFile.Cols[0].CommaText := vleParameters.Values['Grid Type'];
    grdFile.Cols[1].CommaText := vleParameters.Values['Grid Trigger'];
    grdFile.Cols[2].CommaText := vleParameters.Values['Grid Files'];
    grdFile.Cols[3].CommaText := vleParameters.Values['Email Ini File'];
    edtDailyLoop.Text := vleParameters.Values['Daily Loop Time'];


  end;


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

  vleParameters.Values['Daily Day'] := IntToStr(cmbDailyStart.ItemIndex);
  vleParameters.Values['Daily Start'] := TimeToStr(dteDailyStart.Time);
  vleParameters.Values['Daily End'] := TimeToStr(dteDailyEnd.Time);
  vleParameters.Values['Email Application']:=  edtEmailApp.Text;
  vleParameters.Values['Daily Trigger']:=edtDailyTrig.Text;
  vleParameters.Values['Monthly Trigger']:=edtMonthlyTrig.Text;

  vleParameters.Values['Grid Type'] := grdFile.Cols[0].CommaText;
  vleParameters.Values['Grid Trigger'] := grdFile.Cols[1].CommaText;
  vleParameters.Values['Grid Files'] := grdFile.Cols[2].CommaText;
  vleParameters.Values['Email Ini File'] := grdFile.Cols[3].CommaText;
  vleParameters.Values['Daily Loop Time'] := edtDailyLoop.Text;      

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


end;

procedure TfrmParameters.FormCreate(Sender: TObject);
begin
  grdFile.Cells[0,0] := 'Download Type';
  grdFile.Cells[1,0] := 'Trigger File';
  grdFile.Cells[2,0] := 'Download Files';
  grdFile.Cells[3,0] := 'Email Details';
  grdFile.ColWidths[0] := 80;
  grdFile.ColWidths[1] := 260;
  grdFile.ColWidths[2] := 260;
  grdFile.ColWidths[3] := 260;
  dteDailyStart.Date := Now;
  dteDailyEnd.Date := Now;
end;

procedure TfrmParameters.BitBtn4Click(Sender: TObject);
var
  RowNo:Integer;
begin

  frmEditType.edtTrigger.Text := '';
  frmEditType.edtEmailIni.Text := '';
  frmEditType.grdDownload.Cols[0].CommaText := '';
  frmEditType.FEmailApp := edtEmailApp.Text;

  if frmEditType.ShowModal = mrOK then
  begin
    RowNo := grdFile.RowCount -1;

    if grdFile.Cells[0,RowNo] <> '' then
    begin
      inc(RowNo);
      grdFile.RowCount := RowNo+1;
    end;

    grdFile.Cells[0,RowNo] := frmEditType.cmbType.Text;
    grdFile.Cells[1,RowNo] := frmEditType.edtTrigger.Text;
    grdFile.Cells[2,RowNo] := frmEditType.grdDownload.Cols[0].CommaText;
    grdFile.Cells[3,RowNo] := frmEditType.edtEmailIni.Text;
    grdFile.Refresh;
  end;

end;

procedure TfrmParameters.BitBtn5Click(Sender: TObject);
var
  RowNo:Integer;
begin

  RowNo := grdFile.Row;
  frmEditType.cmbType.ItemIndex := frmEditType.cmbType.Items.IndexOf(grdFile.Cells[0,RowNo]);
  frmEditType.edtTrigger.Text := grdFile.Cells[1,RowNo];
  frmEditType.edtEmailIni.Text := grdFile.Cells[3,RowNo];
  frmEditType.grdDownload.Cols[0].CommaText := grdFile.Cells[2,RowNo];
  frmEditType.FEmailApp := edtEmailApp.Text;

  if frmEditType.ShowModal = mrOK then
  begin

    grdFile.Cells[0,RowNo] := frmEditType.cmbType.Text;
    grdFile.Cells[1,RowNo] := frmEditType.edtTrigger.Text;
    grdFile.Cells[2,RowNo] := frmEditType.grdDownload.Cols[0].CommaText;
    grdFile.Cells[3,RowNo] := frmEditType.edtEmailIni.Text;

  end;

end;

procedure TfrmParameters.BitBtn6Click(Sender: TObject);
var
  RowNo,RCount:Integer;
  SaveRowStr:String;
begin

  RowNo := grdFile.Row;
  grdFile.Rows[RowNo].CommaText := '';

  for RCount := RowNo to grdFile.RowCount -2 do
  begin
    grdFile.Rows[RowNo].CommaText := grdFile.Rows[RowNo+1].CommaText;
  end;

  if grdFile.RowCount > 2 then
    grdFile.RowCount := grdFile.RowCount-1;

end;

function TfrmParameters.CountComma(AStr: String): Integer;
var
  aPos:Integer;

begin
  Result := 0;
  aPos := 1;

  while apos > 0 do
  begin
    aPos := Pos(',',aStr);
    if aPos >0 then
    begin
      inc(Result);
      AStr := Copy(AStr,Pos(',',AStr)+1,Length(AStr));
    end;
  end;



end;


procedure TfrmParameters.Button1Click(Sender: TObject);
begin
  if Opendialog1.Execute then
    edtEmailApp.Text := OpenDialog1.FileName;

end;


function TfrmParameters.GetEndTime(DailyMonthly: String): TDateTime;
begin
  Result := dteDailyEnd.DateTime ;

end;

function TfrmParameters.GetStartTime(DailyMonthly: String): TDateTime;
begin

  Result := dteDailyStart.DateTime;
  if cmbDailyStart.ItemIndex = 0 then
    Result := IncDay(Result,-1);

end;

procedure TfrmParameters.Button2Click(Sender: TObject);
begin
  if Opendialog1.Execute then
    edtDailyTrig.Text := OpenDialog1.FileName;

end;

procedure TfrmParameters.Button3Click(Sender: TObject);
begin
  if Opendialog1.Execute then
    edtMonthlyTrig.Text := OpenDialog1.FileName;

end;

end.
