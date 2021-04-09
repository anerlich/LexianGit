program AddNewProduct;

uses
  Forms,
  uAddNewProduct in '..\uAddNewProduct.pas' {frmAddNewProduct},
  uDmOptimiza in 'UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  udmAddNewProduct in 'udmAddNewProduct.pas' {dmaddNewProduct: TDataModule},
  VersionInfo in 'VersionInfo.pas',
  uLookupProduct in 'uLookupProduct.pas' {frmLookupProduct},
  uLocationData in 'uLocationData.pas' {frmLocationData},
  uLookupSupplier in 'uLookupSupplier.pas' {frmLookupSupplier},
  uLookupGroup in 'uLookupGroup.pas' {frmLookupGroup},
  uSelectLocation in 'uSelectLocation.pas' {frmSelectLocations},
  uValidateLocs in 'uValidateLocs.pas' {frmValidateLocs},
  uEditSuppliers in 'uEditSuppliers.pas' {frmEditSuppliers};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmAddNewProduct, frmAddNewProduct);
  Application.CreateForm(TdmaddNewProduct, dmaddNewProduct);
  Application.CreateForm(TfrmLookupProduct, frmLookupProduct);
  Application.CreateForm(TfrmLocationData, frmLocationData);
  Application.CreateForm(TfrmLookupSupplier, frmLookupSupplier);
  Application.CreateForm(TfrmLookupGroup, frmLookupGroup);
  Application.CreateForm(TfrmSelectLocations, frmSelectLocations);
  Application.CreateForm(TfrmValidateLocs, frmValidateLocs);
  Application.CreateForm(TfrmEditSuppliers, frmEditSuppliers);
  Application.Run;
end.
