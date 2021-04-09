unit uGroup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, ExtCtrls;

type
  TfrmGroup = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Panel1: TPanel;
    chkFromData: TCheckBox;
    ComboBox3: TComboBox;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    chkSpecificValue: TCheckBox;
    Edit1: TEdit;
    Panel2: TPanel;
    ComboBox1: TComboBox;
    Panel3: TPanel;
    ComboBox2: TComboBox;
    Panel4: TPanel;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel5: TPanel;
    Label7: TLabel;
    lblGroup: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    CheckBox1: TCheckBox;
    ComboBox4: TComboBox;
    CheckBox2: TCheckBox;
    Edit2: TEdit;
    ComboBox5: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBox1Change(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure chkSpecificValueClick(Sender: TObject);
    procedure chkFromDataClick(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure DBLookupComboBox1CloseUp(Sender: TObject);
    procedure DBLookupComboBox2CloseUp(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure ComboBox5Change(Sender: TObject);
  private
    { Private declarations }
    procedure DisableCombo;
    procedure EnableCombo;
    procedure GroupOrUser;
  public
    { Public declarations }
    SQLString: String;
  end;

var
  frmGroup: TfrmGroup;

implementation

uses uDmUpdateSpecial;

{$R *.DFM}

procedure TfrmGroup.FormShow(Sender: TObject);
begin
  dmUpdateSpecial.OpenGroups;
  SQLString := '';

end;

procedure TfrmGroup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dmUpdateSpecial.CloseGroups;

end;
procedure TfrmGroup.DisableCombo;
begin
  DBLookupComboBox1.Visible := False;
  DBLookupComboBox2.Visible := False;
  ComboBox3.Visible := False;
  ComboBox5.Visible := False;
end;

procedure TfrmGroup.EnableCombo;
begin

  with ComboBox1 do
  begin


    if Text = 'Criticality' then
    begin
      ComboBox5.Visible := True;
      Label11.Caption := ComboBox5.Text;

    end
    else
    begin
      if Text = 'Pareto Category' then
      begin
        ComboBox3.Visible := True;
        Label11.Caption := ComboBox3.Text;

      end
      else
        if Text = 'Supplier' then
        begin
          DBLookupComboBox1.Visible := True ;
          Label11.Caption := DbLookupComboBox1.Text;
        end
        else
          begin
            if Text = 'Group Major' then
                  DBLookupComboBox2.ListSource := dmUpdateSpecial.srcGroupMajor;

            if Text = 'Group Minor 1' then
                  DBLookupComboBox2.ListSource := dmUpdateSpecial.srcGroupMinor1;

            if Text = 'Group Minor 2' then
                  DBLookupComboBox2.ListSource := dmUpdateSpecial.srcGroupMinor2;


            DBLookupComboBox2.Visible := True ;
            Label11.Caption := DbLookupComboBox2.Text;
          end;


      end;
    end;

end;

procedure TfrmGroup.ComboBox1Change(Sender: TObject);
begin

  //disbale all combos then enable only the applicable ones.
  DisableCombo;
  EnableCombo;
  lblGroup.Caption := ComboBox1.Text;
  chkSpecificValue.Enabled := True;
  chkFromData.Enabled := True;

  if chkFromData.State = cbChecked then
    Edit1.Enabled := False
  Else
    Edit1.Enabled := True;

  //Force Paretco Cat to specific values
  if ComboBox1.Text = 'Pareto Category' then
  begin
    chkSpecificValue.Enabled := False;
    Edit1.Enabled := False;
    chkFromData.Checked := True;
    chkFromData.Enabled := False;
  end;

  //Force Paretco Cat to specific values
  if ComboBox1.Text = 'Criticality' then
  begin
    chkSpecificValue.Enabled := False;
    Edit1.Enabled := False;
    chkFromData.Checked := True;
    chkFromData.Enabled := False;
  end;

end;

procedure TfrmGroup.BitBtn2Click(Sender: TObject);
begin
  SQLString := '';
end;

procedure TfrmGroup.BitBtn1Click(Sender: TObject);
Var
  ItemText, DelimText, GroupNoText, GroupCodeText, TableName, FieldData: String;
begin

  if CheckBox1.State = cbChecked then
  begin

    if ComboBox1.Text = 'Criticality' then
    begin
     if chkSpecificValue.Checked then
       FieldData := Edit1.Text
     Else
       FieldData := ComboBox5.Text;

     SQLString := 'Criticality ' + ComboBox2.text + ' '+
                    FieldData + ''
    end
    else
    begin
      if ComboBox1.Text = 'Pareto Category' then
      begin
       if chkSpecificValue.Checked then
         FieldData := Edit1.Text
       Else
         FieldData := ComboBox3.Text;

       SQLString := 'ParetoCategory ' + ComboBox2.text + ' "'+
                      FieldData + '"'
      end
      else
      begin
        TableName := StringReplace(ComboBox1.Text, ' ', '',[rfReplaceAll]);

        If TableName = 'Supplier' then
        begin
          ItemText := 'SupplierNo1';
          GroupNoText := 'SupplierNo';
          GroupCodeText := 'SupplierCode';
          FieldData := DBLookupComboBox1.Text;
        end
        else
        begin
          ItemText := TableName;
          GroupNoText := 'GroupNo';
          GroupCodeText := 'GroupCode';
          FieldData := DBLookupComboBox2.Text;
        end;   //if tablename

        SQLString := ItemText + ' in (Select '+ GroupNoText + ' From '+TableName +
                   ' where '+GroupCodeText+' ' + ComboBox2.text + ' "' + FieldData + '")';


      end; //if combobox1
    end;
  end
  Else
  begin

    If ComboBox4.Text = '(None)' then
      SQLString := ''
    else
    begin
      ItemText := Copy(ComboBox4.Text,Pos('(',ComboBox4.Text)+1,Length(ComboBox4.Text)-1);
      ItemText := Copy(ItemText,1,Length(ItemText)-1);
      SQLString := ItemText + ' ' + ComboBox2.text;

      if Pos('Char',ItemText) > 0 then
        DelimText := '"'
      Else
        DelimText := '';

      SQlString := SQLString + ' ' + DelimText + Edit2.text + DelimText;
    end; //if combobox4

  end; //if checkbox1

end;

procedure TfrmGroup.chkSpecificValueClick(Sender: TObject);
begin
  chkFromData.Checked :=not (chkSpecificValue.State = cbChecked);

  if chkFromData.State = cbUnchecked then
  begin
    disableCombo;
    Edit1.Enabled := True;
  end
  else
  begin
    disableCombo;
    enableCombo ;
    Edit1.Enabled := False;
  end;

  if Edit1.Enabled then label11.Caption := Edit1.Text;

end;

procedure TfrmGroup.chkFromDataClick(Sender: TObject);
begin
  chkSpecificValue.Checked := not (chkFromData.State = cbChecked);

  if chkSpecificValue.State = cbChecked then
  begin
    disableCombo;
    Edit1.Enabled := True;
  end
  else
  begin
    disableCombo;
    enableCombo ;
    Edit1.Enabled := False;
  end;


  if Edit1.Enabled then label11.Caption := Edit1.Text;

end;

procedure TfrmGroup.ComboBox2Change(Sender: TObject);
begin
  Label12.caption := ComboBox2.Text;
end;

procedure TfrmGroup.Edit1Change(Sender: TObject);
begin
  Label11.Caption := Edit1.Text;
end;

procedure TfrmGroup.ComboBox3Change(Sender: TObject);
begin
  Label11.Caption := ComboBox3.Text;

end;

procedure TfrmGroup.DBLookupComboBox1CloseUp(Sender: TObject);
begin
      Label11.Caption := DBLookupComboBox1.Text;

end;

procedure TfrmGroup.DBLookupComboBox2CloseUp(Sender: TObject);
begin
  Label11.Caption := DBLookupComboBox2.Text;

end;

procedure TfrmGroup.FormCreate(Sender: TObject);
begin
  SetWindowLong(BitBtn3.Handle, GWL_STYLE,
    GetWindowLong(BitBtn3.Handle, GWL_STYLE)
    or BS_MULTILINE);
  BitBtn3.Caption := 'Specify '#13'Another'#13'Condition';

  ComboBox4.Items := dmUpdateSpecial.GetUserFields;
  

end;

procedure TfrmGroup.CheckBox1Click(Sender: TObject);
begin
  CheckBox2.Checked := not CheckBox1.Checked;
  ComboBox1.Enabled := not ComboBox1.Enabled;
  GroupOrUser;
end;

procedure TfrmGroup.CheckBox2Click(Sender: TObject);
begin
  CheckBox1.Checked := not CheckBox2.Checked;
  ComboBox4.Enabled := not ComboBox4.Enabled;
  GroupOrUser;
end;

procedure TfrmGroup.GroupOrUser;
begin

  if Checkbox1.State = cbChecked then
  begin
     Edit1.Visible := True;
     Edit2.Visible := False;
     chkFromData.Visible := True;
     chkSpecificValue.Visible := True;
     ComboBox1Change(nil);
  end
  else
  begin
     Edit1.Visible := False;
     Edit2.Visible := True;
     chkFromData.Visible := False;
     chkSpecificValue.Visible := False;
     ComboBox3.Visible := False;
     ComboBox5.Visible := False;
     DBLookupComboBox1.Visible := False;
     DBLookupComboBox2.Visible := False;
     ComboBox4Change(nil);
  end;


end;

procedure TfrmGroup.ComboBox4Change(Sender: TObject);
begin
  lblGroup.Caption := Copy(ComboBox4.Text,1,Pos('(',ComboBox4.text)-1);

end;

procedure TfrmGroup.ComboBox5Change(Sender: TObject);
begin
  Label11.Caption := ComboBox5.Text;

end;

end.
