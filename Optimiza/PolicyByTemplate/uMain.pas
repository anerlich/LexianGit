unit uMain;

interface

//Version info
//   1.4
//   1.5 - 2/5/08 - TSL setting, error trapping where template is deleted.
//                  and exception file.
//   1.6 - 28/08/08 - Change caption for JT - email Tuesday, 26 August 2008 9:55 AM
//                  - Fix bug - Incorrect user is displayed for an already entered template
//                  -           although the template detail information is correct.
//                  - Only allow LOCALADMIN templates to be selected.
//   1.7 - 12/09/08 - Disable run option.
//                  - Up - down buttons.
//   1.8 - 03/09/09 - Log files re-directed
//   1.9 - 20/10/09 - FB 2 has issue when stored proc is altered.
//         Changed to close and open DB as patch
//   2.0 - 08/10/12 - Fix problem where template selection processing did not allow for BOM & finished goods.
//   2.1 - 17/01/14 - Allow MOQ and Order Multiples to be updated as well.
//   2.2 - 10/03/14 - Fix bug where there was no Where clause generated (no template used)
//   2.3 - 16/02/2017 - Change so each location runs as separate job
//   2.4 - Improve error logging
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, StdCtrls, Buttons,StrUtils, ExtCtrls,IdGlobal, IdGlobalProtocols,
  Menus;

type
  TPolicyType = (ptLeadTime, ptReplenishmentCycle, ptReviewPeriod, ptServiceLevel, ptSafetyStock, ptMinimumOrderQuantity, ptOrderMultiples, ptAll);

  TfrmMain = class(TForm)
    Panel1: TPanel;
    btnRun: TBitBtn;
    btnClose: TBitBtn;
    Panel2: TPanel;
    Label2: TLabel;
    edtTemplateName: TEdit;
    btnTemplate: TButton;
    edtTemplateNo: TEdit;
    GroupBox1: TGroupBox;
    chkLT: TCheckBox;
    chkRC: TCheckBox;
    chkRP: TCheckBox;
    chkTSL: TCheckBox;
    grdLocs: TStringGrid;
    btnLocs: TBitBtn;
    btnPolicy: TBitBtn;
    btnSave: TBitBtn;
    btnCancel: TBitBtn;
    Panel3: TPanel;
    Label1: TLabel;
    vleUpdates: TValueListEditor;
    btnAdd: TBitBtn;
    btnEdit: TBitBtn;
    btnDelete: TBitBtn;
    vleSettings: TValueListEditor;
    Label3: TLabel;
    edtDescription: TEdit;
    Label4: TLabel;
    btnCopyTo: TBitBtn;
    PopupMenu1: TPopupMenu;
    CopyALLpolicytoAllLocations1: TMenuItem;
    N1: TMenuItem;
    CopyLTtoAllLocations1: TMenuItem;
    CopyRCtoAllLocations1: TMenuItem;
    CopyRPtoAllLocations1: TMenuItem;
    CopyTSLtoAllLocations1: TMenuItem;
    CopySStoAllLocations1: TMenuItem;
    chkSS: TCheckBox;
    chkResetTSL: TCheckBox;
    vleParameters: TValueListEditor;
    btnMoveUp: TBitBtn;
    btnMoveDown: TBitBtn;
    chkMOQ: TCheckBox;
    chkORM: TCheckBox;
    procedure btnTemplateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnLocsClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnPolicyClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure grdLocsClick(Sender: TObject);
    procedure GroupBox1Click(Sender: TObject);
    procedure btnRunClick(Sender: TObject);
    procedure edtDescriptionClick(Sender: TObject);
    procedure vleUpdatesClick(Sender: TObject);
    procedure btnCopyToClick(Sender: TObject);
    procedure CopyALLpolicytoAllLocations1Click(Sender: TObject);
    procedure CopyLTtoAllLocations1Click(Sender: TObject);
    procedure CopyRCtoAllLocations1Click(Sender: TObject);
    procedure CopyRPtoAllLocations1Click(Sender: TObject);
    procedure CopyTSLtoAllLocations1Click(Sender: TObject);
    procedure CopySStoAllLocations1Click(Sender: TObject);
    procedure chkSSEnter(Sender: TObject);
    procedure chkRPEnter(Sender: TObject);
    procedure chkTSLEnter(Sender: TObject);
    procedure chkRCEnter(Sender: TObject);
    procedure chkLTEnter(Sender: TObject);
    procedure btnMoveUpClick(Sender: TObject);
    procedure btnMoveDownClick(Sender: TObject);
    procedure chkMOQEnter(Sender: TObject);
    procedure chkORMEnter(Sender: TObject);
  private
    { Private declarations }
    FUserNo,FUpDateNo,FLocalAdminNo:Integer;
    FirstShow:Boolean;
    FParamFile,FControlFile:String;
    FSettingsName:String;
    FSettingChanged,FScheduleRun:Boolean;
    procedure LoadParam;
    procedure LoadSettings(UpdateNo:Integer);
    procedure LoadLocs(UpdateNo:Integer);
    procedure SaveLocs;
    procedure SaveSettings;
    procedure SaveFiles;
    function GetTemplateName(TemplateNo: Integer): String;
    procedure EnableEdit;
    procedure DisableEdit;
    procedure SetButtons;
    function ValidateEntries:Boolean;
    procedure StartProcess;
    function GetUniqueName:String;
    procedure CopyPolicy(PolicyType:TPolicyType);
    procedure SetLocalAdminNo;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses uSelectTemplate, udmData, uSelectLocationListOpt, uPolicy, uStatus;

{$R *.dfm}

procedure TfrmMain.btnTemplateClick(Sender: TObject);

