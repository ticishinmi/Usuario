unit UCadUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UCadPadrao, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.Provider, Data.DB, Datasnap.DBClient, UFuncao;

type
  TFCadUsuario = class(TFPadrao)
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBCheckBox1: TDBCheckBox;
    PnData: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    DBText1: TDBText;
    DBText2: TDBText;
    DBEdit2: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Label7: TLabel;
    Label8: TLabel;
    DBComboBox1: TDBComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCadUsuario: TFCadUsuario;

implementation

{$R *.dfm}

uses UDM;

procedure TFCadUsuario.btSalvarClick(Sender: TObject);
begin
  btSalvar.SetFocus;
  if DM.cdsUsuarioUSU_EMAIL.AsString <> '' then
  begin
     if ValidarEMail(DBEdit3.Text) = False then
     begin
         MessageDlg('E-mail informado � inv�lido!', mtWarning, [MBOk], 0);
         DBEdit3.SetFocus;
         Exit;
     end;
     DM.QuBusca.Close;
     DM.QuBusca.SQL.Clear;
     DM.QuBusca.SQL.Add('Select * from usuario where usu_email = '+#39+DM.cdsUsuarioUSU_EMAIL.AsString+#39+
     ' and usu_cod <> '+DM.cdsUsuarioUSU_COD.AsString);
     DM.QuBusca.Open;
     if DM.QuBusca.RecordCount > 0 then
     begin
         MessageDlg('J� existe um usu�rio cadastrado com o e-mail informado!', mtWarning, [MBOK], 0);
         DBEdit3.SetFocus;
         Exit;
     end;
  end;
  inherited;
end;

procedure TFCadUsuario.FormCreate(Sender: TObject);
begin
  Conexao    := DM.Connection;
  Transacao  := DM.Transaction;
  CDSPadrao  := DM.cdsusuario;
  DSPadrao   := DM.dsUsuario;
  TableName  := 'USUARIO';
  ChaveTable := 'USU_COD';
  CampoLabel := 'USU_NOME';
  Descricao  := 'C�digo';

  inherited;
end;

end.
