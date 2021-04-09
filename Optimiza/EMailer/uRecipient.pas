unit uRecipient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, Data.DB;

type
  TfrmRecipient = class(TForm)
    Panel6: TPanel;
    Panel4: TPanel;
    DBGrid1: TDBGrid;
    Splitter3: TSplitter;
    Panel5: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    ListBox1: TListBox;
    Panel2: TPanel;
    BitBtn2: TBitBtn;
    ListBox2: TListBox;
    Panel3: TPanel;
    BitBtn3: TBitBtn;
    ListBox3: TListBox;
    Panel7: TPanel;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Panel8: TPanel;
    Panel9: TPanel;
    ListBox4: TListBox;
    Label1: TLabel;
    BitBtn6: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBox2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBox3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRecipient: TfrmRecipient;

implementation

uses udmData;

{$R *.dfm}

procedure TfrmRecipient.FormShow(Sender: TObject);
begin
  if not dmData.qryUser.Active then
      dmData.qryUser.Open;

  ListBox1.SetFocus;
end;

procedure TfrmRecipient.BitBtn1Click(Sender: TObject);
var
 gCount:Integer;
begin


  if DBGrid1.SelectedRows.Count>0 then
  begin
    with DBGrid1.DataSource.DataSet do
      for gCount:=0 to DBGrid1.SelectedRows.Count-1 do
      begin
        //GotoBookmark(pointer(DBGrid1.SelectedRows.Items[gCount]));
        GotoBookmark(TBookMark(DBGrid1.SelectedRows.Items[gCount]));
        ListBox1.Items.Add(FieldByName('Eaddr').AsString);
      end;
  end
  else
  begin

  end;


  if ListBox4.SelCount > 0 then
  begin

    for gCount := 0 to ListBox4.Count-1 do
    begin
      if ListBox4.Selected[gCount] then
        ListBox1.Items.Add(ListBox4.Items.Strings[gCount]);

    end;

    ListBox4.ClearSelection;
  end;



end;

procedure TfrmRecipient.ListBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);

begin

 if (Key=VK_DELETE) then
 begin
   ListBox1.DeleteSelected;

 end;

end;

procedure TfrmRecipient.ListBox2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (Key=VK_DELETE) then
 begin
   ListBox2.DeleteSelected;

 end;

end;

procedure TfrmRecipient.ListBox3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

 if (Key=VK_DELETE) then
 begin
   ListBox3.DeleteSelected;
 end;

end;

procedure TfrmRecipient.BitBtn2Click(Sender: TObject);
var
 gCount:Integer;
begin


  if DBGrid1.SelectedRows.Count>0 then
  begin
    with DBGrid1.DataSource.DataSet do
      for gCount:=0 to DBGrid1.SelectedRows.Count-1 do
      begin
        //GotoBookmark(pointer(DBGrid1.SelectedRows.Items[gCount]));
        GotoBookmark(TBookMark(DBGrid1.SelectedRows.Items[gCount]));
        ListBox2.Items.Add(FieldByName('Eaddr').AsString);
      end;
  end
  else
  begin

  end;

end;


procedure TfrmRecipient.BitBtn3Click(Sender: TObject);
var
 gCount:Integer;
begin


  if DBGrid1.SelectedRows.Count>0 then
  begin
    with DBGrid1.DataSource.DataSet do
      for gCount:=0 to DBGrid1.SelectedRows.Count-1 do
      begin
        //GotoBookmark(pointer(DBGrid1.SelectedRows.Items[gCount]));
        GotoBookmark(TBookMark(DBGrid1.SelectedRows.Items[gCount]));
        ListBox3.Items.Add(FieldByName('Eaddr').AsString);
      end;
  end
  else
  begin

  end;

end;

end.
