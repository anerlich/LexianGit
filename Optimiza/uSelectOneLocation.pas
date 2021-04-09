unit uSelectOneLocation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, uDmOptimiza, StdCtrls, Buttons, ExtCtrls;

type
  TfrmSelectOneLocation = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DBLookupListBox1: TDBLookupListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }

    TempDm: TDmOptimiza;
    FConnected: Boolean;
  public
    { Public declarations }
    LocationCode: STring;
    LocationDescription: String;
    procedure IncludeLocations(LocList: String);
  end;

var
  frmSelectOneLocation: TfrmSelectOneLocation;

implementation


{$R *.dfm}

procedure TfrmSelectOneLocation.FormActivate(Sender: TObject);

begin

  LocationCode := '';
  LocationDescription := '';
  TempDm.dbOptimiza.Connected := True;
  TempDm.qrySelectLocation.Open;
  DBLookupListBox1.Refresh;

end;

procedure TfrmSelectOneLocation.FormCreate(Sender: TObject);
begin

  TempDm := TDmOptimiza.Create(frmSelectOneLocation);
  TempDm.qrySelectLocation.SQL.Clear;
  TempDm.qrySelectLocation.SQL.Add('Select * from Location');
  TempDm.qrySelectLocation.SQL.Add(' where 1=1');
  TempDm.qrySelectLocation.SQL.Add('Order by Description');
  TempDm.dbOptimiza.Connected := False;
  // tempDm.qrySelectLocation.Open;

end;

procedure TfrmSelectOneLocation.FormDestroy(Sender: TObject);
begin
  Application.ProcessMessages;
  TempDm.qrySelectLocation.Close;
  TempDm.free;
  TempDm := nil;
end;

procedure TfrmSelectOneLocation.BitBtn1Click(Sender: TObject);
begin
  LocationCode := '';
  LocationDescription := '';
  TempDm.dbOptimiza.Connected := False;

end;

procedure TfrmSelectOneLocation.BitBtn2Click(Sender: TObject);
begin
  LocationCode := TempDm.qrySelectLocation.fieldbyName('LocationCode').AsString;
  LocationDescription := TempDm.qrySelectLocation.fieldbyName
    ('Description').AsString;
  TempDm.dbOptimiza.Connected := False;
end;

procedure TfrmSelectOneLocation.IncludeLocations(LocList: String);
begin
  if LocList <> '' then
  begin
    // DBLookupListBox1.ListSource := nil;
    TempDm.qrySelectLocation.Close;
    TempDm.qrySelectLocation.SQL.Strings[1] := ' Where LocationCode in (' +
      LocList + ')';
    // tempDm.qrySelectLocation.Open;

    // DBLookupListBox1.ListSource := tempDM.srcSelectLocation ;
    DBLookupListBox1.Refresh;
  end;

end;

end.
