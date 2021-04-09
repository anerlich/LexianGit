unit uSelectLocation;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TfrmSelectLocations = class(TForm)
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ListBox3: TListBox;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ListBox4: TListBox;
    BitBtn16: TBitBtn;
    BitBtn17: TBitBtn;
    BitBtn18: TBitBtn;
    BitBtn19: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn16Click(Sender: TObject);
    procedure BitBtn18Click(Sender: TObject);
    procedure BitBtn19Click(Sender: TObject);
    procedure BitBtn17Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure BuildLocationList;
  public
    { Public declarations }
  end;

var
  frmSelectLocations: TfrmSelectLocations;
  FirstShow : Boolean;

implementation

uses udmAddNewProduct;

{$R *.DFM}

procedure TfrmSelectLocations.BitBtn16Click(Sender: TObject);
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

procedure TfrmSelectLocations.BitBtn18Click(Sender: TObject);
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


procedure TfrmSelectLocations.BitBtn19Click(Sender: TObject);
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


procedure TfrmSelectLocations.BitBtn17Click(Sender: TObject);
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

procedure TfrmSelectLocations.BuildLocationList;
begin
  ListBox1.Clear;
  ListBox2.Clear;
  ListBox3.Clear;
  ListBox4.Clear;

  dmAddNewProduct.OpenAllLocations;

  With dmAddNewProduct.srcAllLocations.DataSet do
  begin
    first;

    while not eof do
    begin
      ListBox1.Items.Add(FieldByName('LocationCode').AsString+' -> '+FieldByName('DESCRIPTION').AsString);
      ListBox3.Items.Add(FieldByName('LOCATIONNO').AsString);
      next;
    end;

  end;

  dmAddNewProduct.CloseAllLocations;

end;

procedure TfrmSelectLocations.FormShow(Sender: TObject);
begin

if Firstshow then
begin
  BuildLocationList;
  FirstShow := False;
end;

end;

procedure TfrmSelectLocations.FormCreate(Sender: TObject);
begin
  FirstShow := True;
end;

end.
