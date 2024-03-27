unit uClienteModel;

{ Camada Model responsável por armazenar informações, como valor de variável }

interface

Type
  TClienteModel = Class

  private
    { private declarations }
    FNome          :String;
    FID            :Integer;
    FGenero        :String;
    FTipoDocumento :String;
    FDocumento     :String;
    FTelefone      :String;

  public
    { public declarations }
    constructor Create(AID: Integer; ANome, AGenero, ATipoDocumento,
    ADocumento, ATelefone: string); overload;
    
    property Nome           :String  read FNome           write FNome;
    property ID             :Integer read FID             write FID;
    property Genero         :String  read FGenero         write FGenero;
    property tipoDocumento  :String  read FTipoDocumento  write FTipoDocumento;
    property Documento      :String  read FDocumento      write FDocumento;
    property Telefone       :String  read FTelefone       write FTelefone;

  end;

implementation

{ TClienteModel }

constructor TClienteModel.Create(AID: Integer; ANome, AGenero, ATipoDocumento,
  ADocumento, ATelefone: string);
begin
  FID := AID;
  FNome := ANome;
  FGenero := AGenero;
  FtipoDocumento := ATipoDocumento;
  FDocumento := ADocumento;
  FTelefone := ATelefone;
end;

end.
