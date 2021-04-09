unit uExportReportTemplate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,StrUtils;

type
  TfrmExportReportTemplate = class(TForm)
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
  frmExportReportTemplate: TfrmExportReportTemplate;

implementation

uses udmData, uSelectUser;

{$R *.dfm}

procedure TfrmExportReportTemplate.Button1Click(Sender: TObject);
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
function TfrmExportReportTemplate.ValidFromUser(UserNo: String): Boolean;
begin
  Result := True;



end;


procedure TfrmExportReportTemplate.BitBtn3Click(Sender: TObject);
begin

  if SaveDialog1.Execute then
  begin
    Edit1.Text := SaveDialog1.FileName;
    Application.ProcessMessages;
    BitBtn1Click(Nil);
  end;

end;

procedure TfrmExportReportTemplate.BitBtn1Click(Sender: TObject);
var
  CanContinue,OverWrite:Boolean;
  CsvFile: TextFile;
  aString:String;
  Save_Cursor:TCursor;

begin
  CanContinue := True;

  if Edit1.Text = '' then
  begin
    MessageDlg('Please Select an Output CSV File',mtError,[MBOK],0);
    CanContinue := False;
  end;

  if CanContinue then
  begin
    if CheckBox1.Checked then
      dmData.OpenReportTemplate(-1)
    else
    begin
      if edtUserFrom.Text = '' then
      begin
        MessageDlg('Please Select a User',mtError,[MBOK],0);
        CanContinue := False;
      end
      else
        dmData.OpenReportTemplate(StrToInt(edtUserFromNo.Text));

    end;
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

      Screen.Cursor := crHourGlass;    { Show hourglass cursor }

      try

        AssignFile(CsvFile, Edit1.Text);
        Rewrite(CsvFile);

        with dmData.qryReportTemplate do
        begin
          First;
          aString := 'Report Name,';
          aString := aString+ 'Report Template Name,';
          aString := aString+ 'User Name,';
          aString := aString+ 'User Template Name';


          Writeln(CsvFile,aString);

          while not dmData.qryReportTemplate.Eof do
          begin
            aString := FieldByName('Description').asString + ',';
            aString := aString+ AnsiReplaceStr(FieldByName('RepTEmplateDescr').asString,',',' ')+',';
            aString := aString+ FieldByName('UserName').asString+',';
            aString := aString+ AnsiReplaceStr(FieldByName('TEmplateDescr').asString,',',' ');


            Writeln(CsvFile,aString);

            next;
          end;


          Close;
        end;


        CloseFile(CsvFile);

      finally
        Screen.Cursor := Save_Cursor;  { Always restore to normal }
      end;

      MessageDlg(Edit1.Text+#10+'Saved !',mtInformation,[mbOK],0);

    end;



  end;


end;

end.
