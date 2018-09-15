object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 309
  Width = 371
  object conORM_FD: TFDConnection
    Params.Strings = (
      'Database=E:\PROGRAMACAO\Repositorios\GITHUB\MEU-ORM\MEUORM.FDB'
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
  object fdgxwtcrsr1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 160
    Top = 32
  end
end
