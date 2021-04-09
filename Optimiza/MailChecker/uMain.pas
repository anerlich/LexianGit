unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Psock, NMpop3, ComCtrls, Buttons, Grids, ValEdit,StrUtils,
  ExtCtrls, DB, DBCtrls, DBGrids;

const
  _MaxMail=200;

type
  TfrmMain = class(TForm)
    NMPOP31: TNMPOP3;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    vleBusinesses: TValueListEditor;
    TabSheet4: TTabSheet;
    StringGrid1: TStringGrid;
    TabSheet5: TTabSheet;
    Panel4: TPanel;
    BitBtn3: TBitBtn;
    grdHeader: TStringGrid;
    Panel3: TPanel;
    BitBtn4: TBitBtn;
    Panel5: TPanel;
    vleMailType: TValueListEditor;
    Panel6: TPanel;
    Panel8: TPanel;
    BitBtn1: TBitBtn;
    TabSheet6: TTabSheet;
    Memo2: TMemo;
    Button2: TButton;
    cmbLocalMailType: TComboBox;
    Panel9: TPanel;
    StringGrid3: TStringGrid;
    Panel10: TPanel;
    StringGrid2: TStringGrid;
    Panel11: TPanel;
    Label5: TLabel;
    Panel12: TPanel;
    Label6: TLabel;
    BitBtn2: TBitBtn;
    TabSheet7: TTabSheet;
    Panel7: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    TabSheet8: TTabSheet;
    Panel15: TPanel;
    Panel16: TPanel;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    vleParameters: TValueListEditor;
    TabSheet9: TTabSheet;
    Panel17: TPanel;
    Panel18: TPanel;
    DBGrid2: TDBGrid;
    DBNavigator2: TDBNavigator;
    procedure NMPOP31ConnectionFailed(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdHeaderDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtn4Click(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure TabSheet5Show(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure vleMailTypeSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure vleBusinessesSetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: String);
    procedure Button2Click(Sender: TObject);
    procedure StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid3DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
    FirstShow:Boolean;
    FChanged:Boolean;
    FBusMailCount:Integer;
    FFoundHeader:Array[1.._MaxMail] of Boolean;
    procedure ConnectMail;
    procedure LoadMailTypes;
    procedure SaveMailTypes;
    procedure LoadBusTypes;
    procedure SaveBusTypes;
    procedure LoadBusMail;
    procedure SaveBusMail;
    procedure ListMail;
    function FindMail(From,Subject:String):Integer;
    procedure CheckComponentCount;
    procedure DeleteBusMail(MailNo:Integer);
    function FindMailHeader(From,Subject:String):Integer;
    function GetMailDate:String;
    procedure AddMessageToGrid(MailTypeNo,LineNo:Integer;Company,MailType,Status:String);
    procedure ConnectToDatabase;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses uEdit, uStatus, uDmData;

{$R *.dfm}

procedure TfrmMain.NMPOP31ConnectionFailed(Sender: TObject);
begin
  Statusbar1.SimpleText := 'Connection Failed';
end;

procedure TfrmMain.BitBtn2Click(Sender: TObject);
var
  MailNo,ColNo:Integer;

begin

  for MailNo := grdHeader.RowCount-1 downto 1 do
  begin
    if FFoundHeader[MailNo] then
    begin
      NMPOP31.DeleteMailMessage(MailNo);
      FFoundHeader[MailNo]:= False;
    end;

  end;

  //RichEdit1.Clear;
  for ColNo := 0 to StringGrid2.ColCount -1 do
  begin
    StringGrid2.Cols[ColNo].Clear;
    StringGrid3.Cols[ColNo].Clear;
  end;
  
  MessageDlg('Mail Headers Deleted',mtInformation,[mbOK],0);

  NMPOP31.Disconnect;
  NMPOP31.Connect;
  ListMail;

end;

procedure TfrmMain.BitBtn3Click(Sender: TObject);
begin
  ListMail;
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin

  if FirstShow then
  begin
    FirstShow := False;
    PageControl1.ActivePage := TabSheet1;

    
    ConnectToDatabase;
    LoadMailTypes;
    LoadBusTypes;
    LoadBusMail;

    ConnectMail;

    ListMail;
    StringGrid2.ColWidths[2] := 350;
    StringGrid3.ColWidths[2] := 350;



  end;

end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FirstShow := True;
  FBusMailCount:=0;
  FChanged:=False;
end;

procedure TfrmMain.LoadMailTypes;
var
  FName:String;
begin
  FName := UpperCase(ParamStr(0));
  FName := AnsiReplaceStr(FName,'.EXE','_MailType.dat');

  if FileExists(FNAme) then
  begin
    vleMailType.Strings.LoadFromFile(FName);
  end;


end;

procedure TfrmMain.SaveMailTypes;
var
  FName:String;
begin

  FName := UpperCase(ParamStr(0));
  FName := AnsiReplaceStr(FName,'.EXE','_MailType.dat');
  vleMailType.Strings.SaveToFile(FName);

end;

procedure TfrmMain.ConnectMail;
begin
  Try
    frmStatus.Panel1.Caption := 'Connecting ...';
    frmStatus.show;
    NMPOP31.AttachFilePath := '.';
    NMPOP31.DeleteOnRead := FALSE;
    NMPOP31.ReportLevel := Status_Basic;
    NMPOP31.TimeOut := 20000;
    NMPOP31.Host := Edit1.Text;
    NMPOP31.Port := StrToInt(Edit2.Text);
    NMPOP31.UserID := Edit3.Text;
    NMPOP31.Password := Edit4.Text;
    NMPOP31.Connect;
  except
    on e: exception do
    begin
      MessageDlg(e.Message,mtError,[mbOK],0);
    end;

  end;

  frmStatus.hide;

end;

procedure TfrmMain.LoadBusTypes;
var
  FName:String;
begin
  FName := UpperCase(ParamStr(0));
  FName := AnsiReplaceStr(FName,'.EXE','_BusType.dat');

  if FileExists(FNAme) then
  begin
    vleBusinesses.Strings.LoadFromFile(FName);
  end;

  
end;

procedure TfrmMain.SaveBusTypes;
var
  FNAme:String;
begin
  FName := UpperCase(ParamStr(0));
  FName := AnsiReplaceStr(FName,'.EXE','_BusType.dat');
  vleBusinesses.Strings.SaveToFile(FName);

end;

procedure TfrmMain.LoadBusMail;
var
  FName,TheData:String;
  BusMail:TextFile;
  RCount:Integer;
begin

  StringGrid1.RowCount := _MaxMail;

  stringGrid1.ColWidths[0] := 120;
  StringGrid1.Cells[0,0] := 'Business';

  stringGrid1.ColWidths[1] := 160;
  StringGrid1.Cells[1,0] := 'Mail Type';

  stringGrid1.ColWidths[2] := 220;
  StringGrid1.Cells[2,0] := 'From';

  stringGrid1.ColWidths[3] := 520;
  StringGrid1.Cells[3,0] := 'Subject';

  stringGrid1.ColWidths[4] := 120;
  StringGrid1.Cells[4,0] := 'Critical';

  FName := UpperCase(ParamStr(0));
  FName := AnsiReplaceStr(FName,'.EXE','_BusMail.dat');

  if FileExists(FNAme) then
  begin
    AssignFile(BusMail,FName);
    Reset(BusMail);
    RCount:=0;
    FBusMailCount:=0;

    while not eof(BusMail) do
    begin
      ReadLn(BusMail,TheData);
      Inc(RCount);
      StringGrid1.Rows[RCount].CommaText := TheData;

      if Trim(StringGrid1.Cells[0,RCount]) <> '' then
        Inc(FBusMailCount);

    end;

    CloseFile(BusMail);
  end;

end;

procedure TfrmMain.ListMail;
var
  MailNo,CommaPos:Integer;

begin


  StatusBar1.SimpleText := 'Retrieving Headers';
  grdHeader.RowCount := NMPOP31.MailCount+1;

  grdHeader.ColWidths[0] := 15;
  grdHeader.Cells[0,0] := 'A';

  grdHeader.ColWidths[1] := 220;
  grdHeader.Cells[1,0] := 'From';

  grdHeader.ColWidths[2] := 520;
  grdHeader.Cells[2,0] := 'Subject';

  grdHeader.ColWidths[3] := 220;
  grdHeader.Cells[3,0] := 'Time';

  for MailNo := 1 to NMPOP31.MailCount do
  begin
    NMPOP31.GetSummary(MailNo);

    grdHeader.Cells[1,MailNo] := NMPOP31.Summary.From;
    grdHeader.Cells[2,MailNo] := NMPOP31.Summary.Subject;

    Memo2.Clear;
    Memo2.Lines.AddStrings(NMPOP31.Summary.Header);

    grdHeader.Cells[3,MailNo] := GetMailDate;

    if FindMail(NMPOP31.Summary.From,NMPOP31.Summary.Subject) > 0 then
       grdHeader.Cells[0,MailNo] := 'A';

  end;

  StatusBar1.SimpleText := '# of Messages: '+IntToStr(NMPOP31.MailCount);


end;

function TfrmMain.FindMail(From, Subject: String): Integer;
var
  MailNo:Integer;
  TempFrom, TempSubject:String;
begin
  From := Trim(AnsiReplaceStr(From,' ','')); //Reomove spaces
  Subject := Trim(Subject);

  Result := -1;

  for MailNo := 1 to StringGrid1.RowCount do
  begin

    if StringGrid1.Cells[0,MailNo] = '' then
      break;

    TempFrom := Trim(AnsiReplaceStr(StringGrid1.Cells[2,MailNo],' ','')); //Reomove spaces
    TempSubject := Trim(StringGrid1.Cells[3,MailNo]);

    if (TempFrom = From) and (Trim(StringGrid1.Cells[3,MailNo]) = Subject) then
    begin
      Result := MailNo;
      break;
    end;

  end;

end;

procedure TfrmMain.grdHeaderDblClick(Sender: TObject);
var
  CurRow:Integer;
  MailNo:Integer;
  aREsult:TModalResult;
begin
  CurRow:=grdHeader.Row;

  CheckComponentCount;

  frmEdit.Edit1.Text := grdHeader.Cells[1,CurRow];
  frmEdit.Edit2.Text := grdHeader.Cells[2,CurRow];
  frmEdit.btnRemove.Enabled := grdHeader.Cells[0,CurRow]='A';
  MailNo := FindMail(grdHeader.Cells[1,CurRow],grdHeader.Cells[2,CurRow]);

  if MailNo > 0 then
  begin
    frmEdit.cmbBusiness.ItemIndex := frmEdit.cmbBusiness.Items.IndexOf(StringGrid1.Cells[0,MailNo]);
    frmEdit.cmbMailType.ItemIndex := frmEdit.cmbMailType.Items.IndexOf(StringGrid1.Cells[1,MailNo]);
    frmEdit.CheckBox1.Checked := StringGrid1.Cells[4,MailNo] = 'Yes';
  end
  else
  begin
    frmEdit.cmbBusiness.ItemIndex := -1;
    frmEdit.cmbMailType.ItemIndex := -1;
    frmEdit.CheckBox1.Checked := True;
  end;


  aResult := frmEdit.ShowModal;

  if aResult = mrYes then
  begin
    grdHeader.Cells[0,CurRow] := '';
    StringGrid1.Cells[0,MailNo] := '** Deleted **';
    DeleteBusMail(MailNo);
  end;

  if aResult = mrOK then
  begin
    grdHeader.Cells[0,CurRow] := 'A';

    //if not found then we add
    if MailNo <= 0 then
    begin
      Inc(FBusMailCount);
      MailNo:=FBusMailCount;
    end;

    if MailNo > _MaxMail then
      MessageDlg('Maximum Entries '+IntToStr(_MaxMail),mtError,[mbOK],0)
    else
    begin
      FChanged:=True;
      StringGrid1.Cells[0,MailNo] := frmEdit.cmbBusiness.Text;
      StringGrid1.Cells[1,MailNo] := frmEdit.cmbMailType.Text;
      StringGrid1.Cells[2,MailNo] := frmEdit.Edit1.Text;
      StringGrid1.Cells[3,MailNo] := frmEdit.Edit2.Text;

      if frmEdit.CheckBox1.Checked then
        StringGrid1.Cells[4,MailNo] := 'Yes'
      else
        StringGrid1.Cells[4,MailNo] := 'No';

    end;

  end;

end;

procedure TfrmMain.CheckComponentCount;
var
  CCount:Integer;
begin

  with frmEdit do
  begin
    if (vleBusinesses.RowCount - 1) <> cmbBusiness.Items.Count then
    begin
      cmbBusiness.Clear;
      For CCount := 1 to vleBusinesses.RowCount-1 do
      begin
        cmbBusiness.Items.Add(vleBusinesses.Cells[0,CCount]);

      end;

    end;

    if (vleMailType.RowCount - 1) <> cmbMailType.Items.Count then
    begin
      cmbMailType.Clear;
      For CCount := 1 to vleMailType.RowCount-1 do
      begin
        cmbMailType.Items.Add(vleMailType.Cells[0,CCount]);

      end;

      //cmbLocalMailType.Clear;
      //cmbLocalMailType.Items.Add('<All>');

      //cmbLocalMailType.Items.AddStrings(cmbMailType.Items);
      //cmbLocalMailType.ItemIndex := 0;
    end;

  end;

end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin


 dmData.CommitAndClose;
 
 if FChanged then
 begin
   SaveMailTypes;
   SaveBusTypes;
   SaveBusMail;
 end;

end;

procedure TfrmMain.SaveBusMail;
var
  FNAme:String;
  BusMail:TextFile;
  RCount:Integer;
begin
  FName := UpperCase(ParamStr(0));
  FName := AnsiReplaceStr(FName,'.EXE','_BusMail.dat');
  AssignFile(BusMail,FName);
  Rewrite(BusMail);

  for RCount := 1 to StringGrid1.RowCount -1 do
  begin
    WriteLn(BusMail,StringGrid1.Rows[RCount].CommaText);
  end;

  CloseFile(BusMail);


end;

procedure TfrmMain.DeleteBusMail(MailNo: Integer);
var
  RCount:Integer;
begin
  Dec(FBusMailCount);
  FChanged:=True;

  if FBusMailCount < 0 then FBusMailCount := 0;

  //Shift all one row up
  for RCount := MailNo to StringGrid1.RowCount-2 do
  begin
    StringGrid1.Rows[RCount].CommaText := StringGrid1.Rows[RCount+1].CommaText;
  end;

  StringGrid1.Rows[StringGrid1.RowCount-1].CommaText := '';

end;

procedure TfrmMain.BitBtn4Click(Sender: TObject);
var
  CurRow,MailNo:Integer;
  aREsult:TModalResult;
begin
  CurRow:=StringGrid1.Row;
  CheckComponentCount;

  frmEdit.Edit1.Text := StringGrid1.Cells[2,CurRow];
  frmEdit.Edit2.Text := StringGrid1.Cells[3,CurRow];
  frmEdit.btnRemove.Enabled := True;

  frmEdit.cmbBusiness.ItemIndex := frmEdit.cmbBusiness.Items.IndexOf(StringGrid1.Cells[0,CurRow]);
  frmEdit.cmbMailType.ItemIndex := frmEdit.cmbMailType.Items.IndexOf(StringGrid1.Cells[1,CurRow]);
  frmEdit.CheckBox1.Checked := StringGrid1.Cells[4,CurRow] = 'Yes';

  MailNo := FindMailHeader(StringGrid1.Cells[2,CurRow],StringGrid1.Cells[3,CurRow]);
  aResult := frmEdit.ShowModal;

  if aResult = mrYes then
  begin
    StringGrid1.Cells[0,CurRow] := '** Deleted **';
    DeleteBusMail(CurRow);

    if MailNo > 0 then
      grdHeader.Cells[0,MailNo] := '';

  end;

  if aResult = mrOK then
  begin

      StringGrid1.Cells[0,CurRow] := frmEdit.cmbBusiness.Text;
      StringGrid1.Cells[1,CurRow] := frmEdit.cmbMailType.Text;

      FChanged:=True;

      if frmEdit.CheckBox1.Checked then
        StringGrid1.Cells[4,CurRow] := 'Yes'
      else
        StringGrid1.Cells[4,CurRow] := 'No';

    if MailNo > 0 then
      grdHeader.Cells[0,MailNo] := 'A';

  end;

end;

function TfrmMain.FindMailHeader(From, Subject: String): Integer;
var
  MailNo:Integer;
  TempFrom:String;
begin
  From := Trim(AnsiReplaceStr(From,' ',''));
  Subject := Trim(Subject);

  Result := -1;

  for MailNo := 1 to grdHeader.RowCount-1 do
  begin

    if grdHeader.Cells[1,MailNo] = '' then
      break;

    TempFrom := Trim(AnsiReplaceStr(grdHeader.Cells[1,MailNo],' ',''));

    if (TempFrom = From) and (Trim(grdHeader.Cells[2,MailNo]) = Subject) then
    begin
      Result := MailNo;
      break;
    end;

  end;

end;

procedure TfrmMain.StringGrid1DblClick(Sender: TObject);
begin
  BitBtn4Click(Sender);
end;

procedure TfrmMain.TabSheet5Show(Sender: TObject);
begin
  CheckComponentCount;
end;

procedure TfrmMain.BitBtn1Click(Sender: TObject);
var
  AllMailType,WriteData:Boolean;
  SCount,MailNo,ACount,MailTypeNo,LCount:Integer;
  TheData,MsgFound:String;
  TempList :TStringList;
begin

  //AllMailType := cmbLocalMailType.Text = '<All>';
  //RichEdit1.Clear;
  TempList := TStringList.Create;
  LCount := 0;

  for ACount := 1 to _MaxMail do
    FFoundHeader[ACount] := False;


  For MailTypeNo := 1 to 2 do
  begin
    TempList.Clear;
    TempList.Sorted := False;

    for SCount := 1 to StringGrid1.RowCount-1 do
    begin

      WriteData := False;

      //Critical only in first loop
      if (MailtypeNo = 1) and (Trim(StringGrid1.Cells[4,SCount]) = 'Yes') then
      begin
        WriteData := True;
      end;

      if (MailtypeNo = 2) and (Trim(StringGrid1.Cells[4,SCount]) <> 'Yes') then
      begin
        WriteData := True;
      end;

      if WriteData then
      begin
        MailNo := FindMailHeader(StringGrid1.Cells[2,SCount],StringGrid1.Cells[3,SCount]);

        MsgFound := '';


        if MailNo > 0 then
        begin
          MsgFound := 'OK          ';

          if MailTypeNo = 1 then
            MsgFound := MsgFound + grdHeader.Cells[3,MailNo]
          else
            MsgFound := MsgFound + grdHeader.Cells[2,MailNo];

          FFoundHeader[MailNo] :=True;
          //tblCompany.Insert;
          //tblCompany.FieldByName('Company').AsString := StringGrid1.Cells[0,SCount];
          //tblCompany.Post;
        end
        else
          if MailTypeNo = 1 then
          begin
            MsgFound := '** Not Found';

          end;

        If MsgFound <> '' then
        begin
          TheData := Format('%-20s,%-20s,%-15s',[StringGrid1.Cells[0,SCount],
                                                 StringGrid1.Cells[1,SCount],
                                                 MsgFound]);
          TempList.Add(TheData);
        end;

      end;

    end;

    TempList.Sorted := True;


    if MailTypeNo = 1 then
    begin
      //RichEdit1.Lines.Add('------ Critical Messages');
      LCount := 0;  //Reset Line Count
    end
    else
    begin
      //RichEdit1.Lines.Add('------ Other Messages');
      LCount := 0;  //Reset Line Count
    end;

    for Scount := 0 to TempList.Count-1 do
    begin

      AddMessageToGrid(MailTypeNo,lCount,
                       Copy(TempList.Strings[Scount],1,20),
                       Copy(TempList.Strings[Scount],22,20),
                       Copy(TempList.Strings[Scount],43,85));


      //StringGrid2.Cells[0,lCount] :=Copy(TempList.Strings[Scount],1,20);
      //StringGrid2.Cells[1,lCount] :=Copy(TempList.Strings[Scount],22,20);
      //StringGrid2.Cells[2,lCount] :=Copy(TempList.Strings[Scount],43,15);
      Inc(LCount);
      {if Copy(TempList.Strings[Scount],43,1) = '*' then
        RichEdit1.SelAttributes.Color := clBlue
      else
        RichEdit1.SelAttributes.Color := clBlack;

      RichEdit1.Lines.Add(TempList.Strings[Scount]);}
    end;

    //RichEdit1.Lines.Add('-----------------------------------------------------');
    if MailTypeNo = 1 then
      StringGrid2.Cells[0,lCount] := '   ### End of Report ###'
    else
      StringGrid3.Cells[0,lCount] := '   ### End of Report ###';

  end;


  //RichEdit1.Lines.Add(' ### End of Report ###');

  TempList.Free;

end;

procedure TfrmMain.vleMailTypeSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  FChanged := True;
end;

procedure TfrmMain.vleBusinessesSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  FChanged := True;
end;

function TfrmMain.GetMailDate: String;
var
  MCount:Integer;
begin
  Result := '';

  for MCount := 0 to Memo2.Lines.Count-1 do
  begin
    if UpperCase(LeftStr(Memo2.Lines.Strings[MCount],5)) = 'DATE:' then
    begin
      Result := Copy(Memo2.Lines.Strings[MCount],6,Length(Memo2.Lines.Strings[MCount]));
      break;
    end;
  end;

end;

procedure TfrmMain.Button2Click(Sender: TObject);
var
  MailNo:Integer;
begin
  MailNo:=grdHeader.Row;

  if MailNo > 0 then
  begin
    NMPOP31.GetSummary(MailNo);

    Memo2.Clear;
    Memo2.Lines.AddStrings(NMPOP31.Summary.Header);
  end;

end;
{  for SCount := 1 to StringGrid1.RowCount-1 do
  begin

    WriteData := True;

    if not AllMailType then
    begin

      if Trim(StringGrid1.Cells[1,SCount]) <> Trim(cmbLocalMailType.Text) then
        WriteData := False;

    end;

    if (chkCritical.Checked) and (Trim(StringGrid1.Cells[4,SCount]) <> 'Yes') then
      WriteData := False;

    if (not chkCritical.Checked) and (Trim(StringGrid1.Cells[4,SCount]) = 'Yes') then
      WriteData := False;

    if WriteData then
    begin
      MailNo := FindMailHeader(StringGrid1.Cells[2,SCount],StringGrid1.Cells[3,SCount]);

      if MailNo > 0 then
      begin
        MsgFound := 'OK';
        FFoundHeader[MailNo] :=True;
      end
      else
        MsgFound := '** Not Found';

      TheData := Format('%-20s,%-20s,%-15s',[StringGrid1.Cells[0,SCount],
                                             StringGrid1.Cells[1,SCount],
                                             MsgFound]);
      RichEdit1.Lines.Add(TheData)
    end;


  end;
}
procedure TfrmMain.StringGrid2DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  TheText:String;
  HasError:Boolean;
begin

  HasError := Copy(StringGrid2.Cells[2, ARow],1,1) = '*';

  if (HasError) or ((Arow > 0) and (Arow mod 2 = 0)) then
  begin
    TheText := StringGrid2.Cells[ACol, ARow];

    if HasError then
      StringGrid2.Canvas.Font.Style := [fsBold];

    if (Arow mod 2 = 0) then
      StringGrid2.Canvas.Brush.Color := clInfoBk;

    StringGrid2.Canvas.FillRect(Rect);
    StringGrid2.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, TheText);
  end;

end;

procedure TfrmMain.AddMessageToGrid(MailTypeNo,LineNo: Integer; Company, MailType,
  Status: String);
begin
  if MailTypeNo = 1 then
  begin
    StringGrid2.Cells[0,LineNo] :=Company;
    StringGrid2.Cells[1,LineNo] :=MailType;
    StringGrid2.Cells[2,LineNo] :=Status;
  end
  else
  begin
    StringGrid3.Cells[0,LineNo] :=Company;
    StringGrid3.Cells[1,LineNo] :=MailType;
    StringGrid3.Cells[2,LineNo] :=Status;
  end;

end;

procedure TfrmMain.StringGrid3DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  TheText:String;
  HasError:Boolean;
begin

  HasError := Copy(StringGrid3.Cells[2, ARow],1,1) = '*';

  if (HasError) or ((Arow > 0) and (Arow mod 2 = 0)) then
  begin
    TheText := StringGrid3.Cells[ACol, ARow];

    if HasError then
      StringGrid3.Canvas.Font.Style := [fsBold];

    if (Arow mod 2 = 0) then
      StringGrid3.Canvas.Brush.Color := clInfoBk;

    StringGrid3.Canvas.FillRect(Rect);
    StringGrid3.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, TheText);
  end;

end;

procedure TfrmMain.ConnectToDatabase;
var
  AFileName,ADbName:String;
begin
  AFileName := ExtractFilePath(ParamStr(0))+ 'MailChecker_db.dat';
  vleParameters.Strings.LoadFromFile(AFileName);

  ADbName := vleParameters.Values['Database'];
  dmData.dbMain.DatabaseName := ADbName;

  if not FileExists(AFileName) then
  begin

    if MessageDlg('This appears to be a new installation. Create Necessary Files ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin
      AFileName := InputBox('Confirm','Please confirm the database criteria',ADbName);
      dmData.dbMain.DatabaseName := ADbName;
    end;

  end;

  //dmData.ConnectDatabase;

end;

end.
