program CopyMultipleHistory;

uses
  Forms,
  windows,
  Dialogs,
  uCopyMultipleHistory in 'uCopyMultipleHistory.pas' {frmCopySalesHist},
  uDmOptimiza in '..\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uDmCopySalesHist in 'uDmCopySalesHist.pas' {dmCopySalesHist: TDataModule},
  uStatus in 'uStatus.pas' {frmStatus},
  uHelp in 'uHelp.pas' {frmHelp};

{$R *.RES}
var
   Mutex     : THandle;

begin
  Mutex := CreateMutex(nil, True, 'My_Unique_Application_Mutex_Name');
  if (Mutex = 0) OR (GetLastError = ERROR_ALREADY_EXISTS) then
  begin
    // code to searh for, and activate
    // the previous (first) instance
    MessageDlg('Another user is already running this program - Try again later',mtError,[mbOK],0);
  end
  else
  begin
    Application.Initialize;
    Application.CreateForm(TfrmCopySalesHist, frmCopySalesHist);
  Application.CreateForm(TdmCopySalesHist, dmCopySalesHist);
  Application.CreateForm(TfrmStatus, frmStatus);
  Application.CreateForm(TfrmHelp, frmHelp);
  Application.Run;
  end;
end.
