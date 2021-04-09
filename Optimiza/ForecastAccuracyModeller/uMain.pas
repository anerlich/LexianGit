unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, ValEdit, ComCtrls, Menus, Buttons,StrUtils;

type
  TfrmMain = class(TForm)
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    TabSheet3: TTabSheet;
    vleParameters: TValueListEditor;
    Label1: TLabel;
    edtPath: TEdit;
    Button1: TButton;
    grpIncrease: TRadioGroup;
    Label2: TLabel;
    edtPercentage: TEdit;
    Label3: TLabel;
    OpenDialog1: TOpenDialog;
    chkCap: TCheckBox;
    edtCap: TEdit;
    Label4: TLabel;
    BitBtn1: TBitBtn;
    GroupBox4: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    ListBox3: TListBox;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ListBox4: TListBox;
    BitBtn16: TBitBtn;
    BitBtn17: TBitBtn;
    BitBtn18: TBitBtn;
    BitBtn19: TBitBtn;
    Button2: TButton;
    procedure grpIncreaseClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure chkCapClick(Sender: TObject);
    procedure BitBtn16Click(Sender: TObject);
    procedure BitBtn18Click(Sender: TObject);
    procedure BitBtn19Click(Sender: TObject);
    procedure BitBtn17Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    FirstShow:Boolean;
    
    procedure BuildLocationList;
    procedure SaveParam;
    procedure LoadParam;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses udmData;

{$R *.dfm}

procedure TfrmMain.grpIncreaseClick(Sender: TObject);
begin
  if grpIncrease.ItemIndex = 0 then
    Label2.Caption := 'Increase Percentage by :'
  else
    Label2.Caption := 'Decrease Percentage by :';

end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    edtPath.Text := OpenDialog1.FileName;
  end;

end;

procedure TfrmMain.chkCapClick(Sender: TObject);
begin
edtCap.Enabled := chkCap.Checked;
end;

procedure TfrmMain.BitBtn16Click(Sender: TObject);
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

procedure TfrmMain.BitBtn18Click(Sender: TObject);

begin

  While ListBox1.Items.Count - 1 >= 0 do
  begin
    ListBox2.Items.Add(ListBox1.Items.Strings[0]);
    ListBox1.Items.Delete(0);
    ListBox4.Items.Add(ListBox3.Items.Strings[0]);
    ListBox3.Items.Delete(0);
  end;



end;

procedure TfrmMain.BitBtn19Click(Sender: TObject);

begin

  While ListBox2.Items.Count - 1 >= 0 do
  begin
    ListBox1.Items.Add(ListBox2.Items.Strings[0]);
    ListBox2.Items.Delete(0);
    ListBox3.Items.Add(ListBox4.Items.Strings[0]);
    ListBox4.Items.Delete(0);
  end;


end;

procedure TfrmMain.BitBtn17Click(Sender: TObject);
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

procedure TfrmMain.BuildLocationList;

begin
  ListBox1.Clear;
  ListBox2.Clear;
  ListBox3.Clear;
  ListBox4.Clear;

  dmData.trnOptimiza.StartTransaction;

  with dmData.qryAllLocations do
  begin
    ExecQuery;

    while not eof do
    begin
      ListBox1.Items.Add(FieldByName('DESCRIPTION').AsString);
      ListBox3.Items.Add(FieldByName('LOCATIONNO').AsString);
      next;
    end;

    Close;

  end;

end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin

  if FirstShow then
  begin
    FirstShow := False;
    BuildLocationList;
    LoadParam;
  end;

end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FirstShow := True;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  SaveParam;
end;

procedure TfrmMain.SaveParam;
var
  Paramfile:String;
begin
  VleParameters.Values['Executable Path'] := edtPath.Text;
  VleParameters.Values['Increase'] := IntToStr(grpIncrease.ItemIndex);
  VleParameters.Values['Percentage'] :=  edtPercentage.Text;

  if chkCap.Checked then
    VleParameters.Values['Cap'] := 'YES'
  else
    VleParameters.Values['Cap'] := 'NO' ;

  VleParameters.Values['Cap Percentage'] :=  edtCap.Text;

  VleParameters.Values['Locations'] := ListBox4.Items.CommaText;


  ParamFile := AnsiReplaceStr(UpperCase(Paramstr(0)),'.EXE','.ini');
  VleParameters.Strings.SaveToFile(ParamFile);

end;

procedure TfrmMain.LoadParam;
var
  Paramfile:String;
  lCount,pCount:Integer;
begin

  ParamFile := AnsiReplaceStr(UpperCase(Paramstr(0)),'.EXE','.ini');

  if FileExists(ParamFile) then
  begin

    VleParameters.Strings.LoadFromFile(ParamFile);

    edtPath.Text := VleParameters.Values['Executable Path'];
    grpIncrease.ItemIndex := StrToInt(VleParameters.Values['Increase']);
    edtPercentage.Text := VleParameters.Values['Percentage'];

    chkCap.Checked := VleParameters.Values['Cap'] = 'YES';

    edtCap.Text := VleParameters.Values['Cap Percentage'];

    ListBox4.Items.CommaText := VleParameters.Values['Locations'];

    for lCount := ListBox4.Items.Count - 1 downto 0 do
    begin

        pCount := ListBox3.Items.IndexOf(ListBox4.Items.Strings[lCount]);

        if pCount >= 0 then
        begin
          ListBox2.Items.Add(ListBox1.Items.Strings[pCount]);

          ListBox1.Items.Delete(pCount);
          ListBox3.Items.Delete(pCount);
        end
        else
          ListBox4.Items.Delete(lCount);


    end;


  end;



end;

end.
