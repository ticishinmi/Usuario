unit UCadCategoria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, UBotaoFrame, Mask, DBCtrls, DB, Menus;

type
  TFCadCategoria = class(TForm)
    GroupBox1: TGroupBox;
    FBotaoFrame1: TFBotaoFrame;
    BtConsultar: TBitBtn;
    BtFechar: TBitBtn;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    DBComboBox1: TDBComboBox;
    PopupMenu1: TPopupMenu;
    Sair1: TMenuItem;
    procedure BtFecharClick(Sender: TObject);
    procedure FBotaoFrame1BtNovoClick(Sender: TObject);
    procedure FBotaoFrame1BtAlterarClick(Sender: TObject);
    procedure FBotaoFrame1BtSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DBEdit1Enter(Sender: TObject);
    procedure DBEdit1Exit(Sender: TObject);
    procedure FBotaoFrame1BtCancelarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Novacidade1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
  private
        procedure FocarCampo(varCampo: String);  
    { Private declarations }
  public
    { Public declarations }
  end;


var
  FCadCategoria: TFCadCategoria;

implementation

uses UDM, UFuncao, UDM2;

{$R *.dfm}

procedure TFCadCategoria.FocarCampo(varCampo: String);
var i: integer;
begin
  For i := 0 To ComponentCount -1 Do
  begin
     If Components[i] is TDbEdit then
      begin
       If TDBEdit (Components[i]).DataField = varCampo then
        begin
          TDBEdit(Components[i]).SetFocus;
          Abort;
        end;
      end;
     If Components[i] is TDBComboBox then
      begin
       If TDBComboBox (Components[i]).DataField = varCampo then
        begin
          TDBComboBox(Components[i]).SetFocus;
          Abort;
        end;
      end;

  end;
end;

procedure TFCadCategoria.BtFecharClick(Sender: TObject);
begin
    close;
end;

procedure TFCadCategoria.FBotaoFrame1BtNovoClick(Sender: TObject);
begin
  FBotaoFrame1.BtNovoClick(Sender);
  GroupBox1.Enabled:=true;
  GroupBox2.Enabled:=false;
  DBEdit2.setfocus();
end;

procedure TFCadCategoria.FBotaoFrame1BtAlterarClick(Sender: TObject);
begin
  GroupBox1.Enabled:=true;
  GroupBox2.Enabled:=true;
  FBotaoFrame1.BtAlterarClick(Sender);
  DBEdit2.SetFocus;
end;

procedure TFCadCategoria.FBotaoFrame1BtSalvarClick(Sender: TObject);
begin
  FocarCampo(VerificaCamposTabela(DM2.TbCategoria));
  FBotaoFrame1.BtSalvarClick(Sender);
  GroupBox1.Enabled:=false;
  GroupBox2.Enabled:=false;
end;

procedure TFCadCategoria.FormShow(Sender: TObject);
begin
    DM2.TbCategoria.Close;
    DM2.TbCategoria.Sql.Clear;
    DM2.TbCategoria.SQL.Add('Select * from Categoria order by cat_desc');
    DM2.TbCategoria.Open;
    FBotaoFrame1.QueryTemp := DM2.TbCategoria;
    FBotaoFrame1.DBNavigator1.DataSource:= DM2.DsCategoria;
    FBotaoFrame1.entrar;
    GroupBox1.Enabled:=false;
    GroupBox2.Enabled:=false;
    FBotaoFrame1.BtNovo.SetFocus;
end;

procedure TFCadCategoria.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
if Dm2.DsCategoria.State in [dsInsert, dsEdit] then
     begin
        MessageDLG ('Salve ou Cancela a operação', mtError, [MbOk],0);
        CanClose := false;
     end;
end;

procedure TFCadCategoria.DBEdit1Enter(Sender: TObject);
begin
   mudarCorEntra(Sender);
end;

procedure TFCadCategoria.DBEdit1Exit(Sender: TObject);
begin
   mudarCorSair(Sender);
end;

procedure TFCadCategoria.FBotaoFrame1BtCancelarClick(Sender: TObject);
begin
 if Application.MessageBox('Deseja cancelar o registro atual?','Confirme',
 MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then
 begin
    Exit;
 end
 else
 begin
  FBotaoFrame1.BtCancelarClick(Sender);
  GroupBox1.Enabled:=false;
  GroupBox2.Enabled:=false;
 end;
end;

procedure TFCadCategoria.FormKeyPress(Sender: TObject; var Key: Char);
begin
    If Key = #13 Then
      begin
        Key := #0;
        Perform(Wm_NextDlgCtl, 0, 0);
      end;
end;

procedure TFCadCategoria.Novacidade1Click(Sender: TObject);
begin
  FBotaoFrame1.BtNovoClick(Sender);
  GroupBox1.Enabled:=true;
  GroupBox2.Enabled:=false;
  DBEdit2.setfocus();
end;

procedure TFCadCategoria.Sair1Click(Sender: TObject);
begin
    close;
end;

end.





