unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, ValEdit, Buttons, StdCtrls, ComCtrls, Menus,DBLogDlg,
  DBGrids;

// Ver 3.7 - Export of Report Templates
// Ver 3.8 - Export User List
// ver 3.9 - Added default location to user list.
// ver 4.0  Copy As functionality
// ver 4.1  Added ability top copy SCO templates (Type N)

type
  TfrmMain = class(TForm)
    StatusBar1: TStatusBar;
    Splitter1: TSplitter;
    Panel10: TPanel;
    BitBtn8: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel4: TPanel;
    Panel5: TPanel;
    Label1: TLabel;
    edtUserFrom: TEdit;
    Button1: TButton;
    edtUserFromNo: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    vleTemplate: TValueListEditor;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    vleUserTo: TValueListEditor;
    Panel9: TPanel;
    BitBtn7: TBitBtn;
    Label2: TLabel;
    edtDeleteFromNo: TEdit;
    edtDeleteFrom: TEdit;
    Button2: TButton;
    BitBtn10: TBitBtn;
    Memo1: TMemo;
    Label3: TLabel;
    BitBtn9: TBitBtn;
    PopupMenu1: TPopupMenu;
    Upgrade1: TMenuItem;
    N1: TMenuItem;
    RemoveSpecificRepCat1: TMenuItem;
    ReassignReportCategory1: TMenuItem;
    BitBtn11: TBitBtn;
    Button3: TButton;
    Button4: TButton;
    TabSheet3: TTabSheet;
    Label4: TLabel;
    edtUserSaveAs: TEdit;
    Button5: TButton;
    BitBtn12: TBitBtn;
    edtUserSaveAsno: TEdit;
    Label5: TLabel;
    edtTemplate: TEdit;
    edtSaveTemplateNo: TEdit;
    edtNewName: TEdit;
    Label6: TLabel;
    BitBtn13: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure Upgrade1Click(Sender: TObject);
    procedure RemoveSpecificRepCat1Click(Sender: TObject);
    procedure ReassignReportCategory1Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
  private
    { Private declarations }
    FirstShow:Boolean;
    FOverWrite:Word;
    function ValidFromUser(UserNo:String):Boolean;
    function ValidToUser(UserNo: String): Boolean;
    procedure DoCopy;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses uSelectUser, udmData, uSelectTemplate, uExportTemplate, uRemoveRepCat,
  uReAssignRepCat, uExportReportTemplate, uExportUsers;

{$R *.dfm}

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  frmSelectUser.MultiSelectOn(False);
  if frmSelectUser.ShowModal = mrOK then
  begin

    if ValidFromUser(dmData.qryUser.fieldByName('UserNo').AsString) then
    begin
      edtUserFrom.Text := dmData.qryUser.fieldByName('UserName').AsString;
      edtUserFromNo.Text := dmData.qryUser.fieldByName('UserNo').AsString;
    end;

  end;
end;

procedure TfrmMain.BitBtn1Click(Sender: TObject);
var
  RowNo: Integer;
begin

  with frmSelectUser do
  begin
    MultiSelectOn(True);
    if ShowModal = mrOK then
    begin

      if DBGrid1.SelectedRows.Count>0 then
      begin
        for RowNo:=0 to DBGrid1.SelectedRows.Count-1 do
        begin
          DBGrid1.DataSource.DataSet.GotoBookmark(pointer(DBGrid1.SelectedRows.Items[RowNo]));
          if ValidToUser(dmData.qryUser.FieldByName('UserNo').AsString) then
            vleUserTo.InsertRow(dmData.qryUser.FieldByName('UserNo').AsString,dmData.qryUser.FieldByName('UserName').AsString,True);
        end;
      end;

    end;
  end;

end;

procedure TfrmMain.BitBtn2Click(Sender: TObject);
begin

  try
    //if none selected or no user then except block will catch error
    vleUserTo.DeleteRow(vleUserTo.Row);
  except
  end;

end;

procedure TfrmMain.BitBtn3Click(Sender: TObject);
begin
  try
    while vleUserTo.RowCount>1 do
      vleUserTo.DeleteRow(vleUserTo.RowCount-1);
  except
  end;
  
end;

procedure TfrmMain.BitBtn4Click(Sender: TObject);
var
  RowNo:Integer;
