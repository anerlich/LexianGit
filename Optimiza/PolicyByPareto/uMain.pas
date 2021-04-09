unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, DBCtrls, Grids, DBGrids, Buttons, Mask, Spin,Clipbrd;

type
  TfrmMain = class(TForm)
    StatusBar1: TStatusBar;
    BitBtn1: TBitBtn;
    grpSL: TGroupBox;
    DBEdit1: TDBEdit;
    dbChkSL: TDBCheckBox;
    SpinButton1: TSpinButton;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    SpinButton2: TSpinButton;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    SpinButton3: TSpinButton;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    SpinButton4: TSpinButton;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    SpinButton5: TSpinButton;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    SpinButton6: TSpinButton;
    dbChkRC: TDBCheckBox;
    grpRC: TGroupBox;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    SpinButton7: TSpinButton;
    Label8: TLabel;
    DBEdit8: TDBEdit;
    SpinButton8: TSpinButton;
    Label9: TLabel;
    DBEdit9: TDBEdit;
    SpinButton9: TSpinButton;
    Label10: TLabel;
    DBEdit10: TDBEdit;
    SpinButton10: TSpinButton;
    Label11: TLabel;
    DBEdit11: TDBEdit;
    SpinButton11: TSpinButton;
    Label12: TLabel;
    DBEdit12: TDBEdit;
    SpinButton12: TSpinButton;
    dbChkRP: TDBCheckBox;
    grpRP: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    DBLookupComboBox4: TDBLookupComboBox;
    DBLookupComboBox5: TDBLookupComboBox;
    DBLookupComboBox6: TDBLookupComboBox;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Edit1: TEdit;
    Label19: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure DBEdit1Exit(Sender: TObject);
    procedure dbChkSLClick(Sender: TObject);
    procedure SpinButton7DownClick(Sender: TObject);
    procedure SpinButton7UpClick(Sender: TObject);
    procedure DBEdit7Exit(Sender: TObject);
    procedure dbChkRCClick(Sender: TObject);
    procedure dbChkRPClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FirstShow: Boolean;
    SchedulerSetup:Boolean;
    procedure IncrementField(Sender: TObject;IncValue:Double);
    procedure DecrementField(Sender: TObject;DecValue:Double);
    procedure ValidateSL(TheData: TDbEdit);
    procedure ValidateRC(TheData: TDbEdit);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
const
  Max_SL = 99.5;
  Min_SL = 65;
  Max_RC = 52;
  Min_RC = 0;

implementation

uses udmPolicyByPareto, uSelectOneLocation;

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FirstShow := True;
  SchedulerSetup := False;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  if FirstShow then
  begin
    FirstShow := False;
    StatusBar1.Hint := dmPolicyByPareto.dbOptimiza.DatabaseName;
    StatusBar1.Panels[1].Text := dmPolicyByPareto.DbDescription;
    dmPolicyByPareto.OpenPolicy;

    if UpperCase(ParamStr(1)) = 'UPDATE' then
    begin
      Edit1.Text := ParamStr(2);
      frmMain.Refresh;
      dmPolicyByPareto.UpdatePolicy(True,Edit1.Text);
      close;
    end;


    if UpperCase(ParamStr(1)) = '-Z' then
    begin
      BitBtn2.Visible := True;
      Label19.Visible := True;
      Edit1.Visible := True;

      Edit1.Text := ParamStr(4);
      Button1.Visible := True;
      frmMain.Refresh;
      SchedulerSetup := True;
    end;

  end;

end;

procedure TfrmMain.BitBtn1Click(Sender: TObject);
begin
    dmPolicyByPareto.CommitData;
    MessageDlg('Settings Saved to Table',mtInformation,[mbOK],0);

    if SchedulerSetup then
    begin
      Clipboard.AsText := 'Optimiza:"Update" "'+Edit1.text+'"';
      Close;
    end;

end;

procedure TfrmMain.IncrementField(Sender: TObject;IncValue:Double);
begin
  dmPolicyByPareto.SetEditState;
  ((Sender as TSpinButton).FocusControl as TDbEdit).Field.Value :=  ((Sender as TSpinButton).FocusControl as TDbEdit).Field.Value + IncValue;


end;

procedure TfrmMain.SpinButton1UpClick(Sender: TObject);
begin
  IncrementField(Sender,0.5);
  ValidateSL((Sender as TSpinButton).FocusControl as TDbEdit);
