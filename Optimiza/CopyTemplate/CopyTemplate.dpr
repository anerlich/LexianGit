program CopyTemplate;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  uSelectUser in 'uSelectUser.pas' {frmSelectUser},
  uDmOptimiza in '..\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  udmData in 'udmData.pas' {dmData: TDataModule},
  uSelectTemplate in 'uSelectTemplate.pas' {frmSelectTemplate},
  uExportTemplate in 'uExportTemplate.pas' {frmExportTemplate},
  uReAssignRepCat in 'uReAssignRepCat.pas' {frmReAssignRepCat},
  uRemoveRepCat in 'uRemoveRepCat.pas' {frmRemoveRepCat},
  uExportReportTemplate in 'uExportReportTemplate.pas' {frmExportReportTemplate},
  uExportUsers in 'uExportUsers.pas' {frmExportUsers};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSelectUser, frmSelectUser);
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TfrmSelectTemplate, frmSelectTemplate);
  Application.CreateForm(TfrmExportTemplate, frmExportTemplate);
  Application.CreateForm(TfrmReAssignRepCat, frmReAssignRepCat);
  Application.CreateForm(TfrmRemoveRepCat, frmRemoveRepCat);
  Application.CreateForm(TfrmExportReportTemplate, frmExportReportTemplate);
  Application.CreateForm(TfrmExportUsers, frmExportUsers);
  Application.Run;
end.