begin

  try
    //See if user is on a valid row, or brand new install without anything
    StrToInt(vleUpdates.Cells[0,vleUpdates.Row]);

    try
      EnableEdit;

      if FUserNo <> FLocalAdminNo then
      begin
        MessageDlg('A template from another user account was used for this update.'#10+
                   'Please use a template from the LOCALADMIN user account.'#10+
                   'Use Optimiza to setup templates for LOCALADMIN and then'#10+
                   're-load this application for them to appear.',mtWarning,[mbOK],0);
        frmSelectTemplate.UserNo := FLocalAdminNo;
      end
      else
        frmSelectTemplate.UserNo := FUserNo;

      frmSelectTemplate.OpenTemplate;
      frmSelectTemplate.DBLookupComboBox1.Enabled := False; // Don't allow them to use
                                                            // Anything but LOCALADMIN

      if frmSelectTemplate.showmodal = mrOK then
      begin
        edtTemplateName.Color := clWindow;
        FUserNo := frmSelectTemplate.UserNo;

        //All items
        if frmSelectTemplate.CheckBox1.Checked then
        begin
          edtTemplateNo.Text := '-1';
          edtTemplateName.Text := '<No Template - All Items>';
        end
        else
        begin

          if frmSelectTemplate.TemplateNo >= 0  then
          begin
            edtTemplateNo.Text := IntToStr(frmSelectTemplate.TemplateNo);
            edtTemplateName.Text := frmSelectTEmplate.Description;
          end
          else
            MessageDlg('Please select a valid template.',mtError,[mbOK],0);

        end;

      end;

    except
      MessageDlg('This option failed. Please check selections and try again.',mtError,[mbOK],0);
    end;


  except
    MessageDlg('Please select a valid update from the list above before attempting this option.',mtError,[mbOK],0);

  end;


end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FUserNo := 1;
  FUpdateNo := 0;
  FirstShow := True;
  FSettingChanged := False;
  FControlFile := '';
end;

procedure TfrmMain.FormActivate(Sender: TObject);
var
  TempName:String;
begin
  if FirstShow then
  begin
    FirstShow := False;
    grdLocs.Cells[0,0] := 'Location';
    grdLocs.Cells[1,0] := 'LT';
    grdLocs.Cells[2,0] := 'RC';
    grdLocs.Cells[3,0] := 'RP';
    grdLocs.Cells[4,0] := 'TSL';
    grdLocs.Cells[5,0] := 'SS';
    grdLocs.Cells[6,0] := 'MOQ';
    grdLocs.Cells[7,0] := 'ORM';
    grdLocs.Cells[8,0] := 'Description';

    grdLocs.ColWidths[0] := 70;
    grdLocs.ColWidths[8] := 250;

    Caption := Caption + ' (Ver '+dmData.kfVersionInfo+')';

    if (ParamCount > 0) and (UpperCase(ParamStr(1)) <> '-Z' ) and (Copy(UpperCase(ParamStr(1)),1,2) <> '-U' ) then
    begin
      TempName := ParamStr(1);
      FParamFile := TempName;

      FScheduleRun := True;

      StartProcess;
      Close;
    end
    else
    begin
      TempName := '';
      FScheduleRun := False;

      if (UpperCase(ParamStr(1)) = '-Z' ) then
        if (UpperCase(ParamStr(3)) <> '-NF' ) then
        begin
            TempName := ParamStr(3);
            FParamFile := TempName;
        end;

      if TempName = '' then
      begin
        TempName := ParamStr(0);
        FParamFile := AnsiReplaceStr(UpperCase(TempName),'.EXE','.dat');
      end;


      LoadParam;

      if VleUpdates.cells[0,VleUpdates.Row] <> '' then
        LoadSettings(StrToInt(VleUpdates.cells[0,VleUpdates.Row]));


      SetLocalAdminNo;  
    end;



  end;

  

end;

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  SaveFiles;
  Close;
end;

procedure TfrmMain.btnAddClick(Sender: TObject);
var
  NewName:String;
begin

  NewName := InputBox('Enter','Description','');

  if NewName <> '' then
  begin
    FSettingsName := GetUniqueName;
    vleUpdates.InsertRow(IntToStr(FUpdateNo),NewName,True);

    SaveFiles;
    vleUpdates.Row := vleUpdates.RowCount-1;
    vleUpdates.SetFocus;

    btnEdit.Click;
    edtDescription.Text := vleUpdates.Cells[1,vleUpdates.row];
  end
  else
    MessageDlg('Invalid Description',mtError,[mbOK],0);

end;

procedure TfrmMain.LoadParam;
begin

  if FileExists(FParamFile) then
  begin
    vleUpdates.Strings.LoadFromFile(FParamFile);


    FControlFile := AnsiReplaceStr(FParamFile,'.','_Parameters.');

    if FileExists(FControlFile) then
      vleParameters.Strings.LoadFromFile(FControlFile);

    chkResetTSL.Checked := UpperCase(vleParameters.Values['Reset to TSL before start']) = 'YES';
    chkSS.Enabled := chkResetTSL.Checked;

  end;



end;

procedure TfrmMain.btnDeleteClick(Sender: TObject);
begin
  try

    FUpdateNo := StrToInt(vleUpdates.Cells[0,vleUpdates.Row]);
    LoadSettings(FUpdateNo);
    DeleteFile(FSettingsName);
    vleUpdates.DeleteRow(vleUpdates.Row);
    LoadSettings(StrToInt(VleUpdates.cells[0,VleUpdates.Row]));
  except
  end;

end;

