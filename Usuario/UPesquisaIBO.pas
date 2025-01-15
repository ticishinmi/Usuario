unit UPesquisaIBO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids,IniFiles, Data.DBXJSON,
  IBQuery, DB, DBClient, Mask, Gauges, ComCtrls, Menus, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, REST.Response.Adapter, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL;

type
  THackDBGrid = class(TDBGrid);
  TFPesquisaIBO = class(TForm)
    Panel1: TPanel;
    CbConsultarPor: TComboBox;
    Label1: TLabel;
    CbTipo: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    DBGrid1: TDBGrid;
    BtPesquisar: TButton;
    DsConsulta: TDataSource;
    EdCons: TMaskEdit;
    Panel2: TPanel;
    Gauge1: TGauge;
    Label4: TLabel;
    LbConsPor: TLabel;
    LbEntrada: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    LbTotalReg: TLabel;
    Label5: TLabel;
    PopupMenu1: TPopupMenu;
    Focarentrada1: TMenuItem;
    LbProgress: TLabel;
    Panel3: TPanel;
    Button1: TButton;
    Sair1: TMenuItem;
    StatusBar1: TStatusBar;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Memo1: TMemo;
    QuConsulta2: TFDMemTable;
    QuConsulta: TFDQuery;
    DsConsulta2: TDataSource;
    IdHTTP1: TIdHTTP;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    procedure FormShow(Sender: TObject);
    procedure BtPesquisarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure CbConsultarPorExit(Sender: TObject);
    procedure EdConsKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Focarentrada1Click(Sender: TObject);
    procedure CbConsultarPorKeyPress(Sender: TObject; var Key: Char);
    procedure CbTipoKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure QuConsultaBeforeClose(DataSet: TDataSet);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure Sair1Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    Cont: Integer;
    varSQL,RestoConsulta: String;
    Data: TInifile;

    FDescricao : String;
    FNomeTabela:String;
    FChave     :String;
    FCampo     :String;
    FConnection : TFDCustomConnection;

    function RetornaTipo:String;
    Procedure RetornaCampo;
    function TrocarCaracter(Texto, Caracter1, Caracter2:String):String;
    { Private declarations }
  public
    Query: TClientDataSet;
    procedure JsonToDataset(aDataset : TDataSet; aJSON : string);
    property Descricao  : String read FDescricao write FDescricao;
    property NomeTabela : String read FNomeTabela write FNomeTabela;
    property Chave : String read FChave write FChave;
    property Campo : String read FCampo write FCampo;
    property Conexao : TFDCustomConnection read FConnection write FConnection;

    procedure AutenticarEListarUsuarios;
    { Public declarations }
  end;

const
   _URL_CONSULTA_CNPJ = 'http://receitaws.com.br/v1/cnpj/%s';

var
  FPesquisaIBO: TFPesquisaIBO;

implementation

{$R *.dfm}

uses UFuncao;

procedure TFPesquisaIBO.FormShow(Sender: TObject);
var x: Integer;
begin
  EdCons.SetFocus;
{  QuConsulta.Connection := Conexao;

  Caption            := 'Consulta de ' + Descricao;
  Gauge1.MinValue    := 0;
  Gauge1.MaxValue    := 0;
  Gauge1.Progress    := 0;
  LbConsPor.Caption  := '';
  LbEntrada.Caption  := '';
  LbTotalReg.Caption := '';

  EdCons.Clear;
  CbConsultarPor.Clear;
  CbTipo.ItemIndex := 0;
  CbConsultarPor.SetFocus;
  RestoConsulta := '';
  DBGrid1.Columns.Clear;

  Cont    := 0;     }
{
  for x := 0 To Query.FieldCount -1 Do
  begin
    If (Query.Fields[x].FieldKind = fkData) and  (Query.Fields[x].IsBlob = False) Then
    begin
      if Query.Fields[x].Tag = 0 then
        CbConsultarPor.Items.Add(Query.Fields[x].DisplayLabel);

      if Query.Fields[x].Visible = true then
      begin
        DBGrid1.Columns.Add;
        DBGrid1.Columns[cont].FieldName     := Query.Fields[x].FieldName;
        DBGrid1.Columns[cont].Title.Caption := Query.Fields[x].DisplayLabel;
        Inc(cont);
      end;
    end;
  end;

  With QuConsulta do
  begin
    Close;
    SQL.Add(TrocarCaracter(Query.CommandText,' * ',' first 0 * '));
    Open;
    Close;
  end;

  CBConsultarPor.ItemIndex := 0;

  CbConsultarPorExit(Sender);
  EdCons.SetFocus;         }
end;

function TFPesquisaIBO.RetornaTipo:String;
var
  retorno: String;
begin
  If (Trim(EdCons.Text) = '') and (CbTipo.ItemIndex = 2) Then
  begin
    MessageDlg('Para utilizar o tipo =, digite a entrada',mtError,[mbok],0);
    EdCons.SetFocus;
    Gauge1.Progress := 0;
    Abort;
  end;

