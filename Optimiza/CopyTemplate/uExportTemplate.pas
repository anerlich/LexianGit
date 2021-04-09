unit uExportTemplate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,StrUtils;

type
  TfrmExportTemplate = class(TForm)
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
  frmExportTemplate: TfrmExportTemplate;

implementation

uses udmData, uSelectUser;

{$R *.dfm}

procedure TfrmExportTemplate.Button1Click(Sender: TObject);
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
function TfrmExportTemplate.ValidFromUser(UserNo: String): Boolean;
begin
  Result := True;



end;


procedure TfrmExportTemplate.BitBtn3Click(Sender: TObject);
begin

  if SaveDialog1.Execute then
  begin
    Edit1.Text := SaveDialog1.FileName;
    Application.ProcessMessages;
    BitBtn1Click(Nil);
  end;

end;

procedure TfrmExportTemplate.BitBtn1Click(Sender: TObject);
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
      dmData.OpenTemplateByUser('ALL')
    else
    begin
      if edtUserFrom.Text = '' then
      begin
        MessageDlg('Please Select a User',mtError,[MBOK],0);
        CanContinue := False;
      end
      else
        dmData.OpenTemplateByUser(edtUserFrom.Text);

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

        with dmData.qryTemplateByUser do
        begin
          First;
          aString := 'User Name,';
          aString := aString+ 'Template Description,';
          aString := aString+ 'Group Type,';
          aString := aString+ 'Group Type Description,';
          aString := aString+ 'Group Code,';
          aString := aString+ 'Group Description,';

          aString := aString+ 'PARETO A,';
          aString := aString+ 'PARETO B,';
          aString := aString+ 'PARETO C,';
          aString := aString+ 'PARETO D,';
          aString := aString+ 'PARETO E,';
          aString := aString+ 'PARETO F,';
          aString := aString+ 'PARETO M,';
          aString := aString+ 'STOCKED,';
          aString := aString+ 'NON STOCKED,';
          aString := aString+ 'PARETO X,';
          aString := aString+ 'GENERIC PARENTS,';
          aString := aString+ 'GENERIC CHILDREN,';
          aString := aString+ 'GENERIC NONE,';
          aString := aString+ 'EXCLUDE MAJOR,';
          aString := aString+ 'EXCLUDE MINOR1,';
          aString := aString+ 'EXCLUDE MINOR2,';
          aString := aString+ 'EXCLUDE SUPPLIER,';
          aString := aString+ 'EXCLUDE REPORTCATEGORY,';
          aString := aString+ 'TEMPLATE TYPE,';
          aString := aString+ 'CRITICALITY 1,';
          aString := aString+ 'CRITICALITY 2,';
          aString := aString+ 'CRITICALITY 3,';
          aString := aString+ 'CRITICALITY 4,';
          aString := aString+ 'CRITICALITY 5,';
          aString := aString+ 'EXPEDITE,';
          aString := aString+ 'DE EXPEDITE,';

          Writeln(CsvFile,aString);

          while not dmData.qryTemplateByUser.Eof do
          begin
            aString := FieldByName('UserName').asString + ',';
            aString := aString+ AnsiReplaceStr(FieldByName('TemplateDesc').asString,',',' ')+',';
            aString := aString+ FieldByName('GroupType').asString+',';
            aString := aString+ FieldByName('GroupTypeDesc').asString+',';
            aString := aString+ FieldByName('GroupCode').asString+',';
            aString := aString+ FieldByName('GroupDesc').asString+',';

            aString := aString+ FieldByName('PARETO_A').asString+',';
            aString := aString+ FieldByName('PARETO_B').asString+',';
            aString := aString+ FieldByName('PARETO_C').asString+',';
            aString := aString+ FieldByName('PARETO_D').asString+',';
            aString := aString+ FieldByName('PARETO_E').asString+',';
            aString := aString+ FieldByName('PARETO_F').asString+',';
            aString := aString+ FieldByName('PARETO_M').asString+',';
            aString := aString+ FieldByName('STOCKED').asString+',';
            aString := aString+ FieldByName('NONSTOCKED').asString+',';
            aString := aString+ FieldByName('PARETO_X').asString+',';
            aString := aString+ FieldByName('GENERICPARENTS').asString+',';
            aString := aString+ FieldByName('GENERICCHILDREN').asString+',';
            aString := aString+ FieldByName('GENERICNONE').asString+',';
            aString := aString+ FieldByName('EXCLUDEMAJOR').asString+',';
            aString := aString+ FieldByName('EXCLUDEMINOR1').asString+',';
            aString := aString+ FieldByName('EXCLUDEMINOR2').asString+',';
            aString := aString+ FieldByName('EXCLUDESUPPLIER').asString+',';
            aString := aString+ FieldByName('EXCLUDEREPORTCATEGORY').asString+',';
            aString := aString+ FieldByName('TEMPLATETYPE').asString+',';
            aString := aString+ FieldByName('CRITICALITY_1').asString+',';
            aString := aString+ FieldByName('CRITICALITY_2').asString+',';
            aString := aString+ FieldByName('CRITICALITY_3').asString+',';
            aString := aString+ FieldByName('CRITICALITY_4').asString+',';
            aString := aString+ FieldByName('CRITICALITY_5').asString+',';
            aString := aString+ FieldByName('EXPEDITE').asString+',';
            aString := aString+ FieldByName('DEEXPEDITE').asString;

            Writeln(CsvFile,aString);

            next;
          end;



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
