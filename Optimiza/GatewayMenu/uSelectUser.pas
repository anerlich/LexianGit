unit uSelectUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, DBCtrls;

type
  TfrmSelectUser = class(TForm)
    Panel6: TPanel;
    Panel4: TPanel;
    Splitter3: TSplitter;
    Panel5: TPanel;
    Splitter2: TSplitter;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    ListBox1: TListBox;
    Panel7: TPanel;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn2: TBitBtn;
    Button1: TButton;
    lstData: TListBox;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateUserList;
  public
    { Public declarations }
  end;

var
  frmSelectUser: TfrmSelectUser;

implementation

uses udmData;

{$R *.dfm}

procedure TfrmSelectUser.FormShow(Sender: TObject);
begin
  if not dmData.qryUser.Active then
  begin
      dmData.qryUser.Open;
      UpdateUserList;
  end;

  ListBox1.SetFocus;
end;

procedure TfrmSelectUser.BitBtn1Click(Sender: TObject);
var
 gCount:Integer;
begin

  for gCount := 0 to lstData.Count-1 do
    if lstData.Selected[gcount] then
      ListBox1.Items.Add(lstData.Items.Strings[gCount]);

  {if DBGrid1.SelectedRows.Count>0 then
  begin
    with DBGrid1.DataSource.DataSet do
      for gCount:=0 to DBGrid1.SelectedRows.Count-1 do
      begin
        GotoBookmark(pointer(DBGrid1.SelectedRows.Items[gCount]));
        ListBox1.Items.Add(FieldByName('UserName').AsString);
      end;
  end
  else
  begin
        ListBox1.Items.Add(DBGrid1.DataSource.DataSet.FieldByName('UserName').AsString);

  end;
  }


end;

procedure TfrmSelectUser.ListBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);

begin

 if (Key=VK_DELETE) then
 begin
   ListBox1.DeleteSelected;

 end;

end;

procedure TfrmSelectUser.BitBtn2Click(Sender: TObject);
begin
  if MessageDlg('Delete Selected Users from this Group?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    ListBox1.DeleteSelected;
end;

procedure TfrmSelectUser.Button1Click(Sender: TObject);
var
  NewUser:String;
begin
  NewUser := InputBox('New User','Enter User Name','');

  if NewUser <> '' then
  begin
    ListBox1.Items.Add(UpperCase(NewUser));
  end;

end;

procedure TfrmSelectUser.UpdateUserList;
begin

  with dmData.qryUser do
  begin
    first;
    lstData.Clear;

    while not eof do
    begin
      lstData.Items.Add(FieldByName('UserName').AsString);
      next;
    end;

  end;


end;

end.
