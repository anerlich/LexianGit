unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    OpenDialog1: TOpenDialog;
    StatusBar1: TStatusBar;
    Edit1: TEdit;
    BitBtn3: TBitBtn;
    ListBox1: TListBox;
    Edit2: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.BitBtn1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    StatusBar1.Panels[4].Text := OpenDialog1.FileName;
    ListBox1.Clear;
    ListBox1.Items.LoadFromFile(OpenDialog1.FileName);
    StatusBar1.Panels[0].Text := '1';
    StatusBar1.Panels[1].Text := IntToStr(ListBox1.Items.Count);
  end;

end;

procedure TfrmMain.BitBtn3Click(Sender: TObject);
var
  lCount,fCount:Integer;
begin

  fCount := -1;
  for lCount := 0 to ListBox1.Items.Count - 1 do
  begin
    if Pos(UpperCase(Edit2.Text),UpperCase(ListBox1.Items.Strings[lCount])) > 0 then
    begin
      fCount := lCount;
      break;
    end;

  end;

  if fCount >= 0 then
  begin
    ListBox1.TopIndex := FCount;
    ListBox1.Selected[FCount] := True;
  end
  else
    MessageDlg(Edit2.text+' not found',mtInformation,[mbOK],0);

end;

procedure TfrmMain.ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  statusBar1.Panels[0].Text := IntToStr(ListBox1.ItemIndex);

end;

procedure TfrmMain.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  OffSet:Integer;
begin
   with (Control as TListBox).Canvas do  { draw on control canvas, not on the form }
   begin
	Offset := 2;          { provide default offset }
	TextOut(Rect.Left + Offset, Rect.Top, (Control as TListBox).Items[Index])  { display the text }
   end;

    statusBar1.Panels[0].Text := IntToStr(ListBox1.TopIndex+1);
    //ListBox1.Selected[ListBox1.TopIndex] := True;
end;

procedure TfrmMain.BitBtn2Click(Sender: TObject);
begin
  if Edit1.Text <> '' then
    ListBox1.TopIndex := StrToInt(Edit1.Text)-1;

end;

end.
