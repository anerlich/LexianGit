unit uMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Grids, Menus, ImgList, iniFiles, ComCtrls,clipbrd;

type
  TfrmMain = class(TForm)
    pnlBottom: TPanel;
    pnlTop: TPanel;
    lstSet: TListBox;
    btnEdit: TBitBtn;
    btnAdd: TBitBtn;
    btnDelete: TBitBtn;
    mnuMain: TMainMenu;
    File1: TMenuItem;
    mnuEdit1: TMenuItem;
    Tools1: TMenuItem;
    Help1: TMenuItem;
    Exit1: TMenuItem;
    mnuAddRecord: TMenuItem;
    mnuDeleteRecord: TMenuItem;
    mnuEditRecord: TMenuItem;
    mnuDefaults: TMenuItem;
    RunBackup1: TMenuItem;
    About1: TMenuItem;
    imgButtons: TImageList;
    N1: TMenuItem;
    Label1: TLabel;
    btnCopy: TBitBtn;
    btnRename: TBitBtn;
    N2: TMenuItem;
    Copy1: TMenuItem;
    Rename1: TMenuItem;
    Edit1: TEdit;
    StatusBar1: TStatusBar;
    btnCancel: TBitBtn;
    btnOK: TBitBtn;
    btnRun: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure mnuDefaultsClick(Sender: TObject);
    procedure btnRenameClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Rename1Click(Sender: TObject);
    procedure mnuAddRecordClick(Sender: TObject);
    procedure mnuDeleteRecordClick(Sender: TObject);
    procedure mnuEditRecordClick(Sender: TObject);
    procedure btnRunClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOKClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
  private
    { Private declarations }
    function SaveData:Boolean;
    procedure LoadData(SetName: String);
    function Exist(SetName: String):Boolean;
    procedure CopyRename(OpType:Char);
    function Rungbak(setName: String):Boolean;
    function RunZip(setName: String):Boolean;
    function RunCommand(Title: String): Boolean;
    function CheckResult(LogFileName:String):Boolean;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  FirstShow: Boolean;
  SetFile: Tinifile;

implementation

uses uProperties, uExist, uStatus, uDmOptimiza, uAbout;

{$R *.DFM}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Firstshow := True;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  SetFileName: String;
  FileHandle: Integer;

begin

  if FirstShow then
  begin
    SetFileName := ExtractFilePath(ParamStr(0))+'BackupSets.txt';

    //if it doesn't exist first create
    if not FileExists(SetFileName) then
    begin
      FileHandle := FileCreate(SetFileName);
      FileClose(FileHandle);
    end;

    SetFile := TIniFile.Create(SetFileName);

    setFile.ReadSections(lstSet.Items);

    StatusBar1.Panels[1].Text := dmOptimiza.dbOptimiza.DatabaseName;

    FirstShow := False;

    if lstSet.Items.Count > 0 then
    begin
      lstSet.ItemIndex := 0;
      lstSet.Selected[0]:= True;

    end;

    btnOK.SetFocus;

    if ParamCount > 0 then
    begin

      if FindCmdLineSwitch('z',['-'],True) then
      begin
        btnRun.Visible := False;
        RunBackup1.Enabled := False;
      end
      else
      begin
        btnRunClick(Sender);
        Close;
      end;

    end;


  end;

end;

procedure TfrmMain.btnEditClick(Sender: TObject);
var
  i: Integer;
  SetName: String;
begin

  SetName := '';

  for i := 0 to (lstSet.Items.Count - 1) do
  if lstSet.Selected[i] then
  begin
    setName := lstSet.Items.Strings[i];
    break;
  end;

  if SetName <> '' then
  begin
    frmProperties.edtName.Enabled := False;
    LoadData(setName);

    if frmProperties.ShowModal = mrOK then
    begin
      SaveData;
    end;

  end;

  if (SetName = '') then
  begin
    MessageDlg('Please Select a Record.',mtInformation,[mbOK],0);
  end;

end;

function TfrmMain.SaveData:Boolean;
var
  YesNo, FileName,SetName: String;
  i: Integer;
