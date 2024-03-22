unit uFrmBaixarRelatorios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, uClienteController, uClienteModel, uDmConexao, ADODB,
  ComCtrls;

type
  TfrmBaixarRelatorios = class(TForm)
    rgTiposRelatorio: TRadioGroup;
    btnBaixar: TButton;
    pbBarraProgresso: TProgressBar;
    procedure btnBaixarClick(Sender: TObject);
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

end;

procedure TfrmBaixarRelatorios.relatorioTxt;
var
  Arquivo : TextFile;
  TotalRegistros, RegistroAtual: Integer;
begin
  try
    AssignFile(Arquivo, 'Clientes.txt');
    Rewrite(Arquivo);

    objCliente := TClienteModel.Create;
    quPesquisar := clienteController.Detalhar(objCliente);

    // Inicializa a barra de progresso
    TotalRegistros := quPesquisar.RecordCount;
    RegistroAtual := 0;
    pbBarraProgresso.Max := TotalRegistros;
    pbBarraProgresso.Position := RegistroAtual;

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
        WriteLn(Arquivo, Format('%-2d;%-50s;%-2s;%-4s;%-14s;%-11s',
        [ID, Nome, Genero, TipoDocumento, Documento, Telefone]));

        // Atualiza a barra de progresso
        Inc(RegistroAtual);
        pbBarraProgresso.Position := RegistroAtual;

        Next;
      end;
    end;
    // Fecha o arquivo
    CloseFile(Arquivo);
    MessageDlg('Relatório em TXT emitido!', mtInformation, [mbOK], 0);
    pbBarraProgresso.Position := 0;
  except
    MessageDlg('Erro ao gerar relatório!', mtError,[mbOK], 0);
    Exit;
  end;
end;

end.