procedure TfrmMain.LoadSettings(UpdateNo: Integer);
begin
  FSettingsName := AnsiReplaceStr(FParamFile,'.','_'+IntToStr(UpdateNo)+'.');
  Label3.Caption := '';

  if FileExists(FSettingsName) then
  begin
    vleSettings.Strings.LoadFromFile(FSettingsName);
    edtDescription.Text := vleUpdates.Cells[1,vleUpdates.Row];
    edtTemplateNo.Text := vleSettings.Values['Template No'];
    edtTemplateName.Color := clWindow;


    if vleSettings.Values['User No'] <> '' then
      FUserNo := StrToInt(vleSettings.Values['User No']);

    if edtTemplateNo.Text <> '' then
      edtTemplateName.Text := GetTemplateName(StrToInt(edtTemplateNo.Text));

    chkLT.Checked := Pos('LT',vleSettings.Values['Update']) >0 ;
    chkRC.Checked := Pos('RC',vleSettings.Values['Update']) >0 ;
    chkRP.Checked := Pos('RP',vleSettings.Values['Update']) >0 ;
    chkTSL.Checked := Pos('TSL',vleSettings.Values['Update']) >0 ;
    chkSS.Checked := Pos('SS',vleSettings.Values['Update']) >0 ;
    chkMOQ.Checked := Pos('MOQ',vleSettings.Values['Update']) >0 ;
    chkORM.Checked := Pos('ORM',vleSettings.Values['Update']) >0 ;

    LoadLocs(UpdateNo);

  end
  else
  begin
    edtTemplateName.Text := 'Settings unavailable - please save new set';
    edtTemplateName.Color := clRed;
    edtDescription.Text := vleUpdates.Cells[1,vleUpdates.Row];
    vleSettings.Values['Locations'] := '';
    LoadLocs(-1);
  end;



end;

procedure TfrmMain.btnSaveClick(Sender: TObject);
begin

  if ValidateEntries then
  begin
    Label3.Caption := '';
    SaveSettings;
    SaveFiles;
    DisableEdit;
  end;

end;

procedure TfrmMain.btnLocsClick(Sender: TObject);
var
  LocCodes:String;
  lCount,RCount:Integer;
  SaveList:TStringList;
begin
  EnableEdit;
  frmSelectLocationList.SelectedLocationCodes := grdLocs.Cols[0].DelimitedText;

  if frmSelectLocationList.ShowModal = mrOK then
  begin
    SaveList := TStringList.Create;
    SaveList.DelimitedText := grdLocs.Cols[0].DelimitedText;

    LocCodes := frmSelectLocationList.SelectedLocationCodes;

    grdLocs.Cols[0].DelimitedText := '"Location",'+LocCodes;

    for lCount := 1 to grdLocs.RowCount-1 do
    begin

      if Trim(grdLocs.Cells[0,lCount]) <> '' then
      begin


        if vleSettings.FindRow(grdLocs.Cells[0,lCount],RCount) then
        begin
          grdLocs.Rows[lCount].DelimitedText := vleSettings.Values[grdLocs.Cells[0,lCount]];
        end;

        grdLocs.Cells[8,lCount] := dmData.GetLocationDesc(grdLocs.Cells[0,lCount]);

      end
      else
      begin
        grdLocs.Rows[lCount].DelimitedText := '';
      end;

    end;

    //Remove any from vleSettings that have been untagged
    for lCount := 1 to SaveList.Count-1 do
    begin

      if Trim(SaveList.Strings[lCount]) <> '' then
      begin

        if grdLocs.Cols[0].IndexOf(SaveList.Strings[lCount]) < 0 then
          if vleSettings.FindRow(SaveList.Strings[lCount],RCount) then
            vleSettings.DeleteRow(RCount);

      end;

    end;

    SaveList.Free;


  end;


end;

function OccurrencesOfChar(const hayStack: string; const needle: char): integer;
var
  i: Integer;
begin
  result := 0;
  for i := 1 to Length(hayStack) do
    if hayStack[i] = needle then
      inc(result);
end;

procedure TfrmMain.LoadLocs(UpdateNo: Integer);
var
  lCount,RCount, PCount:Integer;
  TempStr:String;
begin
  grdLocs.Cols[0].DelimitedText := vleSettings.Values['Locations'];

    for lCount := 1 to grdLocs.RowCount-1 do
    begin

      if Trim(grdLocs.Cells[0,lCount]) <> '' then
      begin

        if vleSettings.FindRow(grdLocs.Cells[0,lCount],RCount) then
        begin
          PCount := OccurrencesOfChar(vleSettings.Values[grdLocs.Cells[0,lCount]] , ',');
          while PCount < 8 do
          begin
            vleSettings.Values[grdLocs.Cells[0,lCount]] := StuffString(vleSettings.Values[grdLocs.Cells[0,lCount]], lastDelimiter(',' , vleSettings.Values[grdLocs.Cells[0,lCount]]), 1, ',,');
            inc(PCount);
          end;
          grdLocs.Rows[lCount].DelimitedText := vleSettings.Values[grdLocs.Cells[0,lCount]];
          TempStr := Trim(grdLocs.Cells[7,lCount]);
           
          if Length(TempStr) > 0 then
            if not (TempStr[1] in ['0'..'9']) then
              grdLocs.Cells[7,lCount] := '';

          grdLocs.Cells[8,lCount] := dmData.GetLocationDesc(grdLocs.Cells[0,lCount]);
        end;

      end
      else
      begin
        grdLocs.Rows[lCount].DelimitedText := '';

      end;
        
    end;


   
end;

procedure TfrmMain.SaveLocs;
var
  LCount,RCount:Integer;
