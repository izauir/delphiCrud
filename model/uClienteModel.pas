unit uClienteModel;

{ Camada Model responsável por armazenar informações, como valor de variável }

interface

Type
  TClienteModel = Class

  private
    { private declarations }
    FNome         :String;
    FID           :Integer;
    FGenero       :String;
    FTipoDocumento :String;
    FDocumento    :String;
    FTelefone     :String;

    procedure SetNome       (const Value: String);
    procedure SetId         (const Value: Integer);
    procedure SetGenero     (const Value: String);
    procedure SetTipoDocumento (const Value: String);
    procedure SetDocumento  (const Value: String);
    procedure SetTelefone   (const Value: String);

  public
    { public declarations }
    property Nome           :String  read FNome      write SetNome;
    property ID             :Integer read FID        write SetId;
    property Genero         :String  read FGenero    write SetGenero;
    property tipoDocumento  :String  read FTipoDocumento  write SetTipoDocumento;
    property Documento      :String  read FDocumento write SetDocumento;
    property Telefone       :String  read FTelefone  write SetTelefone;

  end;

implementation

{ TClienteModel }

procedure TClienteModel.SetDocumento(const Value: String);
begin
  FDocumento := Value;
end;

procedure TClienteModel.SetId(const Value: Integer);
begin
  FID := Value;
end;

procedure TClienteModel.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TClienteModel.SetTelefone(const Value: String);
begin
  FTelefone := Value;
end;

procedure TClienteModel.SetTipoDocumento(const Value: String);
begin
  FTipoDocumento := Value;
end;

procedure TClienteModel.SetGenero(const Value: String);
begin
  FGenero := Value;
end;

end.
