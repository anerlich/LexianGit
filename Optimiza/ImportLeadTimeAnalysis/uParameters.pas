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
    Panel3: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    edtParamFile: TEdit;
    Button1: TButton;
    Label3: TLabel;
    OpenDialog2: TOpenDialog;
    ValueListEditor1: TValueListEditor;
    cmbDummy: TComboBox;
    ValueListEditor2: TValueListEditor;
    BitBtn3: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ValueListEditor1EditButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ValueListEditor1Validate(Sender: TObject; ACol,
      ARow: Integer; const KeyName, KeyValue: String);
  private
    { Private declarations }
    procedure UpdateFieldList;
  public
    { Public declarations }
    FExport:Boolean;
    procedure InitList;
    function GetExcessType:String;
  end;

var
  frmParameters: TfrmParameters;

implementation

uses uSelectOneLocation, uFieldSetup, uFieldSelect, uSetAppend;

{$R *.dfm}

procedure TfrmParameters.BitBtn2Click(Sender: TObject);

begin

  //ExcessType := 'X';

 // PO := 'N';

  //if chkInclude.Checked then PO := 'Y';

  //Case grpType.ItemIndex of
  //  0:ExcessType := 'P';
  //  1:ExcessType := 'N';
  //  2:ExcessType := 'X';
  //end;

  if edtParamFile.Text <> '' then
  begin
    if fileExists(edtParamFile.Text) then
    begin
      if MessageDlg(edtParamFile.Text + ' exists, Overwrite ? ',mtConfirmation,[mbYes,MbNo],0) = mrYes then
      begin
        ValueListEditor1.Strings.SaveToFile(edtParamFile.Text);
      end;

    end
    else
      ValueListEditor1.Strings.SaveToFile(edtParamFile.Text);
  end;
  
  Clipboard.AsText := 'Optimiza:"'+edtParamFile.Text+'"';

end;

procedure TfrmParameters.BitBtn3Click(Sender: TObject);
begin
  FExport := True;
  BitBtn2Click(Sender);
end;

procedure TfrmParameters.FormActivate(Sender: TObject);
begin
  FExport := False;
end;

procedure TfrmParameters.Button1Click(Sender: TObject);
begin

  if opendialog2.Execute then
    edtParamFile.Text := opendialog2.FileName;

  if FileExists(edtParamFile.Text) then
  begin
    ValueListEditor1.Strings.LoadFromFile(edtParamFile.Text);
    InitList;
  end;


end;

procedure TfrmParameters.ValueListEditor1EditButtonClick(Sender: TObject);
var
  RowNo:Integer;
begin

  RowNo := ValueListEditor1.row;

  if RowNo = 1 then
  begin
    if opendialog1.Execute then
      ValueListEditor1.Values['Input Filename'] := opendialog1.FileName;
  end;

  if RowNo = 4 then
  begin

    frmSetAppend.ImportType := ValueListEditor1.Values['Append or Replace Data'];

    if frmSetAppend.ShowModal = mrOK then
      ValueListEditor1.Values['Append or Replace Data'] := frmSetAppend.ImportType;

  end;

  if (RowNo >= 5) and (RowNo <= 19) then
  begin

    with frmFieldSetup do
    begin

      lblField.Caption := 'Field'+IntToStr(RowNo-4);
      SetAllData(ValueListEditor1.Values['Field'+IntToStr(RowNo-4)]);

      if ShowModal = mrOK then
      begin

        if Calculated then
          ValueListEditor1.Values['Field'+IntToStr(RowNo-4)] := FieldName + ','+IntToStr(FieldLen)+','+edtCalculation.Text
        else
          ValueListEditor1.Values['Field'+IntToStr(RowNo-4)] := FieldName + ','+IntToStr(FieldLen);


        UpdateFieldList;
      end;

    end;

  end;

  if (RowNo > 19) then
  begin
    frmFieldSelect.edtFieldName.Text := ValueListEditor1.Keys[RowNo];
    frmFieldSelect.cmbFieldName.Text := ValueListEditor1.Values[ValueListEditor1.Keys[RowNo]];

    if frmFieldSelect.ShowModal = mrOK then
    begin
      ValueListEditor1.Values[frmFieldSelect.edtFieldName.Text] := frmFieldSelect.cmbFieldName.Text;
    end;

  end;


