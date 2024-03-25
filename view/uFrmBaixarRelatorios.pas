unit uFrmBaixarRelatorios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, uClienteController, uClienteModel, uDmConexao, ADODB,
  ComCtrls, Gauges, uUtil;

type
  TfrmBaixarRelatorios = class(TForm)
    rgTiposRelatorio: TRadioGroup;
    btnBaixar: TButton;
    Gauge: TGauge;
    procedure btnBaixarClick(Sender: TObject);
    procedure relatorioExcel;
  private
    { Private declarations }
    objCliente: TClienteModel;
    clienteController : TClienteController;
    quPesquisar: TADOQuery;
    
    procedure relatorioTxt;
  public
    { Public declarations }
  end;

var
  frmBaixarRelatorios: TfrmBaixarRelatorios;

implementation

{$R *.dfm}

procedure TfrmBaixarRelatorios.btnBaixarClick(Sender: TObject);
begin
 if rgTiposRelatorio.ItemIndex = 1 then begin
   relatorioTxt;
 end;

 if rgTiposRelatorio.ItemIndex = 0 then begin
   relatorioExcel;
 end;

end;

procedure TfrmBaixarRelatorios.relatorioExcel;
var
  totalRegistros, registroAtual: Integer;
begin
  try
    objCliente := TClienteModel.Create;
    quPesquisar := clienteController.Detalhar(objCliente);

    // Inicializa a barra de progresso
    totalRegistros := quPesquisar.RecordCount;
    registroAtual := 0;
    Gauge.Progress := 0;

    //Colocar ponteiro no primeiro registro
    quPesquisar.First;
    while not quPesquisar.Eof do
    begin
      // Atualiza a barra de progresso
      Inc(registroAtual);
      Gauge.Progress := Round(registroAtual/totalRegistros * 100);
      quPesquisar.Next;
    end;

    //Chamada da function lib Util
    imprimirPlanilha(quPesquisar, 'Cliente', EmptyStr);

    Application.MessageBox('Relatório emitido com sucesso!', 'Aviso', MB_ICONINFORMATION + MB_OK);
  except
    Application.MessageBox('Erro ao gerar relatório!', 'Erro', MB_ICONERROR + MB_OK);
    Exit;
  end;
end;

procedure TfrmBaixarRelatorios.relatorioTxt;
var
  Arquivo : TextFile;
  totalRegistros, registroAtual: Integer;
begin
  try
    AssignFile(Arquivo, 'Clientes.txt');
    Rewrite(Arquivo);

    objCliente := TClienteModel.Create;
    quPesquisar := clienteController.Detalhar(objCliente);

    // Inicializa a barra de progresso
    totalRegistros := quPesquisar.RecordCount;
    registroAtual := 0;
    Gauge.Progress := 0;

    with quPesquisar, objCliente do
    begin
      while not Eof do
      begin
        ID := FieldByName('id').AsInteger;
        Nome := FieldByName('nome').AsString;
        Genero := FieldByName('genero').AsString;
        TipoDocumento := FieldByName('tipoDocumento').AsString;
        Documento := FieldByName('documento').AsString;
        Telefone := FieldByName('telefone').AsString;

        // Escreve os dados do cliente no arquivo
        WriteLn(Arquivo, Format('%-5d %-50s %-3s %-5s %-15s %-11s',
        [ID, Nome, Genero, TipoDocumento, Documento, Telefone]));

        // Atualiza a barra de progresso
        Inc(registroAtual);
        Gauge.Progress := Round(registroAtual/totalRegistros * 100);

        Next;
      end;
    end;
    // Fecha o arquivo
    CloseFile(Arquivo);
    Application.MessageBox('Relatório emitido com sucesso!', 'Aviso', MB_ICONINFORMATION + MB_OK);
  except
    Application.MessageBox('Erro ao gerar relatório!', 'Erro', MB_ICONERROR + MB_OK);
    Exit;
  end;
end;

end.
