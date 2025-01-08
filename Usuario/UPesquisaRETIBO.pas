unit UPesquisaRETIBO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids,
  IBQuery, DB, Mask, Gauges, ComCtrls, Menus, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,DBClient;

type
  TFPesquisaRETIBO = class(TForm)
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
    CBManterPConsulta: TCheckBox;
    Button1: TButton;
    Label6: TLabel;
    LbVersao: TLabel;
    Sair1: TMenuItem;
    ConfGrade: TPopupMenu;
    ConfigurarGrade1: TMenuItem;
    StatusBar1: TStatusBar;
    LabCampoStatus: TLabel;
    QuConsulta: TFDQuery;
    procedure FormShow(Sender: TObject);
    procedure BtPesquisarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure CbConsultarPorExit(Sender: TObject);
    procedure EdConsKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure Focarentrada1Click(Sender: TObject);
    procedure CbConsultarPorKeyPress(Sender: TObject; var Key: Char);
    procedure CbTipoKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure QuConsultaBeforeClose(DataSet: TDataSet);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure Sair1Click(Sender: TObject);
  private
    Cont: Integer;
    caminho, NomeCampo, varSQL, RestoConsulta: string;
    FDescricao        : String;
    FNomeTabela       : String;
    FChave            : String;
    FCampo            : String;
    FConnection       : TFDCustomConnection;
    FSQLPersonalizado : String;
    function RetornaTipo: string;
    procedure RetornaCampo;
    function TrocarCaracter(Texto, Caracter1, Caracter2: string): string;
    { Private declarations }
  public
    CodRet, CodCampoRet: string;
    CampoPadrao: string;
    Query: TClientDataSet;
    property Descricao        : String read FDescricao write FDescricao;
    property NomeTabela       : String read FNomeTabela write FNomeTabela;
    property Chave            : String read FChave write FChave;
    property Campo            : String read FCampo write FCampo;
    property Conexao          : TFDCustomConnection read FConnection write FConnection;
    property SQLPersonalizado : String read FSQLPersonalizado write FSQLPersonalizado;
    { Public declarations }
  end;
var
  FPesquisaRETIBO: TFPesquisaRETIBO;

implementation

uses UFuncao;

{$R *.dfm}

procedure TFPesquisaRETIBO.FormShow(Sender: TObject);
var
  x: Integer;
  ItemIndexPadrao: Integer;
  restauraTecla: string;
  y: Integer;
begin
  Caption            := 'Consulta de ' + Descricao;
  Gauge1.MinValue    := 0;
  Gauge1.MaxValue    := 0;
  Gauge1.Progress    := 0;
  LbConsPor.Caption  := '';
  LbEntrada.Caption  := '';
  LbTotalReg.Caption := '';
  restauraTecla      := copy(EdCons.Text, 1, 1);
  CodRet             := '';
  CbTipo.ItemIndex   := 0;
  CbConsultarPor.Clear;
  CbConsultarPor.SetFocus;

  RestoConsulta := '';

  DBGrid1.Columns.Clear;
  Cont := 0;

  for x := 0 to Query.FieldCount - 1 do
  begin
    if Query.Fields[x].FieldKind = fkData then
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

      if UpperCase(CampoPadrao) = UpperCase(Query.Fields[x].FieldName) then
        ItemIndexPadrao := x;
    end;
  end;

  with QuConsulta do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select * from ' + NomeTabela + ' where ' + Chave + ' is null');
    Open;
    Close;
  end;

  CbConsultarPor.ItemIndex := ItemIndexPadrao;
  EdCons.SetFocus;
  EdCons.Text      := trim(restauraTecla);
  EdCons.SelLength := 0;
  EdCons.SelStart  := 1;

  CbConsultarPor.ItemIndex := ItemIndexPadrao;
  CbTipo.ItemIndex         := 0;

  caminho := ExtractFilePath(Application.ExeName);
  if not DirectoryExists(Caminho + 'config') then
    CreateDir(caminho + 'config');

  if FileExists(caminho + '/config/' + Descricao + '.afa') then
    DBGrid1.Columns.LoadFromFile(caminho + '/config/' + Descricao + '.afa');

  for x := 0 to Query.FieldCount - 1 do
  begin
    for y := 0 to DBGrid1.Columns.Count -1 do
    begin
      if Query.Fields[x].FieldName = DBGrid1.Columns[y].FieldName then
        DBGrid1.Columns[y].Title.Caption := Query.Fields[x].DisplayLabel;
    end;
  end;
end;

function TFPesquisaRETIBO.RetornaTipo: string;
var
  retorno: string;
begin
  if (Trim(EdCons.Text) = '') and
    (CbTipo.ItemIndex = 2) then
  begin
    MessageDlg('Para utilizar o tipo =, digite a entrada', mtError, [mbok], 0);
    EdCons.SetFocus;
    Gauge1.Progress := 0;
    Abort;
  end;

  case CbTipo.ItemIndex of
    0: retorno := ' like ' + #39 + EdCons.Text + '%' + #39;
    1: retorno := ' like ' + #39 + '%' + EdCons.Text + #39;
    2: if Query.FieldByName(NomeCampo).DataType = ftDate then
        retorno := ' = ' + #39 + copy(EdCons.Text, 4, 3) + copy(EdCons.Text, 1, 3) + copy(EdCons.Text, 7, 4) + #39
      else
        retorno := ' = ' + #39 + EdCons.Text + #39;
  end;
  result := retorno;
end;

