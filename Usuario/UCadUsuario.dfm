inherited FCadUsuario: TFCadUsuario
  Caption = 'Cadastro de Usu'#225'rio'
  ClientHeight = 320
  ExplicitHeight = 359
  PixelsPerInch = 96
  TextHeight = 16
  inherited pnSuperior: TPanel
    inherited pnNovo: TPanel
      inherited btNovo: TBitBtn
        Left = 5
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555FFFFFFFFFF55555000000000055555577777777775FFFF00B8B8B8B8B0
          0000775F5555555777770B0B8B8B8B8B0FF07F75F555555575F70FB0B8B8B8B8
          B0F07F575FFFFFFFF7F70BFB0000000000F07F557777777777570FBFBF0FFFFF
          FFF07F55557F5FFFFFF70BFBFB0F000000F07F55557F777777570FBFBF0FFFFF
          FFF075F5557F5FFFFFF750FBFB0F000000F0575FFF7F777777575700000FFFFF
          FFF05577777F5FF55FF75555550F00FF00005555557F775577775555550FFFFF
          0F055555557F55557F755555550FFFFF00555555557FFFFF7755555555000000
          0555555555777777755555555555555555555555555555555555}
        ExplicitLeft = 5
      end
      inherited btAlterar: TBitBtn
        Left = 104
        Top = 1
        ExplicitLeft = 104
        ExplicitTop = 1
      end
    end
  end
  inherited pgGeral: TPageControl
    Height = 191
    ExplicitHeight = 191
    inherited tsDadosGerais: TTabSheet
      ExplicitHeight = 160
      inherited Bevel1: TBevel [0]
        Height = 160
        ExplicitLeft = 0
        ExplicitTop = -2
        ExplicitWidth = 539
        ExplicitHeight = 160
      end
      inherited Label1: TLabel [1]
        Top = 9
        ExplicitTop = 9
      end
      object Label2: TLabel [2]
        Left = 203
        Top = 101
        Width = 49
        Height = 16
        Caption = 'Senha:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel [3]
        Left = 100
        Top = 9
        Width = 41
        Height = 16
        Caption = 'Nome:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel [4]
        Left = 11
        Top = 57
        Width = 44
        Height = 16
        Caption = 'E-mail:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel [5]
        Left = 11
        Top = 101
        Width = 52
        Height = 16
        Caption = 'Usu'#225'rio:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel [6]
        Left = 403
        Top = 57
        Width = 45
        Height = 16
        Caption = 'Painel:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      inherited dbPadrao: TDBEdit
        Left = 100
        Top = 27
        Width = 418
        DataField = 'USU_NOME'
        DataSource = DM.dsUsuario
        TabOrder = 1
        ExplicitLeft = 100
        ExplicitTop = 27
        ExplicitWidth = 418
      end
      object DBEdit1: TDBEdit
        Left = 202
        Top = 120
        Width = 150
        Height = 24
        CharCase = ecUpperCase
        Color = clBtnFace
        DataField = 'USU_SENHA'
        DataSource = DM.dsUsuario
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 5
        OnKeyPress = dbPadraoKeyPress
      end
      object DBCheckBox1: TDBCheckBox
        Left = 465
        Top = 134
        Width = 53
        Height = 17
        TabStop = False
        Caption = 'Ativo'
        DataField = 'USU_STATUS'
        DataSource = DM.dsUsuario
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        ValueChecked = 'SIM'
        ValueUnchecked = 'N'#195'O'
      end
      object DBEdit2: TDBEdit
        Left = 11
        Top = 27
        Width = 77
        Height = 24
        CharCase = ecUpperCase
        DataField = 'USU_COD'
        DataSource = DM.dsUsuario
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnKeyPress = dbPadraoKeyPress
      end
      object DBEdit3: TDBEdit
        Left = 11
        Top = 74
        Width = 374
        Height = 24
        CharCase = ecLowerCase
        DataField = 'USU_EMAIL'
        DataSource = DM.dsUsuario
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnKeyPress = dbPadraoKeyPress
      end
      object DBEdit4: TDBEdit
        Left = 11
        Top = 120
        Width = 174
        Height = 24
        CharCase = ecUpperCase
        DataField = 'USU_USUARIO'
        DataSource = DM.dsUsuario
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnKeyPress = dbPadraoKeyPress
      end
      object DBComboBox1: TDBComboBox
        Left = 403
        Top = 74
        Width = 115
        Height = 24
        Style = csOwnerDrawFixed
        DataField = 'USU_PAINEL'
        DataSource = DM.dsUsuario
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 18
        Items.Strings = (
          'ADMIN'
          'USER')
        ParentFont = False
        TabOrder = 3
        OnKeyPress = dbPadraoKeyPress
      end
    end
  end
  inherited StatusBar1: TStatusBar
    Top = 301
    ExplicitTop = 301
  end
  object PnData: TPanel [4]
    Left = 0
    Top = 275
    Width = 547
    Height = 26
    Align = alTop
    BevelInner = bvLowered
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object Label3: TLabel
      Left = 15
      Top = 6
      Width = 77
      Height = 16
      Caption = 'Data cria'#231#227'o:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 303
      Top = 6
      Width = 111
      Height = 16
      Caption = #218'ltima atualiza'#231#227'o:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object DBText1: TDBText
      Left = 98
      Top = 6
      Width = 65
      Height = 17
      DataField = 'USU_DTCRIA'
      DataSource = DM.dsUsuario
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object DBText2: TDBText
      Left = 420
      Top = 6
      Width = 65
      Height = 17
      DataField = 'USU_DTATU'
      DataSource = DM.dsUsuario
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
  end
end