begin
  SetName :=frmProperties.edtName.Text;
  if SetName = '' then
  begin
    MessageDlg('The Backup Set Name cannot be blank. Please enter again.',mtError,[mbOK],0);
    Result := False;
  end
  else
  begin
    setFile.WriteString(SetName,'DATABASE',frmProperties.edtDatabase.Text);
    setFile.WriteString(SetName,'BACKUP',frmProperties.edtBackupPath.Text);
    setFile.WriteString(SetName,'GBAK',frmProperties.edtGBak.Text);
    setFile.WriteString(SetName,'ZIP',frmProperties.edtZip.Text);
    setFile.WriteString(SetName,'ZIPFILE',frmProperties.edtFileName.Text);
    setFile.WriteString(SetName,'REQUIREDNO',frmProperties.edtRoll.Text);
    setFile.WriteString(SetName,'CURRENTNO','0');

    YesNo := 'Y';

    if not frmProperties.CheckBox1.Checked then
    begin
      YesNo := 'N';
    end;

    setFile.WriteString(SetName,'INCLUDE',YesNO);

    YesNo := 'Y';

    if not frmProperties.chkZip.Checked then
    begin
      YesNo := 'N';
    end;

    setFile.WriteString(SetName,'USEZIP',YesNO);

    For i := 1 to 20 do
    begin
      FileName := '';

      if frmProperties.ListBox1.Items.Count >= i then
        FileName :=frmProperties.ListBox1.Items.Strings[i-1];

      setFile.WriteString(SetName,'FILE'+IntToStr(i)+'',FileName);
    end; // end for

    Result := True;
  end;//end else

end;

procedure TfrmMain.btnAddClick(Sender: TObject);
var
  EndLoop: Boolean;
begin
  frmProperties.edtName.Enabled := True;
  LoadData('Default Set');
  frmProperties.edtName.Text := '';

  if frmProperties.ShowModal = mrOK then
  begin
    EndLoop := False;

    Repeat

      if Exist(frmProperties.edtName.Text) then
      begin
        frmExist.edtNew.Text := frmProperties.edtName.Text;
        frmExist.edtOld.Text := frmProperties.edtName.Text;

         frmExist.Panel1.Caption := 'This Backup Set already exists. Please use a different name.';
         frmExist.Caption :=   'Record Exists';
         if frmExist.ShowModal = mrOK then
           frmProperties.edtName.Text := frmExist.edtNew.Text
         else
           EndLoop := True;

      end
      else
      begin

        if SaveData then
        begin
          lstSet.Items.Add(frmProperties.edtName.Text);
        end;

        EndLoop := True;

      end;

    until EndLoop;

  end;

end;

procedure TfrmMain.btnDeleteClick(Sender: TObject);
var
  i, Recs: Integer;
begin
  Recs := 0;

  for i := (lstSet.Items.Count - 1) downto 0 do begin
    if lstSet.Selected[i] then
    begin
      Inc(Recs);
    end;
  end;

  if Recs > 0 then
  begin
    if MessageDlg('Delete Selected Records ?',mtInformation,[mbYes,mbNo],0) = mrYes Then
    begin
      for i := (lstSet.Items.Count - 1) downto 0 do begin
        if lstSet.Selected[i] then
        begin
          SetFile.EraseSection(lstSet.Items.Strings[i]);
          lstSet.Items.Delete(i);
        end;
      end;
    end;
  end
  else
    MessageDlg('No Records Selected for Delete !',mtWarning,[mbOK],0);

end;

procedure TfrmMain.LoadData(SetName: String);
var
  i: Integer;
  FileName: String;
begin
    frmProperties.edtName.Text := SetName;
    frmProperties.edtDatabase.Text := setFile.ReadString(SetName,'DATABASE','');
    frmProperties.edtDatabase.Text := setFile.ReadString(SetName,'DATABASE','');
    frmProperties.edtBackupPath.Text := setFile.ReadString(SetName,'BACKUP','');
    frmProperties.edtGbak.Text:= setFile.ReadString(SetName,'GBAK','');
    frmProperties.edtZip.Text:= setFile.ReadString(SetName,'ZIP','');
    frmProperties.edtFileName.Text:= setFile.ReadString(SetName,'ZIPFILE','');
    frmProperties.edtRoll.Text:= setFile.ReadString(SetName,'REQUIREDNO','');
    frmProperties.CheckBox1.Checked:= (setFile.ReadString(SetName,'INCLUDE','Y')='Y');
    frmProperties.chkZip.Checked:= (setFile.ReadString(SetName,'USEZIP','Y')='Y');

    frmProperties.ListBox1.Items.Clear;

    For i := 1 to 20 do
    begin

      FileName := setFile.ReadString(SetName,'FILE'+IntToStr(i),'');

      if FileName <> '' then
        frmProperties.ListBox1.Items.Add(FileName);

    end;

