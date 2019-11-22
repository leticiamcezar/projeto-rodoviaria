object FormMenu: TFormMenu
  Left = 192
  Top = 117
  Width = 250
  Height = 300
  Caption = 'Menu Rodovi'#225'ria'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BotaoEmpresas: TSpeedButton
    Left = 71
    Top = 48
    Width = 100
    Height = 30
    Caption = 'EMPRESAS'
    OnClick = BotaoEmpresasClick
  end
  object BotaoMotoristas: TSpeedButton
    Left = 71
    Top = 96
    Width = 100
    Height = 30
    Caption = 'MOTORISTAS'
    OnClick = BotaoMotoristasClick
  end
  object BotaoOnibus: TSpeedButton
    Left = 71
    Top = 144
    Width = 100
    Height = 30
    Caption = #212'NIBUS'
    OnClick = BotaoOnibusClick
  end
  object BotaoFechar: TSpeedButton
    Left = 71
    Top = 192
    Width = 100
    Height = 30
    Caption = 'FECHAR'
    OnClick = BotaoFecharClick
  end
  object ConexaoBD: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=123;Persist Security Info=True;User' +
      ' ID=sa;Initial Catalog=Rodoviaria;Data Source=PROGRAMADOR-01'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 16
    Top = 16
  end
end
