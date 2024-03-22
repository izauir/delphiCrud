unit uClienteController;

interface
  uses
    uDmCliente, ADODB, uClienteModel, Contnrs;

type
  TClienteController = class
  private
    { private declarations }
  public
    { public declarations }
    function Pesquisar   (objCliente: TClienteModel): TADOQuery;
    function Detalhar    (objCliente: TClienteModel): TADOQuery;
    function Gravar      (objCliente: TClienteModel): Boolean;
    function gravarLista (listaObjCliente: TObjectList): Boolean;
    function Excluir     (objCliente: TClienteModel): Boolean;
    function buscarPorId (objCliente: TClienteModel): Boolean;
    function Alterar     (objCliente: TClienteModel): Boolean;
  end;

implementation

{ TClienteController }

function TClienteController.Alterar(objCliente: TClienteModel): Boolean;
begin
  Result := dmCliente.Alterar(objCliente);
end;

function TClienteController.buscarPorId(objCliente: TClienteModel): Boolean;
begin
  Result := dmCliente.buscarPorID(objCliente);
end;

function TClienteController.Detalhar(objCliente: TClienteModel): TADOQuery;
begin
  Result := dmCliente.Detalhar(objCliente);
end;

function TClienteController.Excluir(objCliente: TClienteModel): Boolean;
begin
 Result := dmCliente.Excluir(objCliente);
end;

function TClienteController.Gravar(objCliente: TClienteModel): Boolean;
begin
  Result := dmCliente.Gravar(objCliente);
end;

function TClienteController.gravarLista(listaObjCliente: TObjectList): Boolean;
begin
  Result := dmCliente.gravarLista(listaObjCliente);
end;

function TClienteController.Pesquisar(objCliente: TClienteModel): TADOQuery;
begin
  Result := dmCliente.Pesquisar(objCliente);
end;

end.