procedure TFPesquisaRETIBO.BtPesquisarClick(Sender: TObject);
begin
  if Query.FieldByName(NomeCampo).DataType = ftDate then
  begin
    if CBTipo.ItemIndex <> 2 then
      CBTipo.ItemIndex := 2;
    try
      StrToDate(EdCons.Text);
    except
      begin
        MessageDLG('Data inválida!', mtInformation, [mbok], 0);
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

  if CBManterPConsulta.Checked then
  begin
    if RestoConsulta = '' then
      RestoConsulta := NomeCampo + RetornaTipo
    else
      RestoConsulta := RestoConsulta + ' or ' + NomeCampo + RetornaTipo;
  end
  else
    RestoConsulta := NomeCampo + RetornaTipo;

  with QuConsulta do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from ' + NomeTabela);
    SQL.Add('Where (' + RestoConsulta + ')');
    SQL.Add('and ' + Chave + ' <> ''0''');

    //Para pegar ou Não cadastros inativos
    if LabCampoStatus.Caption <> '' then
    begin
      SQL.Add('and ' + LabCampoStatus.Caption + ' = ' + #39 + 'SIM' + #39);
    end;

    if SQLPersonalizado <> '' then
    begin
      SQL.Add(SQLPersonalizado);
    end;

    open;
    varSQL := QuConsulta.SQL.Text;

    if isEmpty then
      EdCons.SetFocus
    else
      DBGrid1.SetFocus;
  end;
  Gauge1.Progress    := Gauge1.Progress + 1;
  LbProgress.Caption := '2 / 3';
  Application.ProcessMessages;

  if Trim(EdCons.Text) = '' then
    LbEntrada.Caption := '_'
  else
    LbEntrada.Caption := EdCons.Text;

  LbConsPor.Caption  := CbConsultarPor.Text;
  LbTotalReg.Caption := IntToStr(QuConsulta.RecordCount);
  Gauge1.Progress    := Gauge1.Progress + 1;
  LbProgress.Caption := '3 / 3';
  Application.ProcessMessages;

  if QuConsulta.RecordCount > 0 then
    DBGrid1.SetFocus
  else
    EdCons.SetFocus;
end;

procedure TFPesquisaRETIBO.DBGrid1DblClick(Sender: TObject);
begin
  if Query.Active = False then
    Query.Active := True;

  if Query.Active = True then
  begin
    if QuConsulta.RecordCount <> 0 then
      Query.Locate(Query.Fields[CbConsultarPor.ItemIndex].FieldName,
        QuConsulta.FieldByName(Query.Fields[CbConsultarPor.ItemIndex].FieldName).AsString, []);
    Close;
  end;
end;

procedure TFPesquisaRETIBO.CbConsultarPorExit(Sender: TObject);
begin
  RetornaCampo;
  EdCons.Clear;
  if Query.FieldByName(NomeCampo).DataType = ftDate then
    CbTipo.ItemIndex := 2
  else
    CbTipo.ItemIndex := 0;

  if Query.FieldByName(NomeCampo).DataType = ftDate then
    EdCons.EditMask := '!99/99/9999;1;'
  else
    EdCons.EditMask := '';
end;

procedure TFPesquisaRETIBO.EdConsKeyPress(Sender: TObject; var Key: Char);
begin
  if (Query.Fields[CbConsultarPor.ItemIndex].DataType = ftInteger) or
    (Query.Fields[CbConsultarPor.ItemIndex].DataType = ftFloat) or
    (Query.Fields[CbConsultarPor.ItemIndex].DataType = ftCurrency) then
    if not (key in ['0'..'9', #8, #13]) then
      key := #0;

  if key = #13 then
  begin
    BtPesquisar.Click;
    key := #0;
  end;

end;

procedure TFPesquisaRETIBO.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if QuConsulta.Active then
    if not QuConsulta.IsEmpty then
      CodRet := QuConsulta.FieldByName(Chave).AsString
    else
      CodRet := ''
  else
    CodRet := '';

  QuConsulta.Close;
  Query := nil;
end;

procedure TFPesquisaRETIBO.DBGrid1TitleClick(Column: TColumn);
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

procedure TFPesquisaRETIBO.Focarentrada1Click(Sender: TObject);
begin
  EdCons.SetFocus;
end;

procedure TFPesquisaRETIBO.CbConsultarPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    CbTipo.SetFocus;
end;

procedure TFPesquisaRETIBO.CbTipoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    EdCons.SetFocus;
end;

procedure TFPesquisaRETIBO.RetornaCampo;
var
  x: Integer;
begin
  for x := 0 to Query.FieldCount - 1 do
  begin
    if CbConsultarPor.Text = Query.Fields[x].DisplayLabel then
      nomeCampo := Query.Fields[x].FieldName;
  end;
end;

procedure TFPesquisaRETIBO.Button1Click(Sender: TObject);
begin
  RestoConsulta := '';
  QuConsulta.Close;
end;

function TFPesquisaRETIBO.TrocarCaracter(Texto, Caracter1, Caracter2: string): string;
var
  TamanhoTeste: Integer;
  StrRetirada: string;
begin
  TamanhoTeste := 1;
  StrRetirada  := '';
  Result       := '';

  while TamanhoTeste <= Length(Texto) do
  begin
    StrRetirada := Copy(Texto, TamanhoTeste, 1);

    if StrRetirada <> Caracter1 then
      Result := Result + StrRetirada
    else
      Result := Result + Caracter2;

    TamanhoTeste := TamanhoTeste + 1;
  end;
end;

procedure TFPesquisaRETIBO.QuConsultaBeforeClose(DataSet: TDataSet);
begin
  QuConsulta.IndexFieldNames := QuConsulta.Fields[0].FieldName;
end;

procedure TFPesquisaRETIBO.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    DBGrid1DblClick(sender);
end;

procedure TFPesquisaRETIBO.Sair1Click(Sender: TObject);
begin
  QuConsulta.Close;
  Close;
end;

end.
