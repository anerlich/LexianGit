unit uExportUsers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,StrUtils;

type
  TfrmExportUsers = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    edtUserFrom: TEdit;
    Button1: TButton;
    edtUserFromNo: TEdit;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    Edit1: TEdit;
    BitBtn3: TBitBtn;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
   function ValidFromUser(UserNo: String): Boolean;
  public
    { Public declarations }
  end;

var
  frmExportUsers: TfrmExportUsers;

implementation

uses udmData, uSelectUser;

{$R *.dfm}

procedure TfrmExportUsers.Button1Click(Sender: TObject);
begin

  frmSelectUser.MultiSelectOn(False);

  if frmSelectUser.ShowModal = mrOK then
  begin

    if ValidFromUser(dmData.qryUser.fieldByName('UserNo').AsString) then
    begin
      edtUserFrom.Text := dmData.qryUser.fieldByName('UserName').AsString;
      edtUserFromNo.Text := dmData.qryUser.fieldByName('UserNo').AsString;
    end;

  end;

end;
function TfrmExportUsers.ValidFromUser(UserNo: String): Boolean;
begin
  Result := True;



end;


procedure TfrmExportUsers.BitBtn3Click(Sender: TObject);
begin

  if SaveDialog1.Execute then
  begin
    Edit1.Text := SaveDialog1.FileName;
    Application.ProcessMessages;
    BitBtn1Click(Nil);
  end;

end;

procedure TfrmExportUsers.BitBtn1Click(Sender: TObject);
var
  CanContinue,OverWrite:Boolean;
  CsvFile: TextFile;
  aString:String;
  Save_Cursor:TCursor;
  AccessLevel:Integer;
  AccessLevels:Array[1..3] of String;
begin
  CanContinue := True;

  if Edit1.Text = '' then
  begin
    MessageDlg('Please Select an Output CSV File',mtError,[MBOK],0);
    CanContinue := False;
  end;


  if CanContinue then
  begin
    OverWrite := True;

    if FileExists(Edit1.Text) then
    begin
      if MessageDlg(Edit1.Text+#10+'exists. Overwrite ? ',mtWarning,[mbYes,mbNo],0) = mrNo then
        Overwrite := False;
    end;

    if OverWrite then
    begin
      Save_Cursor := Screen.Cursor;

      dmData.OpenUserList;

      Screen.Cursor := crHourGlass;    { Show hourglass cursor }

      AccessLevels[1] := 'Administrator';
      AccessLevels[2] := 'Inventory Manager';
      AccessLevels[3] := 'Inventory Controller';


      try

        AssignFile(CsvFile, Edit1.Text);
        Rewrite(CsvFile);

        with dmData.qryUserList do
        begin
          First;
          aString := 'User Name,';
          aString := aString+ 'Email,';
          aString := aString+ 'Default Location,';
          aString := aString+ 'Access Level,';
          aString := aString+ 'Can Create Templates';


          Writeln(CsvFile,aString);

          while not dmData.qryUserList.Eof do
          begin
            aString := FieldByName('UserName').asString + ',';
            aString := aString+ FieldByName('EmailAdd_1').asString+',';
            aString := aString+ ' ' + FieldByName('DefaultLocation').asString+',';

            AccessLevel := FieldByName('AccessLevel').AsInteger;
            aString := aString+ AccessLevels[AccessLevel]+',';

            aString := aString+  FieldByName('CanCreateTemplates').asString;


            Writeln(CsvFile,aString);

            next;
          end;


          Close;
        end;


        CloseFile(CsvFile);
        dmData.qryUserList.Close;
        
      finally
        Screen.Cursor := Save_Cursor;  { Always restore to normal }
      end;

      MessageDlg(Edit1.Text+#10+'Saved !',mtInformation,[mbOK],0);

    end;



  end;


end;

end.
