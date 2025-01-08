unit UPrinc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Menus, IniFiles,
  FireDAC.Stan.Intf, FireDAC.Phys, FireDAC.Phys.IBBase, FireDAC.Phys.FB,Midas, MidasLib,
  Vcl.XPMan, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, Vcl.StdCtrls;

type
  TFPrinc = class(TForm)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Usurio1: TMenuItem;
    PopupMenu1: TPopupMenu;
    Usuario1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Usurio1Click(Sender: TObject);
  private
    FCodUsuario: Integer;
    FUsuario: string;
    FLogUsuario: string;
    { Private declarations }
  public
    property CodUsuario: Integer read FCodUsuario write FCodUsuario default 0;
    property Usuario: string read FUsuario write FUsuario;
    property LogUsuario: string read FLogUsuario write FLogUsuario;
    { Public declarations }
  end;

var
  FPrinc: TFPrinc;

implementation

{$R *.dfm}

uses UFuncao, UCadUsuario, UDM;

procedure TFPrinc.FormCreate(Sender: TObject);
begin
  Caption := 'Teste Linx - Vers�o ' + GetBuildInfo;
end;

procedure TFPrinc.FormShow(Sender: TObject);
var
  varConexao, varArqIni: String;
begin
  CaminhoEXE := ExtractFilePath(Application.ExeName);
  ArqIni     := tIniFile.Create(CaminhoEXE + 'opcoes.txt');

  try
    with DM.Connection do
    begin
      Connected := False;
      Params.Clear;
      Params.Values['Database']     := ArqIni.ReadString('CONFIGURACAO', 'Database', '');
      Params.Values['DriverID']     := ArqIni.ReadString('CONFIGURACAO', 'DriverID', '');
      Params.Values['User_Name']    := ArqIni.ReadString('CONFIGURACAO', 'User_Name', '');
      Params.Values['Password']     := ArqIni.ReadString('CONFIGURACAO', 'Password', '');
      Params.Values['CharacterSet'] := ArqIni.ReadString('CONFIGURACAO', 'CharacterSet', '');
      Params.Values['Server']       := ArqIni.ReadString('CONFIGURACAO', 'Server', '');

      Connected := True;
    end;
  except
    MessageDLG('Caminho do banco de dados de origem est� incorreto, verifique as configura��es no arquivo opcao.txt',
      mtInformation, [mbOk], 0);
    Application.Terminate;
  end;
end;

procedure TFPrinc.Usurio1Click(Sender: TObject);
begin
  AbrirDestruirForm(FCadUsuario, TFCadUsuario);
end;



end.