program Usuario;

uses
  Vcl.Forms,
  UDM in 'UDM.pas' {DM: TDataModule},
  UPrinc in 'UPrinc.pas' {FPrinc},
  UPesquisaIBO in 'UPesquisaIBO.pas' {FPesquisaIBO},
  UCadPadrao in 'UCadPadrao.pas' {FPadrao},
  UCadUsuario in 'UCadUsuario.pas' {FCadUsuario},
  UFuncao in 'UFuncao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFPrinc, FPrinc);
  Application.Run;
end.