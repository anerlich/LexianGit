unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,StrUtils;

type
  TForm1 = class(TForm)
    edtSetup: TEdit;
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    edtProduct: TEdit;
    Button5: TButton;
    Label3: TLabel;
    RadioGroup1: TRadioGroup;
    GroupBox1: TGroupBox;
    Button3: TButton;
    Button4: TButton;
    RadioGroup2: TRadioGroup;
    Button6: TButton;
    Button7: TButton;
    Label4: TLabel;
    Label5: TLabel;
    edtUserScript: TEdit;
    Button8: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
    InFile:TextFile;
    OpenTheFile:Boolean;
    FCommitCount:Integer;
    procedure ExecuteSQLFile(AFileName:String;AllowInsert:Boolean);
  public
    { Public declarations }


  end;

var
  Form1: TForm1;

implementation

uses uDmData;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    edtSetup.Text := OpenDialog1.FileName;

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  InsertSetupInfo:Boolean;
begin
  FCommitCount :=3;
  ExecuteSQLFile(edtUserScript.Text,True);

  InsertSetupInfo := RadioGroup1.ItemIndex = 0;
  FCommitCount :=7;
  ExecuteSQLFile(edtSetup.Text,InsertSetupInfo);
  FCommitCount :=2;
  ExecuteSQLFile(edtProduct.Text,True);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
   SQLText:String;
begin


  if not OpenTheFile then
  begin
    MessageDlg('File not open',mtError,[mbOK],0);
  end
  else
  begin
    if not eof(InFile) then
    begin
      ReadLn(InFile,SQLText);

      if Length(SQLText) > 254 then
      Begin
       SQLText := WrapText(SQLText,#13#10, [',',')'],100);
      end;

      Memo1.Clear;
      Memo1.Lines.Add(SQLText);
        Application.ProcessMessages;
    end
    else
    begin
       MessageDlg('No more data',mtInformation,[mbOK],0);
    end;

  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  OpenTheFile := False;
  FCommitCount:=0;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if not dmdata.trnOptimiza.InTransaction then
    dmData.trnOptimiza.StartTransaction;

    with dmData.IBSQL1 do
    begin
      Close;
      SQL.Clear;
      SQL.AddStrings(Memo1.Lines);
      ExecQuery;
    end;

end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    edtProduct.Text := OpenDialog1.FileName;

end;

procedure TForm1.ExecuteSQLFile(AFileName: String;AllowInsert:Boolean);
var
  SQLText:String;
  SQLFile:TextFile;
  ExecCount:Integer;
begin

  if not dmdata.trnOptimiza.InTransaction then
    dmData.trnOptimiza.StartTransaction;

  AssignFile(SQLFile,AFileName);
  Reset(SQLfile);

  ExecCount:=0;

  while not Eof(SQLFile) do
  begin

    ReadLn(SQLFile,SQLText);

    if (not AllowInsert) and ((UpperCase(LeftStr(SQLText,6)) = 'INSERT') or (UpperCase(LeftStr(SQLText,6)) = 'DELETE')) then
    begin
       //Ignore isert statements
       Memo1.Clear;
       Memo1.Lines.Add('Ignoring Insert');

    end
    else
    begin

      //SQL longer than 255 chars
      if Length(SQLText) > 254 then
      Begin
       SQLText := WrapText(SQLText,#13#10, [',',')'],100);
      end;

      Memo1.Clear;

      try
        with dmData.IBSQL1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add(SQLText);
          Memo1.Lines.Add(SQLText);

          Application.ProcessMessages;
          ExecQuery;

          Inc(ExecCount);

          if (FCommitCount > 0) and (ExecCount = FCommitCount) then
          begin
            dmData.trnOptimiza.Commit;
            dmData.trnOptimiza.StartTransaction;
          end;

        end;
      except
        on e: exception do begin
          if MessageDlg('Error: '+e.Message+#10+'Continue?',mtError,[mbYes,mbNo],0)= mrNo then
            break;
        end;
      end;

    end;

  end;


  CloseFile(SQLFile);

  dmData.trnOptimiza.Commit;

  MessageDlg(AFileName +' done.',mtInformation,[mbOK],0);

end;

procedure TForm1.Button6Click(Sender: TObject);
begin

  if not OpenTheFile then
  begin
    if (EdtSetup.Text = '') or (edtProduct.Text='') then
      MessageDlg('Files not specified.',mtError,[mbOK],0)
    else
    begin
      if RadioGroup2.ItemIndex = 0 then
        AssignFile(inFile,edtSetup.Text)
      else
        AssignFile(inFile,edtProduct.Text);

      Reset(Infile);
      OpenTheFile := True;
      Button7.Enabled := True;
      Button6.Enabled := False;
      Button3.Enabled := True;
      Button4.Enabled := True;
      Memo1.Clear;
    end;
  end;

end;

procedure TForm1.Button7Click(Sender: TObject);
begin

  if OpenTheFile then
  begin
    CloseFile(Infile);
    OpenTheFile := False;
    Button7.Enabled := False;
    Button6.Enabled := True;
    Button3.Enabled := False;
    Button4.Enabled := False;
    Memo1.Clear;
  end;

end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  Label4.Caption := dmData.DbDescription;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    edtUserScript.Text:= OpenDialog1.FileName;
  
end;

end.