end;

procedure TfrmMain.ValidateSL(TheData: TDbEdit);
var
  ConvertNum: Double;
begin

  //Prevent Access Violation when the form destroys
  // it enters this routine during destroy
  if TheData.Field <> nil then
  begin

    ConvertNum := StrToFloat(TheData.text);

    if ConvertNum > Max_SL then
    begin
      MessageDlg('Service Level Cannot exceed ' + FloatToStr(Max_SL),mtInformation,[mbOK],0);
      TheData.Field.Value := Max_SL;
    end;

    if ConvertNum < Min_SL then
    begin
      MessageDlg('Service Level Cannot be less than ' + FloatToStr(Min_SL),mtInformation,[mbOK],0);
      TheData.Field.Value := Min_SL;
    end;

  end;

end;

procedure TfrmMain.DecrementField(Sender: TObject;DecValue:Double);
begin
  dmPolicyByPareto.SetEditState;
  ((Sender as TSpinButton).FocusControl as TDbEdit).Field.Value :=  ((Sender as TSpinButton).FocusControl as TDbEdit).Field.Value - DecValue;


end;

procedure TfrmMain.SpinButton1DownClick(Sender: TObject);
begin
  DecrementField(Sender,0.5);
  ValidateSL((Sender as TSpinButton).FocusControl as TDbEdit);
end;

procedure TfrmMain.DBEdit1Exit(Sender: TObject);
begin
 ValidateSL(Sender as TDbEdit);
end;

procedure TfrmMain.dbChkSLClick(Sender: TObject);
begin
   grpSL.Enabled := dbChkSL.Checked;
end;

procedure TfrmMain.ValidateRC(TheData: TDbEdit);
var
  ConvertNum: Double;
begin

  //Prevent Access Violation when the form destroys
  // it enters this routine during destroy
  if TheData.Field <> nil then
  begin

    ConvertNum := StrToFloat(TheData.text);

    if ConvertNum > Max_RC then
    begin
      MessageDlg('Replenishment Cycle should not exceed ' + FloatToStr(Max_RC),mtInformation,[mbOK],0);
      TheData.Field.Value := Max_RC;
    end;

    if ConvertNum < Min_RC then
    begin
      MessageDlg('Replenishment Cycle Cannot be less than ' + FloatToStr(Min_RC),mtInformation,[mbOK],0);
      TheData.Field.Value := Min_RC;
    end;

  end;

end;

procedure TfrmMain.SpinButton7DownClick(Sender: TObject);
begin
  DecrementField(Sender,1);
  ValidateRC((Sender as TSpinButton).FocusControl as TDbEdit);

end;

procedure TfrmMain.SpinButton7UpClick(Sender: TObject);
begin
  IncrementField(Sender,1);
  ValidateRC((Sender as TSpinButton).FocusControl as TDbEdit);

end;

procedure TfrmMain.DBEdit7Exit(Sender: TObject);
begin
 ValidateRC(Sender as TDbEdit);

end;

procedure TfrmMain.dbChkRCClick(Sender: TObject);
begin
   grpRC.Enabled := dbChkRC.Checked;

end;

procedure TfrmMain.dbChkRPClick(Sender: TObject);
begin
 grpRP.Enabled := dbChkRP.Checked;

end;

procedure TfrmMain.BitBtn3Click(Sender: TObject);
begin

    Close;

end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := False;

  if dmPolicyByPareto.InEdit then
  begin

    if MessageDlg('Exit without Saving?',mtWarning,[mbYes,mbNo],0) = mrYes then
      CanClose := True;

  end
  else
      CanClose := True;


end;

procedure TfrmMain.BitBtn2Click(Sender: TObject);
begin
  if MessageDlg('This will update the Item Master with the Specified Policy Settings.'+
                #10+'This Update will EXCLUDE Items that have a Manual Policy.'+#10+
                'Do you wish to Continue?',mtWarning,[mbYes,mbNo],0) = mrYes then
  begin
    //Save 1st then run update
    dmPolicyByPareto.CommitData;
    dmPolicyByPareto.UpdatePolicy(False,edit1.Text);
    
  end;
  
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
    if frmSelectOneLocation.ShowModal = mrOK then
      Edit1.Text := frmSelectOneLocation.LocationCode;

end;

end.
