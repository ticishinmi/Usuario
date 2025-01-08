object FPesquisaRETIBO: TFPesquisaRETIBO
  Left = 216
  Top = 149
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
    object LabCampoStatus: TLabel
      Left = 416
      Top = 8
      Width = 100
      Height = 16
      Caption = 'LabCampoStatus'
      Visible = False
    end
    object CbConsultarPor: TComboBox
      Left = 9
      Top = 27
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
      Top = 27
      Width = 105
      Height = 24
      Style = csOwnerDrawFixed
      ItemHeight = 18
      TabOrder = 1
      OnKeyPress = CbTipoKeyPress
      Items.Strings = (
        'Iniciando por'
        'Terminando por'
        'Igual')
    end
    object BtPesquisar: TButton
      Left = 576
      Top = 26
      Width = 89
      Height = 25
      Caption = 'Pesquisar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = BtPesquisarClick
    end
    object EdCons: TMaskEdit
      Left = 249
      Top = 27
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
    PopupMenu = ConfGrade
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    OnKeyPress = DBGrid1KeyPress
    OnTitleClick = DBGrid1TitleClick
    Columns = <
      item
        Expanded = False
        Visible = True
      end>
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
      ExplicitLeft = 0
      ExplicitTop = 0
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
      Left = 74
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
      Left = 242
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
      Left = 578
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
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object Label6: TLabel
      Left = 600
      Top = 16
      Width = 42
      Height = 14
      Caption = 'Vers'#227'o:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object LbVersao: TLabel
      Left = 648
      Top = 16
      Width = 15
      Height = 14
      Caption = '1.5'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object CBManterPConsulta: TCheckBox
      Left = 8
      Top = 13
      Width = 252
      Height = 17
      Caption = 'Manter dados para a pr'#243'xima consulta'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object Button1: TButton
      Left = 252
      Top = 8
      Width = 113
      Height = 25
      Caption = 'Limpar Consulta'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
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
        Width = 100
      end
      item
        Text = 'Esc - Sair'
        Width = 75
      end>
  end
  object DsConsulta: TDataSource
    DataSet = QuConsulta
    Left = 80
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
  object ConfGrade: TPopupMenu
    Left = 248
    Top = 128
    object ConfigurarGrade1: TMenuItem
      Caption = 'Configurar Grade'
      ShortCut = 16455
    end
  end
  object QuConsulta: TFDQuery
    Left = 128
    Top = 136
  end
end