{  case CbTipo.ItemIndex of
    0: retorno := ' like '+#39+EdCons.Text+'%'+#39;
    1: retorno := ' like '+#39+'%'+EdCons.Text+#39;
    2: If Query.FieldByName(Campo).DataType=ftDate Then
         retorno := ' = '+#39+copy(EdCons.Text,4,3)+copy(EdCons.Text,1,3)+copy(EdCons.Text,7,4)+#39
       else
         retorno := ' = '+#39+EdCons.Text+#39;
  end;                 }
  result := retorno;
end;

procedure TFPesquisaIBO.BtPesquisarClick(Sender: TObject);
var
LCNPJ, LResposta : string;
x:integer;
begin
   if EdCons.Text <> '' then
   begin
      LCNPJ:= Trim(EdCons.text);
      RESTClient1.BaseURL:= Format(_URL_CONSULTA_CNPJ, [LCNPJ]);

      RESTRequest1.Execute;
      LResposta:= RESTResponse1.Content;

      for x := 0 To Query.FieldCount -1 Do
      begin
            DBGrid1.Columns[x].Width:=50 ;
            Inc(cont);
      end;
   end
   else
   begin
      MessageDlg('Informe o CNPJ', mtInformation, [MBOK], 0);
   end;


 { If Query.FieldByName(Campo).DataType=ftDate Then
  begin
    If CBTipo.ItemIndex <> 2 then
      CBTipo.ItemIndex := 2;

    Try
      StrToDate(EdCons.Text);
    Except
      begin
        MessageDLG('Data inv�lida!',mtInformation,[mbok],0);
        EdCons.Clear;
        EdCons.SetFocus;
        Abort;
      end;
    end;
  end;

  Gauge1.MinValue    := 0;
  Gauge1.MaxValue    := 3;
  Gauge1.Progress    := 1;
  LbProgress.Caption := '1 / 3';
  Application.ProcessMessages;

  RestoConsulta := Campo+RetornaTipo;

  With QuConsulta do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from ' + NomeTabela + ' Where ('+RestoConsulta+')');
    open;

    varSQL := QuConsulta.SQL.Text ;

    if isEmpty Then
      EdCons.SetFocus
    else
      DBGrid1.SetFocus;
  end;
  Gauge1.Progress    := Gauge1.Progress + 1;
  LbProgress.Caption := '2 / 3';
  Application.ProcessMessages;

  If Trim(EdCons.Text) = '' Then
    LbEntrada.Caption  := '_'
  else
    LbEntrada.Caption  := EdCons.Text;

  LbConsPor.Caption  := CbConsultarPor.Text;
  LbTotalReg.Caption := IntToStr(QuConsulta.RecordCount);
  Gauge1.Progress    := Gauge1.Progress + 1;
  LbProgress.Caption := '3 / 3';
  Application.ProcessMessages;
  If QuConsulta.RecordCount>0 then
    DBGrid1.SetFocus
  else
    EdCons.SetFocus;  }
end;

procedure TFPesquisaIBO.DBGrid1DblClick(Sender: TObject);
begin
  If QuConsulta.RecordCount <> 0 then
  begin
    with Query do
    begin
      Close;
      CommandText := 'Select * from ' + NomeTabela +
                     ' where ' + Chave + ' = ' + QuConsulta.FieldByName(Chave).AsString;
      Open;
    end;
    Close;
  end;
end;

procedure TFPesquisaIBO.CbConsultarPorExit(Sender: TObject);
begin
 { RetornaCampo;
  EdCons.Clear;
  If Query.FieldByName(Campo).DataType=ftDate then
    CbTipo.ItemIndex := 2
  else
    CbTipo.ItemIndex := 0;

  If Query.FieldByName(Campo).DataType=ftDate then
    EdCons.EditMask := '!99/99/9999;1;'
  else
    EdCons.EditMask := '';  }
end;

