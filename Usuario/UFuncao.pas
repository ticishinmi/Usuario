unit UFuncao;

interface

Uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, ExtCtrls, ComCtrls, DateUtils, IniFiles,
  FireDAC.Comp.Client, StdCtrls, Vcl.Buttons,
  DBClient, Vcl.DBCtrls, DB, Vcl.DBGrids;

procedure CriarForm(var varForm; varInstance: TFormClass; varParam: String);
procedure AbrirDestruirForm(var varForm; varInstance: TFormClass);
procedure DestruirForm(var varForm: TForm);
function GetBuildInfo: string;
function GerarPK(varCampo, varTabela: String): Integer;
function ExecAndWait(const FileName, Params: string;
  const WindowState: Word): Boolean;
function CrySenha(Snh: String): String;
function AbrirPesquisaCad(varCampoPadrao, varCampoCod, varCampoStatus,
  varTabela, varDescricao, varSQL: string; varQueryPesq: TClientDataSet;
  Conexao: TFDCustomConnection): string;
function RetornaCalculado(varTabela, varChave, varCampo, varValorComparar,
  varJoin, varAND: String): String;
function ValidaCPF(Num: string): Boolean;
function ValidaCNPJ(Num: string): Boolean;
procedure ValidaVazia(varClient: TClientDataSet; varMsg: String);
procedure ValidarCamposObrigatorios(const aQuery: TClientDataSet;
  varForm: TForm);
procedure ControlaPainel(varVisible: Boolean; varPainel: TPanel);
function BuscarString(varCampo, varTabela, varChave, varValorChave
  : String): String;
function GerarID(varGenerator: String): string;
function ValidaNumeros(varKey: char): char;
procedure ifThenAbort(Cond: Boolean; Mns: String = ''; CampoFocu: TObject = Nil;
  tipoMns: TMsgDlgType = mtInformation; aQuClose: TFDQuery = Nil);
procedure ExecCons(aQuery: TFDQuery; aSql: String);
procedure TrataException(msg: string);
function CloseAllClientDataSet(ADm: TDataModule): Boolean;
procedure Focar(campo: TWinControl);
procedure OcultarSheets(PageControl: TPageControl);
procedure ControlarEstadoBotoes(AForm: TForm; ATabela: TClientDataSet;
  ATag: Integer);
function ValidarEMail(aStr: string): Boolean;

var
  CaminhoEXE: String;
  ArqIni: tIniFile;
  varTecla: char;
  pgGeral: TPageControl;

implementation

uses UPesquisaIBO, UDM, UPesquisaRETIBO, UPrinc;

procedure TrataException(msg: string);
var
  Mensagem: string;
  Pos1, Pos2: Integer;
