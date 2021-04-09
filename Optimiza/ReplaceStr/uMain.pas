unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,StrUtils;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BitBtn2: TBitBtn;
    Label4: TLabel;
    Label5: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin

  if Opendialog1.Execute then
  begin
    Edit1.Text :=Opendialog1.FileName;
    Edit2.Text :=Opendialog1.FileName;
  end;

end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  InFile,OutFile:TextFile;
  StringOfData,InStr,OutStr:String;
  RecNo:Integer;
begin

  AssignFile(Infile,Edit1.Text);
  Reset(InFile);

  AssignFile(Outfile,Edit2.Text);
  Rewrite(OutFile);
  RecNo:=0;

  InStr := Edit3.Text;
  OutStr := Edit4.Text;


  while not eof(InFile) do
  begin

      ReadLn(InFile,StringOfData);

      StringOfData := AnsiReplaceStr(StringOfData,InStr,OutStr);

      WriteLn(OutFile,StringOfData);

      inc(RecNo);

      if RecNo mod 50 = 0 then
        begin
          Label1.Caption := IntToStr(REcNo);
          Application.ProcessMessages;
        end;


  end;

  Label1.Caption := IntToStr(REcNo);
  Application.ProcessMessages;

  CloseFile(InFile);
  CloseFile(OutFile);
  MessageDlg('Done.',mtInformation,[mbOK],0);

end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
Close;
end;

end.
