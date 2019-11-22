program Rodoviaria;

uses
  Forms,
  UnitMenu in 'UnitMenu.pas' {FormMenu},
  UnitEmpresas in 'UnitEmpresas.pas' {FormEmpresas},
  UnitMotoristas in 'UnitMotoristas.pas' {FormMotoristas},
  UnitOnibus in 'UnitOnibus.pas' {FormOnibus};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMenu, FormMenu);
  Application.CreateForm(TFormEmpresas, FormEmpresas);
  Application.CreateForm(TFormMotoristas, FormMotoristas);
  Application.CreateForm(TFormOnibus, FormOnibus);
  Application.Run;
end.