procedure TFPesquisaIBO.EdConsKeyPress(Sender: TObject; var Key: Char);
begin
 { if (Query.Fields[CbConsultarPor.ItemIndex].DataType = ftInteger) or
     (Query.Fields[CbConsultarPor.ItemIndex].DataType = ftFloat) or
     (Query.Fields[CbConsultarPor.ItemIndex].DataType = ftCurrency) then
    if not (key in ['0'..'9',#8,#13]) then
      key := #0;
                }
  if key=#13 then
  begin
    BtPesquisar.Click;
    key := #0;
  end;
end;

procedure TFPesquisaIBO.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  QuConsulta.Close;
  NomeTabela := '';
end;

procedure TFPesquisaIBO.Focarentrada1Click(Sender: TObject);
begin
  EdCons.SetFocus;
end;

procedure TFPesquisaIBO.CbConsultarPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  If Key = #13 Then
    CbTipo.SetFocus;
end;

procedure TFPesquisaIBO.CbTipoKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then
    EdCons.SetFocus;
end;

procedure TFPesquisaIBO.RetornaCampo;
var x: Integer;
begin
  for x := 0 to Query.FieldCount -1 Do
  begin
    If CbConsultarPor.Text=Query.Fields[x].DisplayLabel Then
      Campo := Query.Fields[x].FieldName;
  end;
end;

procedure TFPesquisaIBO.Button1Click(Sender: TObject);
begin
  RestoConsulta := '';
  QuConsulta.Close;
end;

function TFPesquisaIBO.TrocarCaracter(Texto, Caracter1, Caracter2:String):String;
var
  TamanhoTeste : Integer;
  StrRetirada:String;
begin
  TamanhoTeste := 1;
  StrRetirada  := '';
  Result       := '';

  While TamanhoTeste <= Length(Texto) do
  begin
    StrRetirada := Copy(Texto,TamanhoTeste,1);

    If StrRetirada <> Caracter1 then
      Result := Result+StrRetirada
    else
      Result := Result+Caracter2;

    TamanhoTeste := TamanhoTeste+1;
  end;
end;


procedure TFPesquisaIBO.QuConsultaBeforeClose(DataSet: TDataSet);
begin
  QuConsulta.IndexFieldNames := QuConsulta.Fields[0].FieldName;
end;

procedure TFPesquisaIBO.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
    DBGrid1DblClick(sender);
end;

procedure TFPesquisaIBO.DBGrid1TitleClick(Column: TColumn);
var
  ASql: String;
begin
  If varSQL = '' Then
    Exit;

  with QuConsulta do
  begin
    if not IsEmpty then
    begin
      if Column.Field.FieldKind = fkData then
      begin
        ASql := SQL.Text;
        Close;
        SQL.Clear;
        if Pos('ASC', pChar(ASql)) = 0 then
          sql.add(varSQL + ' ORDER BY ' + Column.FieldName + ' ASC')
        else
          sql.Add(varSQL + ' ORDER BY ' + Column.FieldName + ' DESC');
        Open;
      end;
    end;
  end;
end;

procedure TFPesquisaIBO.Sair1Click(Sender: TObject);
begin
  Close;
end;

procedure TFPesquisaIBO.JsonToDataset(aDataset : TDataSet; aJSON : string);
var
JObj: TJSONArray;
vConv : TCustomJSONDataSetAdapter;
begin
    if (aJSON = EmptyStr) then
    begin
       Exit;
    end;

    JObj := TJSONObject.ParseJSONValue(aJSON) as TJSONArray;
    vConv := TCustomJSONDataSetAdapter.Create(Nil);

    try
        vConv.Dataset := aDataset;
        vConv.UpdateDataSet;
    finally
        vConv.Free;
        JObj.Free;
    end;
end;

procedure TFPesquisaIBO.AutenticarEListarUsuarios;
var
  HTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  IdTCPClient : TIdTCPClient;
  RequestBody: TStringStream;
  ResponseBody: string;
  JWTToken: string;
  URLLogin, URLGetUsers: string;
  JSONResponse: TJSONObject;
begin
  // Configura��o dos URLs
  URLLogin := 'https://setacore_apidev.setaerp.com.br/api/v1/admin/auth/login';
  URLGetUsers := 'https://setacore_apidev.setaerp.com.br/api/v1/admin/users/get-all';

  // Inicializar HTTP e SSL
  HTTP := TIdHTTP.Create(nil);
  IdTCPClient := TIdTCPClient.Create;
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  RequestBody := nil;

  try
    // Configurar o SSL para suportar TLS 1.2
    SSL.SSLOptions.Method := sslvTLSv1_2;
    SSL.SSLOptions.SSLVersions := [sslvTLSv1_2];
//    SSL.PassThrough:=False;
    HTTP.IOHandler := SSL;

    // Configurar os cabe�alhos para autentica��o
    HTTP.Request.ContentType := 'application/json';
    HTTP.Request.Accept := 'application/json';

    // Etapa 1: Autenticar e obter o token JWT
    RequestBody := TStringStream.Create(
      '{"login": "teste@gmail.com.br", "password": "UnWh0AW74oYt"}',TEncoding.UTF8);

    HTTP.Post(URLLogin, RequestBody);
    try
      ResponseBody := HTTP.Post(URLLogin, RequestBody);

      // Analisar resposta JSON e capturar o token JWT
      JSONResponse := TJSONObject.ParseJSONValue(ResponseBody) as TJSONObject;
      if Assigned(JSONResponse) then
      try
         JWTToken := JSONResponse.GetValue('token').Value;
      finally
        JSONResponse.Free;
      end;

    except
      on E: Exception do
      begin
        Writeln('Erro durante a autentica��o: ' + E.Message);
        Exit;
      end;
    end;

    // Configurar o cabe�alho de autoriza��o com o token JWT
    HTTP.Request.CustomHeaders.Values['Authorization'] := 'Bearer ' + JWTToken;

    // Etapa 2: Listar usu�rios
    try
      ResponseBody := HTTP.Get(URLGetUsers);
      Writeln('Lista de usu�rios: ' + ResponseBody);
    except
      on E: Exception do
      begin
        Writeln('Erro ao listar usu�rios: ' + E.Message);
      end;
    end;

  finally
    // Liberar recursos
    HTTP.Free;
    SSL.Free;
    if Assigned(RequestBody) then
      RequestBody.Free;
  end;
end;

end.
