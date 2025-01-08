unit UCadPadrao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Mask, DBCtrls, ExtCtrls, Vcl.Buttons, Vcl.Menus,
  DB, IniFiles, DBClient, FireDAC.Comp.Client, System.UITypes, StrUtils;

type
  TFPadrao = class(TForm)
    pnPesquisa: TPanel;
    pnSuperior: TPanel;
    pnSalvar: TPanel;
    pnNovo: TPanel;
    pgGeral: TPageControl;
    tsDadosGerais: TTabSheet;
    StatusBar1: TStatusBar;
    PopupMenu1: TPopupMenu;
    Novo1: TMenuItem;
    Alterar1: TMenuItem;
    Salvar1: TMenuItem;
    Cancelar1: TMenuItem;
    Pesquisar1: TMenuItem;
    Fechar1: TMenuItem;
    btNovo: TBitBtn;
    btAlterar: TBitBtn;
    btExcluir: TBitBtn;
    btSalvar: TBitBtn;
    btCancelar: TBitBtn;
    btPesq: TBitBtn;
    btPri: TBitBtn;
    btAnt: TBitBtn;
    btProx: TBitBtn;
    btUlt: TBitBtn;
    dbPadrao: TDBEdit;
    LabInfo: TLabel;
    Label1: TLabel;
    N2: TMenuItem;
    Excluir1: TMenuItem;
    N3: TMenuItem;
    Bevel1: TBevel;
    procedure FormShow(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btNovoClick(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btPriClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure NovaGuia1Click(Sender: TObject);
    procedure btConfClick(Sender: TObject);
    procedure NovoCampoInteiro1Click(Sender: TObject);
    procedure btPesqClick(Sender: TObject);
    procedure dbPadraoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    QUPai: TClientDataSet;
    quNavMin, quNavMax, quGetPriUlt: TFDQuery;
    varAlterar: String;

    moveX, moveY: Integer;
    mover: boolean;

    FDSPadrao: TDataSource;
    FCDSPadrao: TClientDataSet;
    FTableName: String;
    FChaveTable: String;
    FDescricao: String;
    FConnection: TFDCustomConnection;
    FTransacao: TFDCustomTransaction;
    FCampoLabel: String;

    procedure ControlarPn(Modo: Char);
    procedure ValidarCamposObrigatorios(const aQuery: TClientDataSet);
    procedure TabelaVazia(const aMns: String = '');
    procedure AbrirTb;
    procedure LoadIniConf;
    function AddTS(const nameTbs, oCap: String): String;

    { ===Controle de navega��o=== }
    function GetAntProx(const Min: boolean): String;
    procedure GetMinMax(var vMin, vMax: String);
    procedure PrepararQuNav;
    { ===Fim Controle de navega��o=== }

    { ===Arrastar Componentes=== }
    procedure ControlMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure ControlMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ControlMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ValidaChaveCadastrada(varValorChave: String);
    { ===Fim Arrastar Componentes=== }
  public
    { Public declarations }
    procedure AvancarTab(var varKey: Char; varForm: TForm);
    procedure PintarCamposObrigatorios(const aQuery: TClientDataSet; ATag: Integer);
    procedure setCaption; virtual; abstract;
    procedure FocoPadrao; virtual;
    procedure CalcFields(DataSet: TClientDataSet); virtual;
    procedure HabilitarGuias; virtual;
    procedure CarregarLabInfo;

    property DSPadrao: TDataSource read FDSPadrao write FDSPadrao;
    property CDSPadrao: TClientDataSet read FCDSPadrao write FCDSPadrao;

    property TableName: String read FTableName write FTableName;
    property ChaveTable: String read FChaveTable write FChaveTable;
    property Descricao: String read FDescricao write FDescricao;
    property Conexao: TFDCustomConnection read FConnection write FConnection;
    property Transacao: TFDCustomTransaction read FTransacao write FTransacao;
    property CampoLabel: String read FCampoLabel write FCampoLabel;
  end;

  TTSDefault = class(TTabSheet)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

  TDBEDefault = class(TDBEdit)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
  FPadrao: TFPadrao;

implementation

{$R *.dfm}

uses UPesquisaIBO, UDM, UFuncao, UPrinc;

procedure TFPadrao.PintarCamposObrigatorios(const aQuery: TClientDataSet; ATag: Integer);
var
  i, X: Integer;
begin
  For i := 0 to aQuery.FieldCount - 1 do
  begin
    if (aQuery.Fields[i].Required) then
    begin
      For X := 0 to Self.ComponentCount - 1 do
      begin
        if (Components[X] is TDBEdit) and (TDBEdit(Components[X]).Tag = ATag) then
        begin
          if TDBEdit(Components[X]).Field.FieldName = aQuery.Fields[i].FieldName then
            TDBEdit(Components[X]).Color := cl3DLight;
        end
        else
        if (Components[X] is TDBComboBox) and (TDBComboBox(Components[X]).Tag = ATag) then
        begin
          if TDBComboBox(Components[X]).Field.FieldName = aQuery.Fields[i].FieldName then
            TDBComboBox(Components[X]).Color := cl3DLight;
        end
        else
        if (Components[X] is TDBLookupComboBox) and (TDBLookupComboBox(Components[X]).Tag = ATag) then
        begin
          if TDBLookupComboBox(Components[X]).Field.FieldName = aQuery.Fields[i].FieldName then
            TDBLookupComboBox(Components[X]).Color := cl3DLight;
        end;
      end;
    end;
  end;
end;

procedure TFPadrao.AvancarTab(var varKey: Char; varForm: TForm);
begin
  varKey := #0;
  varForm.Perform(WM_NextDlgCtl, 0, 0);
end;

procedure TFPadrao.FormShow(Sender: TObject);
begin
  PintarCamposObrigatorios(QUPai, 0);
  ControlarPn('S');
  LoadIniConf;
  pgGeral.ActivePageIndex   := 0;
  StatusBar1.Panels[0].Text := 'ID: ' + UpperCase(Self.Name);

  if Caption = 'Novo' then
  begin
    setCaption; { Definido nas classes filhas }
    btNovo.Click;
  end;

  dbPadrao.DataSource := DSPadrao;

  HabilitarGuias;
end;

procedure TFPadrao.btSairClick(Sender: TObject);
begin
  if pnPesquisa.Visible then
    Close;
end;

procedure TFPadrao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Not pnPesquisa.Visible then
  begin
    MessageDlg('Salve ou Cancele a Opera��o!', mtInformation, [mbOk], 0);
    Action := caNone;
    Abort;
  end;
  QUPai.Close;
end;

procedure TFPadrao.ControlarPn(Modo: Char);
var
  i: Integer;
begin
  pnNovo.Visible     := Modo = 'S';
  pnPesquisa.Visible := Modo = 'S';
  pnSalvar.Visible   := Modo = 'N';

  for i := 0 to pgGeral.PageCount -1 do
  begin
    if pgGeral.Pages[i].Tag = 0 then
    begin
      pgGeral.Pages[i].Enabled := Modo = 'N';

      Novo1.Enabled      := btNovo.Enabled and pnPesquisa.Visible;
      Alterar1.Enabled   := btAlterar.Enabled and pnPesquisa.Visible;
      Excluir1.Enabled   := btExcluir.Enabled and pnPesquisa.Visible;
      Salvar1.Enabled    := not pnPesquisa.Visible;
      Cancelar1.Enabled  := not pnPesquisa.Visible;
      Pesquisar1.Enabled := pnPesquisa.Visible;
      Fechar1.Enabled    := pnPesquisa.Visible;
    end
    else
      pgGeral.Pages[i].Enabled := Modo = 'S';
  end;
end;

procedure TFPadrao.btNovoClick(Sender: TObject);
begin
  if Not pnPesquisa.Visible then
    Exit;

  ControlarPn('N');
  pgGeral.ActivePageIndex := 0;
  FocoPadrao;
  Transacao.StartTransaction;
  QUPai.Insert;
end;

procedure TFPadrao.btAlterarClick(Sender: TObject);
begin
  TabelaVazia;
  if (not (pnPesquisa.Visible)) or (QUPai.FieldByName(ChaveTable).AsString = '0') then
  begin
    MessageDlg('N�o � permitido alterar este registro.', mtInformation, [mbOK], 0);
    Exit;
  end;

  varAlterar := 'Sim';
  ControlarPn('N');
  pgGeral.ActivePageIndex := 0;
  FocoPadrao;
  Transacao.StartTransaction;
  QUPai.Edit;
end;

procedure TFPadrao.btSalvarClick(Sender: TObject);
var
  AStatus: string;
begin
  if pnPesquisa.Visible then
    Exit;

  Focar(btSalvar);
  ValidarCamposObrigatorios(QUPai);
  if QUPai.State = dsInsert then
    ValidaChaveCadastrada(QUPai.FieldByName(ChaveTable).AsString);

  if QUPai.ApplyUpdates(-1) = 0 then
  begin
    if varAlterar <> 'Sim' then
      AbrirTb
    else
      QUPai.Refresh;

    Transacao.Commit;

    ControlarPn('S');

    if btNovo.Visible then
     Focar(btNovo);

    if varAlterar <> 'Sim' then
      btUlt.Click;

    HabilitarGuias;
    CarregarLabInfo;
    varAlterar := 'N�o';
  end;
end;

procedure TFPadrao.btCancelarClick(Sender: TObject);
begin
  if pnPesquisa.Visible then
    Exit;

  Focar(btCancelar);
  QUPai.Cancel;
  QUPai.CancelUpdates;
  Transacao.Rollback;
  ControlarPn('S');
  HabilitarGuias;
end;

procedure TFPadrao.ValidarCamposObrigatorios(const aQuery: TClientDataSet);
  procedure PorFoco(campo: TWinControl);
  begin
    pgGeral.ActivePage := TTabSheet(campo.Parent);
    campo.SetFocus;
  end;
var
  i, X: Integer;
begin
  For i := 0 to aQuery.FieldCount - 1 do
  begin
    if (aQuery.Fields[i].Required) and (aQuery.Fields[i].AsString = '') then
    begin
      For X := 0 to Self.ComponentCount - 1 do
        if (Components[X] is TDBEdit) then
        begin
          if TDBEdit(Components[X]).Field.FieldName = aQuery.Fields[i].FieldName then
            PorFoco(TDBEdit(Components[X]));
        end
        else
        if (Components[X] is TDBComboBox) then
        begin
          if TDBComboBox(Components[X]).Field.FieldName = aQuery.Fields[i].FieldName then
            PorFoco(TDBComboBox(Components[X]));
        end
        else
        if (Components[X] is TDBLookupComboBox) then
        begin
          if TDBLookupComboBox(Components[X]).Field.FieldName = aQuery.Fields[i].FieldName then
            PorFoco(TDBLookupComboBox(Components[X]));
        end;
      MessageDlg('O Campo "' + aQuery.Fields[i].DisplayLabel +
        '" deve ser preenchido!', mtInformation, [mbOk], 0);
      Abort;
    end;
  end;
end;

procedure TFPadrao.FormCreate(Sender: TObject);
begin
  if Self.Name <> 'FPadrao' then
  begin
    Try
      QUPai := TClientDataSet(DSPadrao.DataSet);
    Except
      ShowMessage('DBPadrao sem v�nculo com a Query!');
      Close;
    end;

    PrepararQuNav;
    if not(QUPai.Active) then
    begin
      AbrirTb;
      if not(QUPai.IsEmpty) then
        btUlt.Click;
    end;
  end;
  CarregarLabInfo;
  ControlarEstadoBotoes(Self, QUPai, 0);
end;

procedure TFPadrao.TabelaVazia(const aMns: String);
begin
  if QUPai.IsEmpty then
  begin
    if aMns <> '' then
      MessageDlg(aMns, mtInformation, [mbOk], 0);
    Abort;
  end;
end;

procedure TFPadrao.btExcluirClick(Sender: TObject);
begin
  TabelaVazia;

  if (not (pnPesquisa.Visible)) or (QUPai.FieldByName(ChaveTable).AsString = '0') then
  begin
    MessageDlg('N�o � permitido excluir este registro.', mtInformation, [mbOK], 0);
    Exit;
  end;

  if MessageDlg('Tem certeza que deseja excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  Try
    QUPai.Delete;
    QUPai.ApplyUpdates(0);
    AbrirTb;
    CarregarLabInfo;
  except
    on E: Exception do
    begin
      MessageDlg('Ocorreu um erro ao tentar excluir o registro!' + #13 +
        'Erro: ' + E.Message, mtInformation, [mbOk], 0);
    end;
  end;
end;

procedure TFPadrao.AbrirTb;
begin
  with QUPai do
  begin
    Close;
    CommandText := 'select * from ' + TableName + ' where ' + ChaveTable + ' = '
      + '( select max(' + ChaveTable + ') from ' + TableName + ')';
    Open;
  end;
end;

procedure TFPadrao.btPriClick(Sender: TObject);
  procedure IrProReg(const valueChave: String);
  begin
    with QUPai do
    begin
      Close;
      CommandText := 'select * from ' + TableName + ' where ' + ChaveTable +
        ' = ''' + valueChave + '''';
      Open;
    end;
  end;

var
  auxA, auxP, Min, max: string;
begin
  TabelaVazia;
  GetMinMax(Min, max);
  Case TBitBtn(Sender).Tag of
    0: { Primeiro }
      IrProReg(Min);
    1: { Anterior }
      begin
        auxA := GetAntProx(False);
        if auxA <> '' then
          IrProReg(auxA);
      end;
    2: { Proximo }
      begin
        auxP := GetAntProx(True);
        if auxP <> '' then
          IrProReg(auxP);
      end;
    3: { Ultimo }
      IrProReg(max);
  end;

  btPri.Enabled  := (TBitBtn(Sender).Tag <> 0) and (QUPai.FieldByName(ChaveTable).AsString <> Min);
  btAnt.Enabled  := (btPri.Enabled);
  btUlt.Enabled  := (TBitBtn(Sender).Tag <> 3) and (QUPai.FieldByName(ChaveTable).AsString <> max);
  btProx.Enabled := (btUlt.Enabled);

  CarregarLabInfo;
end;

function TFPadrao.GetAntProx(const Min: boolean): String;
var
  quTemp: TFDQuery;
begin
  if Min then
    quTemp := quNavMin
  else
    quTemp := quNavMax;

  with quTemp do
  begin
    Close;
    ParamByName('ChaveAtual').AsString := QUPai.FieldByName(ChaveTable).AsString;
    Open;
    Result := Fields[0].AsString;
  end;
end;

procedure TFPadrao.PrepararQuNav;
begin
  quNavMin    := TFDQuery.Create(Self);
  quNavMax    := TFDQuery.Create(Self);
  quGetPriUlt := TFDQuery.Create(Self);

  with quNavMin do
  begin
    Connection := Conexao;
    Close;
    SQL.Clear;
    SQL.Add('select min(' + ChaveTable + ') from ' + TableName + ' where ' +
      ChaveTable + ' > :ChaveAtual');
    Open;
  end;

  with quNavMax do
  begin
    Connection := Conexao;
    Close;
    SQL.Add('select max(' + ChaveTable + ') from ' + TableName + ' where ' +
      ChaveTable + ' < :ChaveAtual');
    Open;
  end;

  with quGetPriUlt do
  begin
    Connection := Conexao;
    Close;
    SQL.Add('select min(' + ChaveTable + '), max(' + ChaveTable + ') from ' +
      TableName);
    Open;
  end;
end;

Procedure TFPadrao.GetMinMax(var vMin, vMax: String);
begin
  with quGetPriUlt do
  begin
    Close;
    Open;
    vMin := Fields[0].AsString;
    vMax := Fields[1].AsString;
  end;
end;

procedure TFPadrao.FormDestroy(Sender: TObject);
begin
  // Screen.OnActiveControlChange := nil;
end;

procedure TFPadrao.LoadIniConf;
var
  IniConf: TIniFile;
  i, posS: Integer;
  Secoes: TStringList;
  CompAux: TComponent;
begin
  Try
    Secoes  := TStringList.Create;
    IniConf := TIniFile.Create(ExtractFilePath(Application.ExeName) + Self.Name + '_conf.afa');
    if FileExists(IniConf.FileName) then
    begin
      if IniConf.SectionExists('LABELS') then
      begin
        IniConf.ReadSectionValues('LABELS', Secoes);
        For i := 0 to Secoes.Count - 1 do
        begin
          CompAux := Self.FindComponent
            (Copy(Secoes[i], 1, Pos('=', Secoes[i]) - 1));
          if CompAux <> Nil then
            TLabel(CompAux).Caption := IniConf.ReadString('LABELS',
              TLabel(CompAux).Name, TLabel(CompAux).Caption);
        end;
      end;

      if IniConf.SectionExists('DBEDITMASK') then
      begin
        IniConf.ReadSectionValues('DBEDITMASK', Secoes);
        For i := 0 to Secoes.Count - 1 do
        begin
          CompAux := Self.FindComponent
            (Copy(Secoes[i], 1, Pos('=', Secoes[i]) - 1));
          if CompAux <> Nil then
            TDBEdit(CompAux).Field.EditMask := IniConf.ReadString('DBEDITMASK',
              TDBEdit(CompAux).Name, '');
        end;
      end;

      if IniConf.SectionExists('TABSHEET') then
      begin
        IniConf.ReadSectionValues('TABSHEET', Secoes);
        For i := 0 to Secoes.Count - 1 do
        begin
          posS := Pos('=', Secoes[i]);
          AddTS(Copy(Secoes[i], 1, posS - 1), Copy(Secoes[i], posS + 1,
            Length(Secoes[i])));
        end;
      end;
    end;
  Finally
    IniConf.Free;
    Secoes.Free;
  end;
end;

procedure TFPadrao.NovaGuia1Click(Sender: TObject);
var
  CapNewTab, nameNewTab: string;
  IniConf: TIniFile;
begin
  CapNewTab := '';
  if InputQuery('T�tulo', 'Informe o T�tulo:', CapNewTab) then
  begin
    if Trim(CapNewTab) <> '' then
    begin
      nameNewTab := AddTS('tbs' + FormatDateTime('mmsszzz', Now), CapNewTab);
      IniConf    := TIniFile.Create(ExtractFilePath(Application.ExeName) +
        Self.Name + '_conf.afa');
      IniConf.WriteString('TABSHEET', nameNewTab, CapNewTab);
      IniConf.Free;
    end;
  end;
end;

procedure TFPadrao.btConfClick(Sender: TObject);
begin
  // PopupMenu2.Popup( Self.Left + btConf.Left - 90, Self.Top + btConf.Top + 70 );
end;

function TFPadrao.AddTS(const nameTbs, oCap: String): String;
var
  NewTab: TTabSheet;
begin
  NewTab             := TTabSheet.Create(Self.pgGeral);
  NewTab.Caption     := oCap;
  NewTab.Name        := nameTbs;
  NewTab.PageControl := Self.pgGeral;
  Result             := NewTab.Name;
end;

procedure TFPadrao.NovoCampoInteiro1Click(Sender: TObject);
var
  NewDbEdit: TDBEdit;
begin
  NewDbEdit             := TDBEdit.Create(Self.pgGeral.ActivePage);
  NewDbEdit.Parent      := Self.pgGeral.ActivePage;
  NewDbEdit.Name        := 'dbe_' + FormatDateTime('mmsszzz', Now);
  NewDbEdit.DataSource  := Self.dbPadrao.DataSource;
  NewDbEdit.BevelInner  := bvSpace;
  NewDbEdit.BevelKind   := bkFlat;
  NewDbEdit.BevelOuter  := bvLowered;
  NewDbEdit.BorderStyle := bsNone;
  NewDbEdit.OnMouseDown := ControlMouseDown;
  NewDbEdit.OnMouseMove := ControlMouseMove;
  NewDbEdit.OnMouseUp   := ControlMouseUp;
end;

procedure TFPadrao.ControlMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  moveX := X;
  moveY := Y;
  mover := True;
  SetCapture(TWinControl(Sender).Handle);
end;

procedure TFPadrao.ControlMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  frmPoint: TPoint;
begin
  if mover then
  begin
    with TWinControl(Sender) do
    begin
      if ssShift in Shift then
      begin
        Screen.Cursor := crSizeNWSE;
        frmPoint      := ScreenToClient(Mouse.CursorPos);
        Width         := frmPoint.X;
        Height        := frmPoint.Y;
      end
      else
      begin
        Screen.Cursor := crSize;
        Left := X - moveX + Left;
        Top  := Y - moveY + Top;
      end;
    end;
  end;
end;

procedure TFPadrao.ControlMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if mover then
  begin
    mover := False;
    ReleaseCapture;
    Screen.Cursor := crDefault;
  end;
end;

procedure TFPadrao.dbPadraoKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then
    AvancarTab(Key, Self);
end;

{ TTSDefault }
procedure TTSDefault.CreateParams(var Params: TCreateParams);
begin
  inherited;
  { Defino os paramentros aqui e qndo for criar um novo fa�o assim noovots:= ttsdefault.create }
end;

{ TDBEDefault }
procedure TDBEDefault.CreateParams(var Params: TCreateParams);
begin
  inherited;
  BevelInner  := bvSpace;
  BevelKind   := bkFlat;
  BevelOuter  := bvLowered;
  BorderStyle := bsNone;
  Font        := FPadrao.dbPadrao.Font;
end;

procedure TFPadrao.btPesqClick(Sender: TObject);
begin
  Application.CreateForm(TFPesquisaIBO, FPesquisaIBO);
  FPesquisaIBO.Conexao    := Conexao;
  FPesquisaIBO.Descricao  := Descricao;
  FPesquisaIBO.Chave      := ChaveTable;
  FPesquisaIBO.Query      := QUPai;
  FPesquisaIBO.NomeTabela := TableName;
  FPesquisaIBO.ShowModal;
  FPesquisaIBO := nil;

  CarregarLabInfo;
end;

procedure TFPadrao.FocoPadrao;
begin
  pgGeral.ActivePageIndex := 0;
  Focar(dbPadrao);
end;

procedure TFPadrao.CalcFields(DataSet: TClientDataSet);
begin
  { ***Implementar classes Filhas*** }
end;

procedure TFPadrao.CarregarLabInfo;
var
  i: Integer;
begin
  if QUPai.IsEmpty then
    Exit;

  if CampoLabel <> '' then
  begin
    For i := 0 to QUPai.FieldCount - 1 do
    begin
      if ChaveTable = QUPai.Fields[i].FieldName then
      begin
        LabInfo.Caption := QUPai.Fields[i].Value;
        Continue;
      end;
    end;

    if LabInfo.Caption = '' then
      Exit;

    For i := 0 to QUPai.FieldCount - 1 do
    begin
      if CampoLabel = QUPai.Fields[i].FieldName then
      begin
        LabInfo.Caption := LabInfo.Caption + ' - ' + QUPai.Fields[i].Value;
        Continue;
      end;
    end;
  end;
end;

procedure TFPadrao.HabilitarGuias;
begin
  { ***Implementar classes Filhas*** }
end;

procedure TFPadrao.ValidaChaveCadastrada(varValorChave : String);
var
  QuBusca: TFDQuery;
begin
  quBusca := TFDQuery.Create( Self );
  quBusca.Connection := Conexao;
  with quBusca do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select * from '+TableName);
    SQL.Add('Where '+ChaveTable+' = '+#39+varValorChave+#39);
    Open;

    if not IsEmpty then
    begin
      MessageDlg('Registro j� cadastrado!',mtInformation,[mbOK],0);
      Abort;
    end;
  end;
end;

end.
