unit uFrmImportarRelatorios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uClienteModel, StdCtrls, ExtCtrls, ComCtrls, Contnrs, Gauges;

type
  TfrmImportarRelatorios = class(TForm)
    rgTiposRelatorio: TRadioGroup;
    odSubirArquivo: TOpenDialog;
    btnImportar: TButton;
    Gauge: TGauge;
    procedure importarTxt;
    procedure btnImportarClick(Sender: TObject);
  private
    { Private declarations }
    objCliente: TClienteModel;
  public
    { Public declarations }
  end;
  
var
  frmImportarRelatorios: TfrmImportarRelatorios;

implementation

uses
  uClienteController, uFrmCadastrarCliente;

{$R *.dfm}

procedure TfrmImportarRelatorios.btnImportarClick(Sender: TObject);
begin
if rgTiposRelatorio.ItemIndex = 1 then
 importarTxt;
end;

procedure TfrmImportarRelatorios.importarTxt;
var
  Arquivo: TextFile;
  Linha, errosId: String;
  listaErroId: TStringList;
  listaObjCliente: TObjectList;
  objClienteController: TClienteController;
  linhaAtual, totalLinhas: Integer;
begin
  try
    odSubirArquivo.Filter := 'Arquivos de texto|*.txt';
    if odSubirArquivo.Execute then begin
       AssignFile(Arquivo, odSubirArquivo.FileName);
       Reset(Arquivo);

       listaObjCliente := TObjectList.Create; // Inicializa a lista
       objClienteController := TClienteController.Create; // Inicializa o objeto
       errosId := EmptyStr; // Boa pr�tica, zerar a vari�vel

       totalLinhas := 0;
       Gauge.Progress := 0;
       while not Eof(Arquivo) do
       begin
         ReadLn(Arquivo, Linha);
         Inc(totalLinhas);
       end;
       Reset(Arquivo);

       try
        While not Eof(Arquivo) do
        begin
          ReadLn(Arquivo, Linha);

          { Copy, pega a posi��o inicial (de uma String), at� a quantidade de
            caracteres que definir. }
          // TRIM: Tira os espa�os em branco
          objCliente := TClienteModel.Create; // Cria um novo objeto

          { Passando o ID antes para conseguir popular o objeto e meu buscarPorID
            ter a informa��o da linha do arquivo ID, para conseguir executar a
            fun��o }
          With objCliente do
          begin
            ID := StrToInt(Trim(Copy(Linha, 1, 5)));
            if not objClienteController.buscarPorId(objCliente) then
            begin
              ObjCliente.Nome          := Trim(Copy(Linha, 5, 50));
              ObjCliente.Genero        := Trim(Copy(Linha, 56, 3));
              ObjCliente.TipoDocumento := Trim(Copy(Linha, 59, 5));
              ObjCliente.Documento     := Trim(Copy(Linha, 64, 15));
              ObjCliente.Telefone      := Trim(Copy(Linha, 79, 11));

              listaObjCliente.Add(objCliente); // Adiciona o objeto � lista
            end
            else
            begin
              errosId := errosId + IntToStr(ObjCliente.ID) + Chr(13);
            end;

            // Atualiza a barra de progresso
            Inc(linhaAtual);
            Gauge.Progress := Round(linhaAtual/totalLinhas * 100);
          end;
        end;

        if errosId <> EmptyStr then
           ShowMessage('Os IDS respectivos j� existem:' + Chr(13) + errosId);

        if objClienteController.gravarLista(listaObjCliente) then
           Application.MessageBox(PChar(IntToStr(listaObjCliente.Count) + ' registros adicionados!'), 'Aviso', MB_ICONINFORMATION + MB_OK);
      except
        Application.MessageBox('Erro ao importar relat�rio!', 'Erro', MB_ICONERROR + MB_OK);
        Exit;
      end;
    end;
  finally
    odSubirArquivo.Free;
    CloseFile(Arquivo);
  end;
end;

end.
