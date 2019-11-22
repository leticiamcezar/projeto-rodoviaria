object FormEmpresas: TFormEmpresas
  Left = 195
  Top = 118
  Width = 468
  Height = 403
  Caption = 'Empresas'
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
  object BotaoFechar: TSpeedButton
    Left = 180
    Top = 318
    Width = 100
    Height = 30
    Caption = 'FECHAR'
    OnClick = BotaoFecharClick
  end
  object Label1: TLabel
    Left = 17
    Top = 16
    Width = 42
    Height = 13
    Caption = 'C'#211'DIGO'
  end
  object Label2: TLabel
    Left = 113
    Top = 16
    Width = 32
    Height = 13
    Caption = 'NOME'
  end
  object BotaoInserir: TSpeedButton
    Left = 17
    Top = 72
    Width = 80
    Height = 30
    Caption = 'INSERIR'
    OnClick = BotaoInserirClick
  end
  object BotaoAlterar: TSpeedButton
    Left = 110
    Top = 72
    Width = 80
    Height = 30
    Caption = 'ALTERAR'
    OnClick = BotaoAlterarClick
  end
  object BotaoSalvar: TSpeedButton
    Left = 202
    Top = 72
    Width = 150
    Height = 30
    Caption = 'SALVAR AS ALTERA'#199#213'ES'
    OnClick = BotaoSalvarClick
  end
  object BotaoExluir: TSpeedButton
    Left = 362
    Top = 72
    Width = 80
    Height = 30
    Caption = 'EXCLUIR'
    OnClick = BotaoExluirClick
  end
  object DBGridEmpresas: TDBGrid
    Left = 17
    Top = 136
    Width = 424
    Height = 167
    DataSource = DataSourceEmpresas
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object EditCod: TEdit
    Left = 17
    Top = 32
    Width = 80
    Height = 21
    MaxLength = 10
    TabOrder = 0
  end
  object EditNome: TEdit
    Left = 113
    Top = 32
    Width = 328
    Height = 21
    MaxLength = 30
    TabOrder = 1
  end
  object ADOQueryEmpresas: TADOQuery
    Connection = FormMenu.ConexaoBD
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Empresas ORDER BY nome')
    Left = 40
    Top = 312
    object ADOQueryEmpresascod_empresa: TIntegerField
      FieldName = 'cod_empresa'
    end
    object ADOQueryEmpresasnome: TStringField
      FieldName = 'nome'
      Size = 30
    end
  end
  object DataSourceEmpresas: TDataSource
    DataSet = ADOQueryEmpresas
    Left = 120
    Top = 312
  end
  object ADOQueryAuxiliar: TADOQuery
    Connection = FormMenu.ConexaoBD
    Parameters = <>
    Left = 80
    Top = 312
  end
end