end;

procedure TfrmMain.mnuDefaultsClick(Sender: TObject);
begin
    frmProperties.edtName.Enabled := False;
    LoadData('Default Set');

    if not Exist('Default Set') then
    begin
      frmProperties.edtRoll.Text := '1';
      frmProperties.Checkbox1.Checked := True;
    end;

    if frmProperties.ShowModal = mrOK then
    begin
      SaveData;
      if not Exist('Default Set') then
      begin
        lstSet.Items.Add(frmProperties.edtName.Text);
      end;

    end;

end;

function TfrmMain.Exist(SetName: String):Boolean;
var
  i: Integer;
begin
  Result := False;

  For i := 0 to lstset.Items.Count -1 do
  begin
    if lstSet.Items.Strings[i] = setName then
    begin
      Result := True;
      Break;
    end;

  end;
end;

procedure TfrmMain.btnRenameClick(Sender: TObject);

begin
  CopyRename('R');

end;

procedure TfrmMain.CopyRename(OpType:Char);
var
  setName : String;
  i: Integer;
  EndLoop: Boolean;

begin

  SetName := '';

  for i := (lstSet.Items.Count - 1) downto 0 do begin
    if lstSet.Selected[i] then
    begin
      SetName := lstSet.Items.Strings[i];
      Break;
    end;
  end;

  if (SetName = '') then
  begin
    MessageDlg('Please Select a Record.',mtInformation,[mbOK],0);
    Exit;
  end;

  if (OpType = 'R') and (SetName = 'Default Set') then
  begin
    MessageDlg('Cannot rename the Default.',mtError,[mbOK],0);
    Exit;
  end;

  if (SetName <> '') then
  begin

    frmExist.edtNew.Text := setName;
    frmExist.edtOld.Text := setName;
    frmExist.Panel1.Caption := 'Enter the new name for this Backup Set.';

    if OpType = 'C' then
      frmExist.Caption :=   'Copy Backup Set'
    else
      frmExist.Caption :=   'Rename Backup Set';

    EndLoop := False;

    Repeat

      if frmExist.ShowModal = mrOK then
      begin

        if frmExist.edtNew.Text = '' then
          MessageDlg('New Name Cannot be blank.',mtError,[mbOK],0)
        else
        begin

          if frmExist.edtNew.Text <> frmExist.edtOld.Text then
          begin

            if Exist(frmExist.edtNew.Text) then
              MessageDlg('Already Exists. Choose a different name',mtError,[mbOK],0)
            else
            begin
              LoadData(frmExist.edtOld.Text);
              frmProperties.edtName.Text := frmExist.edtNew.Text;

              if SaveData then
              begin

                if OpType <> 'C' then
                begin
                  setFile.EraseSection(frmExist.edtOld.Text);
                  lstSet.Items.Strings[i] :=  frmExist.edtNew.Text;
                end
                else
                begin
                  lstSet.Items.Add(frmExist.edtNew.Text);
                end; //end if OpType

              end; // end if SaveData

              EndLoop := True;
            end; //end if Exist

          end
          else
          begin
            EndLoop := True; //Names the same so exit
          end; //end New <> OLD

        end;

      end
      else
        EndLoop := True;   //Cancel button

    until EndLoop;

  end;

end;

procedure TfrmMain.btnCopyClick(Sender: TObject);
begin
  CopyRename('C');
end;

procedure TfrmMain.Copy1Click(Sender: TObject);
begin
CopyRename('C');
end;

procedure TfrmMain.Rename1Click(Sender: TObject);
begin
CopyRename('R');
end;

procedure TfrmMain.mnuAddRecordClick(Sender: TObject);
begin
btnAddClick(Sender);
end;

procedure TfrmMain.mnuDeleteRecordClick(Sender: TObject);
begin
btnDeleteClick(Sender);
end;

procedure TfrmMain.mnuEditRecordClick(Sender: TObject);
begin
btnEditClick(Sender);
end;

