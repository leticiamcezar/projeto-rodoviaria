unit UnitOnibus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, Grids, DBGrids, DB, ADODB, StdCtrls;

type
  TFormOnibus = class(TForm)
    ADOQueryOnibus: TADOQuery;
    DBGrid1: TDBGrid;
    SpeedButton1: TSpeedButton;
    EditNum: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EditTrajeto: TEdit;
    Label4: TLabel;
    BotaoInserir: TSpeedButton;
    ComboBoxMot: TComboBox;
    ComboBoxEmp: TComboBox;
    ADOQueryAuxiliar: TADOQuery;
    DataSourceOnibus: TDataSource;
    BotaoAlterar: TSpeedButton;
    BotaoSalvar: TSpeedButton;
    BotaoExcluir: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBoxEmpChange(Sender: TObject);
    procedure ComboBoxMotChange(Sender: TObject);
    procedure BotaoInserirClick(Sender: TObject);
    procedure BotaoAlterarClick(Sender: TObject);
    procedure BotaoSalvarClick(Sender: TObject);
    procedure BotaoExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormOnibus: TFormOnibus;
  num_motorista, cod_empresa : integer;
  num_onibus : string;

implementation

uses UnitEmpresas, UnitMenu, UnitMotoristas;

{$R *.dfm}

procedure TFormOnibus.SpeedButton1Click(Sender: TObject);
begin
 close;
end;

procedure TFormOnibus.FormShow(Sender: TObject);
begin
ADOQueryOnibus.Open;
 ComboBoxMot.Clear;
 ADOQueryAuxiliar.SQL.Text := 'SELECT nome FROM Motoristas ORDER BY nome';
 ADOQueryAuxiliar.Open;
 While Not ADOQueryAuxiliar.Eof do
  begin
    ComboBoxMot.Items.Add(ADOQueryAuxiliar.fieldbyname('nome').AsString);
    ADOQueryAuxiliar.Next;
  end;
 ADOQueryAuxiliar.Close;
 ComboBoxEmp.Clear;
 ADOQueryAuxiliar.SQL.Text := 'SELECT nome FROM Empresas ORDER BY nome';
 ADOQueryAuxiliar.Open;
 While Not ADOQueryAuxiliar.Eof do
  begin
    ComboBoxEmp.Items.Add(ADOQueryAuxiliar.fieldbyname('nome').AsString);
    ADOQueryAuxiliar.Next;
  end;
 ADOQueryAuxiliar.Close;
end;

procedure TFormOnibus.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 ADOQueryOnibus.Close;
end;

procedure TFormOnibus.ComboBoxMotChange(Sender: TObject);
begin
  ADOQueryAuxiliar.SQL.Text := ' SELECT num_motorista FROM Motoristas '+
                               ' WHERE nome = '+ QuotedStr(ComboBoxMot.Text);
  ADOQueryAuxiliar.Open;
  num_motorista := ADOQueryAuxiliar.fieldbyname('num_motorista').AsInteger;
  ADOQueryAuxiliar.Close;
end;

procedure TFormOnibus.ComboBoxEmpChange(Sender: TObject);
begin
  ADOQueryAuxiliar.SQL.Text := ' SELECT cod_empresa FROM Empresas '+
                               ' WHERE nome = '+ QuotedStr(ComboBoxEmp.Text);
  ADOQueryAuxiliar.Open;
  cod_empresa := ADOQueryAuxiliar.fieldbyname('cod_empresa').AsInteger;
  ADOQueryAuxiliar.Close;
end;

