unit uFrmPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uFrmCadastrarCliente;

type
  TfrmPrincipal = class(TForm)
    btnCliente: TButton;
    procedure btnClienteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnClienteClick(Sender: TObject);
begin
  frmCadastrarCliente:=TfrmCadastrarCliente.Create(Self);
  frmCadastrarCliente.ShowModal;
  frmCadastrarCliente.Release;
end;

end.
