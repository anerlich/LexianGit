unit uFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmFilter = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    memWhere: TMemo;
    Panel2: TPanel;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    Panel3: TPanel;
    memFields: TMemo;
    Splitter1: TSplitter;
    Panel4: TPanel;
    Label3: TLabel;
    Panel5: TPanel;
    memJoin: TMemo;
    Splitter2: TSplitter;
    Panel6: TPanel;
    Label4: TLabel;
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure EnableIt;
  end;

var
  frmFilter: TfrmFilter;

implementation

{$R *.dfm}

procedure TfrmFilter.CheckBox1Click(Sender: TObject);
begin
  EnableIT;
end;

procedure TfrmFilter.EnableIt;
begin
  memWhere.Enabled := checkBox1.Checked;
  memFields.Enabled := checkBox1.Checked;
  memJoin.Enabled := checkBox1.Checked;

end;

end.
