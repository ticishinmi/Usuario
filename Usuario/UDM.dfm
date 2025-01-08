object DM: TDM
  OldCreateOrder = False
  Height = 592
  Width = 826
  object Connection: TFDConnection
    Params.Strings = (
      'Database=D:\Projeto Linx\Usuario\LINX.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=localhost'
      'DriverID=FB')
    LoginPrompt = False
    Transaction = Transaction
    Left = 16
    Top = 8
  end
  object Transaction: TFDTransaction
    Connection = Connection
    Left = 47
    Top = 8
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    VendorLib = 'D:\Projeto Linx\fbclient.dll'
    Left = 79
    Top = 8
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrAppWait
    Left = 110
    Top = 8
  end
  object QuGerarID: TFDQuery
    Connection = Connection
    SQL.Strings = (
      '')
    Left = 352
    Top = 8
  end
  object QuBuscarString: TFDQuery
    Connection = Connection
    SQL.Strings = (
      '')
    Left = 408
    Top = 8
  end
  object QuBuscaCalcFields: TFDQuery
    Connection = Connection
    SQL.Strings = (
      '')
    Left = 286
    Top = 8
  end
  object QuBusca: TFDQuery
    Connection = Connection
    SQL.Strings = (
      '')
    Left = 224
    Top = 8
  end
  object cdsUsuario: TClientDataSet
    Aggregates = <>
    CommandText = 'SELECT * FROM USUARIO'
    Params = <>
    ProviderName = 'dspUsuario'
    BeforePost = cdsUsuarioBeforePost
    OnNewRecord = cdsUsuarioNewRecord
    Left = 72
    Top = 65
    object cdsUsuarioUSU_COD: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'USU_COD'
      Required = True
    end
    object cdsUsuarioUSU_NOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'USU_NOME'
      Required = True
      Size = 150
    end
    object cdsUsuarioUSU_USUARIO: TStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'USU_USUARIO'
      Size = 30
    end
    object cdsUsuarioUSU_SENHA: TStringField
      Tag = 1
      DisplayLabel = 'Senha'
      FieldName = 'USU_SENHA'
      Visible = False
      Size = 10
    end
    object cdsUsuarioUSU_EMAIL: TStringField
      DisplayLabel = 'E-mail'
      FieldName = 'USU_EMAIL'
      Required = True
      Size = 100
    end
    object cdsUsuarioUSU_PAINEL: TStringField
      DisplayLabel = 'Painel'
      FieldName = 'USU_PAINEL'
      Size = 30
    end
    object cdsUsuarioUSU_DTCRIA: TDateField
      DisplayLabel = 'Cria'#231#227'o'
      FieldName = 'USU_DTCRIA'
    end
    object cdsUsuarioUSU_DTATU: TDateField
      DisplayLabel = #218'ltima atualiza'#231#227'o'
      FieldName = 'USU_DTATU'
    end
    object cdsUsuarioUSU_STATUS: TStringField
      DisplayLabel = 'Status'
      FieldName = 'USU_STATUS'
      Size = 10
    end
  end
  object dsUsuario: TDataSource
    DataSet = cdsUsuario
    Left = 104
    Top = 65
  end
  object dspUsuario: TDataSetProvider
    DataSet = fqUsuario
    Options = [poPropogateChanges, poAllowCommandText, poUseQuoteChar]
    Left = 40
    Top = 65
  end
  object fqUsuario: TFDQuery
    Connection = Connection
    Transaction = Transaction
    SQL.Strings = (
      'SELECT * FROM USUARIO')
    Left = 8
    Top = 65
  end
end