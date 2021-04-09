unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, ValEdit, ComCtrls, Menus, Buttons,StrUtils;

type
  TfrmMain = class(TForm)
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    tabParameters: TTabSheet;
    tabLocations: TTabSheet;
    Panel1: TPanel;
    tabParameterFile: TTabSheet;
    vleParameters: TValueListEditor;
    Label1: TLabel;
    edtPath: TEdit;
    Button1: TButton;
    grpIncrease: TRadioGroup;
    Label2: TLabel;
    edtPercentage: TEdit;
    Label3: TLabel;
    OpenDialog1: TOpenDialog;
    chkCap: TCheckBox;
    edtCap: TEdit;
    Label4: TLabel;
    GroupBox4: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    ListBox3: TListBox;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ListBox4: TListBox;
    BitBtn16: TBitBtn;
    BitBtn17: TBitBtn;
    BitBtn18: TBitBtn;
    BitBtn19: TBitBtn;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    tabStatus: TTabSheet;
    Memo1: TMemo;
    btnStep1: TSpeedButton;
    btnStep2: TSpeedButton;
    pnlStep1: TLabel;
    lblStep1: TLabel;
    lblStep2: TLabel;
    lblStep3: TLabel;
    lblStep4: TLabel;
    lblStep5: TLabel;
    btnStep3: TSpeedButton;
    btnStep4: TSpeedButton;
    btnStep5: TSpeedButton;
    pnlStep2: TLabel;
    pnlStep3: TLabel;
    pnlStep4: TLabel;
    pnlStep5: TLabel;
    pnlRepeat: TLabel;
    lblRepeat: TLabel;
    btnRepeat: TSpeedButton;
    Memo2: TMemo;
    procedure grpIncreaseClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure chkCapClick(Sender: TObject);
    procedure BitBtn16Click(Sender: TObject);
    procedure BitBtn18Click(Sender: TObject);
    procedure BitBtn19Click(Sender: TObject);
    procedure BitBtn17Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnStep1Click(Sender: TObject);
    procedure btnStep2Click(Sender: TObject);
    procedure btnStep3Click(Sender: TObject);
    procedure btnStep4Click(Sender: TObject);
    procedure btnStep5Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnRepeatClick(Sender: TObject);
  private
    { Private declarations }
    FirstShow:Boolean;
    LogFile:TextFile;
    FResetRequired:Boolean;

    procedure BuildLocationList;
    procedure SaveParam;
    procedure LoadParam;
    function ValidateEntry:Boolean;
    function ValidateLocations:Boolean;
    function ValidatePercentage(Percentage:String):Boolean;
    procedure HideComponents;
    procedure Say(Line : string);
    procedure OpenLogFile;
    procedure CloseLogFile;
    function ExecuteFileWait(CmdLine,CurrentDirectory:string):boolean;
    function GetLocs:String;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses udmData, uWarning;

{$R *.dfm}

procedure TfrmMain.grpIncreaseClick(Sender: TObject);
begin
  if grpIncrease.ItemIndex = 0 then
    Label2.Caption := 'Increase Percentage by :'
  else
    Label2.Caption := 'Decrease Percentage by :';

end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    edtPath.Text := OpenDialog1.FileName;
  end;

end;

procedure TfrmMain.chkCapClick(Sender: TObject);
begin
edtCap.Enabled := chkCap.Checked;
end;

procedure TfrmMain.BitBtn16Click(Sender: TObject);
var
  Count: Integer;
begin

  for Count := 0 to (ListBox1.Items.Count - 1) do
  begin

    if ListBox1.Selected[Count] then
    begin
      ListBox2.Items.Add(ListBox1.Items.Strings[Count]);
      ListBox4.Items.Add(ListBox3.Items.Strings[Count]);
    end;

  end;

  for Count := (ListBox1.Items.Count - 1) downto 0 do
  begin

    if ListBox1.Selected[Count] then
    begin
      ListBox1.Items.delete(Count);
      ListBox3.Items.delete(Count);
    end;

  end;




end;

procedure TfrmMain.BitBtn18Click(Sender: TObject);

begin

  While ListBox1.Items.Count - 1 >= 0 do
  begin
    ListBox2.Items.Add(ListBox1.Items.Strings[0]);
    ListBox1.Items.Delete(0);
    ListBox4.Items.Add(ListBox3.Items.Strings[0]);
    ListBox3.Items.Delete(0);
  end;



