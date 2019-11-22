unit UnitMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, DB, ADODB;

type
  TFormMenu = class(TForm)
    BotaoEmpresas: TSpeedButton;
    BotaoMotoristas: TSpeedButton;
    BotaoOnibus: TSpeedButton;
    BotaoFechar: TSpeedButton;
    ConexaoBD: TADOConnection;
    procedure BotaoFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BotaoEmpresasClick(Sender: TObject);
    procedure BotaoMotoristasClick(Sender: TObject);
    procedure BotaoOnibusClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function ErroBD(msg: string; texto: string): string;
  end;

var
  FormMenu: TFormMenu;

implementation

uses UnitEmpresas, UnitMotoristas, UnitOnibus;

{$R *.dfm}

procedure TFormMenu.BotaoFecharClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormMenu.FormShow(Sender: TObject);
begin
 ConexaoBD.Open;
end;

procedure TFormMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ConexaoBD.Close;
end;

procedure TFormMenu.BotaoEmpresasClick(Sender: TObject);
begin
  FormEmpresas.showmodal;
end;

procedure TFormMenu.BotaoMotoristasClick(Sender: TObject);
begin
  FormMotoristas.showmodal;
end;

procedure TFormMenu.BotaoOnibusClick(Sender: TObject);
begin
  FormOnibus.showmodal;
end;

function TFormMenu.ErroBD(msg, texto: string): string;
var
  i, tam_msg, tam_texto : integer;
  pedaco : string;
begin
  tam_msg := length(msg);
  tam_texto := length(texto);

  for i:=1 to tam_msg do
  begin
    pedaco := copy(msg,i,tam_texto);
    if pedaco = texto then
      begin
        result := 'Sim';
        break;
      end
    else
      result := 'Não';
  end;

end;

end.
