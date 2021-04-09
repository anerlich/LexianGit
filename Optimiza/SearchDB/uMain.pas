unit uMain;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   ExtCtrls, StdCtrls, ComCtrls, StrUtils,DateUtils, Buttons,Filectrl,
  Grids, ValEdit,ShellApi,RichEdit;

type TTextAttributes = record
  Font: TFont;
  BackColor:  TColor;
end;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    Panel2: TPanel;
    tbSearchFor: TEdit;
    BitBtn3: TBitBtn;
    Panel3: TPanel;
    RE1: TRichEdit;
    Panel4: TPanel;
    Label2: TLabel;
    lblSPName: TLabel;
    Panel5: TPanel;
    btnNext: TButton;
    btnPrev: TButton;
    Label1: TLabel;
    tbSPName: TEdit;
    RE2: TRichEdit;
    btnClear: TBitBtn;
    btnAddName: TButton;
    rgType: TRadioGroup;
    cbActive: TCheckBox;
    cbMatches: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure StartSearch;
    procedure Split(const Delimiter: Char; Input: string; const Strings: TStrings) ;
    procedure btnNextClick(Sender: TObject);
    procedure HighLight();
    procedure SetTextColor(oRichEdit : TRichEdit; sText : String; rAttributes : TTextAttributes);
    procedure btnPrevClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnAddNameClick(Sender: TObject);
    procedure lblSPNameDblClick(Sender: TObject);
    procedure cbMatchesClick(Sender: TObject);

  private
    FirstShow:Boolean;
    FParamFileName:String;
    procedure StartProcess;

  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;


implementation

uses uDmOptimiza;

{$R *.DFM}


procedure TfrmMain.StartProcess;
begin
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
  if FirstShow then
  begin
    FirstShow := False;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FirstShow := True;
  //RE2.Clear;
end;

procedure TfrmMain.BitBtn3Click(Sender: TObject);
var
  join: string;
  flds: TStringList;
  i: integer;
