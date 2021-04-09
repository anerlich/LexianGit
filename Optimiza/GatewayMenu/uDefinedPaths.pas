unit uDefinedPaths;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,FileCtrl, Grids, ValEdit, ExtCtrls, ComCtrls;

type
  TfrmDefinedPaths = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    vleVariables: TValueListEditor;
    Label9: TLabel;
    ListBox1: TListBox;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ListBox2: TListBox;
    Label10: TLabel;
    Label8: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ListBox3: TListBox;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure vleVariablesEditButtonClick(Sender: TObject);
  private
    { Private declarations }
    FDefinedPaths:String;
    procedure RefreshSample;
    function getFolderData(FolderID:String):String;
    procedure SetDefinedPaths(Value:String);
    procedure LoadVariables;
    procedure SaveVariables;
    procedure AddNewVariables;
    procedure AddTheVariable(VariableName,DefaultSetting:String);
  public
    { Public declarations }
    property DefinedPaths:String read FDefinedPaths write SetDefinedPaths;
  end;

var
  frmDefinedPaths: TfrmDefinedPaths;

implementation

uses uSelectFolder;

{$R *.dfm}

procedure TfrmDefinedPaths.Button2Click(Sender: TObject);
var
  lCount:Integer;
begin

  for lCount := 0 to ListBox1.Count-1 do
  begin

    if ListBox1.Selected[lCount] then
      ListBox2.Items.Add(ListBox1.Items.Strings[LCount]);

  end;

  RefreshSample;

end;

procedure TfrmDefinedPaths.Button3Click(Sender: TObject);
var
  lCount:Integer;
begin

  for lCount := ListBox2.Count-1 downto 0 do
  begin

    if ListBox2.Selected[lCount] then
      ListBox2.Items.Delete(lCount);

  end;

  RefreshSample;


end;

procedure TfrmDefinedPaths.Button4Click(Sender: TObject);
begin
  ListBox2.Clear;
  Edit1.Text := '';

end;

function TfrmDefinedPaths.getFolderData(FolderID: String): String;
begin
end;

procedure TfrmDefinedPaths.RefreshSample;
var
  lCount:Integer;
begin
  edit1.text := '';
  edit2.text := '';
  FDefinedPaths := '';

  for lCount := 0 to ListBox2.Count -1 do
  begin
    Edit1.Text := Edit1.Text + vleVariables.Values[ListBox2.Items.Strings[lCount]];
    Edit2.Text := Edit2.Text + '[' + Trim(ListBox2.Items.Strings[lCount]) + ']';
  end;

  FDefinedPaths := Edit2.Text;

end;

procedure TfrmDefinedPaths.FormActivate(Sender: TObject);
begin
  LoadVariables;
  RefreshSample;
end;

procedure TfrmDefinedPaths.SetDefinedPaths(Value: String);
var
  TempStr:String;
  cCount:Integer;
begin
  FDefinedPaths := Value;

  ListBox2.Clear;

  TempStr := '';

  for cCount := 1 to Length(Value) do
  begin

    if Copy(Value,cCount,1) = '[' then
      TempStr := '['
    else
      if Copy(TempStr,1,1) = '[' then
      begin
        if Copy(Value,cCount,1) = ']' then
        begin
          TempStr := Copy(TempStr,2,Length(TempStr));
          ListBox2.Items.Add(TempStr);
        end
        else
        begin
          TempStr := TempStr +Copy(Value,cCount,1);
        end;

      end
      else
      begin

      end;



  end;


end;

procedure TfrmDefinedPaths.LoadVariables;
var
  AFileName:String;
  vCount:Integer;
begin
  AFileName := ExtractFilePath(ParamStr(0)) + 'GatewayMenu_var.dat';

  if FileExists(aFileName) then
    vleVariables.Strings.LoadFromFile(AFileName);


  AddNewVariables;

  vleVariables.ItemProps[0].EditStyle :=  esEllipsis;

  ListBox1.Clear;

  for vCount := 1 to vleVariables.RowCount-1 do
  begin
     ListBox1.Items.Add(vleVariables.Cells[0,vCount]);
     ListBox3.Items.Add(vleVariables.Cells[1,vCount]);
  end;

end;

procedure TfrmDefinedPaths.SaveVariables;
var
  AFileName:String;
begin
  AFileName := ExtractFilePath(ParamStr(0)) + 'GatewayMenu_var.dat';
  vleVariables.Strings.SaveToFile(AFileName);


end;

procedure TfrmDefinedPaths.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin

  if ModalResult = mrOK then
    if TabSheet1.TabVisible then
      SaveVariables;

end;

procedure TfrmDefinedPaths.vleVariablesEditButtonClick(Sender: TObject);
var
  CurRow:Integer;
begin

  CurRow := vleVariables.Row;

  if CurRow = 0 then
  begin
   if frmFolder = nil then
    Application.CreateForm(TfrmFolder, frmFolder);

    if frmFolder.ShowModal = mrOK then
      vleVariables.Cells[1,CurRow] := Trim(frmFolder.ShellTreeView1.Path)+'\';
  end;

end;

procedure TfrmDefinedPaths.AddNewVariables;
begin

  AddTheVariable('Sub Folder 6','');
  AddTheVariable('Sub Folder 7','');
  AddTheVariable('Sub Folder 8','');
  AddTheVariable('Database','Database\');

end;

procedure TfrmDefinedPaths.AddTheVariable(VariableName,DefaultSetting: String);
var
  IRow:Integer;
begin

  if not vleVariables.FindRow(VariableName,IRow) then
    vleVariables.InsertRow(VariableName,defaultSetting,True);

end;

end.
