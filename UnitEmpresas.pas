unit UnitEmpresas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Buttons, Grids, DBGrids, StdCtrls;

type
  TFormEmpresas = class(TForm)
    BotaoFechar: TSpeedButton;
    ADOQueryEmpresas: TADOQuery;
    DBGridEmpresas: TDBGrid;
    DataSourceEmpresas: TDataSource;
    ADOQueryEmpresascod_empresa: TIntegerField;
    ADOQueryEmpresasnome: TStringField;
    EditCod: TEdit;
    EditNome: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ADOQueryAuxiliar: TADOQuery;
    BotaoInserir: TSpeedButton;
    BotaoAlterar: TSpeedButton;
    BotaoSalvar: TSpeedButton;
    BotaoExluir: TSpeedButton;
    procedure BotaoFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BotaoInserirClick(Sender: TObject);
    procedure BotaoAlterarClick(Sender: TObject);
    procedure BotaoSalvarClick(Sender: TObject);
    procedure BotaoExluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEmpresas: TFormEmpresas;
  cod_empresa : string;
  deu_errado : boolean;

implementation

uses UnitMenu, UnitMotoristas, UnitOnibus;

{$R *.dfm}

procedure TFormEmpresas.BotaoFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFormEmpresas.FormShow(Sender: TObject);
begin
 ADOQueryEmpresas.Open;
end;

procedure TFormEmpresas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ADOQueryEmpresas.Close;
end;

procedure TFormEmpresas.BotaoInserirClick(Sender: TObject);
begin
  if (trim(EditCod.Text)='') or (trim(EditNome.Text)='') then
   begin
      Showmessage('Preencha todos os campos!');
   end
  else
   begin
    FormMenu.ConexaoBD.BeginTrans;
    ADOQueryAuxiliar.SQL.Text := 'INSERT INTO Empresas VALUES('+
                                  EditCod.Text + ',' + QuotedStr(EditNome.Text) + ')';
    try
      ADOQueryAuxiliar.ExecSQL;
      deu_errado := false;
    except
      on E : Exception do
      begin
        deu_errado := true;
        if FormMenu.ErroBD(E.Message,'PK_Empresas') = 'sim' then
          showmessage('Código já cadastrado!')
        else
          showmessage('Ocorreu o seguinte erro: ' + E.Message);
      end;
    end;

    if deu_errado = false then
      begin
        FormMenu.ConexaoBD.CommitTrans;
        ADOQueryEmpresas.Close;
        ADOQueryEmpresas.Open;
        showmessage('Operação executada com sucesso!');
        EditCod.Clear;
        EditNome.Clear;
      end
    else
      begin
        FormMenu.ConexaoBD.RollbackTrans;
      end;
    end;
end;

procedure TFormEmpresas.BotaoAlterarClick(Sender: TObject);
begin
  cod_empresa := ADOQueryEmpresas.fieldbyname('cod_empresa').AsString;
  EditCod.Text := cod_empresa;
  EditNome.Text := ADOQueryEmpresas.fieldbyname('nome').AsString;
end;

procedure TFormEmpresas.BotaoSalvarClick(Sender: TObject);
begin
  FormMenu.ConexaoBD.BeginTrans;
  ADOQueryAuxiliar.SQL.Text:='UPDATE Empresas SET' +
                             ' cod_empresa = ' + EditCod.Text + ',' +
                             ' nome = ' +QuotedStr(EditNome.Text) +
                             ' WHERE cod_empresa = ' + cod_empresa;
  try
    ADOQueryAuxiliar.ExecSQL;
    deu_errado := false;
  except
      on E : Exception do
      begin
        deu_errado := true;
        if FormMenu.ErroBD(E.Message,'FK_Onibus_Empresas') = 'sim' then
          showmessage('Impossível atualizar o código pois existem ônibus ligados a esta Empresa!')
        else if FormMenu.ErroBD(E.Message,'PK_Empresas') = 'sim' then
          showmessage('Código já cadastrado!')
        else
          showmessage('Ocorreu o seguinte erro: ' + E.Message);
      end;
  end;

  if deu_errado = false then
    begin
      FormMenu.ConexaoBD.CommitTrans;
      ADOQueryEmpresas.Close;
      ADOQueryEmpresas.Open;
      showmessage('Informações atualizadas com sucesso!');
      EditCod.Clear;
      EditNome.Clear;
    end
  else
    begin
      FormMenu.ConexaoBD.RollbackTrans;
    end;
end;

procedure TFormEmpresas.BotaoExluirClick(Sender: TObject);
begin
  cod_empresa:=ADOQueryEmpresas.fieldbyname('cod_empresa').AsString;
  FormMenu.ConexaoBD.BeginTrans;
  ADOQueryAuxiliar.SQL.Text:= ' DELETE FROM Empresas' +
                              ' WHERE cod_empresa = ' + cod_empresa;
  deu_errado := false;
  try
    ADOQueryAuxiliar.ExecSQL;
  except
    on E: Exception do
    begin
      deu_errado := true;
      if FormMenu.ErroBD(E.Message,'FK_Onibus_Empresas') = 'sim' then
        showmessage('Impossível excluir pois existem Ônibus ligados a esta Empresa!')
      else
        showmessage('Ocorreu o seguinte erro: ' + E.Message);
      end;
    end;
  if deu_errado = true then
    FormMenu.ConexaoBD.RollbackTrans
  else
    begin
      FormMenu.ConexaoBD.CommitTrans;
      ADOQueryEmpresas.Close;
      ADOQueryEmpresas.Open;
      showmessage('Empresa excluída com secesso!');
    end;
end;

end.
