object FormMotoristas: TFormMotoristas
  Left = 193
  Top = 119
  Width = 436
  Height = 452
  Caption = 'Motoristas'
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
  object SpeedButton1: TSpeedButton
    Left = 163
    Top = 370
    Width = 100
    Height = 30
    Caption = 'FECHAR'
    OnClick = SpeedButton1Click
  end
  object Label1: TLabel
    Left = 109
    Top = 16
    Width = 32
    Height = 13
    Caption = 'NOME'
  end
  object Label2: TLabel
    Left = 21
    Top = 64
    Width = 33
    Height = 13
    Caption = 'IDADE'
  end
  object Label3: TLabel
    Left = 109
    Top = 64
    Width = 29
    Height = 13
    Caption = 'SEXO'
  end
  object Label4: TLabel
    Left = 197
    Top = 64
    Width = 46
    Height = 13
    Caption = 'SAL'#193'RIO'
  end
  object Label5: TLabel
    Left = 21
    Top = 16
    Width = 48
    Height = 13
    Caption = 'N'#218'MERO'
  end
  object BotaoInserir: TSpeedButton
    Left = 327
    Top = 72
    Width = 80
    Height = 30
    Caption = 'INSERIR'
    OnClick = BotaoInserirClick
  end
  object BotaoAlterar: TSpeedButton
    Left = 46
    Top = 120
    Width = 80
    Height = 30
    Caption = 'ALTERAR'
    OnClick = BotaoAlterarClick
  end
  object BotaoSalvar: TSpeedButton
    Left = 142
    Top = 120
    Width = 150
    Height = 30
    Caption = 'SALVAR ALTERA'#199#213'ES'
    OnClick = BotaoSalvarClick
  end
  object BotaoExcluir: TSpeedButton
    Left = 302
    Top = 120
    Width = 80
    Height = 30
    Caption = 'EXCLUIR'
    OnClick = BotaoExcluirClick
  end
  object DBGrid1: TDBGrid
    Left = 19
    Top = 170
    Width = 390
    Height = 185
    DataSource = DataSourceMotoristas
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object EditNome: TEdit
    Left = 109
    Top = 32
    Width = 297
    Height = 21
    MaxLength = 40
    TabOrder = 1
  end
  object EditIdade: TEdit
    Left = 21
    Top = 80
    Width = 74
    Height = 21
    TabOrder = 2
  end
  object EditSexo: TEdit
    Left = 109
    Top = 80
    Width = 74
    Height = 21
    MaxLength = 1
    TabOrder = 3
  end
  object EditSalario: TEdit
    Left = 197
    Top = 80
    Width = 114
    Height = 21
    TabOrder = 4
  end
  object EditNum: TEdit
    Left = 21
    Top = 32
    Width = 73
    Height = 21
    TabOrder = 0
  end
  object ADOQueryMotoristas: TADOQuery
    Connection = FormMenu.ConexaoBD
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Motoristas ORDER BY nome')
    Left = 38
    Top = 373
  end
  object DataSourceMotoristas: TDataSource
    DataSet = ADOQueryMotoristas
    Left = 342
    Top = 373
  end
  object ADOQueryAuxiliar: TADOQuery
    Connection = FormMenu.ConexaoBD
    Parameters = <>
    Left = 76
    Top = 376
  end
end
