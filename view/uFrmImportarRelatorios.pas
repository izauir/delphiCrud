unit uFrmImportarRelatorios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uClienteModel, StdCtrls, ExtCtrls, ComCtrls, {lib txt} Contnrs, uUtil, Gauges,
  Grids;

type
  TfrmImportarRelatorios = class(TForm)
    rgTiposRelatorio: TRadioGroup;
    odSubirArquivo: TOpenDialog;
    btnImportar: TButton;
    Gauge: TGauge;
    AGrid: TStringGrid;
    procedure importarTxt;
    procedure importarExcel;
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
if rgTiposRelatorio.ItemIndex = 1 then begin
 importarTxt;
end;

if rgTiposRelatorio.ItemIndex = 0 then begin
 importarExcel;
end;

end;

procedure TfrmImportarRelatorios.importarExcel;
var
  Erros, XLSFile: string;
  linhaPlanilha, progressoAtual, progressoTotal: Integer;
  listaObjCliente: TObjectList;
  objClienteController: TClienteController;
begin
  AGrid := TStringGrid.Create(nil);
  try
    // Pega as informa��es do excel, joga dentro de uma Agrid pra depois popular
    XLSFile := 'C:\Users\supor\Desktop\Izauir\Cursos\cursoMVCBom\Cliente.xlsx';
    if not XlsToStringGrid(AGrid, XLSFile) then begin
      ShowMessage('Falha ao carregar arquivo.');
      Exit;
    end;

    listaObjCliente := TObjectList.Create; // Inicializa a lista
    objClienteController := TClienteController.Create; // Inicializa o objeto
    Erros := EmptyStr;

    // Popular objeto com as informa��es da Agrid
    with AGrid do
    begin
      progressoTotal := RowCount - 2;
      Gauge.Progress := 0;

      for linhaPlanilha := 2 to RowCount - 1 do begin
        Inc(progressoAtual);
        objCliente := TClienteModel.Create;
        if Trim(Cells[0, linhaPlanilha]) <> '' then
          objCliente.ID := StrToInt(Trim(Cells[0, linhaPlanilha]))
        else
          objCliente.ID := 0; // Ou qualquer valor padr�o que voc� deseja usar

          if not CheckCPFdv(objCliente.Documento) then begin
             Application.MessageBox('Um ou mais documentos est�o inv�lidos!', 'Erro', MB_ICONERROR + MB_OK);
             Exit;
          end;

          //Utilizar Agrid e Cells para pegar informa��es de excel
        if not objClienteController.buscarPorId(objCliente) then begin
           objCliente.Nome          := Trim(Cells[1, linhaPlanilha]);
           objCliente.Genero        := Trim(Cells[2, linhaPlanilha]);
           objCliente.tipoDocumento := Trim(Cells[3, linhaPlanilha]);

           if not CheckCPFdv(objCliente.Documento) then begin
              erros := erros + IntToStr(objCliente.ID) + ': Documento inv�lido!' + Chr(13);
           end
           else begin
              objCliente.Documento  := Trim(Cells[4, linhaPlanilha]);
           end;

           objCliente.Telefone      := Trim(Cells[5, linhaPlanilha]);

           listaObjCliente.Add(objCliente);
        end else begin
           Erros := Erros + IntToStr(ObjCliente.ID) + ': ID j� existente!' + Chr(13);
        end;
        Gauge.Progress := Round(progressoAtual/progressoTotal * 100);
      end;
      
      if Erros <> EmptyStr then
          ShowMessage('Foram encontrado(s) o(s) seguinte(s) erro(s):' + Chr(13) + Erros);

      if objClienteController.gravarLista(listaObjCliente) then
          Application.MessageBox(PChar(IntToStr(listaObjCliente.Count) + ' registros adicionados!'), 'Aviso', MB_ICONINFORMATION + MB_OK);
    end;
  finally
    AGrid.Free;
  end;
end;

procedure TfrmImportarRelatorios.importarTxt;
var
  Arquivo: TextFile;
  Linha, errosId: String;
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
              Nome          := Trim(Copy(Linha, 5, 50));
              Genero        := Trim(Copy(Linha, 56, 3));
              TipoDocumento := Trim(Copy(Linha, 59, 5));
              Documento     := Trim(Copy(Linha, 64, 15));
              Telefone      := Trim(Copy(Linha, 79, 11));

              listaObjCliente.Add(objCliente); // Adiciona o objeto � lista
            end
            else
            begin
              errosId := errosId + IntToStr(ID) + Chr(13);
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