begin
  vleSettings.Values['Locations'] := grdLocs.Cols[0].DelimitedText;

  for lCount := 1 to grdLocs.RowCount-1 do
  begin

    if Trim(grdLocs.Cells[0,lCount]) <> '' then
    begin
      

      if vleSettings.FindRow(grdLocs.Cells[0,lCount],RCount) then
        vleSettings.Values[grdLocs.Cells[0,lCount]]:= grdLocs.Rows[lCount].DelimitedText
      else
        vleSettings.InsertRow(grdLocs.Cells[0,lCount],grdLocs.Rows[lCount].DelimitedText,True);

    end;

  end;

end;

procedure TfrmMain.btnEditClick(Sender: TObject);
begin
  LoadSettings(StrToInt(VleUpdates.cells[0,VleUpdates.Row]));
  EnableEdit;
  edtDescription.SetFocus;
end;

procedure TfrmMain.SaveSettings;
var
  UpdateStr:String;
begin

  UpdateStr := '';

  if chkLT.Checked then
    UpdateStr := UpdateStr + ',LT'
  else
    grdLocs.Cols[1].DelimitedText := 'LT';  //clear if not used

  if chkRC.Checked then
    UpdateStr := UpdateStr + ',RC'
  else
    grdLocs.Cols[2].DelimitedText := 'RC';  //clear if not used

  if chkRP.Checked then
    UpdateStr := UpdateStr + ',RP'
  else
    grdLocs.Cols[3].DelimitedText := 'RP';  //clear if not used

  if chkTSL.Checked then
    UpdateStr := UpdateStr + ',TSL'
  else
    grdLocs.Cols[4].DelimitedText := 'TSL';  //clear if not used

  if chkSS.Checked then
    UpdateStr := UpdateStr + ',SS'
  else
    grdLocs.Cols[5].DelimitedText := 'SS';  //clear if not used

  if chkMOQ.Checked then
    UpdateStr := UpdateStr + ',MOQ'
  else
    grdLocs.Cols[6].DelimitedText := 'MOQ';  //clear if not used

  if chkORM.Checked then
    UpdateStr := UpdateStr + ',ORM'
  else
    grdLocs.Cols[7].DelimitedText := 'ORM';  //clear if not used

  vleUpdates.Cells[1,vleUpdates.Row] := edtDescription.Text;
  vleSettings.Values['Template No'] := edtTemplateNo.Text;
  vleSettings.Values['User No'] := IntToStr(FUserNo);
  vleSettings.Values['Update'] := UpdateStr;
  SaveLocs;
  vleSettings.Strings.SaveToFile(FSettingsName);

end;

function TfrmMain.GetTemplateName(TemplateNo: Integer): String;
var
  AlreadyActive:Boolean;
begin

  if TemplateNo = -1 then
    Result := '<No Template - All Items>'
  else
  begin

    AlreadyActive := dmData.qryTemplate.Active;
    if  not AlreadyActive then
    begin
      frmSelectTemplate.UserNo := FUserNo;
      frmSelectTemplate.OpenTemplate;
    end;

    if dmData.srcTemplate.DataSet.Locate('TemplateNo',TemplateNo,[]) then
      Result := dmData.srcTemplate.DataSet.fieldByName('Description').asString
    else
      Result := '';

    if not AlreadyActive then
    dmData.qryTemplate.Active := False;

  end;

end;

procedure TfrmMain.btnPolicyClick(Sender: TObject);
begin
  EnableEdit;

  if grdLocs.Cells[0,grdLocs.Row] <> '' then
  begin

    frmPolicy.ExtEdit1.Enabled := chkLT.Checked;
    frmPolicy.ExtEdit2.Enabled := chkRC.Checked;
    frmPolicy.ExtEdit3.Enabled := chkRP.Checked;
    frmPolicy.ExtEdit4.Enabled := chkTSL.Checked;
    frmPolicy.ExtEdit5.Enabled := chkSS.Checked;
    frmPolicy.ExtEditMOQ.Enabled := chkMOQ.Checked;
    frmPolicy.ExtEditORM.Enabled := chkORM.Checked;

    if (chkLT.Checked) and (Trim(grdLocs.Cells[1,grdLocs.Row])<>'') then
      frmPolicy.ExtEdit1.Text := grdLocs.Cells[1,grdLocs.Row];

    if (chkRC.Checked) and (Trim(grdLocs.Cells[2,grdLocs.Row])<>'') then
      frmPolicy.ExtEdit2.Text := grdLocs.Cells[2,grdLocs.Row];

    if (chkRP.Checked) and (Trim(grdLocs.Cells[3,grdLocs.Row])<>'') then
      frmPolicy.ExtEdit3.Text := grdLocs.Cells[3,grdLocs.Row] ;

    if (chkTSL.Checked) and (Trim(grdLocs.Cells[4,grdLocs.Row])<>'') then
      frmPolicy.ExtEdit4.Text := grdLocs.Cells[4,grdLocs.Row];

    if (chkSS.Checked) and (Trim(grdLocs.Cells[5,grdLocs.Row])<>'') then
      frmPolicy.ExtEdit5.Text := grdLocs.Cells[5,grdLocs.Row];

    if (chkMOQ.Checked) and (Trim(grdLocs.Cells[6,grdLocs.Row])<>'') then
      frmPolicy.ExtEditMOQ.Text := grdLocs.Cells[6,grdLocs.Row];

    if (chkORM.Checked) and (Trim(grdLocs.Cells[7,grdLocs.Row])<>'') then
      frmPolicy.ExtEditORM.Text := grdLocs.Cells[7,grdLocs.Row];

    frmPolicy.Label1.caption := grdLocs.Cells[0,grdLocs.Row];
    frmPolicy.Label2.caption := dmData.GetLocationDesc(frmPolicy.Label1.caption);

    if frmPolicy.showmodal = mrOK then
    begin
      grdLocs.Cells[1,grdLocs.Row] := '';
      grdLocs.Cells[2,grdLocs.Row] := '';
      grdLocs.Cells[3,grdLocs.Row] := '';
      grdLocs.Cells[4,grdLocs.Row] := '';
      grdLocs.Cells[5,grdLocs.Row] := '';
      grdLocs.Cells[6,grdLocs.Row] := '';
      grdLocs.Cells[7,grdLocs.Row] := '';

      if chkLT.Checked then
        grdLocs.Cells[1,grdLocs.Row] := frmPolicy.ExtEdit1.Text;

      if chkRC.Checked then
        grdLocs.Cells[2,grdLocs.Row] := frmPolicy.ExtEdit2.Text;

      if chkRP.Checked then
        grdLocs.Cells[3,grdLocs.Row] := frmPolicy.ExtEdit3.Text;

      if chkTSL.Checked then
        grdLocs.Cells[4,grdLocs.Row] := frmPolicy.ExtEdit4.Text;

      if chkSS.Checked then
        grdLocs.Cells[5,grdLocs.Row] := frmPolicy.ExtEdit5.Text;

      if chkMOQ.Checked then
        grdLocs.Cells[6,grdLocs.Row] := frmPolicy.ExtEditMOQ.Text;

      if chkORM.Checked then
        grdLocs.Cells[7,grdLocs.Row] := frmPolicy.ExtEditORM.Text;

      vleSettings.Values[grdLocs.Cells[0,grdLocs.Row]]:= grdLocs.Rows[grdLocs.Row].DelimitedText


    end;

  end;
