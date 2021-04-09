unit uDmService;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDMOPTIMIZA, IBEvents, DB, IBCustomDataSet, IBDatabase,
  IBStoredProc, IBQuery;

type
  TdmOptimiza2 = class(TdmOptimiza)
    evtOptimiza: TIBEvents;
    procedure evtOptimizaEventAlert(Sender: TObject; EventName: String;
      EventCount: Integer; var CancelAlerts: Boolean);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmOptimiza2: TdmOptimiza2;

implementation

{$R *.dfm}

procedure TdmOptimiza2.evtOptimizaEventAlert(Sender: TObject;
  EventName: String; EventCount: Integer; var CancelAlerts: Boolean);
begin
  inherited;
  MessageDlg(EventName,mtInformation,[mbOK],0);
end;

procedure TdmOptimiza2.DataModuleCreate(Sender: TObject);
begin
  inherited;
  MessageDlg(dbOptimiza.DatabaseName,mtInformation,[mbOK],0);
end;

end.
