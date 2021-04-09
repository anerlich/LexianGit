unit uDButilMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, Grids, DBGrids, xmldom, XMLIntf,
  msxmldom, XMLDoc;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    OpenDialog1: TOpenDialog;
    Button1: TButton;
    Button2: TButton;
    Table1: TTable;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    ListBox1: TListBox;
    Edit2: TEdit;
    Edit3: TEdit;
    XMLDocument1: TXMLDocument;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
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
  if OpenDialog1.Execute then
  begin
    Edit1.Text := OpenDialog1.FileName;
    Button2Click(Nil);
  end;
    
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if Table1.Active then
    Table1.Close;

  Table1.TableName := Edit1.Text;
  Table1.Exclusive := True;
  Table1.Open;

  Button2.Enabled := False;
  Button3.Enabled := True;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if Table1.Active then
    Table1.Close;

  Button2.Enabled := True;
  Button3.Enabled := False;

end;

procedure TForm1.Button4Click(Sender: TObject);
var
  fCount:Integer;
begin

  

  ListBox1.Clear;
  for FCount := 0 to Table1.FieldDefs.Count-1 do
  begin

    ListBox1.Items.Add(Table1.FieldDefs.Items[FCount].Name);

  end;

end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
  Button5.Enabled := True;


  Edit2.Text := ListBox1.Items.Strings[ListBox1.itemIndex];

  Edit3.Text := IntToStr(Table1.FieldDefs.Items[ListBox1.itemIndex].Size);
  
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Table1.FieldDefs.Items[ListBox1.itemIndex].Size := StrToInt(Edit3.Text);
  Table1.Close;
  Table1.CreateTable;
end;

end.