begin
  if Pos(UpperCase('is not a valid date'), UpperCase(msg)) <> 0 then
  begin
    Mensagem := 'Data inv�lida!';
  end
  else
  if Pos(UpperCase('key violation'), UpperCase(msg)) <> 0 then
  begin
    Mensagem := 'Houve viola��o de chave!' + #13 + 'Registro j� incluido.';
    MessageDlg(Mensagem, mtInformation, [mbOk], 0);
  end
  else
  if Pos(UpperCase('Input value'), UpperCase(msg)) <> 0 then
    Mensagem := 'Campo preenchido com valor n�o v�lido!' + #13 +
      'Proceda a corre��o.'
  else
  if Pos(UpperCase('is not a valid time'), UpperCase(msg)) <> 0 then
    Mensagem := 'Hora inv�lida, proceda a corre��o.'
  else
  if Pos(UpperCase('Erro ApplyUpdates'), UpperCase(msg)) <> 0 then
    Mensagem := 'N�o foi poss�vel salvar a modifica��o no banco de dados.'
  else
  if Pos(UpperCase('is not a valid float'), UpperCase(msg)) <> 0 then
  begin
    Pos1 := Pos('''', msg);
    Mensagem := msg;
    Delete(Mensagem, Pos1, 1);
    Pos2 := Pos('''', Mensagem);
    Mensagem := Copy(msg, Pos1 + 1, Pos2 - Pos1);
    Mensagem := 'O valor  ' + Mensagem + ' n�o � v�lido.';
  end
  else
  if Pos(UpperCase('field value required'), UpperCase(msg)) <> 0 then
  begin
    Pos1 := Pos('column ', msg) + 7;
    Pos2 := Pos(',', msg);
    Mensagem := Copy(msg, Pos1, Pos2 - Pos1);
    Mensagem := 'Campo ' + Mensagem + ' deve ser preenchido.';
  end
  else
  if Pos(UpperCase('FOREIGN KEY'), UpperCase(msg)) <> 0 then
    Mensagem := 'Opera��o n�o permitida!' + #13 +
      'Registro vinculado em outra tabela.'
  else
  if (Pos(UpperCase('PRIMARY or UNIQUE KEY'), UpperCase(msg)) > 0) or ((Pos(UpperCase('KEY VIOLATION'), UpperCase(msg)) > 0)) then
    Mensagem := 'Voc� est� tentando gravar uma informa��o que j� existe no banco de dados!'
  else
    Mensagem := 'Ocorreu um erro ao tentar gravar o registro! #13 Error: ' + msg;

  MessageBox(Application.Handle, PChar(Mensagem), 'Valida��o',
    mb_ok + MB_ICONERROR);
end;

procedure ExecCons(aQuery: TFDQuery; aSql: String);
begin
  With aQuery do
  begin
    Close;
    SQL.Clear;
    SQL.Add(aSql);
    Prepare;
    Open;
  end;
end;

procedure ifThenAbort(Cond: Boolean; Mns: String; CampoFocu: TObject;
  tipoMns: TMsgDlgType; aQuClose: TFDQuery);
begin
  if Cond then
  begin
    if Trim(Mns) <> '' then
      MessageDlg(Mns, tipoMns, [mbOk], 0);

    if aQuClose <> Nil then
      aQuClose.Close;

    if (CampoFocu <> Nil) and (CampoFocu is TWinControl) then
      Try
        (CampoFocu as TWinControl).SetFocus;
      Except
        Abort;
      end;
    Abort;
  end;
end;


function ValidaNumeros(varKey: char): char;
begin
  If not(varKey in ['0' .. '9', #08, #44, #46]) then
    Result := #0
  else
  begin
    if varKey = #46 then
      varKey := #44;
    Result := varKey;
  end;
end;

function GerarID(varGenerator: String): string;
begin
  with DM.QuGerarID do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select Gen_ID (' + varGenerator + ',1) from RDB$DataBase');
    Open;
    Result := Fields[0].AsString;
  end;
end;

function BuscarString(varCampo, varTabela, varChave, varValorChave
  : String): String;
begin
  with DM.QuBuscarString do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select ' + varCampo + ' from ' + varTabela + ' where ' + varChave +
      ' = ' + #39 + varValorChave + #39);
    Open;
    Result := Fields[0].AsString;
  end;
end;

procedure ControlaPainel(varVisible: Boolean; varPainel: TPanel);
begin
  varPainel.Visible := varVisible;
end;

procedure ValidaVazia(varClient: TClientDataSet; varMsg: String);
begin
  if varClient.RecordCount = 0 then
  begin
    MessageDlg(varMsg, mtInformation, [mbOk], 0);
    Abort;
  end;
end;

function ValidaCNPJ(Num: string): Boolean;
var
  n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12: Integer;
  d1, d2: Integer;
  digitado, calculado: string;
begin
  Num := Trim(Num);
  if Length(Num) = 0 then
    Result := true
  else if Length(Num) <> 14 then
    Result := False
  else if (Num = '00000000000000') or (Num = '11111111111111') or
    (Num = '22222222222222') or (Num = '33333333333333') or
    (Num = '44444444444444') or (Num = '55555555555555') or
    (Num = '66666666666666') or (Num = '77777777777777') or
    (Num = '88888888888888') or (Num = '99999999999999') then
    Result := False
  else
  begin
    n1 := StrToInt(Num[1]);
    n2 := StrToInt(Num[2]);
    n3 := StrToInt(Num[3]);
    n4 := StrToInt(Num[4]);
    n5 := StrToInt(Num[5]);
    n6 := StrToInt(Num[6]);
    n7 := StrToInt(Num[7]);
    n8 := StrToInt(Num[8]);
    n9 := StrToInt(Num[9]);
    n10 := StrToInt(Num[10]);
    n11 := StrToInt(Num[11]);
    n12 := StrToInt(Num[12]);
    d1 := n12 * 2 + n11 * 3 + n10 * 4 + n9 * 5 + n8 * 6 + n7 * 7 + n6 * 8 + n5 *
      9 + n4 * 2 + n3 * 3 + n2 * 4 + n1 * 5;
    d1 := 11 - (d1 mod 11);
    if d1 >= 10 then
      d1 := 0;
    d2 := d1 * 2 + n12 * 3 + n11 * 4 + n10 * 5 + n9 * 6 + n8 * 7 + n7 * 8 + n6 *
      9 + n5 * 2 + n4 * 3 + n3 * 4 + n2 * 5 + n1 * 6;
    d2 := 11 - (d2 mod 11);
    if d2 >= 10 then
      d2 := 0;
    calculado := inttostr(d1) + inttostr(d2);
    digitado := Num[13] + Num[14];
    if calculado <> digitado then
      Result := False
    else
      Result := true;
  end;
end;

function ValidaCPF(Num: string): Boolean;
var
  n1, n2, n3, n4, n5, n6, n7, n8, n9: integer;
  d1, d2: integer;
  digitado, calculado: string;
begin
  num := (trim(num));
  num := StringReplace(num,' ','',[rfReplaceAll]);

  if Length(num) = 0 then
    Result := True
  else
  if Length(num) <> 11 then
    Result := False
  else
  if (num = '00000000000') or
    (num = '11111111111') or
    (num = '22222222222') or
    (num = '33333333333') or
    (num = '44444444444') or
    (num = '55555555555') or
    (num = '66666666666') or
    (num = '77777777777') or
    (num = '88888888888') or
    (num = '99999999999') then
    Result := False
  else
  begin
    n1 := StrToInt(num[1]);
    n2 := StrToInt(num[2]);
    n3 := StrToInt(num[3]);
    n4 := StrToInt(num[4]);
    n5 := StrToInt(num[5]);
    n6 := StrToInt(num[6]);
    n7 := StrToInt(num[7]);
    n8 := StrToInt(num[8]);
    n9 := StrToInt(num[9]);
    d1 := n9 * 2 + n8 * 3 + n7 * 4 + n6 * 5 + n5 * 6 + n4 * 7 + n3 * 8 + n2 * 9 + n1 * 10;
    d1 := 11 - (d1 mod 11);
    if d1 >= 10 then
      d1 := 0;
    d2 := d1 * 2 + n9 * 3 + n8 * 4 + n7 * 5 + n6 * 6 + n5 * 7 + n4 * 8 + n3 * 9 + n2 * 10 + n1 * 11;
    d2 := 11 - (d2 mod 11);
    if d2 >= 10 then
      d2 := 0;
    calculado := inttostr(d1) + inttostr(d2);
    digitado := num[10] + num[11];
    if calculado <> digitado then
      Result := False
    else
      Result := True;
  end;
end;

function AbrirPesquisaCad(varCampoPadrao, varCampoCod, varCampoStatus,
  varTabela, varDescricao, varSQL: string; varQueryPesq: TClientDataSet;
  Conexao: TFDCustomConnection): string;
begin
  CriarForm(FPesquisaRETIBO, TFPesquisaRETIBO, '');
  FPesquisaRETIBO.Query                  := varQueryPesq;
  FPesquisaRETIBO.CampoPadrao            := varCampoPadrao;
  FPesquisaRETIBO.EdCons.Text            := varTecla;
  FPesquisaRETIBO.Chave                  := varCampoCod;
  FPesquisaRETIBO.LabCampoStatus.Caption := varCampoStatus;
  FPesquisaRETIBO.QuConsulta.Connection  := Conexao;
  FPesquisaRETIBO.NomeTabela             := varTabela;
  FPesquisaRETIBO.Descricao              := varDescricao;
  FPesquisaRETIBO.SQLPersonalizado       := varSQL;
  FPesquisaRETIBO.ShowModal;

  if (FPesquisaRETIBO.CodRet <> '') then
  begin
    Result := FPesquisaRETIBO.CodRet;
  end
  else
  begin
    Result := '';
  end;
  DestruirForm(TForm(FPesquisaRETIBO));
  varTecla := #8;
end;

function RetornaCalculado(varTabela, varChave, varCampo, varValorComparar,
  varJoin, varAND: String): String;
begin
  with DM.QuBuscaCalcFields do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select * from RetornaCalculado ( ' + QuotedStr(varTabela) + ',' +
      QuotedStr(varChave) + ',' + QuotedStr(varCampo) + ',' +
      QuotedStr(varValorComparar) + ',' + QuotedStr(varJoin) + ',' +
      QuotedStr(varAND) + ')');
    Open;
    Result := Fields[0].AsString;
  end;
end;


function CrySenha(Snh: String): String;
var
  i: Integer;
begin
  for i := 1 to Length(Snh) do
    Result := Result + Chr((Ord(Snh[i]) + 57));
end;

function ExecAndWait(const FileName, Params: string;
  const WindowState: Word): Boolean;
var
  SUInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CmdLine: string;
begin
  { Coloca o nome do arquivo entre aspas. Isto � necess�rio devido aos espa�os contidos em nomes longos }
  CmdLine := '"' + FileName + '" ' + Params;
  FillChar(SUInfo, SizeOf(SUInfo), #0);
  with SUInfo do
  begin
    cb := SizeOf(SUInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := WindowState;
  end;
  Result := CreateProcess(nil, PChar(CmdLine), nil, nil, False,
    CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,
    PChar(ExtractFilePath(FileName)), SUInfo, ProcInfo);
  { Aguarda at� ser finalizado }
  if Result then
  begin
    WaitForSingleObject(ProcInfo.hProcess, INFINITE);
    { Libera os Handles }
    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);
  end;
end;


procedure AbrirDestruirForm(var varForm; varInstance: TFormClass);
begin
  CriarForm(varForm, varInstance, '');
  TForm(varForm).ShowModal;
  DestruirForm(TForm(varForm));
end;

procedure DestruirForm(var varForm: TForm);
begin
  varForm.Free;
  varForm := nil;
end;

procedure CriarForm(var varForm; varInstance: TFormClass; varParam: String);
var
  varObjeto: TObject;
begin
  If TForm(varForm) <> nil then
  begin
    MessageDlg('N�o � poss�vel visualizar a Janela. Ela j� est� aberta!',
      mtError, [mbOk], 0);
    Abort;
  end;

  Application.CreateForm(varInstance, varForm);

  varObjeto := TForm(varForm).FindComponent('StatusBar1');
  If varObjeto <> nil then
    TStatusBar(varObjeto).Panels[0].Text := 'ID: ' +
      UpperCase(TForm(varForm).Name);

  If varParam <> '' then
    TForm(varForm).Caption := varParam;
end;

function GerarPK(varCampo, varTabela: String): Integer;
begin
  with DM.QuBusca do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select max(' + varCampo + ') from ' + varTabela);
    Open;
    Result := Fields[0].AsInteger + 1;
  end;
end;


function GetBuildInfo:string;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
  V1, V2, V3, V4: Word;
  Prog : string;
begin
  Prog        := Application.Exename;
  VerInfoSize := GetFileVersionInfoSize(PChar(prog), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(prog), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  with VerValue^ do
  begin
    V1 := dwFileVersionMS shr 16;
    V2 := dwFileVersionMS and $FFFF;
    V3 := dwFileVersionLS shr 16;
    V4 := dwFileVersionLS and $FFFF;
  end;
  FreeMem(VerInfo, VerInfoSize);
  result := Copy (InttoStr(100 + v1), 3, 2) + '.' +
  Copy (InttoStr(100 + v2), 2, 2) + '.' +
  Copy (InttoStr(100 + v3), 2, 2);{ + '.' +
  Copy (InttoStr(100 + v4), 2, 2);}
end;

procedure ValidarCamposObrigatorios(const aQuery: TClientDataSet;
  varForm: TForm);
  procedure PorFoco(campo: TWinControl);
  begin
    if campo.CanFocus then
      campo.SetFocus;
  end;

var
  i, x: Integer;
begin
  For i := 0 to aQuery.FieldCount - 1 do
  begin
    if (aQuery.Fields[i].Required) and (aQuery.Fields[i].AsString = '') then
    begin
      For x := 0 to varForm.ComponentCount - 1 do
        if (varForm.Components[x] is TDbEdit) then
        begin
          if TDbEdit(varForm.Components[x]).Field.FieldName = aQuery.Fields[i].FieldName
          then
            PorFoco(TDbEdit(varForm.Components[x]));
        end
        else if (varForm.Components[x] is TDBComboBox) then
        begin
          if TDBComboBox(varForm.Components[x]).Field.FieldName = aQuery.Fields
            [i].FieldName then
            PorFoco(TDBComboBox(varForm.Components[x]));
        end
        else if (varForm.Components[x] is TDBLookupComboBox) then
        begin
          if TDBLookupComboBox(varForm.Components[x])
            .Field.FieldName = aQuery.Fields[i].FieldName then
            PorFoco(TDBLookupComboBox(varForm.Components[x]));
        end;
      MessageDlg('O Campo "' + aQuery.Fields[i].DisplayLabel +
        '" deve ser preenchido!', mtInformation, [mbOk], 0);
      Abort;
    end;
  end;
end;

function CloseAllClientDataSet(ADm: TDataModule): Boolean;
var
  i: Integer;
begin
  with ADm do
  begin
    for i := 0 to ComponentCount - 1 do
    begin
      if (Components[i] is TClientDataSet) then
      begin
        if TClientDataSet(Components[i]).Active = true then
          TClientDataSet(Components[i]).Active := False;
      end;

      if (Components[i] is TFDQuery) then
      begin
        if TFDQuery(Components[i]).Active = true then
          TFDQuery(Components[i]).Active := False;
      end;
    end;
  end;
end;

procedure Focar(campo: TWinControl);
begin
  if campo.CanFocus then
    campo.SetFocus;
end;

{procedure MouseLeaveSetColor(Sender: TObject);
begin
  TLabel(Sender).Cursor := crDefault;
  TLabel(Sender).Font.Color := clBlue;
end;

procedure MouseMoveSetColor(Sender: TObject);
begin
  TLabel(Sender).Cursor := crHandPoint;
  TLabel(Sender).Font.Color := clPurple;
end;}


procedure OcultarSheets(PageControl: TPageControl);
var
  iPage: Integer;
begin
  for iPage := 0 to PageControl.PageCount - 1 do
    PageControl.Pages[iPage].TabVisible := False;

  if (PageControl.PageCount > 0) then
    PageControl.ActivePage := PageControl.Pages[0];

  PageControl.Style := tsButtons;
end;


procedure ControlarEstadoBotoes(AForm: TForm; ATabela: TClientDataSet;
  ATag: Integer);
var
  i: Integer;
  ANovo, AAlterar, AExcluir: Integer;
begin
  ANovo := 1;
  AAlterar := 1;
  AExcluir := 1;

  with AForm do
  begin
    for i := 0 to ComponentCount - 1 do
    begin
      if (Components[i] is TBitBtn) and
        (Copy(UpperCase(TBitBtn(Components[i]).Name), 1, 6) = UpperCase('btNovo')) and
        (TBitBtn(Components[i]).Tag = ATag) then
        TBitBtn(Components[i]).Enabled := (ANovo = 1);

      if (Components[i] is TBitBtn) and
        (Copy(UpperCase(TBitBtn(Components[i]).Name), 1, 9) = UpperCase('btAlterar')) and
        (TBitBtn(Components[i]).Tag = ATag) then
        TBitBtn(Components[i]).Enabled := (AAlterar = 1);

      if (Components[i] is TBitBtn) and
        (Copy(UpperCase(TBitBtn(Components[i]).Name), 1, 9)= UpperCase('btExcluir')) and
        (TBitBtn(Components[i]).Tag = ATag) then
        TBitBtn(Components[i]).Enabled := (AExcluir = 1);
    end;
    Repaint;
  end;
end;

function ValidarEMail(aStr: string): Boolean;
begin
 aStr := Trim(UpperCase(aStr));
 if Pos('@', aStr) > 1 then
 begin
   Delete(aStr, 1, pos('@', aStr));
   Result := (Length(aStr) > 0) and (Pos('.', aStr) > 2);
 end
 else
   Result := False;
end;

end.