end;

procedure TfrmMain.EnableEdit;
begin

  edtTemplateName.Enabled := True;

  Panel3.Enabled := False;
  vleUpdates.Color := clInactiveBorder;

  SetButtons;
end;

procedure TfrmMain.btnCancelClick(Sender: TObject);
begin
  DisableEdit;
end;

procedure TfrmMain.SetButtons;
begin


  btnSave.Enabled := edtTemplateName.Enabled;
  btnCancel.Enabled := edtTemplateName.Enabled;

  btnAdd.Enabled := Panel3.Enabled;
  btnEdit.Enabled := Panel3.Enabled;
  btnDelete.Enabled := Panel3.Enabled;
  btnCopyTo.Enabled := Panel3.Enabled;
  btnRun.Enabled := Panel3.Enabled;
  btnClose.Enabled := Panel3.Enabled;

  btnMoveUp.Enabled := Panel3.Enabled;
  btnMoveDown.Enabled := Panel3.Enabled;

end;

procedure TfrmMain.DisableEdit;
begin

  //Panel2.Enabled := False;
  edtTemplateName.Enabled := False;

  Panel3.Enabled := True;
  vleUpdates.Color := clWindow;

  SetButtons;

end;

function TfrmMain.ValidateEntries: Boolean;
var
  LocCount,LCount:Integer;
  TestVal:Real;
begin
  Result := True;
  LocCount:=0;

  if edtTemplateNo.Text = '' then
  begin
    MessageDlg('Please select a valid template',mtError,[mbOK],0);
    Result := False;
  end
  else
  begin

    for lCount := 1 to grdLocs.RowCount-1 do
    begin

      if Trim(grdLocs.Cells[0,lCount]) <> '' then
      begin

        inc(LocCount);

        if chkLT.Checked then
        begin
          try
            StrtoFloat(grdLocs.Cells[1,lCount]);
          except
            MessageDlg('Invalid LT Policy for '+grdLocs.Cells[0,lCount],mtError,[mbOK],0);
            Result := False;
            break;
          end;
        end;

        if chkRC.Checked then
        begin
          try
            StrtoFloat(grdLocs.Cells[2,lCount]);
          except
            MessageDlg('Invalid RC Policy for '+grdLocs.Cells[0,lCount],mtError,[mbOK],0);
            Result := False;
            break;
          end;
        end;

        if chkRP.Checked then
        begin
          try
            StrtoFloat(grdLocs.Cells[3,lCount]);
          except
            MessageDlg('Invalid RP Policy for '+grdLocs.Cells[0,lCount],mtError,[mbOK],0);
            Result := False;
            break;
          end;
        end;

        if chkTSL.Checked then
        begin
          try
            TestVal := StrtoFloat(grdLocs.Cells[4,lCount]);

            if (TestVal < 50) or (TestVal >= 100) then
            begin
              Result := False;
              MessageDlg('TSL must be 50% to 99.9% '+grdLocs.Cells[0,lCount],mtError,[mbOK],0);
            end;

          except
            MessageDlg('Invalid TSL Policy for '+grdLocs.Cells[0,lCount],mtError,[mbOK],0);
            Result := False;
            break;
          end;
        end;

        if chkSS.Checked then
        begin
          try
            TestVal := StrtoFloat(grdLocs.Cells[5,lCount]);

            if (TestVal < 0) or (TestVal > 12) then
            begin
              Result := False;
              MessageDlg('SS must be between 0 and 12 months '+grdLocs.Cells[0,lCount],mtError,[mbOK],0);
            end;

          except
            MessageDlg('Invalid SS Policy for '+grdLocs.Cells[0,lCount],mtError,[mbOK],0);
            Result := False;
            break;
          end;
        end;

        if chkMOQ.Checked then
        begin
          try
            StrtoFloat(grdLocs.Cells[6,lCount]);
          except
            MessageDlg('Invalid MOQ Policy for '+grdLocs.Cells[0,lCount],mtError,[mbOK],0);
            Result := False;
            break;
          end;
        end;

        if chkORM.Checked then
        begin
          try
            StrtoFloat(grdLocs.Cells[7,lCount]);
          except
            MessageDlg('Invalid ORM Policy for '+grdLocs.Cells[0,lCount],mtError,[mbOK],0);
            Result := False;
            break;
          end;
        end;

      end
      else
      begin
        grdLocs.Rows[lCount].DelimitedText := '';
      end;

    end;

    if (Result) and (LocCount =0 ) then
    begin
      MessageDlg('Please select at least one location',mtError,[mbOK],0);
      Result := False;
    end;

  end;

