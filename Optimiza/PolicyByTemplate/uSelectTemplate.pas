unit uSelectTemplate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, DBCtrls,DB;

type
  TfrmSelectTemplate = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    DBLookupComboBox1: TDBLookupComboBox;
    Label1: TLabel;
    BitBtn2: TBitBtn;
    CheckBox1: TCheckBox;
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DBLookupComboBox1CloseUp(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
    FTemplateNo:Integer;
    Fdescription:String;
    FItemNo,FUserNo:Integer;
    FItemDescription: String;
     procedure SetUserNo(const Value: Integer);
  public
    { Public declarations }
    property TemplateNo:Integer read FTemplateNo write FTemplateNo;
    property UserNo:Integer read FUserNo write SetUserNo;
    property Description:String read FDescription write FDescription;
    property ItemNo:Integer read FItemNo write FItemNo;
    property ItemDescription:String read FItemDescription write FItemDescription;
    procedure OpenTemplate;

  end;

var
  frmSelectTemplate: TfrmSelectTemplate;

implementation

uses uDMData;

{$R *.dfm}

procedure TfrmSelectTemplate.DBGrid1CellClick(Column: TColumn);
begin
  FTemplateNo := dbGrid1.DataSource.DataSet.fieldByName('TemplateNo').asInteger;
  FDescription :=dbGrid1.DataSource.DataSet.fieldByName('Description').asString;
end;

procedure TfrmSelectTemplate.FormShow(Sender: TObject);
begin
  FTemplateNo := -1;
  FDescription := '';

  if not dmData.qryUsers.Active then
  begin
    dmData.qryUsers.Open;
    dmData.qryUsers.Next;
    dmData.qryUsers.Next;
    dmData.qryUsers.Next;
    dmData.qryUsers.First;
    DBLookupComboBox1.KeyValue := FUserNo;
//    dmData.qryUsers.Locate('UserNo',VarArrayOf([FUserNo]),[loPartialKey]);
  end;

  if not dmData.qryTemplate.Active then
    OpenTemplate;
  //else
  //  dmData.qryTemplate.Refresh;

end;

procedure TfrmSelectTemplate.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if dmData.qryTemplate.Active then
    dmData.qryTemplate.Close;



end;

procedure TfrmSelectTemplate.FormCreate(Sender: TObject);
begin
  FuserNo := 1;
end;

procedure TfrmSelectTemplate.OpenTemplate;
begin

  with dmData.qryTemplate do
  begin
    Close;
    ParamByName('UserNo').AsInteger := FUserNo;
    Open;
  end;



end;

procedure TfrmSelectTemplate.DBLookupComboBox1CloseUp(Sender: TObject);
begin

  if dmData.qryUsers.FieldByName('UserNo').AsInteger <> FUserNo then
  begin
    FUserNo := dmData.qryUsers.FieldByName('UserNo').AsInteger;
    OpenTemplate;
  end;

end;

procedure TfrmSelectTemplate.CheckBox1Click(Sender: TObject);
begin
  if not CheckBox1.Checked then
  begin
    DBGrid1.Enabled := True;
    DBGrid1.color := clWindow;
    dbgrid1.SetFocus;
  end
  else
  begin
   DBGrid1.color := clInactiveBorder;
   DBGrid1.Enabled := False;
  end;

end;

procedure TfrmSelectTemplate.SetUserNo(const Value: Integer);
begin
  FUserNo := Value;
  DBLookupComboBox1.KeyValue := FUserNo;
end;

end.