begin
  flds := TStringList.Create;
  split('|', stringreplace(tbSearchFor.Text,'''','''''',[rfReplaceAll, rfIgnoreCase]), flds);

  dmOptimiza.qrySearchSP.Close;
  dmOptimiza.qrySearchSP.SQL.Clear;

  if rgType.ItemIndex = 0 then
  begin
    dmOptimiza.qrySearchSP.SQL.Add('SELECT rdb$procedure_name,rdb$procedure_source FROM RDB$PROCEDURES');
    join:=' WHERE (';
    for i:=0 to flds.Count - 1 do
    begin
      dmOptimiza.qrySearchSP.SQL.Add(join + 'upper(rdb$procedure_source ) like upper(''%'+  flds.Strings[i]+'%'')');
      join:=' OR ';
    end;
    if tbSPName.Text <> '' then
    begin
      dmOptimiza.qrySearchSP.SQL.Add(') AND upper(rdb$procedure_name) like  upper(''%'+tbSPName.Text+'%'')');
    end
    else dmOptimiza.qrySearchSP.SQL.Add(')');
    dmOptimiza.qrySearchSP.SQL.Add(' order by rdb$procedure_name');
  end
  else if rgType.ItemIndex = 1 then
  begin
    dmOptimiza.qrySearchSP.SQL.Add('select SS.DESCRIPTION ssDecc,ss.KICKOFFTYPE,ss.KICKOFFDATA,sc.SCHEDULENO, ');
    dmOptimiza.qrySearchSP.SQL.Add('  sc.SCHEDULERSETNO, ');
    dmOptimiza.qrySearchSP.SQL.Add('  sc.SCHEDULESEQUENCENO, ');
    dmOptimiza.qrySearchSP.SQL.Add('  sc.DESCRIPTION,  ');
    dmOptimiza.qrySearchSP.SQL.Add('  sc.EXECUTABLEPATH, ');
    dmOptimiza.qrySearchSP.SQL.Add('  sc.EXECUTABLE, ');
    dmOptimiza.qrySearchSP.SQL.Add('  sc.TASKACTIVE, ');
    dmOptimiza.qrySearchSP.SQL.Add('  sc.WAITTOFINISH,  ');
    dmOptimiza.qrySearchSP.SQL.Add('  sc.EXECUTABLEPARAMS ');
    dmOptimiza.qrySearchSP.SQL.Add('from schedule sc  ');
    dmOptimiza.qrySearchSP.SQL.Add('left join schedulersets ss on ss.SCHEDULERSETNO = SC.SCHEDULERSETNO');
    join:=' WHERE (';
    for i:=0 to flds.Count - 1 do
    begin
      dmOptimiza.qrySearchSP.SQL.Add(join + 'upper(ss.DESCRIPTION) like upper(''%'+  flds.Strings[i]+'%'')');
      join:=' OR ';
      dmOptimiza.qrySearchSP.SQL.Add(join + 'upper(sc.DESCRIPTION ) like upper(''%'+  flds.Strings[i]+'%'')');
      dmOptimiza.qrySearchSP.SQL.Add(join + 'upper(sc.EXECUTABLEPATH ) like upper(''%'+  flds.Strings[i]+'%'')');
      dmOptimiza.qrySearchSP.SQL.Add(join + 'upper(sc.EXECUTABLE ) like upper(''%'+  flds.Strings[i]+'%'')');
      dmOptimiza.qrySearchSP.SQL.Add(join + 'upper(sc.EXECUTABLEPARAMS ) like upper(''%'+  flds.Strings[i]+'%'')');
    end;
    if cbActive.Checked then
    begin
      dmOptimiza.qrySearchSP.SQL.Add(') AND upper(sc.TASKACTIVE) =  upper(''Y'')');
    end
    else dmOptimiza.qrySearchSP.SQL.Add(')');
    dmOptimiza.qrySearchSP.SQL.Add(' order by ss.SCHEDULERSETNO, sc.SCHEDULESEQUENCENO; ');
  end
  else if rgType.ItemIndex = 2 then
  begin
    dmOptimiza.qrySearchSP.SQL.Add('select * from export e');
    //join:=' WHERE (';
    //for i:=0 to flds.Count - 1 do
    //begin
    //  dmOptimiza.qrySearchSP.SQL.Add(join + 'upper(e.DESCRIPTION) like upper(''%'+  flds.Strings[i]+'%'')');
    //  join:=' OR ';
    //  dmOptimiza.qrySearchSP.SQL.Add(join + 'upper(E.SQLTEXT) like upper(''%'+  flds.Strings[i]+'%'')');
      {where upper(e.DESCRIPTION) like UPPER('%172%')
      or upper(E.FREEFORMTEXT) like UPPER('%172%')
      or upper(E.OUTPUTFILE) like UPPER('%172%')
      or upper(E.SQLTEXT) like UPPER('%172%'); }
   // end;
    //dmOptimiza.qrySearchSP.SQL.Add(')');
    dmOptimiza.qrySearchSP.SQL.Add(' order by e.DESCRIPTION');

  end;
  RE2.Clear;
  StartSearch;
end;

procedure TfrmMain.Split
    (const Delimiter: Char;
     Input: string;
     const Strings: TStrings) ;
 begin
    {Assert(Assigned(Strings)) ;
    Strings.Clear;
    Strings.Delimiter := Delimiter;
    Strings.DelimitedText := Input;}
    classes.ExtractStrings([Delimiter],[],PChar(Input),Strings);

 end;

procedure TfrmMain.StartSearch;
var
  SPText: TStringList;
  i:  integer;
begin
  SPText := TStringList.Create;
  RE1.Clear;
  lblSPName.Caption := 'Finished!!!';
  dmOptimiza.qrySearchSP.Open;
  dmOptimiza.qrySearchSP.First;
  if rgType.ItemIndex = 0 then
  begin
    while not dmOptimiza.qrySearchSP.Eof do begin
      SPText.Text := dmOptimiza.qrySearchSP.fieldbyName('rdb$procedure_source').AsString;
      RE1.Lines := SPText;
      lblSPName.Caption := dmOptimiza.qrySearchSP.fieldbyName('rdb$procedure_name').AsString;
      //dmOptimiza.qrySearchSP.Next;
      HighLight();
      break;
    end;
  end
  else if rgType.ItemIndex = 1 then
  begin
      RE1.Lines.Add('TASKACTIVE'
                    + Chr(9) +  'Schedule'
                    + Chr(9) +  'KICKOFFDATA'
                    + Chr(9) +  'SCHEDULESEQUENCENO'
                    + Chr(9) +  'DESCRIPTION'
                    + Chr(9) +  'EXECUTABLEPATH'
                    + Chr(9) +  'EXECUTABLE'
                    + Chr(9) +  'EXECUTABLEPARAMS'
                    );
    while not dmOptimiza.qrySearchSP.Eof do begin
      //SPText.Text := dmOptimiza.qrySearchSP.fieldbyName('rdb$procedure_source').AsString;
      //RE1.Lines := SPText;
      RE1.Lines.Add(dmOptimiza.qrySearchSP.fieldbyName('TASKACTIVE').AsString
                    + Chr(9) +  dmOptimiza.qrySearchSP.fieldbyName('ssDecc').AsString
                    + Chr(9) +  dmOptimiza.qrySearchSP.fieldbyName('KICKOFFDATA').AsString
                    + Chr(9) +  dmOptimiza.qrySearchSP.fieldbyName('SCHEDULESEQUENCENO').AsString
                    + Chr(9) +  dmOptimiza.qrySearchSP.fieldbyName('DESCRIPTION').AsString
                    + Chr(9) +  dmOptimiza.qrySearchSP.fieldbyName('EXECUTABLEPATH').AsString
                    + Chr(9) +  dmOptimiza.qrySearchSP.fieldbyName('EXECUTABLE').AsString
                    + Chr(9) +  dmOptimiza.qrySearchSP.fieldbyName('EXECUTABLEPARAMS').AsString
                    );
      dmOptimiza.qrySearchSP.Next;
    end;

    lblSPName.Caption := 'Matching Schedules';
    HighLight();
  end
  else if rgType.ItemIndex = 2 then
  begin
    while not dmOptimiza.qrySearchSP.Eof do begin
      SPText.Text := dmOptimiza.qrySearchSP.fieldbyName('SQLTEXT').AsString;
      RE1.Lines := SPText;
      lblSPName.Caption := dmOptimiza.qrySearchSP.fieldbyName('DESCRIPTION').AsString;
      //dmOptimiza.qrySearchSP.Next;
      HighLight();
      break;
    end;
  end;

  if lblSPName.Caption = 'Finished!!!' then
  begin
    for i:=0 to dmOptimiza.qrySearchSP.SQL.Count - 1 do
    begin
      RE1.Lines.Add(dmOptimiza.qrySearchSP.SQL[i]);
    end;
  end;

end;


procedure TfrmMain.HighLight();
var
  rAttrib : TTextAttributes;
  flds: TStringList;
  i,j: integer;
  mt: Boolean;
begin
  rAttrib.Font := TFont.Create;
  rAttrib.Font.Color := clWhite;
  rAttrib.Font.Size  := 9;
  rAttrib.Font.Style := [fsBold];
  rAttrib.BackColor  := clRed;

  flds := TStringList.Create;
  split('|', tbSearchFor.Text, flds);
  if (cbMatches.Checked) then
  begin
    for i:=RE1.Lines.Count -1 downto 0 do
    begin
      mt:=false;
      for j:=0 to flds.Count -1 do
      begin
        if (ansiContainsText(RE1.Lines.Strings[i],flds.Strings[j])) then
        begin
          mt:=true;
          break;
        end;

      end;
      if mt=False then
      begin
        RE1.Lines.Delete(i);
      end;
    end;
  end;

  for i:=0 to flds.Count - 1 do
  begin
    SetTextColor(RE1,flds.Strings[i],rAttrib);
  end;
end;


procedure TfrmMain.SetTextColor(oRichEdit : TRichEdit; sText : String; rAttributes : TTextAttributes);
 var
           iPos : Integer;
           iLen : Integer;

           Format: CHARFORMAT2;
 begin
           FillChar(Format, SizeOf(Format), 0);
           Format.cbSize := SizeOf(Format);
           Format.dwMask := CFM_BACKCOLOR;
           Format.crBackColor := rAttributes.BackColor;

           iPos := 0;
           iLen := Length(oRichEdit.Lines.Text) ;
           iPos := oRichEdit.FindText(sText, iPos, iLen, []);

           while (iPos > -1) do begin
                 oRichEdit.SelStart  := iPos;
                 oRichEdit.SelLength := Length(sText) ;
                 oRichEdit.SelAttributes.Color := rAttributes.Font.Color;
                 oRichEdit.SelAttributes.Size  := rAttributes.Font.Size;
                 oRichEdit.SelAttributes.Style := rAttributes.Font.Style;
                 oRichEdit.SelAttributes.Name  := rAttributes.Font.Name;

                 oRichEdit.Perform(EM_SETCHARFORMAT, SCF_SELECTION, Longint(@Format));

                 iPos := oRichEdit.FindText(sText,iPos + Length(sText),iLen, []) ;
           end;
 end;

procedure TfrmMain.btnNextClick(Sender: TObject);
var
  SPText: TStringList;
begin
  if rgType.ItemIndex = 0 then
  begin
    SPText := TStringList.Create;
    RE1.Clear;
    lblSPName.Caption := 'Finished!!!';
    dmOptimiza.qrySearchSP.Next;
    while not dmOptimiza.qrySearchSP.Eof do begin
      SPText.Text := dmOptimiza.qrySearchSP.fieldbyName('rdb$procedure_source').AsString;
      RE1.Lines := SPText;
      lblSPName.Caption := dmOptimiza.qrySearchSP.fieldbyName('rdb$procedure_name').AsString;
      //dmOptimiza.qrySearchSP.Next;
      HighLight();
      break;
    end;
  end
  else if rgType.ItemIndex = 2 then
  begin
    SPText := TStringList.Create;
    RE1.Clear;
    lblSPName.Caption := 'Finished!!!';
    dmOptimiza.qrySearchSP.Next;
    while not dmOptimiza.qrySearchSP.Eof do begin
      SPText.Text := dmOptimiza.qrySearchSP.fieldbyName('SQLTEXT').AsString;
      RE1.Lines := SPText;
      lblSPName.Caption := dmOptimiza.qrySearchSP.fieldbyName('DESCRIPTION').AsString;
      //dmOptimiza.qrySearchSP.Next;
      HighLight();
      break;
    end;
  end;
end;

procedure TfrmMain.btnPrevClick(Sender: TObject);
var
  SPText: TStringList;
begin
  if rgType.ItemIndex = 0 then
  begin
    SPText := TStringList.Create;
    RE1.Clear;
    lblSPName.Caption := 'Finished!!!';
    dmOptimiza.qrySearchSP.Prior;
    while not dmOptimiza.qrySearchSP.Eof do begin
      SPText.Text := dmOptimiza.qrySearchSP.fieldbyName('rdb$procedure_source').AsString;
      RE1.Lines := SPText;
      lblSPName.Caption := dmOptimiza.qrySearchSP.fieldbyName('rdb$procedure_name').AsString;
      //dmOptimiza.qrySearchSP.Next;
      HighLight();
      break;
    end;
  end
  else if rgType.ItemIndex = 2 then
  begin
    SPText := TStringList.Create;
    RE1.Clear;
    lblSPName.Caption := 'Finished!!!';
    dmOptimiza.qrySearchSP.Prior;
    while not dmOptimiza.qrySearchSP.Eof do begin
      SPText.Text := dmOptimiza.qrySearchSP.fieldbyName('SQLTEXT').AsString;
      RE1.Lines := SPText;
      lblSPName.Caption := dmOptimiza.qrySearchSP.fieldbyName('DESCRIPTION').AsString;
      //dmOptimiza.qrySearchSP.Next;
      HighLight();
      break;
    end;
  end;
end;

procedure TfrmMain.btnClearClick(Sender: TObject);
begin
  RE2.Clear;
end;

procedure TfrmMain.btnAddNameClick(Sender: TObject);
begin
  if rgType.ItemIndex = 0 then
  begin
    RE2.Lines.Add(lblSPName.Caption);
  end;
end;

procedure TfrmMain.lblSPNameDblClick(Sender: TObject);
begin
  if rgType.ItemIndex = 0 then
  begin
    RE2.Lines.Add(lblSPName.Caption);
  end;
end;

procedure TfrmMain.cbMatchesClick(Sender: TObject);
var
  SPText: TStringList;
begin
  if rgType.ItemIndex = 0 then
  begin
    SPText := TStringList.Create;
    RE1.Clear;
    lblSPName.Caption := 'Finished!!!';
    while not dmOptimiza.qrySearchSP.Eof do begin
      SPText.Text := dmOptimiza.qrySearchSP.fieldbyName('rdb$procedure_source').AsString;
      RE1.Lines := SPText;
      lblSPName.Caption := dmOptimiza.qrySearchSP.fieldbyName('rdb$procedure_name').AsString;
      //dmOptimiza.qrySearchSP.Next;
      HighLight();
      break;
    end;
  end
  else if rgType.ItemIndex = 2 then
  begin
    SPText := TStringList.Create;
    RE1.Clear;
    lblSPName.Caption := 'Finished!!!';
    while not dmOptimiza.qrySearchSP.Eof do begin
      SPText.Text := dmOptimiza.qrySearchSP.fieldbyName('SQLTEXT').AsString;
      RE1.Lines := SPText;
      lblSPName.Caption := dmOptimiza.qrySearchSP.fieldbyName('DESCRIPTION').AsString;
      //dmOptimiza.qrySearchSP.Next;
      HighLight();
      break;
    end;
  end;
end;

end.