begin
  if edtUserFromNo.Text = '' then
    MessageDlg('Please select the User first.',mtError,[mbOK],0)
  else
  begin
    dmData.OpenTemplate(StrToInt(edtUserFromNo.text));
    frmSelectTemplate.ShowModal;

      if frmSelectTemplate.DBGrid1.SelectedRows.Count>0 then
      begin
        for RowNo:=0 to frmSelectTemplate.DBGrid1.SelectedRows.Count-1 do
        begin
          frmSelectTemplate.DBGrid1.DataSource.DataSet.GotoBookmark(pointer(frmSelectTemplate.DBGrid1.SelectedRows.Items[RowNo]));
          vleTemplate.InsertRow(dmData.qryTemplate.FieldByName('TemplateNo').AsString,dmData.qryTemplate.FieldByName('Description').AsString,True);
        end;
      end;
  end;

end;

procedure TfrmMain.BitBtn6Click(Sender: TObject);
begin
  try
    while vleTemplate.RowCount>1 do
      vleTemplate.DeleteRow(vleTemplate.RowCount-1);
  except
  end;

end;

procedure TfrmMain.BitBtn5Click(Sender: TObject);
begin
  try
    //if none selected or no user then except block will catch error
    vleTemplate.DeleteRow(vleTemplate.Row);
  except
  end;

end;

procedure TfrmMain.BitBtn7Click(Sender: TObject);
begin
  FOverWrite := mrNo;

  if edtUserFromNo.Text = '' then
    MessageDlg('Please select a User to copy from.',mtError,[mbOK],0)
  else
  begin
    if vleTemplate.Keys[1] = '' then
      MessageDlg('Please select Template(s) to copy from.',mtError,[mbOK],0)
    else
    begin
      if vleUserTo.Keys[1] = '' then
        MessageDlg('Please select User(s) to copy to.',mtError,[mbOK],0)
      else
      begin
        DoCopy;
      end;

    end;

  end;


end;

function TfrmMain.ValidFromUser(UserNo: String): Boolean;
var
  RowNo:Integer;
begin
  Result := True;

  //cannot have same from  user in the to user list
  if vleUserTo.FindRow(UserNo,RowNo) then
  begin
    Result := False;
    MessageDlg('User already exists in the copy to list.',mtError,[mbOK],0);
  end;


end;

function TfrmMain.ValidToUser(UserNo: String): Boolean;
begin
  Result := True;

  //cannot have same from  user in the to user list
  if UserNo = edtUserFromNo.text then
  begin
    Result := False;
    MessageDlg('User '+dmData.qryUser.FieldByName('UserName').AsString+' already exists as the copy from user.',mtError,[mbOK],0);
  end;


end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
  if FirstShow then
  begin
    FirstShow := False;

    Caption := Caption + ' Ver '+dmData.kfVersionInfo;

    if not dmData.CheckInstall then
      Close;

    if not dmData.CheckRepInstall then
      Close;

  end;

end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
      FirstShow := True;

end;

procedure TfrmMain.DoCopy;
var
  FromUserNo,ToUserNo,TemplateNo,TCount,UCount:Integer;
  OldTemplateNo:integer;
begin
  FromUserNo := StrToInt(edtUserFromNo.Text);

    if not dmData.trnOptimiza.InTransaction then
      dmData.trnOptimiza.StartTransaction;

    for TCount := 1 to vleTemplate.RowCount-1 do
    begin
      TemplateNo := StrToInt(vleTemplate.Keys[TCount]);
      for UCount := 1 to vleUserTo.RowCount -1 do
      begin
        ToUserNo := StrToInt(vleUserTo.Keys[UCount]);
        OldTemplateNo := dmData.FindSameTemplate(FromUserNo,ToUserNo,TemplateNo);

      if OldTemplateNo >= 0 then
        begin

          //prompt if No or previous answer was Yes
          if (FOverWrite in [mrNo,mrYes]) then
            FOverWrite := MessageDlg('Template ' + vleTemplate.Cells[1,TCount] + ' already exists for User '+vleUserTo.Cells[1,UCount]+ '. Overwrite ? ',mtConfirmation,[mbYes,mbYesToAll,mbNo],0);


          if (FOverWrite in [mrYes,mrYesToAll]) then
          begin
            dmData.DeleteTemplate(ToUserNo,OldTemplateNo);  //delete the old one first
            dmData.CopyTemplate(FromUserNo,ToUserNo,TemplateNo,''); // then insert new
          end;

        end
        else
            dmData.CopyTemplate(FromUserNo,ToUserNo,TemplateNo,'');

      end;


    end;

    dmData.trnOptimiza.Commit;
    dmData.trnOptimiza.StartTransaction;

    MessageDlg('Copy Complete!',mtInformation,[mbOK],0);