end;

procedure TfrmMain.BitBtn19Click(Sender: TObject);

begin

  While ListBox2.Items.Count - 1 >= 0 do
  begin
    ListBox1.Items.Add(ListBox2.Items.Strings[0]);
    ListBox2.Items.Delete(0);
    ListBox3.Items.Add(ListBox4.Items.Strings[0]);
    ListBox4.Items.Delete(0);
  end;


end;

procedure TfrmMain.BitBtn17Click(Sender: TObject);
var
  Count: Integer;
begin

  for Count := 0 to (ListBox2.Items.Count - 1) do
  begin

    if ListBox2.Selected[Count] then
    begin
      ListBox1.Items.Add(ListBox2.Items.Strings[Count]);
      ListBox3.Items.Add(ListBox4.Items.Strings[Count]);
    end;

  end;

  for Count := (ListBox2.Items.Count - 1) downto 0 do
  begin

    if ListBox2.Selected[Count] then
    begin
      ListBox2.Items.delete(Count);
      ListBox4.Items.delete(Count);
    end;

  end;

end;

procedure TfrmMain.BuildLocationList;

begin
  ListBox1.Clear;
  ListBox2.Clear;
  ListBox3.Clear;
  ListBox4.Clear;

  dmData.trnOptimiza.StartTransaction;

  with dmData.qryAllLocations do
  begin
    ExecQuery;

    while not eof do
    begin
      ListBox1.Items.Add(FieldByName('DESCRIPTION').AsString);
      ListBox3.Items.Add(FieldByName('LOCATIONNO').AsString);
      next;
    end;

    Close;

  end;

end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin

  if FirstShow then
  begin
    FResetRequired:=False;
    FirstShow := False;
    BuildLocationList;
    LoadParam;
    HideComponents;
    btnStep1Click(nil);
    btnStep3.Enabled := False;
    btnStep4.Enabled := False;
    btnStep5.Enabled := False;
    btnRepeat.Enabled := False;
    tabStatus.TabVisible := False;
    StatusBar1.Panels[1].Text := dmData.DbDescription;

    //Make sure Stored proc is installed
    if not dmData.createProc then
      Close;

    if frmWarning.showModal = mrCancel then
      Close;



  end;

end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FirstShow := True;
end;

procedure TfrmMain.SaveParam;
var
  Paramfile:String;
begin
  VleParameters.Values['Executable Path'] := edtPath.Text;
  VleParameters.Values['Increase'] := IntToStr(grpIncrease.ItemIndex);
  VleParameters.Values['Percentage'] :=  edtPercentage.Text;

  if chkCap.Checked then
    VleParameters.Values['Cap'] := 'YES'
  else
    VleParameters.Values['Cap'] := 'NO' ;

  VleParameters.Values['Cap Percentage'] :=  edtCap.Text;

  VleParameters.Values['Locations'] := ListBox4.Items.CommaText;

  ParamFile := AnsiReplaceStr(UpperCase(Paramstr(0)),'.EXE','.ini');
  VleParameters.Strings.SaveToFile(ParamFile);

end;

procedure TfrmMain.LoadParam;
var
  Paramfile:String;
  lCount,pCount:Integer;
begin

  ParamFile := AnsiReplaceStr(UpperCase(Paramstr(0)),'.EXE','.ini');

  if FileExists(ParamFile) then
  begin

    VleParameters.Strings.LoadFromFile(ParamFile);

    edtPath.Text := VleParameters.Values['Executable Path'];
    grpIncrease.ItemIndex := StrToInt(VleParameters.Values['Increase']);
    edtPercentage.Text := VleParameters.Values['Percentage'];

    chkCap.Checked := VleParameters.Values['Cap'] = 'YES';

    edtCap.Text := VleParameters.Values['Cap Percentage'];

    ListBox4.Items.CommaText := VleParameters.Values['Locations'];

    for lCount := ListBox4.Items.Count - 1 downto 0 do
    begin

        pCount := ListBox3.Items.IndexOf(ListBox4.Items.Strings[lCount]);

        if pCount >= 0 then
        begin
          ListBox2.Items.Add(ListBox1.Items.Strings[pCount]);

          ListBox1.Items.Delete(pCount);
          ListBox3.Items.Delete(pCount);
        end
        else
          ListBox4.Items.Delete(lCount);

    end;


  end;



