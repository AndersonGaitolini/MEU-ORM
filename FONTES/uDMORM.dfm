object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 309
  Width = 371
  object conORM_FD: TFDConnection
    Params.Strings = (
      'Database=E:\projeto2\MEU-ORM\MEUORM.FDB'
      'Password=masterkey'
      'User_Name=SYSDBA'
      'Protocol=localhost'
      'Port=3050'
      'CharacterSet=WIN1252'
      'DriverID=FB')
    LoginPrompt = False
    Left = 36
    Top = 35
  end
  object tranORM: TFDTransaction
    Connection = conORM_FD
    Left = 104
    Top = 37
  end
  object conORM_ZEOS: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    HostName = '127.0.0.1'
    Port = 3051
    Database = 'E:\eSocial\RH-DB.FDB'
    User = 'sysdba'
    Password = 'masterkey'
    Protocol = 'firebird-2.5'
    Left = 32
    Top = 94
  end
  object zqry1: TZQuery
    Params = <>
    Left = 94
    Top = 97
  end
end
