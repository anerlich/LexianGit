unit uService;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs;

type
  TOptimizaServiceAlert = class(TService)
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceExecute(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  OptimizaServiceAlert: TOptimizaServiceAlert;

implementation

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  OptimizaServiceAlert.Controller(CtrlCode);
end;

function TOptimizaServiceAlert.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TOptimizaServiceAlert.ServiceCreate(Sender: TObject);
begin
  MessageDlg('Create',mtInformation,[mbOK],0);
end;

procedure TOptimizaServiceAlert.ServiceExecute(Sender: TService);
begin
  MessageDlg('Execute',mtInformation,[mbOK],0);

end;

procedure TOptimizaServiceAlert.ServiceStart(Sender: TService;
  var Started: Boolean);
begin
  MessageDlg('Started',mtInformation,[mbOK],0);

end;

procedure TOptimizaServiceAlert.ServiceStop(Sender: TService;
  var Stopped: Boolean);
begin
  MessageDlg('Stop',mtInformation,[mbOK],0);

end;

end.