end;

procedure TfrmMain.grdLocsClick(Sender: TObject);
begin
  EnableEdit;
end;

procedure TfrmMain.GroupBox1Click(Sender: TObject);
begin
  EnableEdit;
end;


procedure TfrmMain.StartProcess;
var
  RCount,LCount,SCount,LocNo,ErrCount:Integer;
  LT,RC,RP,TSL,SS,MOQ,ORM:Real;
  SayStr,ErrMsg,ExceptName,PutName:String;
  ExceptFile:TextFile;
begin

 try
  LoadParam;

  frmStatus.OpenLogFile;
  frmStatus.Show;
  Application.ProcessMessages;
  frmStatus.Say('Started at '+DateTimeToStr(Now));
  ErrMsg := '';
  ErrCount := 0;

  ExceptNAme := AnsiReplaceStr(UpperCase(FParamFile),'.DAT','_Except.csv');

  frmStatus.Say('Creating Exceptions : '+ExceptName);
  AssignFile(ExceptFile,ExceptName);
  Rewrite(ExceptFile);


  if chkResetTSL.Checked then
  begin
    frmStatus.Say('Resetting TSL ');
    ErrMsg := dmData.BuildStart(-1);  // Without template ... ALL items
    Application.ProcessMessages;

    if ErrMsg = '' then
    begin
      dmData.BuildBody(-1,0,0,0,0,0,0,0,True);  // All locations, no other policy and
                                          // RESET TSL = True.
      dmData.BuildEnd;
    end
    else
    begin
      inc(ErrCount);
      WriteLn(ExceptFile,ErrMsg);

    end;



    frmStatus.Say('.........Start SQL',False);
    for SCount := 0 to dmData.qryAlter.SQL.Count-1 do
      frmStatus.Say(dmData.qryAlter.SQL.Strings[sCount],False);

    frmStatus.Say('.........End SQL',False);

    if ErrMsg <> '' then
      frmStatus.Say('Cannot Execute - Error - '+ErrMsg)
    else
    begin
      frmStatus.Say('Executing....');

      dmData.ExecuteProcedure;
    end;


  end;


  for RCount:=1 to VleUpdates.RowCount-1 do
  begin
    //ACount:=0;
    frmStatus.Say('');
    frmStatus.Say('===========================================================================================');
    frmStatus.Say('ID :' + VleUpdates.cells[0,rCount] + ' - ' + VleUpdates.cells[1,rCount]);
    LoadSettings(StrToInt(VleUpdates.cells[0,rCount]));
    PutName := VleUpdates.cells[1,rCount];

    if edtTemplateNo.Text <> '' then
    begin
      frmStatus.Say('Building Proc ');
      frmStatus.Say(edtTemplateName.Text);
      ErrMsg := dmData.BuildStart(StrToInt(edtTemplateNo.Text));
      Application.ProcessMessages;

      for lCount := 1 to grdLocs.RowCount-1 do
      begin
        ErrMsg := dmData.BuildStart(StrToInt(edtTemplateNo.Text));

        if Trim(grdLocs.Cells[0,lCount]) <> '' then
        begin
          SayStr := 'Location: '+grdLocs.Cells[0,lCount];
          LT := -1;
          RC := -1;
          RP := -1;
          TSL := -1;
          SS := -1;
          MOQ := -1;
          ORM := -1;

          if chkLT.Checked  and (trim(grdLocs.Cells[1,lCount])<>'') then
          begin
            SayStr := SayStr + ' ,LT ='+grdLocs.Cells[1,lCount];
            LT := StrToFloat(grdLocs.Cells[1,lCount]);
          end;

          if chkRC.Checked  and (trim(grdLocs.Cells[2,lCount])<>'') then
          begin
            SayStr := SayStr + ' ,RC ='+grdLocs.Cells[2,lCount];
            RC := StrToFloat(grdLocs.Cells[2,lCount]);
          end;

          if chkRP.Checked  and (trim(grdLocs.Cells[3,lCount])<>'') then
          begin
            SayStr := SayStr + ' ,RP ='+grdLocs.Cells[3,lCount];
            RP := StrToFloat(grdLocs.Cells[3,lCount]);
          end;

          if chkTSL.Checked  and (trim(grdLocs.Cells[4,lCount])<>'') then
          begin
            SayStr := SayStr + ' ,TSL ='+grdLocs.Cells[4,lCount];
            TSL := StrToFloat(grdLocs.Cells[4,lCount]);
          end;

          if chkSS.Checked  and (trim(grdLocs.Cells[5,lCount])<>'') then
          begin
            SayStr := SayStr + ' ,SS ='+grdLocs.Cells[5,lCount];
            SS := StrToFloat(grdLocs.Cells[5,lCount]);
          end;

          if chkMOQ.Checked  and (trim(grdLocs.Cells[6,lCount])<>'') then
          begin
            SayStr := SayStr + ' ,MOQ ='+grdLocs.Cells[6,lCount];
            MOQ := StrToFloat(grdLocs.Cells[6,lCount]);
          end;

          if chkORM.Checked  and (trim(grdLocs.Cells[7,lCount])<>'') then
          begin
            SayStr := SayStr + ' ,ORM ='+grdLocs.Cells[7,lCount];
            ORM := StrToFloat(grdLocs.Cells[7,lCount]);
          end;

          frmStatus.Say(SayStr);
          LocNo := dmData.GetLocationNo(grdLocs.Cells[0,lCount]);
          if LocNo = 0 then
          begin
            ErrMsg := 'Location ' + grdLocs.Cells[0,lCount] + ' not found?';
          end;

          if ErrMsg = '' then
          begin
            dmData.BuildBody(LocNo,LT,RC,RP,TSL,SS,MOQ,ORM);

            try
              dmData.BuildEnd;

              frmStatus.Say('.........Start SQL',False);
              for SCount := 0 to dmData.qryAlter.SQL.Count-1 do
                frmStatus.Say(dmData.qryAlter.SQL.Strings[sCount],False);

              frmStatus.Say('.........End SQL',False);

              frmStatus.Say('Executing....');
              dmData.ExecuteProcedure;
            except
              on e: exception do
              begin
                frmStatus.Say('***  failed');
                frmStatus.Say('*** ' + e.Message);
                WriteLn(ExceptFile,'Error for '+edtDescription.Text);
                WriteLn(ExceptFile,e.Message);
                Inc(ErrCount);
              end;
            end;

          end
          else
          begin
            Inc(ErrCount);
            frmStatus.Say('*** Location: ' + grdLocs.Cells[0,lCount] + ' PUT Name: ' + PutName + ' - ' + ErrMsg);
            WriteLn(ExceptFile,'*** Location: ' + grdLocs.Cells[0,lCount] + ', PUT Name: '+PutName+',  Template:'+edtTemplateName.Text + ', - ' + ErrMsg);

          end;

          //Inc(ACount);
        end;

      end;


    end;

  end;

 frmStatus.Say('');
 CloseFile(ExceptFile);

 frmStatus.Say('Finshed at '+DateTimeToStr(Now));

  if ErrCount=0 then
  begin
    if FileExists(ExceptName) then
    begin
      DeleteFile(ExceptName);
    end;
  end
  else
    frmStatus.Say(' ******** ERRORS have occured . Please Review !!! ********');


  if not FScheduleRun then
  begin

    if FileExists(ExceptName) then
    begin
      MessageDlg('Errors occured, please check '+ExceptName,mtError,[mbOK],0);
    end
    else
      MessageDlg('Complete',mtInformation,[mbOK],0);


  end;


  if FScheduleRun then
    dmData.FireEvent('S');

  dmData.dbOptimiza.Close;

 except
    on e: exception do
    begin
      frmStatus.Say('***  failed');
      frmStatus.Say('*** ' + e.Message);

      if FScheduleRun then
        dmData.FireEvent('F');

      if not FScheduleRun then
        MessageDlg('Error',mtError,[mbOK],0);
    end;

 end;

 frmStatus.CloseLogFile;
 frmStatus.Close;

