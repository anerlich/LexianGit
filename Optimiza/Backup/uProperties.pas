unit uProperties;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ComCtrls;

type
  TfrmProperties = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    edtName: TEdit;
    Label1: TLabel;
    edtBackupPath: TEdit;
    Label3: TLabel;
    edtDatabase: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    edtGbak: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    opnBrowse: TOpenDialog;
    GroupBox1: TGroupBox;
    grpAddtional: TGroupBox;
    ListBox1: TListBox;
    btnAdd: TBitBtn;
    btnRemove: TBitBtn;
    Label6: TLabel;
    edtZip: TEdit;
    Button4: TButton;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    edtRoll: TMaskEdit;
    UpDown1: TUpDown;
    Label8: TLabel;
    edtFileName: TEdit;
    lblSample: TLabel;
    Label9: TLabel;
    btnVerify: TBitBtn;
    Button5: TButton;
    chkZIP: TCheckBox;
    procedure BitBtn2Click(Sender: TObject);
    procedure edtFileNameChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure edtDatabaseExit(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure btnVerifyClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure edtZipExit(Sender: TObject);
    procedure chkZIPClick(Sender: TObject);
  private
    { Private declarations }
    
  public
    { Public declarations }
    function GetFileName(FileName:String;ShortName: Boolean):String;

  end;

var
  frmProperties: TfrmProperties;

implementation

uses uFolderSelect, uZipFile;

{$R *.DFM}

procedure TfrmProperties.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmProperties.edtFileNameChange(Sender: TObject);
begin


  lblSample.Caption := edtFileName.Text + '_1';
end;

procedure TfrmProperties.FormShow(Sender: TObject);
begin
  if edtFileName.Text <> '' then
    lblSample.Caption := edtFileName.Text + '_1';

end;

procedure TfrmProperties.Button1Click(Sender: TObject);
begin
  opnBrowse.Filter := 'Interbase files (*.gdb)|*.GDB' ;

  if edtDatabase.Text <> '' then
  begin
    opnBrowse.InitialDir :=  ExtractFilePath(edtDatabase.Text);
  end;

  if opnBrowse.Execute then
  begin
    edtDatabase.Text := opnBrowse.FileName;

    if edtBackupPath.Text = '' then
    begin
      edtBackupPath.Text := edtDatabase.Text;
      edtBackupPath.Text := StringReplace(edtBackupPath.Text, '.gdb', '.gbk',[rfReplaceAll, rfIgnoreCase]);
    end;

  end;
end;

procedure TfrmProperties.Button3Click(Sender: TObject);
begin
  opnBrowse.Filter := 'Interbase backup utility (gbak.exe)|gbak.exe' ;

  if edtGbak.Text <> '' then
  begin
    opnBrowse.InitialDir :=  ExtractFilePath(edtGbak.Text);
  end;

  if opnBrowse.Execute then
  begin
    edtGbak.Text := opnBrowse.FileName;
  end;

end;

procedure TfrmProperties.Button4Click(Sender: TObject);
begin
  opnBrowse.Filter := 'Winzip command line utility(wzzip.exe)|wzzip.exe|PkZip utility (pkzip.exe)|PkZip.exe' ;
  if edtZip.Text <> '' then
  begin
    opnBrowse.InitialDir :=  ExtractFilePath(edtZip.Text);
  end;

  if opnBrowse.Execute then
  begin
    edtZip.Text := opnBrowse.FileName;
  end;

end;

procedure TfrmProperties.Button2Click(Sender: TObject);
begin

  if edtBackupPath.text <> '' then
  begin
    frmFolder.DirectoryListBox1.Directory := ExtractFilePath(edtBackupPath.text);
    frmFolder.Edit1.Text := ExtractFileName(edtBackupPath.text);
  end;

  if frmFolder.ShowModal = mrOk then
  begin
    edtBackupPath.text := frmFolder.DirectoryListBox1.Directory+ '\'+frmFolder.Edit1.Text;
  end;

end;

procedure TfrmProperties.edtDatabaseExit(Sender: TObject);
begin
    if edtBackupPath.Text = '' then
    begin
      edtBackupPath.Text := edtDatabase.Text;
      edtBackupPath.Text := StringReplace(edtBackupPath.Text, '.gdb', '.gbk',[rfReplaceAll, rfIgnoreCase]);
    end;

end;

procedure TfrmProperties.Button5Click(Sender: TObject);
begin
  if edtFileName.text <> '' then
  begin
    frmFolder.DirectoryListBox1.Directory := ExtractFilePath(edtFileName.text);
    frmFolder.Edit1.Text := ExtractFileName(edtFileName.text);
  end;


  if frmFolder.ShowModal = mrOk then
  begin
    edtFileName.text := frmFolder.DirectoryListBox1.Directory + '\'+frmFolder.Edit1.Text;
  end;

end;

procedure TfrmProperties.btnVerifyClick(Sender: TObject);
var
  WarningOccurred: Boolean;
  FileHandle, i: Integer;
  ZipText, FileName: String;
begin
  WarningOccurred := False;

  if edtName.Text = '' then
  begin
    MessageDlg('Invalid Backup Set Name!',mtWarning,[mbOK],0);
    WarningOccurred := True;
  end;

  if not FileExists(edtDatabase.Text) then
  begin
    MessageDlg(edtDatabase.text+#10+'Invalid database or file not found!',mtWarning,[mbOK],0);
    WarningOccurred := True;
  end;

  if edtDatabase.Text = edtBackupPath.Text then
  begin
    MessageDlg('Database File Name and Backup File Name cannot be the same!',mtWarning,[mbOK],0);
    WarningOccurred := True;
  end;

  if edtBackupPath.Text = '' then
  begin
    MessageDlg('Invalid Backup File Name!',mtWarning,[mbOK],0);
    WarningOccurred := True;
  end
  else
    if not FileExists(edtBackupPath.Text) then
    begin
      FileHandle := FileCreate(edtBackupPath.text);
      If FileHandle = -1 then
      begin
        MessageDlg('Invalid backup file name!'+#10+'Check File and Path Name',mtWarning,[mbOK],0);
        WarningOccurred := True;
      end
      else
        FileClose(FileHandle);


    end;

  if not FileExists(edtGBak.Text) then
  begin
    MessageDlg(edtGBak.text+#10+'Invalid gbak.exe or file not found!',mtWarning,[mbOK],0);
    WarningOccurred := True;
  end;

  if chkZip.Checked then
  begin

    if not FileExists(edtZip.Text) then
    begin
      MessageDlg(edtZip.text+#10+'Invalid Zip Utility or file not found!',mtWarning,[mbOK],0);
      WarningOccurred := True;
    end;

    if edtFileName.Text = '' then
    begin
      MessageDlg('Invalid Zip File Name!',mtWarning,[mbOK],0);
      WarningOccurred := True;
    end
    else
      if not FileExists(edtFileName.Text) then
      begin
        FileHandle := FileCreate(edtFileName.text);
        If FileHandle = -1 then
        begin
          MessageDlg('Invalid ZIP file name!'+#10+'Check File and Path Name',mtWarning,[mbOK],0);
          WarningOccurred := True;
        end
        else
          FileClose(FileHandle);


      end;

      if ListBox1.Items.Count > 20 then
      begin
        MessageDlg('This utility only allows 20 addtional files to be included in the ZIP'+
                   #10+'Please remove some files!',mtError,[mbOK],0);
          WarningOccurred := True;
      end;

      if Pos('PKZIP',Uppercase(edtZip.Text)) > 0 then
      begin

        ZipText := '';

        if frmProperties.CheckBox1.Checked then
          ZipText := '-rp';

        ZipText := '"'+edtZip.Text + '" ' + ZipText;
        ZipText := ZipText + ' "'+GetFileName(edtFileName.Text,True)+'_1"';
        ZipText := Ziptext + ' "'+GetFileName(edtBackupPath.Text,True) +'"';

        For i := 1 to 20 do
        begin
          FileName := '';

          if ListBox1.Items.Count >= i then
            FileName := ListBox1.Items.Strings[i-1];

          if FileName <> '' then
          begin
            ZipText := Ziptext + ' "'+ GetFileName(FileName,True) +'"';
          end;

        end; // end for

        if Length(ZipText) > 150 then
        begin
              MessageDlg(ZipText+#10#10+'PkZip does not support a command line longer than 150 characters.'+
                   #10+'Please remove some of the additional files!',mtError,[mbOK],0);
              WarningOccurred := True;
        end;


      end;

  end; //if chkZip checked
  

  if not WarningOccurred then
    MessageDlg('All options appear to be set correctly!',mtInformation,[mbOK],0);


end;

procedure TfrmProperties.btnRemoveClick(Sender: TObject);
var
  i: Integer;
begin
  for i := (ListBox1.Items.Count - 1) downto 0 do begin
    if ListBox1.Selected[i] then
    begin
      ListBox1.Items.Delete(i);
    end;
  end;

end;

procedure TfrmProperties.btnAddClick(Sender: TObject);
var
  i, ItemsAdded: Integer;
  FullName, PathName: String;

begin
  if frmZipFile.ShowModal = mrOK then
  begin
    ItemsAdded := 0;
    PathName :=   frmZipFile.DirectoryListBox1.Directory+'\';

    for i := (frmZipFile.FileListBox1.Items.Count - 1) downto 0 do begin
    if frmZipFile.FileListBox1.Selected[i] then
    begin
      Inc(ItemsAdded);
      FullName := PathName+frmZipFile.FileListBox1.Items.Strings[i];
      ListBox1.Items.Add(FullName);
    end;
    end;

    If ItemsAdded = 0 then
      ListBox1.Items.Add(PathName+frmZipFile.Edit1.Text);

    if ListBox1.Items.Count > 20 then
      MessageDlg('This utility only allows 20 addtional files to be included in the ZIP'+
                 #10+'Please remove some files!',mtError,[mbOK],0);
  end;
end;

procedure TfrmProperties.edtZipExit(Sender: TObject);
begin
  if pos('PKZIP',UpperCase(edtZip.text))>0 then
    MessageDlg('PkZip does not support long file names'+
               #10+'and only supports a limited command line string.'+
               #10+'This utility will still work but file names will be stored in 8.3 format',mtWarning,[mbOk],0);

end;
function TfrmProperties.GetFileName(FileName:String;ShortName: Boolean):String;
var
  NewName, TempName: String;

begin

  if ShortName then
  begin

    //function ExtractShortPathName does not support a wildcard
    //  as the file name, so we handle ourselves.
    if (pos('*',FileName) > 0) or (pos('?',FileName) > 0) then
    begin
      NewName := ExtractFilePath(FileName);
      TempName := ExtractFileName(FileName);
      NewName := ExtractShortPathName(NewName+'temp.txt');
      NewName := ExtractFilePath(NewName) + TempName;
    end
    else
    begin
      NewName := ExtractShortPathName(FileName);
    end;

    Result := NewName;
  end
  else
    Result := FileName;

end;

procedure TfrmProperties.chkZIPClick(Sender: TObject);
begin
  edtZip.Enabled := chkZip.Checked;
  edtFileName.Enabled:=chkZip.Checked;
  ListBox1.Enabled := chkZip.Checked;
  edtRoll.Enabled := chkZip.Checked;
  CheckBox1.Enabled := chkZip.Checked;
  btnAdd.Enabled := chkZip.Checked;
  btnRemove.Enabled := chkZip.Checked;
end;

end.