end;

function TfrmMain.ValidateEntry: Boolean;
begin
  Result := True;

  if FileExists(edtPath.Text) then
  begin

    if ValidatePercentage(edtPercentage.Text) then
    begin

      if chkCap.Checked and not ValidatePercentage(edtCap.Text) then
      begin
        Result := False;
      end;

    end
    else
      Result := False;

  end
  else
  begin
    Result := False;
    MessageDlg('Safety Stock Application not Found!',mtError,[mbOK],0);
  end;





end;

function TfrmMain.ValidatePercentage(Percentage: String): Boolean;
var
  TempVar:Real;
begin
  Result := True;

  try
    TempVar := StrToFloat(Percentage);

    if (TempVar <= 0) or (TempVar > 100) then
    begin
      MessageDlg('Percentage must be in Range of 1 to 100%',mtError,[mbOK],0);
      Result := False;
    end;

  except
    MessageDlg('Invalid Percentage',mtError,[mbOK],0);
    Result := False;
  end;

end;

procedure TfrmMain.HideComponents;
var
  pCount:Integer;
begin

  for PCount := 0 to PageControl1.PageCount -1 do
  begin
    PageControl1.Pages[pCount].TabVisible := False;
  end;

  pnlStep1.Color := clWhite;
  pnlStep2.Color := clWhite;
  pnlStep3.Color := clWhite;
  pnlStep4.Color := clWhite;
  pnlStep5.Color := clWhite;
  pnlRepeat.Color := clWhite;

  lblStep1.Font.Color := clBlue;
  lblStep2.Font.Color := clBlue;
  lblStep3.Font.Color := clBlue;
  lblStep4.Font.Color := clBlue;
  lblStep5.Font.Color := clBlue;
  lblRepeat.Font.Color := clBlue;

  lblStep1.Color := clWhite;
  lblStep2.Color := clWhite;
  lblStep3.Color := clWhite;
  lblStep4.Color := clWhite;
  lblStep5.Color := clWhite;
  lblRepeat.Color := clWhite;

end;

procedure TfrmMain.btnStep1Click(Sender: TObject);
begin
  HideComponents;
  tabLocations.TabVisible := True;
  pnlStep1.Color := clBlue;
  lblStep1.Font.Color := clWhite;
  lblStep1.Color := clBlue;
  btnStep2.Enabled := True;

end;

procedure TfrmMain.btnStep2Click(Sender: TObject);
begin
  HideComponents;
  TabParameters.TabVisible := True;
  pnlStep2.Color := clBlue;
  lblStep2.Font.Color := clWhite;
  lblStep2.Color := clBlue;

  if not ValidateLocations then
  begin
    btnStep1Click(nil);
  end
  else
  begin
    btnStep3.Enabled := True;
  end;


end;

procedure TfrmMain.btnStep3Click(Sender: TObject);
var
  Params:String;
  lCount:Integer;
  Increase,Cap:String;
  Perc,CapPerc:Real;
