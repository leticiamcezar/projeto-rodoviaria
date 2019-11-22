object FormOnibus: TFormOnibus
  Left = 192
  Top = 117
  Width = 419
  Height = 481
  Caption = #212'nibus'
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
  object BotaoSalvar: TSpeedButton
    Left = 133
    Top = 124
    Width = 150
    Height = 30
    Caption = 'SALVAR ALTERA'#199#213'ES'
    OnClick = BotaoSalvarClick
  end
  object BotaoAlterar: TSpeedButton
    Left = 37
    Top = 124
    Width = 80
    Height = 30
    Caption = 'ALTERAR'
    OnClick = BotaoAlterarClick
  end
  object SpeedButton1: TSpeedButton
    Left = 158
    Top = 402
    Width = 100
    Height = 30
    Caption = 'FECHAR'
    OnClick = SpeedButton1Click
  end
  object Label1: TLabel
    Left = 16
    Top = 18
    Width = 111
    Height = 13
    Caption = 'N'#218'MERO DO '#212'NIBUS'
  end
  object Label2: TLabel
    Left = 16
    Top = 66
    Width = 52
    Height = 13
    Caption = 'EMPRESA'
  end
  object Label3: TLabel
    Left = 131
    Top = 66
    Width = 64
    Height = 13
    Caption = 'MOTORISTA'
  end
  object Label4: TLabel
    Left = 144
    Top = 18
    Width = 49
    Height = 13
    Caption = 'TRAJETO'
  end
  object BotaoInserir: TSpeedButton
    Left = 313
    Top = 74
    Width = 80
    Height = 30
    Caption = 'INSERIR'
    OnClick = BotaoInserirClick
  end
  object BotaoExcluir: TSpeedButton
    Left = 293
    Top = 124
    Width = 80
    Height = 30
    Caption = 'EXCLUIR'
    OnClick = BotaoExcluirClick
  end
  object DBGrid1: TDBGrid
    Left = 12
    Top = 182
    Width = 387
    Height = 198
    DataSource = DataSourceOnibus
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object EditNum: TEdit
    Left = 16
    Top = 34
    Width = 112
    Height = 21
    MaxLength = 4
    TabOrder = 0
  end
  object EditTrajeto: TEdit
    Left = 144
    Top = 34
    Width = 250
    Height = 21
    MaxLength = 40
    TabOrder = 1
  end
  object ComboBoxMot: TComboBox
    Left = 131
    Top = 82
    Width = 170
    Height = 21
    ItemHeight = 13
    TabOrder = 3
    OnChange = ComboBoxMotChange
  end
  object ComboBoxEmp: TComboBox
    Left = 16
    Top = 82
    Width = 100
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    OnChange = ComboBoxEmpChange
  end
  object ADOQueryOnibus: TADOQuery
    Connection = FormMenu.ConexaoBD
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT Onibus.num_onibus AS Onibus, '
      '               Empresas.nome AS Empresa,  '
      '               Motoristas.nome AS Motorista, '
      '               Onibus.trajeto'
      'FROM Onibus'
      '  INNER JOIN Empresas'
      '    ON Empresas.cod_empresa = Onibus.cod_empresa'
      '  INNER JOIN Motoristas'
      '    ON Motoristas.num_motorista = Onibus.num_motorista')
    Left = 31
    Top = 394
  end
  object ADOQueryAuxiliar: TADOQuery
    Connection = FormMenu.ConexaoBD
    Parameters = <>
    Left = 80
    Top = 394
  end
  object DataSourceOnibus: TDataSource
    DataSet = ADOQueryOnibus
    Left = 318
    Top = 394
  end
end
