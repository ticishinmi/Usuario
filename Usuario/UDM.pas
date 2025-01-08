unit UDM;

interface

uses
  SysUtils, Classes, IBCustomDataSet, IBUpdateSQL, DB, IBQuery, IBDatabase,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Comp.Client, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.Phys.IBBase, FireDAC.Phys.FB, frxCross, frxClass, frxCrypt, frxGZip,
  frxRich, frxBarcode, frxChart, frxGradient, frxDesgn, frxDMPExport,
  frxExportImage, frxExportText, frxExportRTF, frxExportPDF, Graphics, Dialogs,
  System.DateUtils, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, Datasnap.Provider, Datasnap.DBClient;

type
  TDM = class(TDataModule)
    Connection: TFDConnection;
    Transaction: TFDTransaction;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    QuGerarID: TFDQuery;
    QuBuscarString: TFDQuery;
    QuBuscaCalcFields: TFDQuery;
    QuBusca: TFDQuery;
    cdsUsuario: TClientDataSet;
    dsUsuario: TDataSource;
    dspUsuario: TDataSetProvider;
    fqUsuario: TFDQuery;
    cdsUsuarioUSU_COD: TIntegerField;
    cdsUsuarioUSU_NOME: TStringField;
    cdsUsuarioUSU_USUARIO: TStringField;
    cdsUsuarioUSU_SENHA: TStringField;
    cdsUsuarioUSU_EMAIL: TStringField;
    cdsUsuarioUSU_PAINEL: TStringField;
    cdsUsuarioUSU_DTCRIA: TDateField;
    cdsUsuarioUSU_DTATU: TDateField;
    cdsUsuarioUSU_STATUS: TStringField;
    procedure cdsUsuarioNewRecord(DataSet: TDataSet);
    procedure cdsUsuarioBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

uses UFuncao;

{$R *.dfm}

procedure TDM.cdsUsuarioBeforePost(DataSet: TDataSet);
begin
  cdsUsuarioUSU_DTATU.AsDateTime:= Date;
end;

procedure TDM.cdsUsuarioNewRecord(DataSet: TDataSet);
begin
  cdsUsuarioUSU_COD.AsInteger  := StrToInt(GerarID('GEN_USUARIO'));
  cdsUsuarioUSU_STATUS.AsString        := 'SIM';
  cdsUsuarioUSU_DTCRIA.AsDateTime:= Date;
end;

end.