end;

procedure TfrmMain.btnRunClick(Sender: TObject);
begin
  SaveFiles;  //Save pending updates
  StartProcess;
end;

procedure TfrmMain.SaveFiles;
begin
  vleUpdates.Strings.SaveToFile(FParamFile);
  vleParameters.Strings.SaveToFile(FControlFile);
end;

procedure TfrmMain.edtDescriptionClick(Sender: TObject);
begin
  EnableEdit;
end;

procedure TfrmMain.vleUpdatesClick(Sender: TObject);
begin
  LoadSettings(StrToInt(VleUpdates.cells[0,VleUpdates.row]));
end;

function TfrmMain.GetUniqueName:String;
var
  FName:String;
  FCount:Integer;
begin

  FUpdateNo := -1;
  Result := '';

  for FCount := 1 to 1000 do
  begin

    FName := AnsiReplaceStr(FParamFile,'.','_'+IntToStr(FCount)+'.');

    If not FileExists(FName) then
    begin
      FUpdateNo := FCount;
      Result := FName;
      Break;
    end;

  end;


end;

procedure TfrmMain.btnCopyToClick(Sender: TObject);
var
  NewName,TempName:String;
begin
  NewName := InputBox('Copy From '+VleUpdates.cells[1,VleUpdates.Row],'New Name','');

  if NewName <> '' then
  begin
    TempName := FSettingsName;
    FSettingsName := GetUniqueName;

    if CopyFileTo(TempName,FSettingsName) then
    begin

      vleUpdates.InsertRow(IntToStr(FUpdateNo),NewName,True);

      SaveFiles;
      vleUpdates.Row := vleUpdates.RowCount-1;
      vleUpdates.SetFocus;

      btnEdit.Click;
      edtDescription.Text := vleUpdates.Cells[1,vleUpdates.row];
    end;

  end
  else
    MessageDlg('Invalid Description',mtError,[mbOK],0);

end;



procedure TfrmMain.CopyALLpolicytoAllLocations1Click(Sender: TObject);
begin
  CopyPolicy(ptAll);
end;

procedure TfrmMain.CopyPolicy(PolicyType: TPolicyType);
var
  MsgStr:String;
  LT,RC,RP,TSL,SS,MOQ,ORM:String;
  lCount:Integer;
