unit UnitMotoristas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, Buttons, ADODB, StdCtrls;

type
  TFormMotoristas = class(TForm)
    ADOQueryMotoristas: TADOQuery;
    SpeedButton1: TSpeedButton;
    DBGrid1: TDBGrid;
    DataSourceMotoristas: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    EditNome: TEdit;
    EditIdade: TEdit;
    Label3: TLabel;
    EditSexo: TEdit;
    EditSalario: TEdit;
    Label4: TLabel;
    EditNum: TEdit;
    Label5: TLabel;
    BotaoInserir: TSpeedButton;
    ADOQueryAuxiliar: TADOQuery;
    BotaoAlterar: TSpeedButton;
    BotaoSalvar: TSpeedButton;
    BotaoExcluir: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
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
  FormMotoristas: TFormMotoristas;
  num_motorista : string;

implementation

uses UnitEmpresas, UnitMenu, Math;

{$R *.dfm}

procedure TFormMotoristas.FormShow(Sender: TObject);
begin
 ADOQueryMotoristas.Open;
end;

procedure TFormMotoristas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ADOQueryMotoristas.Close;
end;

procedure TFormMotoristas.SpeedButton1Click(Sender: TObject);
begin
 close;
end;

procedure TFormMotoristas.BotaoInserirClick(Sender: TObject);
begin
  if(trim(EditNum.Text)='') or (trim(EditNome.Text)='') or
    (trim(EditIdade.Text)='') or (trim(EditSexo.Text)='') or
    (trim(EditSalario.Text)='') then
   begin
     Showmessage('Preencha todos os campos!');
   end
  else
   begin
     FormMenu.ConexaoBD.BeginTrans;
     ADOQueryAuxiliar.SQL.Text := 'INSERT INTO Motoristas VALUES ('+
                                  EditNum.Text + ',' + QuotedStr(EditNome.Text) + ',' +
                                  EditIdade.Text + ',' + QuotedStr(EditSexo.Text) + ',' +
                                  EditSalario.Text +')';
     try
      ADOQueryAuxiliar.ExecSQL;
      deu_errado := false;
     except
      on E : Exception do
      begin
        deu_errado := true;
        if FormMenu.ErroBD(E.Message,'PK_Motoristas') = 'sim' then
          showmessage('Código já cadastrado!')
        else
          showmessage('Ocorreu o seguinte erro: ' + E.Message);
        end;
      end;

     if deu_errado = false then
      begin
      FormMenu.ConexaoBD.CommitTrans;
      ADOQueryMotoristas.Close;
      ADOQueryMotoristas.Open;
      Showmessage('Informações atualizadas com sucesso!');
      EditNum.Clear;
      EditNome.Clear;
      EditIdade.Clear;
      EditSexo.Clear;
      EditSalario.Clear;
     end
   else
    begin
      FormMenu.ConexaoBD.RollbackTrans;
    end;
   end;
end;

procedure TFormMotoristas.BotaoAlterarClick(Sender: TObject);
begin
  num_motorista := ADOQueryMotoristas.fieldbyname('num_motorista').AsString;
  EditNum.Text := num_motorista;
  EditNome.Text := ADOQueryMotoristas.fieldbyname('nome').AsString;
  EditIdade.Text := ADOQueryMotoristas.fieldbyname('idade').AsString;
  EditSexo.Text := ADOQueryMotoristas.fieldbyname('sexo').AsString;
  EditSalario.Text := ADOQueryMotoristas.fieldbyname('salario').AsString;
end;

procedure TFormMotoristas.BotaoSalvarClick(Sender: TObject);
begin
  FormMenu.ConexaoBD.BeginTrans;
  ADOQueryAuxiliar.SQL.Text:='UPDATE Motoristas SET' +
                             ' num_motorista = ' + EditNum.Text + ',' +
                             ' nome = ' + QuotedStr(EditNome.Text) + ',' +
                             ' idade = ' + EditIdade.Text + ',' +
                             ' sexo = ' + QuotedStr(EditSexo.Text) + ',' +
                             ' salario = ' + EditSalario.Text +
                             ' WHERE num_motorista = ' + num_motorista;
  try
    ADOQueryAuxiliar.ExecSQL;
    deu_errado := false;
  except
    on E : Exception do
    begin
      deu_errado := true;
      if FormMenu.ErroBD(E.Message,'FK_Onibus_Motoristas') = 'sim' then
        showmessage('Impossível atualizar o código pois existem ônibus ligados a esta empresa!')
      else if FormMenu.ErroBD(E.Message,'PK_Motoristas') = 'sim' then
        showmessage('Código já cadastrado!')
      else
        showmessage('Ocorreu o seguinte erro: ' + E.Message);
      end;
    end;

    if deu_errado = false then
      begin
        FormMenu.ConexaoBD.CommitTrans;
        ADOQueryMotoristas.Close;
        ADOQueryMotoristas.Open;
        showmessage('Informações atualizadas com sucesso!');
        EditNum.Clear;
        EditNome.Clear;
        EditIdade.Clear;
        EditSexo.Clear;
        EditSalario.Clear;
      end
    else
      begin
        FormMenu.ConexaoBD.RollbackTrans;
      end;
end;

procedure TFormMotoristas.BotaoExcluirClick(Sender: TObject);
begin
  num_motorista:=ADOQueryMotoristas.fieldbyname('num_motorista').AsString;
  FormMenu.ConexaoBD.BeginTrans;
  ADOQueryAuxiliar.SQL.Text:=' DELETE FROM MOTORISTAS' +
                             ' WHERE num_motorista = ' + num_motorista;
  deu_errado := false;
  try
  ADOQueryAuxiliar.ExecSQL;
  except
    on E: Exception do
    begin
      deu_errado := true;
      if FormMenu.ErroBD(E.Message,'FK_Onibus_Motoristas') = 'sim' then
        showmessage('Impossível excluir pois existem ônibus ligados a esta Empresa!')
      else
        showmessage('Ocorreu o seguinte erro: ' + E.Message);
      end;
    end;

     if deu_errado = true then
      FormMenu.ConexaoBD.RollbackTrans
     else
      begin
        FormMenu.ConexaoBD.CommitTrans;
        ADOQueryMotoristas.Close;
        ADOQueryMotoristas.Open;
        showmessage('Motorista excluído com sucesso!');
    end;
end;
end.
