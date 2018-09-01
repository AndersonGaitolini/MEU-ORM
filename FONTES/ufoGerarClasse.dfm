object foGeraClasse: TfoGeraClasse
  Left = 0
  Top = 0
  Caption = 'ORM-B'#225'sico: Gerar Classe'
  ClientHeight = 491
  ClientWidth = 739
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlRodape: TPanel
    Left = 0
    Top = 450
    Width = 739
    Height = 41
    Align = alBottom
    TabOrder = 0
    object btnSalvar: TButton
      Left = 76
      Top = 1
      Width = 75
      Height = 39
      Align = alLeft
      Caption = 'Salvar'
      TabOrder = 0
      OnClick = btnSalvarClick
    end
    object btnSair: TButton
      Left = 663
      Top = 1
      Width = 75
      Height = 39
      Align = alRight
      Caption = 'Sair'
      TabOrder = 1
      OnClick = btnSairClick
    end
    object btnGerar: TButton
      Left = 1
      Top = 1
      Width = 75
      Height = 39
      Align = alLeft
      Caption = 'Gerar'
      TabOrder = 2
      OnClick = btnGerarClick
    end
    object btnExecPackage: TButton
      Left = 151
      Top = 1
      Width = 75
      Height = 39
      Align = alLeft
      Caption = 'Pacote'
      TabOrder = 3
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 739
    Height = 25
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 265
      Top = 1
      Width = 473
      Height = 23
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = 'Resultado'
      Color = clGradientActiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label2: TLabel
      Left = 1
      Top = 1
      Width = 264
      Height = 23
      Align = alLeft
      Alignment = taCenter
      AutoSize = False
      Caption = 'Tabelas'
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
  end
  object pnlMenu: TPanel
    Left = 0
    Top = 25
    Width = 739
    Height = 62
    Align = alTop
    TabOrder = 2
    object btn1: TSpeedButton
      Left = 366
      Top = 13
      Width = 30
      Height = 22
      Caption = '...'
      OnClick = btn1Click
    end
    object btnInfo: TSpeedButton
      Left = 565
      Top = 14
      Width = 30
      Height = 35
      Flat = True
      Glyph.Data = {
        52060000424D52060000000000003604000028000000130000001B0000000100
        0800000000001C020000120B0000120B0000000100004A000000A07C2900FAF4
        EA00C7B18000CEA35200F0DEBE00B7995500EACA8600C7A56100B28A3900F1E7
        D500DECEAC00E7C68200DAB66C00FFFFFF00C69B4B00D5A75400E0CBA100F6E5
        BE00E0C69500DFBB7300BD964600F8EEDC00B8924100DFC08500A8833200D6AD
        6200D6AA5A00E3D3B200E5CB9900FAF9F500F1E3C700C79E4F00D7C59F00E6DB
        C300E0D4BA00BC944200D5A85900C3A25E00EED5A100D8B57500DBB06100E6C2
        7B00FCF7EE00F7F0E400BE994D00F6E8CC00A27F2D00EFE6DE00EDCD8A00EDE2
        CB00D9C08F00E5C79200BB985200CAA04F00B48E4100F5EAD500DBB36D00D2AC
        6800E7C98E00B99B5900E2BE7800F9F7F000CCB48300EBDEC400FCFAF500E0D1
        B200E6CFA400ECD9B800F5E5C400DCC79D00E7D9BD00CFA65800DEB573000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000000000000D0D0D0D0D0D
        0D0D0D0D0D0D0D0D0D0D0D0D0D5C0D0D0D0D0D0D0D0D2F221D0D0D0D0D0D0D0D
        0D5C0D0D0D0D0D0D0D02000000090D0D0D0D0D0D0D5C0D0D0D0D0D0D3D2E2E2E
        2E3B0D0D0D0D0D0D0D5C0D0D0D0D0D0D2B182E2E2E050D0D0D0D0D0D0D5C0D0D
        0D0D0D0D0D3B181818410D0D0D0D0D0D0D5C0D0D0D0D0D0D0D0D203E210D0D0D
        0D0D0D0D0D5C0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D5C0D0D0D0D0D0D
        0D1534360A0D0D0D0D0D0D0D0D5C0D0D0D0D0D0D0D250808080D0D0D0D0D0D0D
        0D5C0D0D0D0D0D0D0D2C363636310D0D0D0D0D0D0D5C0D0D0D0D0D0D0D071616
        163E0D0D0D0D0D0D0D5C0D0D0D0D0D0D0D1216161616460D0D0D0D0D0D5C0D0D
        0D0D0D0D0D4023232323231B0D0D0D0D0D5C0D0D0D0D0D0D0D0D3F1414141414
        450D0D0D0D5C0D0D0D0D0D0D0D0D0D3F1414141414320D0D0D5C0D0D0D0D0D0D
        0D0D0D0D090E0E0E0E0E100D0D5C0D0D401E400D0D0D0D0D0D2B1F0E0E0E0E2B
        0D5C0D15353535010D0D0D0D0D0D0935353535120D5C0D17353535120D0D0D0D
        0D0D0D39353535270D5C0D33470303030D0D0D0D0D0D0D38030303170D5C0D04
        0C030303420D0D0D0D0D01030303191C0D5C0D0D3C47474747430D0D0D151924
        240313150D5C0D0D37060F0F0F0F0F38191A1A1A0F13330D0D5C0D0D0D2D3028
        0F0F1A1A1A1A1A0F0B3A0D0D0D5C0D0D0D0D2A263029382828130630040D0D0D
        0D5C0D0D0D0D0D0D402D11111144150D0D0D0D0D0D5C}
      Transparent = False
      OnClick = btnInfoClick
    end
    object mo: TSpeedButton
      Left = 704
      Top = 30
      Width = 23
      Height = 22
      OnClick = moClick
    end
    object btnGetFileClass: TSpeedButton
      Left = 366
      Top = 37
      Width = 30
      Height = 22
      Caption = '...'
      OnClick = btnGetFileClassClick
    end
    object edFileBD: TLabeledEdit
      Left = 20
      Top = 14
      Width = 340
      Height = 21
      EditLabel.Width = 41
      EditLabel.Height = 13
      EditLabel.Caption = 'edFileBD'
      TabOrder = 0
    end
    object btnConexao: TJvSwitch
      Left = 402
      Top = 5
      Width = 157
      Height = 49
      Caption = 'Conectar'
      TabOrder = 1
      TextPosition = tpLeft
      OnClick = btnConexaoClick
    end
    object edFileClass: TLabeledEdit
      Left = 20
      Top = 38
      Width = 340
      Height = 21
      EditLabel.Width = 25
      EditLabel.Height = 13
      EditLabel.Caption = 'edBD'
      TabOrder = 2
    end
  end
  object pnlConfig: TPanel
    Left = 0
    Top = 87
    Width = 739
    Height = 59
    Align = alTop
    TabOrder = 3
  end
  object pnlMain: TPanel
    Left = 0
    Top = 146
    Width = 739
    Height = 304
    Align = alClient
    Caption = 'pnlMain'
    TabOrder = 4
    object pgc1: TPageControl
      Left = 1
      Top = 1
      Width = 737
      Height = 302
      ActivePage = tsSQL
      Align = alClient
      TabOrder = 0
      object tsClass: TTabSheet
        Caption = 'Gera Classes'
        object lstTabelas: TListBox
          Left = 0
          Top = 0
          Width = 227
          Height = 274
          Style = lbOwnerDrawFixed
          Align = alLeft
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 25
          Items.Strings = (
            'Tabela 1'
            'Tabela 2'
            'Tabela 3')
          ParentFont = False
          PopupMenu = pm1
          TabOrder = 0
        end
        object mmGerarSQL: TMemo
          Left = 227
          Top = 0
          Width = 502
          Height = 274
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          PopupMenu = pm1
          ScrollBars = ssVertical
          TabOrder = 1
        end
      end
      object tsSQL: TTabSheet
        Caption = 'Gera SQL'
        ImageIndex = 1
        object mmGerarCLass: TMemo
          Left = 227
          Top = 0
          Width = 502
          Height = 274
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          PopupMenu = pm1
          ScrollBars = ssVertical
          TabOrder = 0
        end
        object lstClasses: TListBox
          Left = 0
          Top = 0
          Width = 227
          Height = 274
          Style = lbOwnerDrawFixed
          Align = alLeft
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 25
          Items.Strings = (
            'Tabela 1'
            'Tabela 2'
            'Tabela 3')
          ParentFont = False
          PopupMenu = pm1
          TabOrder = 1
        end
      end
    end
  end
  object Salvar: TSaveDialog
    Filter = '*.pas|Pascal File'
    Left = 602
    Top = 178
  end
  object dlgOpen1: TOpenDialog
    Filter = 'ALL|*.*|FIREBIRD|*.FDB|ARQUIVO.PAS|*.PAS'
    FilterIndex = 2
    InitialDir = 'C:\'
    Title = 'Selecione o banco de dados'
    Left = 641
    Top = 177
  end
  object pm1: TPopupMenu
    Left = 678
    Top = 180
    object opcLimpartabela: TMenuItem
      Caption = 'Limpar tabela'
      OnClick = opcLimpartabelaClick
    end
    object opcLimparPas: TMenuItem
      Caption = 'Limpar .PAS'
      OnClick = opcLimparPasClick
    end
  end
end