procedure TFormOnibus.BotaoInserirClick(Sender: TObject);
begin
  if (trim(EditNum.Text)='') or (trim(EditTrajeto.Text)='') or
     (trim(ComboBoxMot.Text)='') or (trim(ComboBoxEmp.Text)='') then
   begin
    Showmessage('Preencha todos os campos!');
   end
  else
   begin
    FormMenu.ConexaoBD.BeginTrans;
    ADOQueryAuxiliar.SQL.Text:='INSERT INTO Onibus VALUES ('+
                                EditNum.Text + ',' + IntToStr(cod_empresa) + ',' +
                                IntToStr(num_motorista) + ',' + QuotedStr(EditTrajeto.Text) + ')';
    try
      ADOQueryAuxiliar.ExecSQL;
      deu_errado := false;
    except
      on E : Exception do
      begin
        deu_errado := true;
        if FormMenu.ErroBD(E.Message,'PK_Onibus') = 'sim' then
          showmessage('Código já cadastrado!')
        else
          showmessage('Ocorreu o seguinte erro: ' + E.Message);
        end;
      end;
    if deu_errado = false then
      begin
        FormMenu.ConexaoBD.CommitTrans;
        ADOQueryOnibus.Close;
        ADOQueryOnibus.Open;
        showmessage('Operação executada com sucesso!');
        EditNum.Clear;
        EditTrajeto.Clear;
        ComboBoxMot.ItemIndex := -1;
        ComboBoxEmp.ItemIndex := -1;
      end
    else
      begin
        FormMenu.ConexaoBD.RollbackTrans;
      end;
    end;
end;

procedure TFormOnibus.BotaoAlterarClick(Sender: TObject);
begin
 num_onibus := ADOQueryOnibus.fieldbyname('onibus').AsString;
 EditNum.Text := num_onibus;
 EditTrajeto.Text := ADOQueryOnibus.fieldbyname('trajeto').AsString;
 ComboBoxMot.Text := ADOQueryOnibus.fieldbyname('motorista').AsString;
 ComboBoxMotChange(sender);
 ComboBoxEmp.Text := ADOQueryOnibus.fieldbyname('empresa').AsString;
 ComboBoxEmpChange(sender);
end;

procedure TFormOnibus.BotaoSalvarClick(Sender: TObject);
begin
  FormMenu.ConexaoBD.BeginTrans;
  ADOQueryAuxiliar.SQL.Text := 'UPDATE Onibus SET' +
                               ' num_onibus = ' + EditNum.Text + ',' +
                               ' cod_empresa = ' + IntToStr(cod_empresa) + ',' +
                               ' num_motorista = ' + IntToStr(num_motorista) + ',' +
                               ' trajeto = ' + QuotedStr(EditTrajeto.Text) +
                               ' WHERE num_onibus = ' + num_onibus;
  try
    ADOQueryAuxiliar.ExecSQL;
    deu_errado := false;
  except
    on E : Exception do
    begin
      deu_errado := true;
      if FormMenu.ErroBD(E.Message,'FK_Onibus_Empresas') = 'sim' then
        showmessage('Impossível atualizar o código pois existem empresas ligadas a esse ônibus!')
      else if FormMenu.ErroBD(E.Message,'PK_Onibus') = 'sim' then
        showmessage('Código já cadastrado!')
      else
        showmessage('Ocorreu o seguinte erro: ' + E.Message);
    end;
  end;

    if deu_errado = false then
    begin
      FormMenu.ConexaoBD.CommitTrans;
      ADOQueryOnibus.Close;
      ADOQueryOnibus.Open;
      showmessage('Infromações atualizações com sucesso!');
      EditNum.Clear;
      EditTrajeto.Clear;
      ComboBoxMot.ItemIndex := -1;
      ComboBoxEmp.ItemIndex := -1;
    end
    else
      begin
        FormMenu.ConexaoBD.RollbackTrans;
      end;
end;

procedure TFormOnibus.BotaoExcluirClick(Sender: TObject);
begin
  num_onibus:=ADOQueryOnibus.fieldbyname('onibus').AsString;
  FormMenu.ConexaoBD.BeginTrans;
  ADOQueryAuxiliar.SQL.Text:=' DELETE FROM Onibus' +
                             ' WHERE num_onibus = ' +num_onibus;
  deu_errado := false;
  try
    ADOQueryAuxiliar.ExecSQL;
  except
    on E: Exception do
    begin
      deu_errado := true;
      if FormMenu.ErroBD(E.Message,'FK_Onibus_Empresas') = 'sim' then
        showmessage('Impossível atualizar o código pois existem empresas ligadas a esse ônibus!')
      else
        showmessage('Ocorreu  o seguinte erro: ' + E.Message);
    end;
  end;

    if deu_errado = true then
      FormMenu.ConexaoBD.RollbackTrans
    else
      begin
        FormMenu.ConexaoBD.CommitTrans;
        ADOQueryOnibus.Close;
        ADOQueryOnibus.Open;
        showmessage('Linha excluída com sucesso!');
      end;
end;

end.