end;

procedure TfrmParameters.InitList;
var
  FCount:Integer;
begin
  ValueListEditor1.ItemProps[0].EditStyle :=  esEllipsis;

  ValueListEditor1.ItemProps[1].EditStyle :=  esPickList;
  ValueListEditor1.ItemProps[1].ReadOnly := True;
  ValueListEditor1.ItemProps[1].PickList.Add('CSV');
  ValueListEditor1.ItemProps[1].PickList.Add('Text');

  ValueListEditor1.ItemProps[2].EditStyle :=  esPickList;
  ValueListEditor1.ItemProps[2].ReadOnly := True;
  ValueListEditor1.ItemProps[2].PickList.Add('YYYYMMDD');
  ValueListEditor1.ItemProps[2].PickList.Add('YYYY/MM/DD');
  ValueListEditor1.ItemProps[2].PickList.Add('YYMMDD');
  ValueListEditor1.ItemProps[2].PickList.Add('YY/MM/DD');
  ValueListEditor1.ItemProps[2].PickList.Add('DDMMYYYY');
  ValueListEditor1.ItemProps[2].PickList.Add('DD/MM/YYYY');
  ValueListEditor1.ItemProps[2].PickList.Add('DDMMYY');
  ValueListEditor1.ItemProps[2].PickList.Add('DD/MM/YY');

  ValueListEditor1.ItemProps[3].EditStyle :=  esEllipsis;
  ValueListEditor1.ItemProps[3].ReadOnly := True;

  for FCount := 4 to ValueListEditor1.Strings.Count - 1 do
  begin
    ValueListEditor1.ItemProps[FCount].EditStyle :=  esEllipsis;
    ValueListEditor1.ItemProps[FCount].ReadOnly := True;
  end;


  if ValueListEditor1.Values['File Format'] = 'CSV' then
    frmFieldSetup.ImportFileType := ftCSV
  else
    frmFieldSetup.ImportFileType := ftFixedLength;

  ValueListEditor2.ItemProps[0].ReadOnly := True;

end;

procedure TfrmParameters.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin

  if (ModalResult =  mrOK) or (Fexport) then
  begin
    if edtParamFile.Text = '' then
    begin
      MessageDlg('Please Specify the Parameter File Name',mtError,[mbOK],0);
      CanClose := False;

    end;

  end
  else
  begin
      if MessageDlg('OK to loose changes ?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
        CanClose := False;
  end;

end;

function TfrmParameters.GetExcessType: String;
begin


end;

procedure TfrmParameters.ValueListEditor1Validate(Sender: TObject; ACol,
  ARow: Integer; const KeyName, KeyValue: String);
begin

 if KeyName = 'File Format' then
  begin
    if ValueListEditor1.Values[KeyName] = 'CSV' then
      frmFieldSetup.ImportFileType := ftCSV
    else
      frmFieldSetup.ImportFileType := ftFixedLength;

  end;

end;

procedure TfrmParameters.UpdateFieldList;
var
  FCount:Integer;
  TempStr:String;
begin

  with frmFieldSelect.cmbFieldName.Items do
  begin
    Clear;

    for FCount :=  4 to 19 do
    begin
      TempStr :=  ValueListEditor1.Values['Field'+IntToStr(FCount-3)];
      TempStr := Copy(TempStr,1,Pos(',',TempStr)-1);

      if TempStr <> '' then
      begin
        TempStr := TempStr + ','+IntToStr(FCount-3);
        Add(TempStr);
      end;

    end;

  end;

end;

end.