procedure TfrmMain.btnRunClick(Sender: TObject);
var
  i: Integer;
  SetName: String;
  ErrorOccurred: Boolean;
begin
  ErrorOccurred := False;
  frmStatus.Memo1.Lines.Clear;

  if ParamCount > 0 then
  begin
    SetName := ParamStr(1);

    if not Exist(SetName) then
    begin
      frmStatus.Memo1.Lines.Add('Backup set:'+SetName);
      SetName := '';
    end;

  end
  else
  begin
    SetName := '';

    for i := 0 to (lstSet.Items.Count - 1) do
    if lstSet.Selected[i] then
    begin
      setName := lstSet.Items.Strings[i];
      break;
    end;

  end;

  if (SetName = '') then
  begin
    frmStatus.Memo1.Lines.Add('Invalid backup set name. Please use a valid Backup set.');
    ErrorOccurred := True;
  end
  else
  begin

    if (ParamCount > 0) or (MessageDlg('Run Backup Set:'+#10+SetName,mtInformation,[mbYes,mbNo],0) = mrYes) then
    begin

      if Rungbak(SetName) then
      begin

        if frmProperties.chkZip.checked then
        begin
          if not RunZip(SetName) then
          begin
            ErrorOccurred := True;
          end;
        end;

      end
      else
      begin
        ErrorOccurred := True;

      end;

    end;

  end; //end if setname

  if ParamCount > 0 then
  begin

    try
      dmOptimiza.dbOptimiza.Connected := False;
      dmOptimiza.dbOptimiza.DatabaseName := frmProperties.edtDatabase.Text;
      StatusBar1.Panels[1].Text := frmProperties.edtDatabase.Text;
      dmOptimiza.dbOptimiza.Connected := True;

      if ErrorOccurred then
      begin
        dmOptimiza.FireEvent('F');
      end
      else
      begin
        dmOptimiza.FireEvent('S');
      end;

      dmOptimiza.dbOptimiza.Connected := False;

    except
      StatusBar1.Panels[1].Text := '';
    end;

  end;

  if ErrorOccurred then
  begin
    frmStatus.ShowModal;
  end
  else
  begin
    if ParamCount = 0 then
    begin
      MessageDlg(SetName+' Completed.',mtInformation,[mbOk],0);
    end;
  end;


end;

function TfrmMain.Rungbak(setName: String):Boolean;
var
  LogFileName: String;
begin

  Try
    LoadData(SetName);
    LogFileName := ExtractFilePath(frmProperties.edtBackupPath.Text)+SetName+'.log';
    Result := True;

    If FileExists(LogFileName) then
    begin

      if not DeleteFile(LogFileName) then
      begin

        Result := False;
      end;

    end;

    if Result then
    begin
      Edit1.Text := '"'+frmProperties.edtGbak.Text + '" -B -USER "SYSDBA" -PASSWORD "masterkey" -Y "'+LogFileName+'"';
      Edit1.Text := Edit1.text + ' "'+frmProperties.edtDatabase.Text +'"';
      Edit1.Text := Edit1.text + ' "'+frmProperties.edtBackupPath.Text +'"';

      if not RunCommand('Backup Set: '+SetName+', Running Database Backup(GBak.exe)') then
      begin
        Result := False;
      end
      else
      begin

        if not CheckResult(LogFileName) then
        begin
          Result := False;
        end;

      end;

    end;

  except
    Result := False;
  end;

end;

function TfrmMain.RunZip(setName: String):Boolean;
var
  SaveFolder, FileName: String;
  i, CurrentNo, RequiredNo: Integer;
  ShortName: Boolean;
begin
  Try
    Result := True;
    LoadData(SetName);
    SaveFolder := '';
    CurrentNo := StrToInt(setFile.ReadString(SetName,'CURRENTNO','1'));
    RequiredNo := StrToInt(setFile.ReadString(SetName,'REQUIREDNO','1'));

    Inc(CurrentNo);

    if CurrentNo > RequiredNo then
      CurrentNo := 1;

    ShortName := False;

    if Pos('PKZIP',UpperCase(frmProperties.edtZip.Text)) > 0 then
      ShortName := True;


    if frmProperties.CheckBox1.Checked then
      SaveFolder := '-rp';

    Edit1.Text := '"'+frmProperties.edtZip.Text + '" ' + SaveFolder;
    Edit1.Text := Edit1.text + ' "'+frmProperties.GetFileName(frmProperties.edtFileName.Text,ShortName)+'_'+IntToStr(CurrentNo) +'"';
    Edit1.Text := Edit1.text + ' "'+frmProperties.GetFileName(frmProperties.edtBackupPath.Text,ShortName) +'"';

    For i := 1 to 20 do
    begin
      FileName := '';

      if frmProperties.ListBox1.Items.Count >= i then
        FileName :=frmProperties.ListBox1.Items.Strings[i-1];

      if FileName <> '' then
      begin
        Edit1.Text := Edit1.text + ' "'+ frmProperties.GetFileName(FileName,ShortName) +'"';
      end;

    end; // end for

    frmStatus.Memo1.Lines.Add('Zip Started');

    if not RunCommand('Backup Set: '+SetName+', Running Zip Utitlity') then
    begin
      Result := False;
      frmStatus.Memo1.Lines.Add('...Zip Failed');
    end
    else
    begin
      setFile.WriteString(SetName,'CURRENTNO',IntToStr(CurrentNo));
    end;

  except
    Result := False;
    frmStatus.Memo1.Lines.Add('...Zip Failed');
  end;

end;

function TfrmMain.RunCommand(Title: String):Boolean;
var  SInfo: TStartupInfo;
     PInfo: TProcessInformation;
     VInfo: TOSVersionInfo;
begin

  Result := True;
  VInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(VInfo);

  //Windows NT Only !!!!
  //if VInfo.dwPlatformId =  VER_PLATFORM_WIN32_NT then begin
    SInfo.cb := sizeof(TStartupInFo);
    SInfo.lpReserved := Nil;
    SInfo.lpReserved2 := Nil;
    SInfo.lpDesktop := Nil;
    SInfo.dwFlags := 0;
    SInFo.lpTitle := PChar(Title);

    if CreateProcess( Nil,
               PChar(Edit1.text),
               Nil,
               Nil,
               True,
               NORMAL_PRIORITY_CLASS,
               Nil,
               Nil,
               SInfo,
               PInfo) then
    begin

      if WaitForSingleObject(PInfo.hProcess,INFINITE) = WAIT_FAILED then
        Result := False
      else
        Result := True;

    end
    else
    begin
      frmStatus.Memo1.Lines.Add('Cannot Execute '+Edit1.text);
        Result := False;
    end;


  //end;

end;

function TfrmMain.CheckResult(LogFileName:String):Boolean;
var
  LogFile: TextFile;
  DataRecord: String;

begin

  Result := True;

  try
    Assignfile(LogFile,LogFileName);
    Reset(LogFile);


    While not Eof(LogFile) do
    begin
      ReadLn(LogFile,DataRecord);
      if Pos('ERROR',UpperCase(DataRecord)) > 0 then
      begin
        Result := False;
        break;
      end;

    end;

    CloseFile(LogFile);

    if (Result = False) then
    begin
      frmStatus.Memo1.Lines.Clear;
      frmStatus.Memo1.Lines.LoadFromFile(LogFileName);
    end;

  except
    Result := False;
  end;


end;


procedure TfrmMain.Button1Click(Sender: TObject);
var
  i: Integer;
  Setname: String;
begin
    SetName := '';

    for i := 0 to (lstSet.Items.Count - 1) do
    if lstSet.Selected[i] then
    begin
      setName := lstSet.Items.Strings[i];
      break;
    end;

  Clipboard.AsText := 'Optimiza:"'+SetName+'"';

end;

procedure TfrmMain.btnCancelClick(Sender: TObject);
begin
  Close;
end;


procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SetFile.Free;
end;

procedure TfrmMain.btnOKClick(Sender: TObject);
var
  i: Integer;
  Setname: String;
begin

  if (ParamCount > 0) and (FindCmdLineSwitch('z',['-'],True)) then
  begin
    SetName := '';

    for i := 0 to (lstSet.Items.Count - 1) do
    if lstSet.Selected[i] then
    begin
      setName := lstSet.Items.Strings[i];
      break;
    end;

    Clipboard.AsText := 'Optimiza:"'+SetName+'"';
    
  end;

  Close;
end;

procedure TfrmMain.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.About1Click(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

end.
