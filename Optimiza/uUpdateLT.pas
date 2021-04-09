unit uUpdateLT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, StdCtrls, ExtCtrls, Buttons, ComCtrls;

type
  TfrmUpdateLT = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Button1: TButton;
    Button2: TButton;
    GroupBox2: TGroupBox;
    ListBox3: TListBox;
    ListBox4: TListBox;
    Label4: TLabel;
    Label5: TLabel;
    Button3: TButton;
    Button4: TButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    procedure BuildList;
    procedure RunWithParam;
  public
    { Public declarations }
  end;

var
  frmUpdateLT: TfrmUpdateLT;
  FirstLoad : Boolean;
implementation

uses uDmUpdateLT;

{$R *.DFM}

procedure TfrmUpdateLT.FormCreate(Sender: TObject);
begin
   FirstLoad := True;

end;

procedure TfrmUpdateLT.FormActivate(Sender: TObject);
begin
   If firstLoad Then
   Begin
     FirstLoad := False;
     StatusBar1.Panels[0].Text := dmUpdateLT.dbOptimiza.DatabaseName;

     If ParamCount > 0 then
     begin
       RunWithParam;
       BitBtn1.Click;
       dmUpdateLt.FireEvent('S');
       Close;
     end
     else
     begin
       BuildList;
     end;

   end;

end;

procedure TfrmUpdateLT.Button2Click(Sender: TObject);
begin

  If ListBox2.ItemIndex > -1 then
  begin
    ListBox1.Items.Add(ListBox2.Items[ListBox2.ItemIndex]);
    ListBox2.Items.Delete(ListBox2.ItemIndex);
  end;

end;

procedure TfrmUpdateLT.Button1Click(Sender: TObject);
begin

  If ListBox1.ItemIndex > -1 then
  begin
    ListBox2.Items.Add(ListBox1.Items[ListBox1.ItemIndex]);
    ListBox1.Items.Delete(ListBox1.ItemIndex);
  end;

end;

procedure TfrmUpdateLT.Button3Click(Sender: TObject);
begin
  If ListBox4.ItemIndex > -1 then
  begin
    ListBox3.Items.Add(ListBox4.Items[ListBox4.ItemIndex]);
    ListBox4.Items.Delete(ListBox4.ItemIndex);
  end;

end;

procedure TfrmUpdateLT.Button4Click(Sender: TObject);
begin

  If ListBox3.ItemIndex > -1 then
  begin
    ListBox4.Items.Add(ListBox3.Items[ListBox3.ItemIndex]);
    ListBox3.Items.Delete(ListBox3.ItemIndex);
  end;

end;

procedure TfrmUpdateLT.BitBtn1Click(Sender: TObject);
Var
 LeadTime: Real;
begin
   Panel1.Refresh;
   Panel2.Refresh;
   Panel3.Refresh;
   
  If ListBox1.Items.Count < 1 then
     MessageDlg('Please select at least one LOCATION',mtError,[mbOK],0)
  else
  Begin

    If ListBox3.Items.Count < 1 then
     MessageDlg('Please select at least one SUPPLIER',mtError,[mbOK],0)
    else
    Begin

     try
      LeadTime := StrToFloat(Edit1.text);
      dmUpdateLt.UpdateLt(LeadTime,ListBox1,ListBox3);
      If ParamCount = 0 then
      MessageDlg('LT Update Complete !!',mtInformation,[mbOK],0);

     except
       MessageDlg('Please enter a valid Lead Time',mtError,[mbOK],0);
     end;

    end;

  end;

end;

procedure TfrmUpdateLT.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmUpdateLT.BuildList;
begin
       With dmUpdateLT.srcAllLocations.DataSet do
       Begin
         First;
         ListBox2.Items.Clear;

         while not Eof do
         Begin
           ListBox2.Items.Add(FieldByName('LocationCode').AsString + ' ; '+FieldByName('Description').AsString);
           Next;

         end;

       end;

       With dmUpdateLT.srcSuppliers.DataSet do
       Begin
         First;
         ListBox4.Items.Clear;

         while not Eof do
         Begin
           ListBox4.Items.Add(FieldByName('SupplierCode').AsString );
           Next;

         end;

       end;

end;

procedure TfrmUpdateLT.RunWithParam;
var
  LocationList, SupplierList, TheCode: String;
  CountChar: Integer;
begin
  Edit1.text := Paramstr(1);    //Lead Time
  LocationList := Paramstr(2);
  SupplierList := ParamStr(3);
  ListBox1.Items.Clear;
  ListBox3.Items.Clear;

  TheCode := '';

  For CountChar := 1 to Length(LocationList) do
  begin
    If Copy(LocationList,CountChar,1) = ';' Then
    Begin
      ListBox1.Items.Add(TheCode+' ;') ;
      TheCode := '';
    end
    else
      If Copy(LocationList,CountChar,1) <> ' ' Then
         TheCode := TheCode + Copy(LocationList,CountChar,1);

  end;

  If TheCode <> '' Then ListBox1.Items.Add(TheCode+' ;') ;

  TheCode := '';

  For CountChar := 1 to Length(SupplierList) do
  begin
    If Copy(SupplierList,CountChar,1) = ';' Then
    begin
      ListBox3.Items.Add(TheCode);
      TheCode := '';
    end
    else
      If Copy(SupplierList,CountChar,1) <> ' ' Then
         TheCode := TheCode + Copy(SupplierList,CountChar,1);

  end;

  If TheCode <> '' Then ListBox3.Items.Add(TheCode)   ;

end;

end.