begin

  EnableEdit;

  if grdLocs.Cells[0,grdLocs.Row] <> '' then
  begin

    LT :='-1';
    RC :='-1';
    RP :='-1';
    TSL := '-1';
    SS := '-1';
    MOQ := '-1';
    ORM := '-1';

    MsgStr := '';

    if (chkLT.Checked) and (PolicyType in [ptLeadTime,ptAll]) then
    begin
      LT := grdLocs.Cells[1,grdLocs.Row];
      if LT <> '' then
        MsgStr := 'LT: '+LT+',';
    end;

    if (chkRC.Checked) and (PolicyType in [ptReplenishmentCycle,ptAll]) then
    begin
      RC := grdLocs.Cells[2,grdLocs.Row];
      if RC <> '' then
        MsgStr := MsgStr +'RC: '+RC+',';
    end;

    if (chkRP.Checked) and (PolicyType in [ptReviewPeriod,ptAll]) then
    begin
      RP := grdLocs.Cells[3,grdLocs.Row];
      if RP <> '' then
        MsgStr := MsgStr +'RP: '+RP+',';
    end;

    if (chkTSL.Checked) and (PolicyType in [ptServiceLevel,ptAll]) then
    begin
      TSL := grdLocs.Cells[4,grdLocs.Row];
      if TSL <> '' then
        MsgStr := MsgStr +'TSL: '+TSL+',';
    end;

    if (chkSS.Checked) and (PolicyType in [ptSafetyStock,ptAll]) then
    begin
      SS := grdLocs.Cells[5,grdLocs.Row];
      if SS <> '' then
        MsgStr := MsgStr +'SS: '+SS+',';
    end;

    if (chkMOQ.Checked) and (PolicyType in [ptMinimumOrderQuantity,ptAll]) then
    begin
      MOQ := grdLocs.Cells[6,grdLocs.Row];
      if MOQ <> '' then
        MsgStr := MsgStr +'MOQ: '+MOQ+',';
    end;

    if (chkORM.Checked) and (PolicyType in [ptOrderMultiples,ptAll]) then
    begin
      ORM := grdLocs.Cells[7,grdLocs.Row];
      if ORM <> '' then
        MsgStr := MsgStr +'ORM: '+ORM+',';
    end;

    MsgStr := Copy(MsgStr,1,Length(MsgStr)-1); //remove last comma

    if Trim(MsgStr) = '' then
      MessageDlg('Nothing to copy.',mtError,[mbOK],0)
    else
    begin
      if MessageDlg('Copy '+#10+ mSGsTR+ #10+'to ALL locations',mtConfirmation,[mbYes,mbNo],0) = mrYes then
      begin

        for lCount:=1 to grdLocs.RowCount-1 do
        begin

          if grdLocs.Cells[0,lCount] <> '' then
          begin

            if LT <> '-1' then
              grdLocs.Cells[1,lCount] := LT;
            if RC <> '-1' then
              grdLocs.Cells[2,lCount] := RC;
            if RP <> '-1' then
              grdLocs.Cells[3,lCount] := RP;
            if TSL <> '-1' then
              grdLocs.Cells[4,lCount] := TSL;
            if SS <> '-1' then
              grdLocs.Cells[5,lCount] := SS;
            if MOQ <> '-1' then
              grdLocs.Cells[6,lCount] := MOQ;
            if ORM <> '-1' then
              grdLocs.Cells[7,lCount] := ORM;

          end;

        end;

      end;
    end;

  end
  else
    MessageDlg('Please select a valid location and try again.',mtError,[mbOK],0);

end;

procedure TfrmMain.CopyLTtoAllLocations1Click(Sender: TObject);
begin
CopyPolicy(ptLeadTime);
end;

procedure TfrmMain.CopyRCtoAllLocations1Click(Sender: TObject);
begin
CopyPolicy(ptReplenishmentCycle);
end;

procedure TfrmMain.CopyRPtoAllLocations1Click(Sender: TObject);
begin
CopyPolicy(ptReviewPeriod);
end;

procedure TfrmMain.CopyTSLtoAllLocations1Click(Sender: TObject);
begin
CopyPolicy(ptServiceLevel);
end;

procedure TfrmMain.CopySStoAllLocations1Click(Sender: TObject);
begin
 CopyPolicy(ptSafetyStock);
end;

procedure TfrmMain.chkSSEnter(Sender: TObject);
begin
 EnableEdit;
end;

procedure TfrmMain.chkRPEnter(Sender: TObject);
begin
EnableEdit;
end;

procedure TfrmMain.chkTSLEnter(Sender: TObject);
begin
EnableEdit;
end;

procedure TfrmMain.chkRCEnter(Sender: TObject);
begin
EnableEdit;
end;

procedure TfrmMain.chkLTEnter(Sender: TObject);
begin
    EnableEdit;
end;

procedure TfrmMain.SetLocalAdminNo;
begin
  FLocalAdminNo := dmData.GetLocalAdminNo;

  if FLocalAdminNo < 0 then
  begin
    MessageDlg('Please use Optimiza to setup a LOCALADMIN account,'+#10+
                'then setup valid policy templates.'+#10+
                'Re-load this application for them to refresh.',mtWarning,[mbOK],0);
  end;

end;

procedure TfrmMain.btnMoveUpClick(Sender: TObject);
var FromRow,ToRow:Integer;
begin
  FromRow := vleUpdates.Row-1;

  ToRow := FromRow -1;

  if ToRow >= 0 then
  begin
    vleUpdates.Strings.Move(FromRow,ToRow);
    vleUpdates.Row := ToRow+1;
  end
  else
    MessageDlg('Cannot move current row up',mtError,[mbOK],0);


end;

procedure TfrmMain.btnMoveDownClick(Sender: TObject);
var FromRow,ToRow:Integer;
begin
  FromRow := vleUpdates.Row-1;

  ToRow := FromRow +1;

  if ToRow < vleUpdates.RowCount-1 then
  begin
    vleUpdates.Strings.Move(FromRow,ToRow);
    vleUpdates.Row := ToRow+1;
  end
  else
    MessageDlg('Cannot move current row down',mtError,[mbOK],0);


end;

procedure TfrmMain.chkMOQEnter(Sender: TObject);
begin
  enableEdit;
end;

procedure TfrmMain.chkORMEnter(Sender: TObject);
begin
  enableEdit;
end;

end.


