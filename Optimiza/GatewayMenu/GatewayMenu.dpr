program GatewayMenu;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  uMenuMaint in 'uMenuMaint.pas' {frmMenuMaint},
  uCommand in 'uCommand.pas' {frmCommand},
  uFileWait in 'uFileWait.pas',
  uUserMaint in 'uUserMaint.pas' {frmUserMaint},
  uDmOptimiza in '..\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  udmData in 'udmData.pas' {dmData: TDataModule},
  uSelectUser in 'uSelectUser.pas' {frmSelectUser},
  uPassword in 'uPassword.pas' {frmPassword},
  uDefinedPaths in 'uDefinedPaths.pas' {frmDefinedPaths},
  uSelectFolder in '..\uSelectFolder.pas' {frmFolder},
  uEditMenu in 'uEditMenu.pas' {frmEditMenu},
  uDBconnection in 'uDBconnection.pas' {frmDBconnection},
  uViewMenuTags in 'uViewMenuTags.pas' {frmViewMenuTags};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmMenuMaint, frmMenuMaint);
  Application.CreateForm(TfrmCommand, frmCommand);
  Application.CreateForm(TfrmUserMaint, frmUserMaint);
  Application.CreateForm(TfrmSelectUser, frmSelectUser);
  Application.CreateForm(TfrmPassword, frmPassword);
  Application.CreateForm(TfrmDefinedPaths, frmDefinedPaths);
  Application.CreateForm(TfrmDBconnection, frmDBconnection);
  Application.CreateForm(TfrmViewMenuTags, frmViewMenuTags);
  Application.Run;
end.