end;

procedure TfrmMain.BitBtn9Click(Sender: TObject);
begin
  frmExportTemplate.ShowModal;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  //  frmSelectUser.MultiSelectOn(False);
  if frmSelectUser.ShowModal = mrOK then
  begin

    //if ValidFromUser(dmData.qryUser.fieldByName('UserNo').AsString) then
    //begin
      edtDeleteFrom.Text := dmData.qryUser.fieldByName('UserName').AsString;
      edtDeleteFromNo.Text := dmData.qryUser.fieldByName('UserNo').AsString;
    //end;

  end;

end;

procedure TfrmMain.BitBtn10Click(Sender: TObject);
var
  RowNo:Integer;
  ErrMsg:String;
begin

  if edtDeleteFromNo.Text = '' then
    MessageDlg('Please select the User first.',mtError,[mbOK],0)
  else
  begin


    dmData.OpenTemplate(StrToInt(edtDeleteFromNo.text));
    if frmSelectTemplate.ShowModal =mrOK then
    begin

      if frmSelectTemplate.DBGrid1.SelectedRows.Count>0 then
      begin
        if MessageDlg('Deletion about to start, Continue?',mtConfirmation,[mbYes,MbNo],0) = mrYes then
        begin
          for RowNo:=0 to frmSelectTemplate.DBGrid1.SelectedRows.Count-1 do
          begin
            frmSelectTemplate.DBGrid1.DataSource.DataSet.GotoBookmark(pointer(frmSelectTemplate.DBGrid1.SelectedRows.Items[RowNo]));
            ErrMsg := dmData.FindReportTemplate(dmData.qryTemplate.FieldByName('TemplateNo').AsInteger);

            if ErrMsg = '' then
            begin
              dmData.DeleteTemplate(dmData.qryTemplate.FieldByName('UserNo').AsInteger,
                                  dmData.qryTemplate.FieldByName('TemplateNo').AsInteger);
              Memo1.Lines.Add(Format('User No %d Template No %d ...deleted',[dmData.qryTemplate.FieldByName('UserNo').AsInteger,
                                        dmData.qryTemplate.FieldByName('TemplateNo').AsInteger]));
            end
            else
            begin
              ErrMsg := 'Cannot Delete Template: ' +dmData.qryTemplate.FieldByName('Description').AsString +#10+ErrMsg;

              MessageDlg(ErrMsg,mtError,[mbOK],0);
              Memo1.Lines.Add(Format('User No %d Template No %d ...NOT deleted',[dmData.qryTemplate.FieldByName('UserNo').AsInteger,
                                        dmData.qryTemplate.FieldByName('TemplateNo').AsInteger]));
            end;


          end;

          dmData.trnOptimiza.Commit;
          dmData.trnOptimiza.StartTransaction;
          Memo1.Lines.Add('Deletion complete');
          Memo1.Lines.Add('-----------------');
        end
        else
          Memo1.Lines.Add('...Deletion Cancelled');

      end
      else
        Memo1.Lines.Add('Nothing to delete');

    end
    else
        Memo1.Lines.Add('...Deletion Cancelled');


  end;


end;

procedure TfrmMain.Upgrade1Click(Sender: TObject);
begin
dmData.Upgrade;
end;

procedure TfrmMain.RemoveSpecificRepCat1Click(Sender: TObject);
begin
  frmRemoveRepCat.showModal;
end;

procedure TfrmMain.ReassignReportCategory1Click(Sender: TObject);
begin
frmReAssignRepCat.showModal;
end;

procedure TfrmMain.BitBtn11Click(Sender: TObject);
var
  UserPassword,UserName:String;
