object FPrinc: TFPrinc
  Left = 0
  Top = 0
  Caption = 'Teste Linx'
  ClientHeight = 608
  ClientWidth = 1051
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  Position = poDesigned
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object img_logo: TImage
    Left = 0
    Top = 416
    Width = 1051
    Height = 167
    Align = alCustom
    Anchors = [akLeft, akRight, akBottom]
    Center = True
    Transparent = True
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 589
    Width = 1051
    Height = 19
    DoubleBuffered = False
    Panels = <
      item
        Width = 50
      end>
    ParentDoubleBuffered = False
    ParentShowHint = False
    ShowHint = True
    SimplePanel = True
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 16
    object Cadastros1: TMenuItem
      Caption = 'Cadastro'
      object Usurio1: TMenuItem
        Caption = 'Usu'#225'rio'
        ShortCut = 123
        OnClick = Usurio1Click
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 48
    Top = 16
    object Usuario1: TMenuItem
      Caption = 'Usu'#225'rio'
      ShortCut = 123
      OnClick = Usurio1Click
    end
  end
end
