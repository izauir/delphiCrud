program ExempoMVCBom;

uses
  Forms,
  uFrmPrincipal in 'view\uFrmPrincipal.pas' {frmPrincipal},
  uFrmCadastrarCliente in 'view\uFrmCadastrarCliente.pas' {frmCadastrarCliente},
  uClienteModel in 'model\uClienteModel.pas',
  uClienteController in 'controller\uClienteController.pas',
  uDmConexao in 'dao\uDmConexao.pas' {dmConexao: TDataModule},
  uDmCliente in 'dao\uDmCliente.pas' {dmCliente: TDataModule},
  uFrmBaixarRelatorios in 'view\uFrmBaixarRelatorios.pas' {frmBaixarRelatorios},
  uFrmImportarRelatorios in 'view\uFrmImportarRelatorios.pas' {frmImportarRelatorios};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  //Application.CreateForm(TfrmBaixarRelatorios, frmBaixarRelatorios);
  //Application.CreateForm(TfrmImportarRelatorios, frmImportarRelatorios);
  //Application.CreateForm(TfrmCadastrarCliente, frmCadastrarCliente);

  //N�o comentar Conex�es ao banco
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TdmCliente, dmCliente);
  Application.Run;
end.