begin

  UserName := 'ADMIN';
  UserPassword := '';

  if LoginDialogEx('Optimiza',UserName,UserPassword,True) then
  begin
   if UpperCase(UserPassword) = 'LEXADMIN' then
   begin

     if (MessageDlg('Do you wish to enable visibility of Admin templates ?',mtConfirmation,[mbYes,mbNo],0) = mrYes) then
       dmData.FAdminUser := True
     else
       dmData.FAdminUser := False;

   end
   else
     MessageDlg('Invalid Password',mtError,[mbOK],0);

  end;

end;

procedure TfrmMain.Button4Click(Sender: TObject);
begin
  frmExportUsers.ShowModal;
end;

procedure TfrmMain.Button3Click(Sender: TObject);
begin
  frmExportReportTemplate.ShowModal;
end;

procedure TfrmMain.Button5Click(Sender: TObject);
begin
 //  frmSelectUser.MultiSelectOn(False);
  if frmSelectUser.ShowModal = mrOK then
  begin

    //if ValidFromUser(dmData.qryUser.fieldByName('UserNo').AsString) then
    //begin
      edtUserSaveAs.Text := dmData.qryUser.fieldByName('UserName').AsString;
      edtUserSaveAsNo.Text := dmData.qryUser.fieldByName('UserNo').AsString;
    //end;

  end;
end;


procedure TfrmMain.BitBtn12Click(Sender: TObject);
var
  Rowno:Integer;
begin
  if edtUserSaveAsNo.Text = '' then
    MessageDlg('Please select the User first.',mtError,[mbOK],0)
  else
  begin


    dmData.OpenTemplate(StrToInt(edtUserSaveAsNo.Text));
    frmSelectTemplate.DBGrid1.Options := [dgColumnResize,dgColLines,dgRowLines,dgTabs];

    if frmSelectTemplate.ShowModal =mrOK then
    begin
         //frmSelectTemplate.DBGrid1
      //if frmSelectTemplate.DBGrid1. .SelectedRows.Count>0 then
      //begin

          //for RowNo:=0 to frmSelectTemplate.DBGrid1.SelectedRows.Count-1 do
          //begin
            //frmSelectTemplate.DBGrid1.DataSource.DataSet.GotoBookmark(pointer(frmSelectTemplate.DBGrid1.SelectedRows.Items[RowNo]));


            edtSaveTemplateNo.Text := dmData.qryTemplate.FieldByName('TemplateNo').AsString;
            edtTemplate.Text := dmData.qryTemplate.FieldByName('Description').AsString;

            edtNewName.Text := 'Copy of ' +edtTemplate.Text ;


          //end;
      //end;
    end;

    frmSelectTemplate.DBGrid1.Options := [dgColumnResize,dgColLines,dgRowLines,dgTabs,dgMultiSelect];

  end;

end;

procedure TfrmMain.BitBtn13Click(Sender: TObject);
var
  UserNo, TempNo, OldTempNo:Integer;
  DialogRes:Word;
begin

  if (edtUserSaveAsno.Text = '') then
    MessageDlg('Please select the User first.',mtError,[mbOK],0)
  else
  begin
    if (edtSaveTemplateNo.Text = '') then
      MessageDlg('Please select the Template.',mtError,[mbOK],0)
    else
    begin
      if ((edtNewName.Text = '') or (edtTemplate.Text=edtNewName.Text)) then
        MessageDlg('Please enter a new name for the Template.'+#10+'The new name cannot be the same as the existing template name.',mtError,[mbOK],0)
      else
      begin
        UserNo := strToInt(edtUserSaveAsno.Text);
        TempNo := strToInt(edtSaveTemplateNo.Text);
        //OldTempNo := dmData.FindSameTemplateName(UserNo,UserNo,edtNewName.Text);

        //if ( OldTempNo > 0) then
        //begin
        //  DialogRes := MessageDlg('Template ' + edtNewName.Text + ' already exists. Overwrite ?'+#10+'Click Cancel to go back and re-enter a template name ',mtConfirmation,[mbYes,mbNo,mbCancel],0);
        //  if  DialogRes  = mrYes then
        //    dmData.DeleteTemplate(UserNo,OldTempNo);  //delete the old one first
        //end;

        //if DialogRes <> mrCancel then
        //begin
          dmData.CopyTemplate(UserNo,UserNo,TempNo,edtNewName.Text);
          MessageDlg('Template Copied!',mtInformation,[mbOK],0);
        //end;
      end;

    end;

  end;


end;

end.
