object FPesquisaIBO: TFPesquisaIBO
  Left = 560
  Top = 288
  AutoSize = True
  BorderStyle = bsDialog
  Caption = 'Consulta de'
  ClientHeight = 436
  ClientWidth = 672
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 672
    Height = 57
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 89
      Height = 16
      Caption = 'Consultar por:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 136
      Top = 8
      Width = 32
      Height = 16
      Caption = 'Tipo:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 248
      Top = 8
      Width = 53
      Height = 16
      Caption = 'Entrada:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 302
      Top = 8
      Width = 23
      Height = 16
      Caption = '(F3)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object CbConsultarPor: TComboBox
      Left = 8
      Top = 26
      Width = 121
      Height = 24
      Style = csOwnerDrawFixed
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 18
      ParentFont = False
      TabOrder = 0
      OnExit = CbConsultarPorExit
      OnKeyPress = CbConsultarPorKeyPress
    end
    object CbTipo: TComboBox
      Left = 136
      Top = 26
      Width = 105
      Height = 24
      Style = csOwnerDrawFixed
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 18
      ParentFont = False
      TabOrder = 1
      OnKeyPress = CbTipoKeyPress
      Items.Strings = (
        'Iniciando por'
        'Terminando por'
        'Igual')
    end
    object BtPesquisar: TButton
      Left = 576
      Top = 24
      Width = 89
      Height = 25
      Cursor = crHandPoint
      Caption = 'Pesquisar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = BtPesquisarClick
    end
    object EdCons: TMaskEdit
      Left = 248
      Top = 26
      Width = 321
      Height = 24
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = ''
      OnKeyPress = EdConsKeyPress
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 80
    Width = 672
    Height = 298
    Align = alTop
    DataSource = DsConsulta
    DrawingStyle = gdsGradient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    OnKeyPress = DBGrid1KeyPress
    OnTitleClick = DBGrid1TitleClick
  end
  object Panel2: TPanel
    Left = 0
    Top = 57
    Width = 672
    Height = 23
    Align = alTop
    TabOrder = 2
    object Gauge1: TGauge
      Left = 1
      Top = 1
      Width = 670
      Height = 21
      Align = alClient
      BackColor = clSilver
      Color = clBtnFace
      ForeColor = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      MinValue = 1
      MaxValue = 3
      ParentColor = False
      ParentFont = False
      Progress = 1
      ShowText = False
    end
    object Label4: TLabel
      Left = 7
      Top = 5
      Width = 68
      Height = 14
      Caption = 'Consultar por:'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object LbConsPor: TLabel
      Left = 75
      Top = 5
      Width = 6
      Height = 14
      Caption = '_'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object LbEntrada: TLabel
      Left = 239
      Top = 5
      Width = 6
      Height = 14
      Caption = '_'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Label7: TLabel
      Left = 199
      Top = 5
      Width = 40
      Height = 14
      Caption = 'Entrada:'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Label8: TLabel
      Left = 487
      Top = 5
      Width = 89
      Height = 14
      Caption = 'Total de Registros:'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object LbTotalReg: TLabel
      Left = 576
      Top = 5
      Width = 6
      Height = 14
      Caption = '_'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object LbProgress: TLabel
      Left = 636
      Top = 5
      Width = 21
      Height = 14
      Caption = '0 / 3'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 378
    Width = 672
    Height = 39
    Align = alTop
    TabOrder = 3
    object Button1: TButton
      Left = 5
      Top = 8
      Width = 113
      Height = 25
      Cursor = crHandPoint
      Caption = 'Limpar Consulta'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 417
    Width = 672
    Height = 19
    Align = alTop
    Panels = <
      item
        Text = 'ID:FPesquisaIBO'
        Width = 100
      end
      item
        Text = 'Esc - Sair'
        Width = 75
      end>
  end
  object DsConsulta: TDataSource
    DataSet = QuConsulta
    Left = 120
    Top = 128
  end
  object PopupMenu1: TPopupMenu
    Left = 216
    Top = 128
    object Focarentrada1: TMenuItem
      Caption = 'Focar entrada'
      ShortCut = 114
      OnClick = Focarentrada1Click
    end
    object Sair1: TMenuItem
      Caption = 'Sair'
      ShortCut = 27
      OnClick = Sair1Click
    end
  end
  object QuConsulta: TFDQuery
    UpdateOptions.AssignedValues = [uvUpdateMode, uvLockPoint, uvLockWait, uvFetchGeneratorsPoint, uvGeneratorName]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.GeneratorName = 'GEN_EMPRESA'
    UpdateOptions.UpdateTableName = 'EMPRESA'
    UpdateOptions.KeyFields = 'CODEMPRESA'
    UpdateOptions.AutoIncFields = 'CODEMPRESA'
    SQL.Strings = (
      '')
    Left = 56
    Top = 128
  end
end