begin

  HideComponents;
  pnlStep3.Color := clBlue;
  lblStep3.Font.Color := clWhite;
  lblStep3.Color := clBlue;

  if not ValidateEntry then
  begin
    //Go back to step 2
    btnStep2Click(nil);
  end
  else
  begin
    OpenLogFile;

    Say(' ');
    Say('--------------------');
    Params := GetLocs;
    tabStatus.TabVisible := True;
    if grpIncrease.ItemIndex = 0 then
      Increase := 'Y'
    else
      Increase := 'N';

    Say('Parameter -> Increase FC Error : '+Increase);
    Say('Parameter -> Percentage : ' +edtPercentage.Text);

    if chkCap.Checked then
      Cap := 'Y'
    else
      Cap := 'N';

    Say('Parameter -> Cap FC Error : '+Cap);
    if Cap = 'Y' then Say('Parameter -> Cap Percentage : ' +edtCap.Text);

    Perc := StrToFloat(edtPercentage.text);
    CapPerc := StrToFloat(edtCap.text);

    if MessageDlg('Apply the Percentages to the Selected Locations ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin

      //Dont allow user to change locations after they run. Must rest FC error 1st
      btnStep1.Enabled := False;
      btnStep2.Enabled := False;
      btnStep4.Enabled := True;
      btnStep3.Enabled := False;


      //Run the processes
      SaveParam;
      Say(' ');
      Say('FC Error update Started ...............');

      FResetRequired:=True;


      for lCount := 0 to ListBox4.Items.Count-1 do
      begin
        Say('Applying FC Error to : ' +dmData.GetLocCode(StrToInt(ListBox4.Items.Strings[lCount])));
        dmData.UpdateError(StrToInt(ListBox4.Items.Strings[lCount]),Increase,Cap,Perc,CapPerc);
      end;


      if dmData.trnOptimiza.InTransaction then
        dmData.trnOptimiza.Commit;


      Say('Running : Safety Stock Recalc');
      ExecuteFileWait(ExtractFilePath(edtPath.Text)+'SSCalcMP.exe'+Params,ExtractFilePath(edtPath.Text));
      Say('Running : Model Calc');
      ExecuteFileWait(ExtractFilePath(edtPath.Text)+'ModelCalcMP.exe'+Params,ExtractFilePath(edtPath.Text));
      Say('Running : Background Process');
      ExecuteFileWait(ExtractFilePath(edtPath.Text)+'BackgroundProcessMP.exe'+Params,ExtractFilePath(edtPath.Text));
      
      Say('--- Complete ---');
      MessageDlg('FC Error Update has Completed',mtInformation,[mbOK],0);

      //auto click the step 4 to remind user to print
      btnStep4Click(nil);

    end
    else
      btnStep2Click(nil);


    CloseLogFile;

  end;

end;

function TfrmMain.ValidateLocations: Boolean;
begin

  Result := ListBox4.Items.Count > 0;

  if not Result then
      MessageDlg('Please Select at least one Location',mtError,[mbOK],0);

end;

procedure TfrmMain.btnStep4Click(Sender: TObject);
begin
  HideComponents;
  pnlStep4.Color := clBlue;
  lblStep4.Font.Color := clWhite;
  lblStep4.Color := clBlue;
  tabStatus.TabVisible := True;

  MessageDlg('Leave this Application Open and Print all Necessary Reports within Optimiza.'#10+
             'Then Return to Step 5 or Repeat.'#10#10+
             'DO NOT exit this application without completing Step 5!',mtWarning,[mbOK],0);

  btnRepeat.Enabled := True;
  btnStep5.Enabled := True;

end;

procedure TfrmMain.btnStep5Click(Sender: TObject);
var
 Params:String;
begin
  HideComponents;
  pnlStep5.Color := clBlue;
  lblStep5.Font.Color := clWhite;
  lblStep5.Color := clBlue;

  MessageDlg('FC Error Percentages will now be Reset to Original Values!',mtInformation,[mbOK],0);
  OpenLogFile;

  tabStatus.TabVisible := True;

  Say('Resetting Forecast Error');

  Say(' ');
  Say('Finalisation Started ...............');
  Params := GetLocs;


  Say('Running : FC Error Calc');
  ExecuteFileWait(ExtractFilePath(edtPath.Text)+'FCErrorCalcMP.exe'+Params,ExtractFilePath(edtPath.Text));
  Say('Running : Safety Stock Recalc');
  ExecuteFileWait(ExtractFilePath(edtPath.Text)+'SSCalcMP.exe'+Params,ExtractFilePath(edtPath.Text));
  Say('Running : Model Calc');
  ExecuteFileWait(ExtractFilePath(edtPath.Text)+'ModelCalcMP.exe'+Params,ExtractFilePath(edtPath.Text));
  Say('Running : Background Process');
  ExecuteFileWait(ExtractFilePath(edtPath.Text)+'BackgroundProcessMP.exe'+Params,ExtractFilePath(edtPath.Text));

  FResetRequired:=False;
  Say('--- Finalisation Complete ---');
  MessageDlg('Finalisation has Completed',mtInformation,[mbOK],0);

  CloseLogFile;

  if dmData.trnOptimiza.InTransaction then
    dmData.trnOptimiza.Commit;

  btnStep2.Enabled := False;
  btnStep3.Enabled := False;
  btnStep4.Enabled := False;
  btnStep5.Enabled := False;
  btnRepeat.Enabled := False;
  btnStep1.Enabled := True;

end;

procedure TfrmMain.Say(Line: string);
begin
  Memo1.Lines.Add(Line);
  WriteLn(LogFile, Line);
  Application.ProcessMessages;

end;

procedure TfrmMain.CloseLogFile;
begin
CloseFile(LogFile);
end;

procedure TfrmMain.OpenLogFile;
var
  FName:String;
  Year,Month,Day:Word;
  FCount:Integer;
begin
  FName := ExtractFileName(ParamStr(0));
  FName := AnsiReplaceStr(FName,'.exe','');
  DecodeDate(Now, Year, Month, Day);
  FName := Format('%d%d%d '+FName+'.log', [Year, Month, Day]);

  for FCount := 1 to 100 do
  begin

    If FileExists(FName) then
    begin

      if FCount = 1 then
        FName := AnsiReplaceStr(FName,'.log',IntToStr(FCount)+'.log')
      else
        FName := AnsiReplaceStr(FName,IntToStr(FCount-1)+'.log',IntToStr(FCount)+'.log');


    end
    else
      Break;

  end;

  AssignFile(LogFile,FName );
  Rewrite(LogFile);

end;


function TfrmMain.ExecuteFileWait(CmdLine,CurrentDirectory:string):boolean;
var
 si:TStartupInfo;
 pi:TProcessInformation;
 pCurrentDirectory:pchar;
begin
 if CurrentDirectory<>'' then pCurrentDirectory:=pchar(CurrentDirectory)
 else pCurrentDirectory:=nil;
 ZeroMemory(@si,sizeof(si));
 si.cb:=SizeOf(si);
 if not CreateProcess( nil, // No module name (use command line).
  PChar(cmdline),  // Command line.
  nil,             // Process handle not inheritable.
  nil,             // Thread handle not inheritable.
  False,           // Set handle inheritance to FALSE.
  0,               // No creation flags.
  nil,             // Use parent's environment block.
  pCurrentDirectory,// **Use parent's starting directory.
  si,              // Pointer to STARTUPINFO structure.
  pi )             // Pointer to PROCESS_INFORMATION structure.
 then begin
  Result:=false;//        ShowMessage( 'CreateProcess failed.' );
  Exit;
 end;
 WaitForSingleObject( pi.hProcess, INFINITE );
 CloseHandle( pi.hProcess );
 CloseHandle( pi.hThread );
 Result:=true;//      ShowMessage('Done !');
end;



function TfrmMain.GetLocs: String;
var
 lCount:Integer;
begin
  Result := '';

  for lCount := 0 to ListBox4.Items.Count-1 do
  begin
    Result := Trim(Result) + ' "' +dmData.GetLocCode(StrToInt(ListBox4.Items.Strings[lCount]))+'"';
  end;

  Say('Locations : ' + Result);

  if Trim(Result) <> '' then Result := ' -l '+Trim(Result);

end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if FResetRequired then
  begin
    MessageDlg('Cannot close Application without running Step 5',mtError,[mbOK],0);
    CanClose := False;
  end;

end;

procedure TfrmMain.btnRepeatClick(Sender: TObject);
var
  Params:String;
begin
  HideComponents;
  pnlRepeat.Color := clBlue;
  lblRepeat.Font.Color := clWhite;
  lblRepeat.Color := clBlue;

  btnStep5.Enabled := True;
  btnStep4.Enabled := False;
  btnStep2.Enabled := True;

  tabStatus.TabVisible := True;
  btnRepeat.Enabled := False;

  MessageDlg('FC Error Percentages will now be Reset to Original Values'+#10+
             ' and the System will be Reset for Daily Operation',mtInformation,[mbOK],0);
  OpenLogFile;

  tabStatus.TabVisible := True;

  Say('Resetting Forecast Error');

  Say(' ');
  Say('Reset Started ...............');
  Params := GetLocs;


  Say('Running : FC Error Calc');
  ExecuteFileWait(ExtractFilePath(edtPath.Text)+'FCErrorCalcMP.exe'+Params,ExtractFilePath(edtPath.Text));

  Say('--- Reset Complete ---');

  MessageDlg('Reset has Completed',mtInformation,[mbOK],0);

  CloseLogFile;

  if dmData.trnOptimiza.InTransaction then
    dmData.trnOptimiza.Commit;


end;

end.
