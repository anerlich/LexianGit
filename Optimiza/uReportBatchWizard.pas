unit uReportBatchWizard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, printers, Grids, DBGrids, DBCtrls, Buttons;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    GroupBox2: TGroupBox;
    ComboBox2: TComboBox;
    GroupBox3: TGroupBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox4: TGroupBox;
    ListBox3: TListBox;
    Label1: TLabel;
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label2: TLabel;
    ListBox2: TListBox;
    ListBox4: TListBox;
    Button5: TButton;
    Button6: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  FirstShow: Boolean;

implementation

uses uDmReportBatchWizard;

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
Var
  pObject: Tprinter;

begin
  FirstShow := True;
  pObject := Tprinter.Create;
  ComboBox1.Items := pObject.Printers;
  ComboBox1.Text := ComboBox1.Items.Strings[pObject.printerindex];
  pObject.Free;


end;

procedure TForm1.BitBtn1Click(Sender: TObject);
Var
  Count: Integer;
begin

  if ListBox4.Items.Count = 0 then
    MessageDlg('Select at least one location',mtError,[mbOk],0)
  else
  begin

    edit1.Text := '-T "'+ComboBox1.Text+'" ';
    Edit1.Text := edit1.text + '-L ' ;

    For Count := 0 to ListBox4.Items.Count - 1 do
    begin
      Edit1.text := Edit1.Text + ListBox4.Items.Strings[Count] + ' ';
    end;

    edit1.Text := edit1.text + '-U '+ComboBox2.Text+' ';

    edit1.Text := edit1.text + '-R "'+ComboBox4.Text+'" ';

    edit1.Text := edit1.text + '-P -B';
  end;


end;

procedure TForm1.FormShow(Sender: TObject);
begin

if Firstshow then
begin

  With dmOptimiza2.srcAllLocations.DataSet do
  begin
    first;

    while not eof do
    begin
      ListBox1.Items.Add(FieldByName('DESCRIPTION').AsString);
      ListBox3.Items.Add(FieldByName('LOCATIONCODE').AsString);
      next;
    end;

  end;

  With dmOptimiza2.srcUsers.DataSet do
  begin
    first;

    while not eof do
    begin
      ComboBox2.Items.Add(FieldByName('USERNAME').AsString);
      next;
    end;

    ComboBox2.Text := ComboBox2.Items.Strings[0];

  end;

  With dmOptimiza2.srcReports.DataSet do
  begin
    first;


    while not eof do
    begin
      ComboBox3.Items.Add(FormatFloat('00000',FieldByName('REPORTNO').AsFloat) + ' - '+FieldByName('DESCRIPTION').AsString );
      next;
    end;

    ComboBox3.Text := ComboBox3.Items.Strings[0];

  end;

  With dmOptimiza2.srcTemplate.DataSet do
  begin
    first;


    while not eof do
    begin
      ComboBox4.Items.Add(FieldByName('DESCRIPTION').AsString );
      next;
    end;

    If ComBoBox4.Items.Count > 0 then
     ComboBox4.Text := ComboBox4.Items.Strings[0]
    else
     ComboBox4.Text := '(None)';


  end;

  StatusBar1.Panels[0].Text := dmOptimiza2.dbOptimiza.DatabaseName;
  FirstShow := False;

end;

end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Count: Integer;
begin

  While ListBox1.Items.Count - 1 >= 0 do
  begin
    ListBox2.Items.Add(ListBox1.Items.Strings[0]);
    ListBox1.Items.Delete(0);
    ListBox4.Items.Add(ListBox3.Items.Strings[0]);
    ListBox3.Items.Delete(0);
  end;


end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Count: Integer;
begin

  While ListBox2.Items.Count - 1 >= 0 do
  begin
    ListBox1.Items.Add(ListBox2.Items.Strings[0]);
    ListBox2.Items.Delete(0);
    ListBox3.Items.Add(ListBox4.Items.Strings[0]);
    ListBox4.Items.Delete(0);
  end;


end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Count: Integer;
begin

  for Count := 0 to (ListBox1.Items.Count - 1) do
  begin

    if ListBox1.Selected[Count] then
    begin
      ListBox2.Items.Add(ListBox1.Items.Strings[Count]);
      ListBox4.Items.Add(ListBox3.Items.Strings[Count]);
    end;

  end;

  for Count := (ListBox1.Items.Count - 1) downto 0 do
  begin

    if ListBox1.Selected[Count] then
    begin
      ListBox1.Items.delete(Count);
      ListBox3.Items.delete(Count);
    end;

  end;


end;

procedure TForm1.Button4Click(Sender: TObject);
var
  Count: Integer;
begin

  for Count := 0 to (ListBox2.Items.Count - 1) do
  begin

    if ListBox2.Selected[Count] then
    begin
      ListBox1.Items.Add(ListBox2.Items.Strings[Count]);
      ListBox3.Items.Add(ListBox4.Items.Strings[Count]);
    end;

  end;

  for Count := (ListBox2.Items.Count - 1) downto 0 do
  begin

    if ListBox2.Selected[Count] then
    begin
      ListBox2.Items.delete(Count);
      ListBox4.Items.delete(Count);
    end;

  end;


end;


procedure TForm1.Button5Click(Sender: TObject);
begin
  If ListBox2.ItemIndex > 0 then
  begin
    ListBox4.Items.Move(ListBox2.ItemIndex, ListBox2.ItemIndex-1);
    ListBox2.Items.Move(ListBox2.ItemIndex, ListBox2.ItemIndex-1);
  end;

end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  If ListBox2.ItemIndex < (ListBox2.Items.Count -1) then
  begin
    ListBox4.Items.Move(ListBox2.ItemIndex, ListBox2.ItemIndex+1);
    ListBox2.Items.Move(ListBox2.ItemIndex, ListBox2.ItemIndex+1);
  end;

end;

procedure TForm1.ComboBox3Change(Sender: TObject);
var
  ReportNo: Integer;
begin

  ReportNo := StrToInt(Copy(ComboBox3.text,1,5));
  dmOptimiza2.OpenTemplate(ReportNo);
  ComboBox4.Items.Clear;

  With dmOptimiza2.srcTemplate.DataSet do
  begin
    first;


    while not eof do
    begin
      ComboBox4.Items.Add(FieldByName('DESCRIPTION').AsString );
      next;
    end;

    If ComBoBox4.Items.Count > 0 then
     ComboBox4.Text := ComboBox4.Items.Strings[0]
    else
     ComboBox4.Text := '(None)';


  end;

end;

end.
