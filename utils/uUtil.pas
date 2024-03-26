unit uUtil;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Mask, FileCtrl, ExtCtrls, IniFiles,
  DB, DBTables, Buttons, DBClient, SHDocVw, ActiveX, Math, Variants,
  ComObj, Shellapi, Winsock, Grids, DBGrids, IdHashMessageDigest, ADODB,
  StrUtils;

Procedure ImprimeIE(WB: TWebBrowser);
procedure CorEntrada(Sender: TObject);
procedure FileCopy(const FromFile, ToFile: String);
procedure Strzero(var cNum: String ; nLen: Integer);
procedure OdsToXls(var vDir: String);
procedure OdsConverteXls(vDirProc,vArqOds,VArqXls: String);
procedure JpgConvertePdf(vDirProc,vArqJpg,VArqPdf: String);
Procedure DiaUtil(DataEnvio: TDateTime);
Procedure FormatXMLFile(const XmlFile:string);
procedure RemovePalavra(var origem: string; apagar: string);
procedure Delay(MSec: Cardinal);
Procedure ordenarTituloGrid(Grid : TDBGrid; Column : TColumn);
procedure GravarTexto(SalvarComo, Texto: WideString);
procedure imprimirPlanilha(instrucaoSQl: TADOQuery; title, tipo: String);
function  CheckDV(cNum: string ; nLen: integer): Boolean;
Function  StrzeroF(cNum: String ; nLen: Integer):String;
function  Replicate( const L: Integer; C: String ): String;
function  CalculaCodeBar( Bco,Moeda,Vlr,NossoNum,Ag,CodCed,Cart,NumConv,DtVenc : String): String;
function  CalculaLinDig( CodeBar: String): String;
function  CalcDVCodBarGnr(cStr : String) : String;
function  NPadR( const cExp: String; nLen: Integer ): String;
function  NPadL( const cExp: String; nLen: Integer ): String;
function  NTrimL( const S: String ): String;
function  NTrimR( const S: String ): String;
function  NTrim( const S: String ): String;
function  RemoveMask(const cNum : String): String;
function  FormataValor(const cNum: String): String;
function  RetornaNumero(const cNum : String): LongInt;
function  PrinterOnLine : Boolean;
function  CheckOrgao(cCod: String): String;
function  CheckIEdv(cStr: String): Boolean;
function  CheckCPFdv(const CPF: string): boolean;
function  CheckCGCdv(const CGC: string): boolean;
Function  tData(data: String):String;
Function  tDataI(data: String):String;
Function  tDataR(data: String):String;
Function  tDataL(data: String):String;
Function  tDataM(data: String): String;
function  tDataS(data: String): String;
function  tDataP(data: String): String;
Function  Autenticacao(cdCodigos:TClientDataSet ;codigo: String): Boolean;
Function  GravaMulta(cdCodigos:TClientDataSet; codigo: String):Boolean;
Function  GravaTabela(cdCodigos:TClientDataSet;codigo,Tabela: String):Boolean;
Function  DiretorioProcessamento(servername:String):String;
Function  Encrypt(const S: String; Key: Word): String;
Function  Decrypt(const S: String; Key: Word): String;
Function  Executa(Arquivo: String): Integer;
function  CalcDV(cNum: string ; nLen: Integer): String;
function  CalcDV237(cNum: string ; nLen: Integer): String;
function  RemoveAcentos(acentuacao: string): string;
function  ChecaCidade(ncidade: string): string;
function  RemoveZeros(const cNum: String): String;
Function  RetiraCaracteres(wLinha: String): String;
Function  RetiraCaracteresEspeciais(wLinha: String): String;
function  IsCharEspec( Str: String):Boolean;
Function  Gerapercentual(valor:real;Percent:Real):real;
function  Arredonda(Valor: Real): Real;
function  TiraDez(Hora: String):String;
function  FormataCPFCNPJ(fDoc: String): String;
Function  SoNumeros(wLinha: String): String;
function  DefinirPropriedadesOpenOffice(PropName: string; PropValue: variant): variant;
Function  Modulo10(S: String): String;
Function  Modulo11(Numero: String): String;
function  killtask(ExeFileName: string): Integer;
Function  RetornaLetras(sStr: string) : string;
Function  SoLetrasNumeros(wLinha: String): String;
Function  FStrToString(valor: String):String;
Function  ContaPalavasFromFile (const arquivo, palavra : string) : integer;
Function  ContaPalavras (fonte, palavra : string) : integer;
Function  GetComputerNameFunc : string;
Function  IncZeroDec(valor: String):String;
Function  GetIP:string;
Function  FormataLinhaDig10(wLinha: String): String;
Function  FormataLinhaDig11(wLinha: String): String;
Function  Consistencia(Formulario: Tform): Boolean;
Function  TruncaValor(Value: Real; Casas: Integer): Real;
Function  ProximoDiaUtil (dData : TDateTime) : TDateTime;
Function  PreencheZeroDireita(Texto: string; Quant: integer): String;
Function  checaEmail(email : String): Boolean;
Function  tntParaFedex(remessa: String):String;
Function  verificaDiaUtil(dataIncial:TDateTime; dias_uteis:Integer):TDateTime;
function  trocaPonto(Valor: string): String;
function  trocaVirgula(Valor: String): String;
function  tiraVirgula(Valor: String): String;
Function  SubstituiCaracteresEspeciais(wLinha: String): String;
Function  VerificaLetras(Texto:String):Boolean;
function  duasPalavras(frase: String): String;
function  montaLista(Memo: TMemo): String;
function  montaListaString(listaRemessas: TStringList): String;
Function  tiraMinutos(num: integer): string;
Function  anoBissexto(ano : Integer): Boolean;
Function  RetiraCaracteresEspeciaisExportacao(wLinha: String): String;
Function  SoNumerosRecintos(wLinha: String): String;
function  validaNumeroMaster(master: String): Boolean;
Function  XlsToStringGrid(AGrid: TStringGrid; AXLSFile: string): Boolean;

//Procedure GravaTraceMemo(memo: TMemo);
//Procedure MontaDataSet(Var cdCodigos:TClientDataSet);
//Function nomeXML(tipoArq: String;sequencia: Integer):String;

var
  OpenOffice: Variant;

const

   C1 = 52845;
   C2 = 22719;

   { Produção }
   //API_Recintos = 'http://p1044077.corp.ds.fedex.com:8083';

   { Homologação }
   API_Recintos = 'http://u1081299.corp.ds.fedex.com:8083';
   //API_Recintos = 'http://localhost:8083';



implementation

uses Windows, TLHelp32, PsAPI, xmldom, XMLIntf, msxmldom, XMLDoc;

{-------------------------------------------------------
      Nome : CalcDVCodBarGnr
   Sintaxe : CalcDVCodBarGnr(cStr: String)
--------------------------------------------------------}
function CalcDVCodBarGnr(cStr : String) : String;
var
  i : Byte;
  Peso, Tamanho, nCalc, j, Numero, Digito1, Digito2, Fator : Integer;
begin

  nCalc := 0;
  Tamanho := Length(cStr);
  Peso := 2;
  for i := 1 to Tamanho do begin
   Val(cStr[Tamanho],Numero,j);
   Fator := Numero*Peso;
   if Fator > 9 then begin
      Digito1 := StrToInt(Copy(IntToStr(Fator),1,1));
      Digito2 := StrToInt(Copy(IntToStr(Fator),2,1));
      nCalc := nCalc + Digito1 + Digito2;
   end else nCalc := nCalc+(Numero*Peso);
   Dec(Peso);
   if Peso = 0 then Peso := 2;
   Dec(Tamanho);
  end;
  CalcDVCodBarGnr := IntToStr(10-(nCalc mod 10));
  if (10-(nCalc mod 10)) = 10 then CalcDVCodBarGnr := '0';
end;




{-------------------------------------------------------
      Nome : CheckOrgao
   Sintaxe : CheckOrgao(cCod: String)
--------------------------------------------------------}

function CheckOrgao(cCod: String): String;
var
   nCod: integer;
begin

  nCod := StrToInt(cCod);
  case nCod of
    1 : CheckOrgao := '0075'; {Acre}
    2 : CheckOrgao := '0076'; {Alagooas}
    3 : CheckOrgao := '0077'; {Amapa}
    4 : CheckOrgao := '0078'; {Amazonas}
    5 : CheckOrgao := '0079'; {Bahia}
    6 : CheckOrgao := '0080'; {Ceara}
    7 : CheckOrgao := '0083'; {Distrito Federal}
    8 : CheckOrgao := '0081'; {Espirito Santo}
    10 : CheckOrgao := '0082'; {Goias}
    12 : CheckOrgao := '0084'; {Maranhao}
    13 : CheckOrgao := '0085'; {Mato Grosso}
    28 : CheckOrgao := '0086'; {Mato grosso do sul}
    14 : CheckOrgao := '0087'; {Minas Gerais}
    15 : CheckOrgao := '0088'; {Para}
    16 : CheckOrgao := '0089'; {Paraiba}
    17 : CheckOrgao := '0090'; {Parana}
    18 : CheckOrgao := '0091'; {Pernambuco}
    19 : CheckOrgao := '0092'; {Piaui}
    20 : CheckOrgao := '0094'; {Rio Grande do Norte}
    21 : CheckOrgao := '0095'; {Rio Grande do Sul}
    22 : CheckOrgao := '0093'; {Rio de Janeiro}
    23 : CheckOrgao := '0096'; {Rondonia}
    24 : CheckOrgao := '0097'; {Roraima}
    25 : CheckOrgao := '0098'; {Santa Catarina}
    26 : CheckOrgao := '0099'; {Sao Paulo}
    27 : CheckOrgao := '0101'; {Sergipe}
    29 : CheckOrgao := '0102'; {Tocantins}
  end;

end;

{-------------------------------------------------------
      Nome : PrinterOnLine
   Sintaxe : PrinterOnLine
--------------------------------------------------------}

function PrinterOnLine : Boolean;
Const
 PrnStInt : Byte = $17;
   StRq : Byte = $02;
   PrnNum : Word = 0; { 0 para LPT1, 1 para LPT2, etc. }
Var
  nResult : byte;

Begin (* PrinterOnLine*)
  Asm
    mov ah,StRq;
    mov dx,PrnNum;
    Int $17;
    mov nResult,ah;
  end;
  PrinterOnLine := (nResult and $80) = $80;
End;


{-------------------------------------------------------
      Nome : RetornaNumero
   Sintaxe : RetornaNumero(cNum: string)
--------------------------------------------------------}

function RetornaNumero(const cNum: string): LongInt;
var
  i : byte;
  z : String;
begin
  z := '';
  for i := 1 to Length(cNum) do begin
    if (Ord(cNum[i]) >= 48 ) and (Ord(cNum[i]) <= 57 ) then
      z := z + cNum[i];
  end;
  if z = '' then z := '0';
  RetornaNumero := StrToInt(z);
end;


{-------------------------------------------------------
      Nome : FormataValor
   Sintaxe : FormataValor(cNum: string)
--------------------------------------------------------}

function FormataValor(const cNum: String): String;
var
  cVal, cResultado : String;
  cDecimal : String[2];
  i,z : Byte;
  Valor : Real;
begin
  {Tira os zeros aa esquerda}
  cVal := cNum;
  for i := 1 to Length(cNum) do begin
    if cNum[i] = '0' then Delete(cVal,1,1) else Break;
  end;
  if cVal = '' then FormataValor := ''
  else begin
    {verifica se os centavos estao em unidades. Se tiverem acrescenta 0}
    if Length(cVal) < 3 then begin
      if Length(cVal) = 1 then FormataValor := '0,0' + cVal
      else FormataValor := '0,' + cVal;
    end else begin
      {Insere o ponto decimal}
      Insert(DecimalSeparator, cVal, Length(cVal)-1);
      {Transforma em float}
      Valor := StrToFloat(cVal);
      {Formata}
      cResultado := FloatToStrF(Valor, ffNumber, 8, 2);
      FormataValor := cResultado;
    end;
  end;
end;


{-------------------------------------------------------
      Nome : RemoveMask
   Sintaxe : RemoveMask(cNum: string)
--------------------------------------------------------}

function RemoveMask(const cNum: string): String;
var
  i : byte;
  z : String;
begin
  If cNum = '' Then
  begin
     RemoveMask := '';
     Exit;
  end;

  z := '';
  for i := 1 to Length(cNum) do begin
    if (Ord(cNum[i]) >= 48 ) and (Ord(cNum[i]) <= 57 ) then
      z := z + cNum[i];
  end;
  if UpperCase(cNum[Length(cNum)]) = 'X' then
    z := z + 'X';
  RemoveMask := z;
end;

{ LTRIM() }
function NTrimL( const S: String ): String;
var
   STrim: String;
begin
   STrim := S;
   while ( Length( STrim ) > 0 ) and
         ( STrim[1] = ' ' ) do
           Delete( STrim, 1, 1);
   NTrimL := STrim;
end;

{ RTRIM() }
function NTrimR( const S: String ): String;
var
   STrim: String;
begin
   Strim := S;
   while ( Length( STrim ) > 0 ) and
         ( STrim[ Length( STrim ) ] = ' ' ) do
           Delete( STrim, Length( STrim ), 1 );
   NTrimR := STrim;
end;

{ ALLTRIM() }
function NTrim( const S: String ): String;
begin
   NTrim := NTrimL( NTrimR( S ) );
end;

{-------------------------------------------------------
      Nome : CheckDV
   Sintaxe : CheckDV(cNum: string ; nLen: integer)
--------------------------------------------------------}

function CheckDV(cNum: string ; nLen: integer): boolean;
var
  nDig, nMult, nCalc, i, z, j,u : integer;
begin
  nDig := 0;
  nCalc := 0;
  u := Length(cNum);

  if u < nLen then
    for j := 1 to (nLen-u) do
      begin
        Insert('0',cNum,1);
        Inc(u);
      end;

  nDig := Pos(cNum[u],'123456789X0');

  case nLen of
    9 : nMult := 1;
    8 : nMult := 2;
    5 : nMult := 5;
  end;

  for i := 1 to (nLen-1) do
    begin
     Val(cNum[i],z,j);
     nCalc := nCalc+(z*(i+nMult));
    end;

  IF nDig <>(nCalc mod 11) then
     CheckDV := False
  else CheckDV := True;

end;

{-------------------------------------------------------
      Nome : CalcDV
   Sintaxe : CalcDV(cNum: string ; nLen: integer)
--------------------------------------------------------}

function CalcDV(cNum: string ; nLen: Integer): String;
var
  nCalc, i, Numero, j, Tamanho, Peso : integer;
begin
  nCalc   := 0;
  Tamanho := Length(cNum);

  if Tamanho < nLen then
    for j := 1 to (nLen-Tamanho) do
      begin
        Insert('0',cNum,1);
        Inc(Tamanho);
      end;

  Peso := 2;
  for i := 1 to Tamanho do begin
     Val(cNum[Tamanho],Numero,j);
     nCalc := nCalc+(Numero*Peso);
     Dec(Tamanho);
     Inc(Peso);
     if Peso > 9 then Peso := 2;
  end;

  CalcDV := IntToStr(11-(nCalc mod 11));
  if (11-(nCalc mod 11)) = 10 then CalcDV := 'X';
  if (11-(nCalc mod 11)) = 11 then CalcDV := '0';

end;

{-------------------------------------------------------
      Nome : CalcDV237
   Sintaxe : CalcDV(cNum: string ; nLen: integer)
--------------------------------------------------------}

function CalcDV237(cNum: string ; nLen: Integer): String;
var
  nCalc, i, Numero, j, Tamanho, Peso : integer;
begin
  nCalc   := 0;
  cNum := '09' + cNum; // p/ o Bradesco carteira(09)

  Tamanho := Length(cNum);

  if Tamanho < nLen then
    for j := 1 to (nLen-Tamanho) do
      begin
        Insert('0',cNum,1);
        Inc(Tamanho);
      end;

  Peso := 2;
  for i := 1 to Tamanho do begin
     Val(cNum[Tamanho],Numero,j);
     nCalc := nCalc+(Numero*Peso);
     Dec(Tamanho);
     Inc(Peso);
     if Peso > 7 then Peso := 2; // p/ o Bradesco
  end;

  CalcDV237 := IntToStr(11-(nCalc mod 11));
  if (11-(nCalc mod 11)) = 10 then CalcDV237 := 'P'; // p/ o Bradesco
  if (11-(nCalc mod 11)) = 11 then CalcDV237 := '0';

end;


{-------------------------------------------------------
      Nome : Strzero
   Sintaxe : Strzero( var cNum: String ; nLen: Integer)
--------------------------------------------------------}

procedure Strzero(var cNum: String ; nLen: Integer);
begin
  while length(cnum) < nLen do Insert('0',cNum,1);
end;

{-------------------------------------------------------
      Nome : Replicate
   Sintaxe : Replicate( const L: Integer; C: String ): String;
      Unit : LibWin
--------------------------------------------------------}

function Replicate( const L: Integer; C: String ): String;
var
   S: String;
   i: Integer;
begin
   S := '';
   for i := 1 to L do Insert( C, S, i );
   Replicate := S;
end;

{-------------------------------------------------------
      Nome : CalculaCodeBar
   Sintaxe : CalculaCodeBar( Bco,Moeda,Vlr,NossoNum,Ag,CodCed,Cart,NumConv,DtVenc : String): String;
--------------------------------------------------------}

function CalculaCodeBar( Bco,Moeda,Vlr,NossoNum,Ag,CodCed,Cart,NumConv,DtVenc : String): String;
var
  DtBase : TDateTime;
  Dv : String;
  FmtCodeBar : String;
  nCalc, i, j, Numero, Peso, Tamanho : integer;
  FatorVencimento : Real;
  teste: String;
begin

  vlr := FloatToStr(StrToFloat(vlr) * 100);

  if Length(Vlr) > 10 then
    StrZero(Vlr,14)
  else begin
    StrZero(Vlr,10);
    {Calcula fator de vencimento}
    DtBase          := StrToDate('07/10/1997');
    FatorVencimento := StrToDate(DtVenc) - DtBase;
    Vlr             := FloatToStr(Int(FatorVencimento)) + Vlr;
  end;

  If Length(ag) > 4 Then
  begin
     ag := copy(ag,1,4);
     StrZero(ag,4);
  end;

  if Cart <> '09' then begin
     If Length(codCed) > 8 Then
     begin
       codCed := copy(codCed,1,8);
       Strzero(codCed,8);
     end;
  end;

  if Cart = '09' then begin
     If Length(RemoveMask(codCed)) > 7 Then
     begin
       codCed := copy(codCed,1,7);
     end;
  end;

  {Para carteira 09 nosso numero tem 11 posicoes}
  if Cart = '09' then FmtCodeBar := Bco + Moeda + Vlr + Ag + Cart + NossoNum + CodCed + '0';
  {Para carteira 17 nosso numero tem 11 posicoes}
  if Cart = '17' then FmtCodeBar := Bco + Moeda + Vlr + NossoNum + Ag + CodCed + Cart;
  {Para carteira 18 nosso numero tem 17 posicoes}
  if Cart = '18' then FmtCodeBar := Bco + Moeda + Vlr + NumConv + NossoNum + '21';
  nCalc := 0;
  Peso  := 2;

  Tamanho    := Length(FmtCodebar);
  fmtCodeBar := Copy(fmtCodeBar,1,43);
  Tamanho    := Length(FmtCodebar);


  for i := 1 to Tamanho do begin
   Val(FmtCodeBar[Tamanho],Numero,j);
   nCalc := nCalc+(Numero*Peso);
   Dec(Tamanho);
   Inc(Peso);
   if Peso > 9 then Peso := 2;
  end;

  Dv := IntToStr(11-(nCalc mod 11));

  if (11-(nCalc mod 11)) = 10 then Dv := '1';
  if (11-(nCalc mod 11)) = 11 then Dv := '1';
  if Cart = '09' then CalculaCodeBar := Bco + Moeda + Dv + Vlr + Ag + Cart + NossoNum + CodCed + '0';
  if Cart = '17' then CalculaCodeBar := Bco + Moeda + Dv + Vlr + NossoNum + Ag + CodCed + Cart;
  if Cart = '18' then CalculaCodeBar := Bco + Moeda + Dv + Vlr + NumConv + NossoNum + '21';
  teste   := Bco + Moeda + Dv + Vlr + NossoNum + Ag + CodCed + Cart;
  Tamanho := Length(teste);

end;

{-------------------------------------------------------
      Nome : CalculaLinDig
   Sintaxe : CalculaLinDig( CodeBar: String): String;
--------------------------------------------------------}

function CalculaLinDig( CodeBar: String): String;
var
  Linha : String;
  Dv, CheckMult : Byte;
  FmtCampo : String;
  Dezena : Integer;
  nCalc, i, j, Numero, Peso, Tamanho : integer;
  tam: Integer;
begin
  {Primeiro Campo}
  FmtCampo := Copy(CodeBar,1,4) + Copy(CodeBar,20,5);
  nCalc    := 0;
  Peso     := 2;
  Tamanho  := Length(FmtCampo);
  repeat
   Val(FmtCampo[Tamanho],Numero,j);
   CheckMult := Numero*Peso;
   if CheckMult > 9 then CheckMult := CheckMult - 9;
   nCalc := nCalc + CheckMult;
   Dec(Tamanho);
   Dec(Peso);
   if Peso = 0 then Peso := 2;
  until Tamanho < 1;
  if nCalc < 9 then Dezena := 10
    else begin
      Dezena := nCalc div 10;
      Inc(Dezena);
      Dezena := Dezena * 10;
    end;
  Dv := Dezena - nCalc;
  if Dv = 10 then Dv := 0;
  Linha := Copy(FmtCampo,1,5) + '.' + Copy(FmtCampo,6,4) + IntToStr(Dv) + ' ';
  {Segundo Campo}
  FmtCampo := Copy(CodeBar,25,10);
  nCalc := 0;
  Peso := 2;
  Tamanho := Length(FmtCampo);
  repeat
   Val(FmtCampo[Tamanho],Numero,j);
   CheckMult := Numero*Peso;
   if CheckMult > 9 then CheckMult := CheckMult - 9;
   nCalc := nCalc + CheckMult;
   Dec(Tamanho);
   Dec(Peso);
   if Peso = 0 then Peso := 2;
  until Tamanho < 1;
  if nCalc < 9 then Dezena := 10
    else begin
      Dezena := nCalc div 10;
      Inc(Dezena);
      Dezena := Dezena * 10;
    end;
  Dv := Dezena - nCalc;
  if Dv = 10 then Dv := 0;
  Linha := Linha + Copy(FmtCampo,1,5) + '.' +
    Copy(FmtCampo,6,5) + IntToStr(Dv) + ' ';
  {Terceiro Campo}
  FmtCampo := Copy(CodeBar,35,10);
  nCalc := 0;
  Peso := 2;
  Tamanho := Length(FmtCampo);
  repeat
   Val(FmtCampo[Tamanho],Numero,j);
   CheckMult := Numero*Peso;
   if CheckMult > 9 then CheckMult := CheckMult - 9;
   nCalc := nCalc + CheckMult;
   Dec(Tamanho);
   Dec(Peso);
   if Peso = 0 then Peso := 2;
  until Tamanho < 1;
  if nCalc < 9 then Dezena := 10
    else begin
      Dezena := nCalc div 10;
      Inc(Dezena);
      Dezena := Dezena * 10;
    end;
  Dv := Dezena - nCalc;
  if Dv = 10 then Dv := 0;
  Linha := Linha + Copy(FmtCampo,1,5) + '.' + Copy(FmtCampo,6,5) + IntToStr(Dv) + ' ';
  {Quarto Campo - Dv do codigo de barras }
  Linha := Linha + Copy(CodeBar,5,1) + ' ';
  {Quinto Campo - Fator de Vencimento + Valor }
  Linha := Linha + Copy(CodeBar,6,14);
  CalculaLinDig := Linha;
end;

{-------------------------------------------------------
      Nome : NPadR
   Sintaxe : NPadR( const cExp: String; nLen: Integer ): String;
--------------------------------------------------------}
function NPadR( const cExp: String; nLen: Integer ): String;
var
   cMask: String;
   nDiff, L, i: Integer;
begin
   cMask := cExp;
   L := Length( cExp );
   nDiff := nLen - L;
   if nDiff > 0 then
      for i := L + 1 to ( L + nDiff ) do Insert( ' ', cMask, i )
   else
      cMask := Copy( cExp, 1, nLen );
   NPadR := cMask;
end;

{-------------------------------------------------------
      Nome : NPadL
   Sintaxe : NPadL( const cExp: String; nLen: Integer ): String;
--------------------------------------------------------}
function NPadL( const cExp: String; nLen: Integer ): String;
var
   cMask: String;
   nDiff, L, i: Integer;
begin
   cMask := cExp;
   L := Length( cExp );
   nDiff := nLen - L;
   if nDiff > 0 then
      for i := 1 to nDiff do Insert( ' ', cMask, i )
   else
      cMask := Copy( cExp, 1, nLen );
   NPadL := cMask;
end;


procedure FileCopy(const FromFile, ToFile: String);
var
  FromF, ToF: File;
  NumRead, NumWritten: Integer;
  Buf: array[1..2048] of Char;
  begin
    AssignFile(FromF, FromFile);
    Reset(FromF, 1);
    AssignFile(ToF, ToFile);
    Rewrite(ToF, 1);
    repeat
    BlockRead(FromF, Buf, SizeOf(Buf), NumRead);
    BlockWrite(ToF, Buf, NumRead, NumWritten);
    until (NumRead=0) or (NumWritten <> NumRead);
    CloseFile(FromF);
    CloseFile(ToF);
  end;

Function StrzeroF(cNum: String ; nLen: Integer):String;
begin
  while length(cnum) < nLen do Insert('0',cNum,1);
  result := cNUm;
end;


{Function tDataI(data: String):String; // Insere AAAA-MM-DD
begin
  If data = '  /  /    ' Then
     tDataI := data;

  tDataI := Copy(data,7,4) + '-' +
            Copy(data,4,2) + '-' +
            Copy(data,1,2);
end;}

Function tDataI(data: String):String; // Insere AAAA-MM-DD
begin
  If (Copy(data, 3, 1) = '/') and
     (Copy(data, 6, 1) = '/') Then
  begin

    Result := Copy(data,7,4) + '-' +
              Copy(data,4,2) + '-' +
              Copy(data,1,2);

  end else begin
    Result := data;
  end;
end;

Function tDataR(data: String):String; // Retorna de  AAAA-MM-DD p/ DD/MM/AAAA
begin
  If data = '    -  -  ' Then
     tDataR := data;

  tDataR := Copy(data,9,2) + '/' +
            Copy(data,6,2) + '/' +
            Copy(data,1,4);
end;

Function tData(data: String):String; // Retorna a data de MM/DD/AAAA p/ DD-MM-AAAA
begin
  If data = '  /  /    ' Then
     tData := data;

  tData := Copy(data,4,2) + '-' +
           Copy(data,1,2) + '-' +
           Copy(data,7,4);
end;

Function tDataL(data: String):String; // Insere a data de AAAAMMDD p/ AAAA-MM-DD
begin
  If data = '        ' Then
     tDataL := data;

  tDataL := Copy(data,1,4) + '-' +
            Copy(data,5,2) + '-' +
            Copy(data,7,2);
end;

Function tDataM(data: String): String;
begin
  If data = '        ' Then
     tDataM := data;

  tDataM := Copy(data,4,2) + '/' +
            Copy(data,1,2) + '/' +
            Copy(data,7,4);
end;

function tDataS(data: String): String; //Retorna a data de 22DEC01 p/ DD-MM-AAAA
var
  mes, dataConvertida: String;

begin
  if Length(RetornaLetras(data)) > 0 then begin
     mes := Copy(data, 4, 3);

     case IndexStr(mes, ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC']) of
       0:  mes := '01';
       1:  mes := '02';
       2:  mes := '03';
       3:  mes := '04';
       4:  mes := '05';
       5:  mes := '06';
       6:  mes := '07';
       7:  mes := '08';
       8:  mes := '09';
       9:  mes := '10';
       10: mes := '11';
       11: mes := '12';
     end;

     dataConvertida := '20' + Copy(data, 7, 2) + '-' +
                       mes + '-' +
                       Copy(data, 2, 2);
  end else begin
     mes := Copy(IntToStr(RetornaNumero(data)), 3, 2);

     dataConvertida := '20' + Copy(IntToStr(RetornaNumero(data)), 1, 2) + '-' +
                       mes + '-' +
                       Copy(IntToStr(RetornaNumero(data)), 5, 2);
  end;

  Result := dataConvertida;
end;

function  tDataP(data: String): String; // Recebe data 31-JAN-23 Retorna 2023-01-31
var
  mes, dia, ano, dataConvertida: String;
begin

  dia := Copy(data, 1, 2);
  mes := Copy(data, 4, 3);
  ano := Copy(data, 8, 2);

  case IndexStr(mes, ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC']) of
     0:  mes := '01';
     1:  mes := '02';
     2:  mes := '03';
     3:  mes := '04';
     4:  mes := '05';
     5:  mes := '06';
     6:  mes := '07';
     7:  mes := '08';
     8:  mes := '09';
     9:  mes := '10';
     10: mes := '11';
     11: mes := '12';
  end;

  dataConvertida := '20' + ano + '-' + mes + '-' + dia;

  Result := dataConvertida;
end;


{Procedure GravaTraceMemo(memo: TMemo);
var
  Arquivo: TextFile;
  NomeArquivo,diretorio: String;
  IniFile : TIniFile;
  MemoLog: TMemo;
  i: Integer;
begin
  Try
      IniFile     := TIniFile.Create(Main.dbDiretorio + ARQUIVO_INI);
      Diretorio   := IniFile.ReadString('Diretorio','Processamento', Session.NetFileDir);

      nomeArquivo := main.dbDiretorio + 'log' + RemoveMask(TData(DateToStr(main.DataMovimento))) + '.txt';

      AssignFile(arquivo,nomeArquivo);
      Append(arquivo);

      For i := 1 To memo.Lines.Count Do
          writeLn(arquivo,memo.Lines.Strings[i]);
      CloseFile(arquivo);

  Except
      Application.MessageBox('Houve um Erro na Gravação do Log!','COURIER SAT', MB_OK + MB_DEFBUTTON1 + MB_ICONERROR);
  End;

end;}


{Procedure MontaDataSet(Var cdCodigos:TClientDataSet);
begin
  With dm.quCodigosControle Do
  begin
     Close;
     SQL.Clear;
     SQL.Add('Select * from CodigosControle');
     Open;

     While Not Eof Do
     begin
       cdCodigos.Append;
       cdCodigos.FieldByName('codigo').AsString     := fieldByName('codigo').AsString;
       cdCodigos.FieldByName('Darf').AsString       := fieldByName('Darf').AsString;
       cdCodigos.FieldByName('Gnre').AsString       := fieldByName('Gnre').AsString;
       cdCodigos.FieldByName('Cobranca').AsString   := fieldByName('cobranca').AsString;
       cdCodigos.FieldByName('NotaDebito').AsString := fieldByName('NotaDebito').AsString;
       cdCodigos.FieldByName('codigo').AsString     := fieldByName('codigo').AsString;
       cdCodigos.FieldByName('gCobranca').AsString  := fieldByName('gCobranca').AsString;
       cdCodigos.FieldByName('gRemessa').AsString   := fieldByName('gRemessa').AsString;
       cdCodigos.FieldByName('Carteira').AsString   := fieldByName('Carteira').AsString;
       cdCodigos.FieldByName('Autentica').AsString  := fieldByName('Autentica').AsString;
       cdCodigos.FieldByName('CodBarra').AsString   := fieldByName('codBarra').AsString;
       cdCodigos.FieldByName('Tributo').AsString    := fieldByName('Tributo').AsString;
       cdCodigos.FieldByName('Multa').AsString      := fieldByName('Multa').AsString;
       Next;
     end;
  end;
end;}

Function Autenticacao(cdCodigos:TClientDataSet ;codigo: String): Boolean;
begin
  If cdCodigos.Locate('codigo',codigo,[loCaseInsensitive]) Then
     If cdCodigos.fieldByName('Autentica').AsString = 'S' Then
        result := True
     else
        result := False;
end;

Function GravaMulta(cdCodigos:TClientDataSet;codigo: String):Boolean;
begin
  If cdCodigos.Locate('codigo',codigo,[loCaseInsensitive]) Then
     If cdCodigos.fieldByName('Multa').AsString = 'S' Then
        result := True
     else
        result := False;
end;



Function GravaTabela(cdCodigos:TClientDataSet;codigo,Tabela: String):Boolean;
begin
  If cdCodigos.Locate('codigo',codigo,[loCaseInsensitive]) Then
     If cdCodigos.fieldByName(tabela).AsString = 'S' Then
        result := True
     else
        result := False;
end;

Function Diretorioprocessamento(serverName:String):String;
var
  caminho: String;
  i,f,x: Integer;
begin
  caminho := '\\';

  i := pos(':',serverName);
  caminho := caminho + Copy(serverName,1,i-1);

  diretorioProcessamento := caminho;
end;

function Encrypt(const S: String; Key: Word): String;
var
  I: byte;
begin
  Result := '';
  for I := 1 to Length(S) do
  begin
    Result := Result + IntToHex(byte(char(byte(S[I]) xor (Key shr 8))), 2);
    Key := (byte(char(byte(S[I]) xor (Key shr 8))) + Key) * C1 + C2;
  end;
end;

function Decrypt(const S: String; Key: Word): String;
var
  I: byte;
  x: char;
begin
  result := '';
  i := 1;
  while (i < Length(S)) do
  begin
    x := char(strToInt('$' + Copy(s, i, 2)));
    Result := result + char(byte(x) xor (Key shr 8));
    Key := (byte(x) + Key) * C1 + C2;
    Inc(i, 2);
  end;
end;

Function CheckCPFdv(const CPF: string): boolean;
var
  I, Soma, Digito: integer;
  CalcCPF, S1, S2, CPFOK: string;
  B: boolean;
  C: Char;
begin
  CPFOK := StrZeroF(Trim(CPF),11);
  Result := false;
  S1 := ''; { CPF somente com dígitos }
  for I := 1 to Length(CPFOK) do begin
    S2 := Copy(CPFOK, I, 1);
    if Pos(S2, '0123456789') > 0 then
      S1 := S1 + S2;
  end;
  if Length(S1) <> 11 then
    Exit; { Não é CPF, pois não são 11 dígitos }

  { Teste se os 11 díg. são iguais }
  B := true;
  C := S1[1];
  for I := 2 to 11 do begin
    B := B and (S1[I] = C);
    C := S1[I];
  end;
  if B then { Todos díg. iguais }
    Exit;

  CalcCPF := Copy(S1, 1, 9);

  { Cálculo do 1º dígito }
  Soma := 0;
  for I := 1 to 9 do
    Soma := Soma + StrToInt(Copy(CalcCPF, I, 1)) * (11 - I);
  Digito := 11 - (Soma mod 11);
  if Digito in [ 10, 11 ] then
    CalcCPF := CalcCPF + '0'
  else
    CalcCPF := CalcCPF + IntToStr(Digito);

  { Cálculo do 2º dígito }
  Soma := 0;
  for I := 1 to 10 do
    Soma := Soma + StrToInt(Copy(CalcCPF, I, 1)) * (12 - I);
  Digito := 11 - (Soma mod 11);
  if Digito in [ 10, 11 ] then
    CalcCPF := CalcCPF + '0'
  else
    CalcCPF := CalcCPF + IntToStr(Digito);

  if CalcCPF = S1 then
    Result := true;
end;


function CheckCGCdv(const CGC: string): boolean;
var
  CalcCGC, S1, S2, CGCOK: string;
  I, Soma, Digito: integer;
begin
  CGCOK :=StrZeroF(Trim(CGC),14);
  Result := false;

  S1 := ''; { CGC somente com dígitos }
  for I := 1 to Length(CGCOK) do begin
    S2 := Copy(CGCOK, I, 1);
    if Pos(S2, '0123456789') > 0 then
      S1 := S1 + S2;
  end;

  if Length(S1) <> 14 then
    Exit; { Não é CGC, pois não são 14 dígitos }

  if S1 = '00000000000000' then
    Exit;

  CalcCGC := Copy(S1, 1, 12);

  { Cálculo do 1º dígito }
  Soma := 0;

  for I := 1 to 4 do
    Soma := Soma + StrToInt(Copy(CalcCGC, I, 1)) * (6 - I);
  for I := 1 to 8 do
    Soma := Soma + StrToInt(Copy(CalcCGC, I + 4, 1)) * (10 - I);
  Digito := 11 - (Soma mod 11);
  if Digito in [ 10, 11 ] then
    CalcCGC := CalcCGC + '0'
  else
    CalcCGC := CalcCGC + IntToStr(Digito);

  { Cálculo do 2º dígito }
  Soma := 0;
  for I := 1 to 5 do
    Soma := Soma + StrToInt(Copy(CalcCGC, I, 1)) * (7 - I);
  for I := 1 to 8 do
    Soma := Soma + StrToInt(Copy(CalcCGC, I + 5, 1)) * (10 - I);

  Digito := 11 - (Soma mod 11);

  if Digito in [ 10, 11 ] then
    CalcCGC := CalcCGC + '0'
  else
    CalcCGC := CalcCGC + IntToStr(Digito);

  if CalcCGC = S1 then
    Result := true;
end;

Function Executa(Arquivo: String): Integer;
var
 programa: array[0..512] of char;
 curDir: array[0..255] of char;
 workDir: String;
 StartupInfo: TStartupInfo;
 ProcessInfo: TProcessInformation;
 resultado: DWORD;
begin
  StrPCopy(programa,arquivo);
  GetDir(0,WorkDir);
  StrPCopy(CurDir,WorkDir);
  FillChar(StartupInfo,SizeOf(StartUpInfo),#0);
  result                  := 0;
  StartupInfo.cb          := sizeOf(StartupInfo);
  StartupInfo.dwFlags     := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := SW_SHOWMINIMIZED;

  If not CreateProcess(nil,programa,nil,nil,false,CREATE_NEW_CONSOLE Or NORMAL_PRIORITY_CLASS,nil,nil,StartupInfo,ProcessInfo) Then
     result := -1
  else
   begin
      WaitForSingleObject(ProcessInfo.hProcess,Infinite);
      GetExitCodeProcess(ProcessInfo.hProcess,resultado);
   end;
   result := resultado;
end;


Procedure ImprimeIE(WB: TWebBrowser);
var
  CmdTarget : IOleCommandTarget;
  vaIn, vaOut: OleVariant;
begin
  
  if WB.Document <> nil then
    try
      WB.Document.QueryInterface(IOleCommandTarget, CmdTarget);
      if CmdTarget <> nil then
        try
          CmdTarget.Exec( PGuid(nil), OLECMDID_PRINT, OLECMDEXECOPT_DONTPROMPTUSER, vaIn, vaOut);
        finally
          CmdTarget._Release;
        end;
    except
      ShowMessage('Impressão não pode ser realizada !');
    end;
   end;

{-------------------------------------------------------
      Nome : CheckIEdv
   Sintaxe : CheckIEdv(cStr: String)
--------------------------------------------------------}
function CheckIEdv(cStr: String): Boolean;
var
  localIE        : string;
  localResultIE  : boolean;
  digit1, digit2 : integer;
  soma           : integer;
begin
  localIE := cStr;
  { Verifica a quantidade de caracteres da String }
  if Length(localIE) = 8 then begin
  { Verifica se a Inscrição Estadual começa com 1,7,8 ou 9 }
     case StrToInt(copy(localIE,1,1)) of
        1: begin localResultIE := True end;
        7: begin localResultIE := True end;
        8: begin localResultIE := True end;
        9: begin localResultIE := True end;
     else localResultIE := False;
     end;
  end else
        localResultIE := False;
  { Multiplica o valores da String por 2,7,6,5,4,3 e 2}
     if localResultIE = True then
        begin
        digit1 := 2 * StrToInt(copy(localIE,1,1));
        digit1 := digit1 + 7 * StrToInt(copy(localIE,2,1));
        digit1 := digit1 + 6 * StrToInt(copy(localIE,3,1));
        digit1 := digit1 + 5 * StrToInt(copy(localIE,4,1));
        digit1 := digit1 + 4 * StrToInt(copy(localIE,5,1));
        digit1 := digit1 + 3 * StrToInt(copy(localIE,6,1));
        digit1 := digit1 + 2 * StrToInt(copy(localIE,7,1));
        soma   := digit1;
  { Aplica o Módulo 11 para verificar o Dv da Inscrição Estadual }
        digit1 := 11 - (soma mod 11);
        if digit1 > 9 then digit1 := 0;
        digit2 :=  StrToInt(copy(localIE,8,1));
        if digit1 = digit2 then
           localResultIE := True
        else
           localResultIE := False;
     end;
  CheckIEdv := localResultIE;
end;

function RemoveAcentos(acentuacao: string): string;
var 
  i: integer; 
begin 
  Result := acentuacao;
  for i:=1 to Length(Result) do 
  begin 
    case Result[i] of 
      'á','à','ã','ä','â': Result[i]:='a';
      'Á','À','Ã','Ä','Â': Result[i]:='A'; 
      'é','è','ë','ê': Result[i]:='e'; 
      'É','È','Ë','Ê': Result[i]:='E'; 
      'í','ì','ï','î': Result[i]:='i'; 
      'Í','Ì','Ï','Î': Result[i]:='I'; 
      'ó','ò','õ','ö','ô': Result[i]:='o'; 
      'Ó','Ò','Õ','Ö','Ô': Result[i]:='O'; 
      'ú','ù','ü','û': Result[i]:='u'; 
      'Ú','Ù','Ü','Û': Result[i]:='U'; 
      'ç': Result[i]:='c'; 
      'Ç': Result[i]:='C'; 
      'ñ': Result[i]:='n'; 
      'Ñ': Result[i]:='N'; 
    end; 
  end; 
end;

function ChecaCidade(ncidade: String): string;
begin
  Result := EmptyStr;
  if RetiraCaracteres(ncidade) = 'SAO LOURENCO D OESTE'     then Result := '8333';
  if RetiraCaracteres(ncidade) = 'SANTA BARBARA D OESTE'    then Result := '7017';
  if RetiraCaracteres(ncidade) = 'SANTA CLARA D OESTE'      then Result := '7023';
  if RetiraCaracteres(ncidade) = 'SANTA RITA D OESTE'       then Result := '7049';
  if RetiraCaracteres(ncidade) = 'ITAPEJARA D OESTE'        then Result := '7617';
  if RetiraCaracteres(ncidade) = 'PEROLA D OESTE'           then Result := '7759';
  if RetiraCaracteres(ncidade) = 'SAO JORGE D OESTE'        then Result := '7881';
  if RetiraCaracteres(ncidade) = 'HERVAL D OESTE'           then Result := '8131';
  if RetiraCaracteres(ncidade) = 'SAO MIGUEL D OESTE'       then Result := '8339';
  if RetiraCaracteres(ncidade) = 'MIRASSOL D OESTE'         then Result := '9177';
  if RetiraCaracteres(ncidade) = 'FIGUEIROPOLIS D OESTE'    then Result := '9881';
  if RetiraCaracteres(ncidade) = 'DIAMANTE D OESTE'         then Result := '9915';
  if RetiraCaracteres(ncidade) = 'CONQUISTA D OESTE'        then Result := '1082';
  if RetiraCaracteres(ncidade) = 'RANCHO ALEGRE D OESTE'    then Result := '5513';
  if RetiraCaracteres(ncidade) = 'APARECIDA D OESTE'        then Result := '6151';
  if RetiraCaracteres(ncidade) = 'ESTRELA D OESTE'          then Result := '6405';
  if RetiraCaracteres(ncidade) = 'GUARANI D OESTE'          then Result := '6461';
  if RetiraCaracteres(ncidade) = 'PALMEIRA D OESTE'         then Result := '6805';
  if RetiraCaracteres(ncidade) = 'DIAS D AVILA'             then Result := '3087';
  if RetiraCaracteres(ncidade) = 'GLORIA D OESTE'           then Result := '135';
  if RetiraCaracteres(ncidade) = 'LAMBARI D OESTE'          then Result := '137';
  if RetiraCaracteres(ncidade) = 'SAO FELIPE D OESTE'       then Result := '18';
  if RetiraCaracteres(ncidade) = 'ESPIGAO D OESTE'          then Result := '25';
  if RetiraCaracteres(ncidade) = 'ALTA FLORESTA D OESTE'    then Result := '33';
  if RetiraCaracteres(ncidade) = 'ALVORADA D OESTE'         then Result := '35';
  if RetiraCaracteres(ncidade) = 'MACHADINHO D OESTE'       then Result := '39';
  if RetiraCaracteres(ncidade) = 'NOVA BRASILANDIA D OESTE' then Result := '41';
  if RetiraCaracteres(ncidade) = 'SANTA LUZIA D OESTE'      then Result := '43';
end;

{-------------------------------------------------------
      Nome : RemoveZeros
   Sintaxe : RemoveZeros(cNum: string)
      Unit : LibWin
      Data : 18/01/00
 Descrição : Remove os zeros a esquerda da string passada.
--------------------------------------------------------}

function RemoveZeros(const cNum: String): String;
var
  cVal : String;
  i : Byte;
begin
  cVal := cNum;
  {Tira os zeros aa esquerda}
  for i := 1 to Length(cNum) do begin
    if cNum[i] = '0' then Delete(cVal,1,1) else Break;
  end;
  RemoveZeros := cVal;
end;

Function Gerapercentual(valor:real;Percent:Real):real;
// Retorna a porcentagem de um valor
begin
  percent  := percent / 100;
  try
    valor  := valor * Percent;
  finally
    result := valor;
  end;
end;


function Arredonda(Valor: Real): Real;
var
  Modo: TFPURoundingMode;
begin
  Modo := GetRoundMode;
  try
    SetRoundMode(rmDown);
    Result := SimpleRoundTo(Valor, -2);
  finally
    SetRoundMode(Modo);
  end;
end;


// http://www.mail-archive.com/delphi-br@yahoogrupos.com.br/msg36800.html
procedure CorEntrada(Sender: TObject);
Begin
  if (Sender is TEdit) then (Sender as TEdit).Color                       := $00F0E6E8
  else if (Sender is TMaskEdit)     then (Sender as TMaskEdit).Color      := $00F0E6E8
  else if (Sender is TMemo)         then (Sender as TMemo).Color          := $00F0E6E8
  else if (Sender is TComboBox)     then (Sender as TComboBox).Color      := $00F0E6E8
  //else if (Sender is TDateEdit)     then (Sender as TDateEdit).Color      := $00F0E6E8
  //else if (Sender is TCurrencyEdit) then (Sender as TCurrencyEdit).Color  := $00F0E6E8
  //else if (Sender is TDBMemo)   then (Sender as TDBMemo).Color: = clBtnFace
end;

Function RetiraCaracteres(wLinha: String): String;
// http://www.spectrum.eti.br/news/tabela_ascii_completa
var i: Integer;
    linha,caracter: String;
begin
  For i := 1 To Length(wLinha) do
  begin
     {if (wLinha[i] = Chr(33))  or
        (wLinha[i] = Chr(34))  or
        (wLinha[i] = Chr(35))  or
        (wLinha[i] = Chr(36))  or
        (wLinha[i] = Chr(37))  or
        (wLinha[i] = Chr(38))  or
        (wLinha[i] = Chr(39))  or
        (wLinha[i] = Chr(40))  or
        (wLinha[i] = Chr(41))  or
        (wLinha[i] = Chr(42))  or
        (wLinha[i] = Chr(43))  or
        (wLinha[i] = Chr(44))  or
        (wLinha[i] = Chr(45))  or
        (wLinha[i] = Chr(46))  or
        (wLinha[i] = Chr(47))  or

        (wLinha[i] = Chr(58))  or
        (wLinha[i] = Chr(59))  or
        (wLinha[i] = Chr(60))  or
        (wLinha[i] = Chr(61))  or
        (wLinha[i] = Chr(62))  or
        (wLinha[i] = Chr(63))  or
        (wLinha[i] = Chr(64))  or

        (wLinha[i] = Chr(91))  or
        (wLinha[i] = Chr(92))  or
        (wLinha[i] = Chr(93))  or
        (wLinha[i] = Chr(94))  or
        (wLinha[i] = Chr(95))  or
        (wLinha[i] = Chr(96))  or

        (wLinha[i] = Chr(166)) or
        (wLinha[i] = Chr(167)) or

        (wLinha[i] = Chr(178)) or
        (wLinha[i] = Chr(179)) or

        (wLinha[i] = Chr(185)) or
        (wLinha[i] = Chr(186)) or
        (wLinha[i] = Chr(187)) or

        (wLinha[i] = Chr(205)) or

        (wLinha[i] = Chr(221)) or

        (wLinha[i] = Chr(238)) or
        (wLinha[i] = Chr(239)) or

        (wLinha[i] = Chr(241)) or
        (wLinha[i] = Chr(242)) or
        (wLinha[i] = Chr(243)) or
        (wLinha[i] = Chr(244)) or
        (wLinha[i] = Chr(245)) or
        (wLinha[i] = Chr(246)) or
        (wLinha[i] = Chr(247)) or
        (wLinha[i] = Chr(248)) or
        (wLinha[i] = Chr(249)) or

        (wLinha[i] = Chr(250)) or
        (wLinha[i] = Chr(251)) or
        (wLinha[i] = Chr(252)) or
        (wLinha[i] = Chr(253)) or
        (wLinha[i] = Chr(254)) or

        (wLinha[i] = Chr(289)) or

        (wLinha[i] = Chr(295)) or
        (wLinha[i] = Chr(297)) then}

     if (wLinha[i] = Chr(34))  or   // caracter "
        (wLinha[i] = Chr(39))  or   // ´
        (wLinha[i] = Chr(60))  or   // <
        (wLinha[i] = Chr(62))  or   // >
        (wLinha[i] = Chr(96))  or   // `
        (wLinha[i] = Chr(239)) then // caracter '
        caracter := ' '
     else
        caracter :=  wLinha[i];
     linha := linha + caracter;
  end;
  result := linha;
end;


Function RetiraCaracteresEspeciais(wLinha: String): String;
var i: Integer;
    linha,caracter: String;
    aChar:PChar;
Const
  // Apenas caracteres que o Harpia aceita.
  CharEspc: set of Char = [#0..#255] - ['a'..'z','A'..'Z','1'..'9','0','.',';','-',',',':'];
begin
  wLinha := RemoveAcentos(wLinha);
  For i := 1 To Length(wLinha) do
  begin
  aChar := pChar(Copy(wLinha, i, 1 ));
  if ((aChar^ in CharEspc)) then
     caracter := ' '
  else
     caracter :=  wLinha[i];
     linha := linha + caracter;
  end;
  result := linha;
end;

Function SubstituiCaracteresEspeciais(wLinha: String): String;
var i: Integer;
    linha,caracter: String;
    aChar:PChar;
Const
  // Apenas caracteres que o Harpia aceita.
  CharEspc: set of Char = [#0..#255] - ['a'..'z','A'..'Z','1'..'9','0'];
begin
  wLinha := RemoveAcentos(wLinha);
  For i := 1 To Length(wLinha) do
  begin
  aChar := pChar(Copy(wLinha, i, 1 ));
  if ((aChar^ in CharEspc)) then
     caracter := ' '
  else
     caracter :=  wLinha[i];
     linha := linha + caracter;
  end;
  result := linha;
end;


Function SoNumeros(wLinha: String): String;
var I: integer;
    S: string;
begin
  S := '';
  for I := 1 To Length(wLinha) Do
  begin
    if (wLinha[I] in ['0'..'9']) then
    begin
      S := S + Copy(wLinha, I, 1);
    end;
  end;
  result := S;
end; 


(*procedure TFrmEntraDados.EdDescRemessaExit(Sender: TObject);
var
  i: Integer;
begin
//http://www.mail-archive.com/delphi-br@yahoogrupos.com.br/msg19991.html
  for i:=1 to Length(EdDescRemessa.Text) do
  begin
    if IsCharEspec( Copy(EdDescRemessa.Text, i, 1 )) then begin
       ShowMessage('Existe Caracteres Especiais na Autenticação...Reinforme !');
    end;
  end;
end;*)

function IsCharEspec( Str: String):Boolean;
Var
  aChar:PChar;
Const
  CharEspc: set of Char = [#0..#255] - ['a'..'z','A'..'Z','1'..'9','0'];
begin
  aChar := pChar( Str );
  Result := False;
  if ((aChar^ in CharEspc)) then
     Result := True;
end;

function TiraDez(Hora: String):String;
var
Prim : TDateTime;
Dez  : TDateTime;
begin
  Prim := StrToTime(Hora);
  Dez := StrToTime('00:10:00');
  Result := TimeToStr(Prim-Dez);
end;

function FormataCPFCNPJ(fDoc: String): String;
Var vTam, xx : Integer;
    vDoc : String;
begin
vTam := Length(fDoc);
For xx := 1 To vTam Do
   If (Copy(fDoc,xx,1) <> '.') And (Copy(fDoc,xx,1) <> '-') And (Copy(fDoc,xx,1) <> '/') Then
      vDoc := vDoc + Copy(fDoc,xx,1);
fDoc := vDoc;
vTam := Length(fDoc);
vDoc := '';
vDoc := '';
For xx := 1 To vTam Do
   begin
   vDoc := vDoc + Copy(fDoc,xx,1);
   If vTam = 11 Then
      begin
      If (xx in [3,6]) Then vDoc := vDoc + '.';
      If xx = 9 Then vDoc := vDoc + '-';
      end;
   If vTam = 14 Then
      begin
      If (xx in [2,5]) Then vDoc := vDoc + '.';
      If xx = 8 Then vDoc := vDoc + '/';
      If xx = 12 Then vDoc := vDoc + '-';
      end;
   end;
Result := vDoc;
end;

procedure OdsToXls(var vDir: String);
var
  SR: TSearchRec;
  i,Tamanho: integer;
  ArquivoXls : String;
begin
  i := FindFirst(vDir + '*.ods', faAnyFile, SR);
  while i = 0 do begin
    if (SR.Attr and faDirectory) <> faDirectory then
       Tamanho := Length(SR.Name);
       if Copy(Trim(SR.Name),Tamanho,1) <> '#' then begin
       //if pos(SR.Name,'lock') < 0 then begin
          Tamanho := Tamanho - 4;
          ArquivoXls := Copy(SR.Name,1,Tamanho) + '.xls';
          OdsConverteXls(vDir,SR.Name,ArquivoXls);
          if not DeleteFile(Pchar(vDir + SR.Name)) then
             ShowMessage('Arquivo não excluído : ' + vDir + SR.Name);
       end;
    i := FindNext(SR);
  end;
end;

procedure OdsConverteXls(vDirProc,vArqOds,VArqXls: String);
var
  Desktop, Properties, Document: Variant;
begin
  OpenOffice := CreateOleObject('com.sun.star.ServiceManager');
  Desktop    := OpenOffice.createInstance('com.sun.star.frame.Desktop');
  Properties := VarArrayCreate([0, 0], varVariant);
  Properties[0] := DefinirPropriedadesOpenOffice('Hidden', True);
  Document := Desktop.loadComponentFromURL('file:///' +  vDirProc + vArqOds , '_blank',0, Properties);
  Properties[0] := DefinirPropriedadesOpenOffice('FilterName', 'MS Excel 97');
  //Properties[0] := DefinirPropriedadesOpenOffice('FilterName', 'writer_pdf_Export');
  vDirProc := StringReplace(vDirProc,'\','/', [rfReplaceAll]);
  Document.storeToURL('file:///' + vDirProc + VArqXls , Properties);
  Document.Close(True);
  Desktop.Terminate;
  Desktop    := Unassigned;
  OpenOffice := Unassigned;
  Properties := Unassigned;
  Document   := Unassigned;
end;

procedure JpgConvertePdf(vDirProc,vArqJpg,VArqPdf: String);
var
Desktop, Properties, Document: Variant;
begin
  OpenOffice := CreateOleObject('com.sun.star.ServiceManager');
  Desktop    := OpenOffice.createInstance('com.sun.star.frame.Desktop');
  Properties := VarArrayCreate([0, 0], varVariant);
  Properties[0] := DefinirPropriedadesOpenOffice('Hidden', True);
  Document := Desktop.loadComponentFromURL('file:///' +  vDirProc + vArqJpg , '_blank',0, Properties);
  Properties[0] := DefinirPropriedadesOpenOffice('FilterName', 'MS Excel 97');
  vDirProc := StringReplace(vDirProc,'\','/', [rfReplaceAll]);
  Document.storeToURL('file:///' + vDirProc + VArqPdf , Properties);
  Document.Close(True);
  OpenOffice := Unassigned;
  Properties := Unassigned;
  Desktop    := Unassigned;
  Document   := Unassigned;
end;

Function DefinirPropriedadesOpenOffice(PropName: string; PropValue: variant): variant;
var
Struct: variant;
begin
  Struct := OpenOffice.Bridge_GetStruct('com.sun.star.beans.PropertyValue');
  Struct.Name := PropName;
  Struct.Value := PropValue;
  Result := Struct;
end;

Function Modulo10(S: String): String;
var
Indice: ShortInt;
Peso: ShortInt;
Soma: Integer;
Total: ShortInt;
DV: ShortInt;
begin
Soma := 0;
Peso := 2;
for Indice := Length(S) downto 1 do
    begin
    Total := StrToInt(Copy(S, Indice, 1)) * Peso;
    if Total > 9 then
       begin
       Soma := Soma + 1 + (Total - 10);
       end
    else
       begin
       Soma := Soma + Total;
       end;
    if Peso = 1 then
       begin
       Peso := 2
       end
    else
       begin
       Peso := 1;
       end;
    end;
DV := 10 - Soma Mod 10;
if DV = 10 then
   begin
   DV := 0;
   end;
Result := IntToStr(DV);
end;

Function Modulo11(Numero: String): String;
var
i,j,k : Integer;
Soma : Integer;
Digito : Integer;
CNPJ : Boolean;
begin
Result := '';
 Try
   Soma := 0; k:= 2;
   for i := Length(Numero) downto 1 do begin
   Soma := Soma + (StrToInt(Numero[i])*k);
   inc(k);
   if k > 9 then k := 2;
   end;
   Digito := 11 - Soma mod 11;
   if Digito >= 10 then
   Digito := 0;
   Result := Result + Chr(Digito + Ord('0'));
 except
   Result := 'X';
 end;
end;

//http://blog.vitorrubio.com.br/2010/10/como-matar-um-processo-no-delphi.html
function killtask(ExeFileName: string): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

  while Integer(ContinueLoop) <> 0 do
  begin 
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then 
      Result := Integer(TerminateProcess(
                        OpenProcess(PROCESS_TERMINATE,
                                    BOOL(0),
                                    FProcessEntry32.th32ProcessID),
                                    0));
     ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

Function RetornaLetras(sStr: string) : string;
var
  i     : Integer;
  letra : String;
begin
  letra  := '';
  sStr := Lowercase(sStr);
  For i := 1 to length(sStr) do begin
      if sStr[i] in ['a'..'z'] then
         letra := letra + sStr[i];
  end;
  Result := letra;
end;

Function SoLetrasNumeros(wLinha: String): String;
var i: Integer;
    linha,caracter: String;
    aChar:PChar;
Const
  // Apenas números e letras, sem espaço.
  CharEspc: set of Char = [#0..#255] - ['a'..'z','A'..'Z','1'..'9','0'];
begin
  For i := 1 To Length(wLinha) do
  begin
  aChar := pChar(Copy(wLinha, i, 1 ));
  if ((aChar^ in CharEspc)) then
     caracter := ' '
  else
     caracter :=  wLinha[i];
     linha := linha + caracter;
  end;
  result := StringReplace(linha,' ','',[rfReplaceAll]);;
end;

Function FStrToString(valor: String):String;
var ponto: Integer;
begin
  ponto := Pos(',',valor);
  If ponto = 0 Then
     FStrToString := valor + '.00'
  else
     FStrToString := Copy(valor,1,ponto - 1) + '.' + Copy(valor,ponto + 1,Length(valor) - ponto);
end;


Function ContaPalavasFromFile (const arquivo, palavra : string) : integer;
var
  Arq : TStringList;
begin
  Arq := TStringList.Create;
  Arq.LoadFromFile (arquivo);
  Result := ContaPalavras (Arq.Text, palavra);
  Arq.Free;
end;


Function ContaPalavras (fonte, palavra : string) : integer;
var
  p : integer;
begin
  Result := 0;
  repeat
    p := pos(palavra, fonte);
    if p > 0
    then begin
      inc (Result);
      delete (fonte, p, length(palavra));
    end;
  until p = 0;
end;

Function GetComputerNameFunc : string;
var
  lpBuffer : PChar;
  nSize : DWord;
const Buff_Size = MAX_COMPUTERNAME_LENGTH + 1;
begin
  nSize := Buff_Size;
  lpBuffer := StrAlloc(Buff_Size);
  GetComputerName(lpBuffer,nSize);
  Result := String(lpBuffer);
  StrDispose(lpBuffer);
end;


Procedure DiaUtil(DataEnvio: TDateTime);
var
Dia, Mes, Ano : Word;
begin
  DecodeDate(DataEnvio, Ano, Mes, Dia);

  {Verifica se é Feriado}
  if ((Dia = 01) and (Mes = 01)) or
     ((Dia = 21) and (Mes = 04)) or
     ((Dia = 01) and (Mes = 05)) or
     ((Dia = 07) and (Mes = 09)) or
     ((Dia = 12) and (Mes = 10)) or
     ((Dia = 02) and (Mes = 11)) or
     ((Dia = 15) and (Mes = 11)) or
     ((Dia = 25) and (Mes = 12)) then
     Application.MessageBox('Atenção...Hoje é Feriado. Informe o próximo dia útil.',
     'COURIER SAT', MB_OK + MB_ICONINFORMATION);

  {Verifica se é Sabado}
  if DayOfWeek(DataEnvio) = 7 then
     Application.MessageBox('Atenção...Hoje é Sábado. Informe o próximo dia útil.',
     'COURIER SAT', MB_OK + MB_ICONINFORMATION);

  {Verifica se é Domingo}
  if DayOfWeek(DataEnvio) = 1 then
     Application.MessageBox('Atenção...Hoje é Domingo. Informe o próximo dia útil.',
     'COURIER SAT', MB_OK + MB_ICONINFORMATION);
end;

Function IncZeroDec(valor: String):String;
var
  Ponto: Integer;
  Zero: String;
begin
  Ponto := Pos('.',valor);
  Zero  := Trim(Copy(valor,Ponto + 1,2));
  if Length(Zero) < 2 then
     IncZeroDec := valor + '0'
  else
     IncZeroDec := valor;
end;

Function GetIP:string;
//--> Declare a Winsock na clausula uses da unit
var
  WSAData: TWSAData;
  HostEnt: PHostEnt;
  Name:string;
begin
  WSAStartup(2, WSAData);
  SetLength(Name, 255);
  Gethostname(PChar(Name), 255);
  SetLength(Name, StrLen(PChar(Name)));
  HostEnt := gethostbyname(PChar(Name));
  with HostEnt^ do
  begin
    Result := Format('%d.%d.%d.%d',
    [Byte(h_addr^[0]),Byte(h_addr^[1]),
    Byte(h_addr^[2]),Byte(h_addr^[3])]);
  end;
  WSACleanup;
end;


Function FormataLinhaDig10(wLinha: String): String;
var
 Formatada, DV1, DV2, DV3, DV4: String;
begin
 DV1 := Modulo10(Copy(wLinha,1,11));
 DV2 := Modulo10(Copy(wLinha,12,11));
 DV3 := Modulo10(Copy(wLinha,23,11));
 DV4 := Modulo10(Copy(wLinha,34,11));
 Formatada := Copy(wLinha,1,11)  + ' ' + DV1 + ' ' +
              Copy(wLinha,12,11) + ' ' + DV2 + ' ' +
              Copy(wLinha,23,11) + ' ' + DV3 + ' ' +
              Copy(wLinha,34,11) + ' ' + DV4;
 Result := Trim(Formatada);
end;

Function FormataLinhaDig11(wLinha: String): String;
var
 Formatada, DV1, DV2, DV3, DV4: String;
begin
 DV1 := Modulo11(Copy(wLinha,1,11));
 DV2 := Modulo11(Copy(wLinha,12,11));
 DV3 := Modulo11(Copy(wLinha,23,11));
 DV4 := Modulo11(Copy(wLinha,34,11));
 Formatada := Copy(wLinha,1,11)  + ' ' + DV1 + ' ' +
              Copy(wLinha,12,11) + ' ' + DV2 + ' ' +
              Copy(wLinha,23,11) + ' ' + DV3 + ' ' +
              Copy(wLinha,34,11) + ' ' + DV4;
 Result := Trim(Formatada);
end;

// http://www.planetadelphi.com.br/dica/4379/verifica-se-ha-algum-edit-vazio,-passando-o-formulario-como-parametro
// Essa função pode ser colocada em uma unit separada. Assim em qualquer formulário do programa é possível chamar a função e verificar se tem algum edit vazio no formulário passado no parâmetro

Function Consistencia(Formulario: Tform): Boolean;
var
  i : Integer;
  Resposta: Boolean;
  Componente: TEdit;
begin
    // Inicializa a resposta
  Resposta := False;
   // Executa uma repetição em todos os componentes
  For i := 0 to formulario.ComponentCount -1 do
  begin
     // Verifica se o componente é um editBox
    if formulario.Components[i] is TEdit then
    begin
        // Grava o componente em uma variável
      Componente := formulario.Components[i] as TEdit;
      if (Componente.Name = 'EdDescRemessa')   or
         (Componente.Name = 'EdNomeRemetente') or
         (Componente.Name = 'EdLograRem')      or
         (Componente.Name = 'EdNomeDest')      or
         (Componente.Name = 'EdLogradouro')    or
         (Componente.Name = 'EdCEP')           then begin

        // Verifica se o valor está vazio
         if Trim(Componente.Text) = EmptyStr then begin
            Resposta := True;
            Break;
         end; // Fim do if
      end;
    end; // Fim do if
  end; // Fim do for
  Result := Resposta;
end;

Procedure FormatXMLFile(const XmlFile:string);
var
  oXml : IXMLDocument;
begin
  oXml := TXMLDocument.Create(nil);
  try
    oXml.LoadFromFile(XmlFile);
    oXml.XML.Text:=xmlDoc.FormatXMLData(oXml.XML.Text);
    oXml.Active := true;
    oXml.SaveToFile(XmlFile);
  finally
    oXml := nil;
  end;
end;

{Function nomeXML(tipoArq: String;sequencia: Integer):String;
var
  nomeArquivo,dataArquivo: String;
begin
  if main.ambiente = 'P' then
     nomeArquivo := 'K3244.K07610X' //Produção
  else
     nomeArquivo := 'K3244.H07610X'; //Homologação

  dataArquivo := RemoveMask(DateToStr(Date));
  dataArquivo := Copy(dataArquivo,7,2) +
                 Copy(dataArquivo,3,2) +
                 Copy(dataArquivo,1,2);

  //nomeArquivo := nomeArquivo + tipoArq + '.' + 'FDX' + StrZeroF(IntToStr(sequencia),5) + '.D' +
  //               dataArquivo + '.H' + RemoveMask(TimeToStr(Now)) + '.xml';

  nomeArquivo := nomeArquivo + tipoArq + '.' + 'FDX' + StrZeroF(IntToStr(sequencia),5) + '.D' +
                 dataArquivo + '.H' + RemoveMask(TimeToStr(Now));

  Result := Trim(nomeArquivo);
end;}


procedure RemovePalavra(var origem: string; apagar: string);
var
  InicioPalavra, TamanhoPalavra : Integer;
begin
  InicioPalavra := pos(apagar,origem);
  TamanhoPalavra := length(apagar);
  if InicioPalavra > 0 then
     Delete(origem,InicioPalavra,TamanhoPalavra);
end;

//function TruncVal(Value: Double; Casas: Integer): Double;
Function TruncaValor(Value: Real; Casas: Integer): Real;
var
  sPot: String;
  iPot: Integer;
  x: Integer;
begin
  sPot := '1';
  for x := 1 to Casas do sPot := sPot + '0';
  begin
    iPot := StrToInt(sPot);
  end;
  Result := StrToInt(IntToStr(Trunc(Value * iPot))) / iPot;
end;

Function ProximoDiaUtil (dData : TDateTime) : TDateTime;
begin
  if DayOfWeek(dData) = 7 then
     dData := dData + 2
  else
     if DayOfWeek(dData) = 1 then
        dData := dData + 1;
  ProximoDiaUtil := dData;
end;

Function PreencheZeroDireita(Texto: string; Quant: integer): String;
begin
  Result := Texto;
  Quant := Quant - Length(Result);
  if Quant > 0 then
     Result := Result + StringOfChar('0', Quant);
end;

Function checaEmail(email : String): Boolean;
   var {sintaxe: nome@provedor.com.br ou outros}
   s: String;
   EPos: Integer;
begin
   EPos:= pos('@',email);
   if Epos > 1 then
      begin
         s:= copy(eMail, Epos + 1, Length(email));
         if (pos('.',s)> 1) and (pos('.',s)< length(s)) then
             Result := true
           else Result := False;
      end
     else
       Result := False;
end;


procedure Delay(MSec: Cardinal);
var 
  Start: Cardinal; 
begin 
  Start := GetTickCount;
  repeat
    Application.ProcessMessages;
  until (GetTickCount - Start) >= MSec; 
end;

Function tntParaFedex(remessa: String):String;
var
  novoAWB: String;
begin
  novoAWB := RemoveZeros(SoLetrasNumeros(remessa));
  if Copy(novoAWB,Length(novoAWB) - 1, 2) <> '01' then
     novoAWB := novoAWB + '01';
  Result := StrzeroF(novoAWB,12);
end;

Function verificaDiaUtil(dataIncial:TDateTime; dias_uteis:Integer):TDateTime;
{Retorna uma data acresçida de mais um certo número de dias
 uteis descontando os fins de semana}
var dw:Integer;
begin
  dw := DayOfWeek(dataIncial) - 1;
  result := dataIncial + dias_uteis + ((dias_uteis -1 + dw) div 5) *2;
end;

function trocaPonto(Valor: string): String;
begin
  if (Trim(valor) <> EmptyStr) and
     (Trim(valor) <> '0')      then
     Result := trim(StringReplace(Valor,'.',',',[rfReplaceall]))
  else
     Result := '0,00';
end;

function trocaVirgula(Valor: string): String;
begin
  if (Trim(valor) <> EmptyStr) and
     (Trim(valor) <> '0')      then
     Result := Trim(StringReplace(Valor,',','.',[rfReplaceall]))
  else
     Result := '0.00';
end;

function  tiraVirgula(Valor: String): String;
begin
  if (Trim(valor) <> EmptyStr) and
     (Trim(valor) <> '0')      then
     Result := Trim(StringReplace(Valor,',','',[rfReplaceall]))
  else
     Result := '0.00';
end;

procedure GravarTexto(SalvarComo, Texto: WideString);
var
  txt: textfile;
begin
  try
    AssignFile(txt, SalvarComo);
    Rewrite(txt, SalvarComo);
    Append(txt);
    WriteLn(txt, Texto);
  finally
    CloseFile(txt);
  end;
end;

procedure imprimirPlanilha(instrucaoSQl: TADOQuery; title, tipo: String);
var
  Linha, Coluna: Integer;
  ValorCampo: String;
  Celula: Variant;
  MSExcel, ExcelBook, ExcelSheet: OleVariant;
begin
  MSExcel    := CreateOLEObject( 'Excel.Application' ); // Cria uma aplicação do Excel
  ExcelBook  := MSExcel.WorkBooks.Add;                  // Adiciona uma pasta na planilha
  ExcelSheet := ExcelBook.WorkSheets.Add;
  ExcelSheet.Range['A1','H1'].Merge(EmptyParam);
  ExcelSheet.Cells[ 1,1 ].Font.Size      := 12;
  ExcelSheet.Cells[ 1,1 ].Interior.Color := $00ffcf9c;
  ExcelSheet.Cells[ 1,1 ].Font.Bold      := True;
  Celula       := ExcelSheet.Cells[ 1,1 ];
  Celula.Value := title;
  Linha := 3; // Dados são inseridos a partir desta linha
  Screen.Cursor := crHourGlass;

  instrucaoSQl.Open;

  if (instrucaoSQl.RecordCount > 0) then begin
    for Coluna := 1 to instrucaoSQL.FieldCount do
    begin
      ValorCampo := instrucaoSQL.Fields[coluna - 1].DisplayLabel;
      MSExcel.cells[2,coluna] := ValorCampo; // Nome das colunas
      MSExcel.Cells[2,coluna].Font.Color := clWhite;
      MSExcel.Cells[2,coluna].Font.Bold := True;
      MSExcel.Cells[2,coluna].Interior.Color := clBlue;
    end;


    For Coluna := 0 to (instrucaoSQl.FieldCount - 1) do
    begin
      MSExcel.Cells[Linha,Coluna + 1] := instrucaoSQl.Fields[Coluna].DisplayLabel;
      Case instrucaoSQl.Fields[Coluna].DataType Of
        ftDate    : MSExcel.Columns.Columns[ Coluna + 1 ].NumberFormat := 'dd/mm/aaaa';
        ftDateTime: MSExcel.Columns.Columns[ Coluna + 1 ].NumberFormat := 'dd/mm/aaaa';
        ftString  : MSExcel.Columns.Columns[ Coluna + 1 ].NumberFormat := '@';
        ftCurrency: MSExcel.Columns.Columns[ Coluna + 1 ].NumberFormat := '###0,00';
        ftFloat   : MSExcel.Columns.Columns[ Coluna + 1 ].NumberFormat := '###0';
        ftBCD     : MSExcel.Columns.Columns[ Coluna + 1 ].NumberFormat := '@';
        ftSmallint: MSExcel.Columns.Columns[ Coluna + 1 ].NumberFormat := '###0,00';
      end;
    end;

    instrucaoSQl.First;
    instrucaoSQl.DisableControls;
    try
      while not instrucaoSQl.Eof do
      begin
        try
          for Coluna := 0 to (instrucaoSQL.FieldCount - 1) do  begin
            if not VarIsEmpty(instrucaoSQl.Fields[coluna].Value) then
              MSExcel.Cells[Linha,Coluna + 1] := Trim(VarToStr(instrucaoSQl.Fields[Coluna].Value))
            else
              MSExcel.Cells[Linha,Coluna + 1] := instrucaoSQl.Fields[Coluna].Value;

            if tipo = 'Voo' then begin
               if (coluna = 19) or (coluna = 21) or (coluna = 24) or (coluna = 26) then
                  MSExcel.Cells[Linha,Coluna + 1] := trocaVirgula(instrucaoSQl.Fields[coluna].Value);
            end;

            if Trim(tipo) = 'Tratamento' then begin
               if (coluna = 4) and (Trim(instrucaoSQl.Fields[coluna].Value) <> EmptyStr) then
                  MSExcel.Cells[Linha,Coluna + 1] := 'TC - ' + Trim(instrucaoSQl.Fields[coluna].Value);
            end;

            if Trim(tipo) = 'Total' then begin
               if coluna = 4 then
                  MSExcel.Cells[Linha,Coluna + 1] := FloatToStr(StrToFloat(instrucaoSQl.Fields[coluna].Value) * 2.2046);
            end;

          end;
          instrucaoSQl.Next;
          Inc(Linha);
        finally
        end;
      end;
    finally
      instrucaoSQl.EnableControls;
    end;
  end;
  MSExcel.Columns.AutoFit;
  MSExcel.Visible := True;
  Screen.Cursor := crDefault;
end;

Function VerificaLetras(Texto:String):Boolean;
var
Resultado:Boolean;
I:Integer;
Begin
  Resultado := False;
  For I := 1 to Length(Texto) do
  begin
    if (Texto[I] in ['a'..'z','A'..'Z']) then
    begin
      Resultado := True;
    end else
      Resultado := False;
  end;
  Result := Resultado;
end;

function duasPalavras(frase: String): String;
var
  i: Integer;
  palavra1,palavra2,palavra3,texto: String;
begin
  texto := frase;
  i := Pos (' ', texto);
  palavra1 := Copy(texto,1,Pos (' ', texto) - 1);
  Delete(texto,1,i);
  texto := Trim(texto);
  if Pos (' ', texto) > 0 then begin
     palavra2 := Copy(texto,1,Pos (' ', texto) - 1);
     if Length(palavra2) < 3 then begin
        Delete(texto,1,Length(palavra2));
        texto := Trim(texto);
        if Pos (' ', Trim(texto)) > 0 then
           palavra3 := Copy(Trim(texto),1,Pos (' ', Trim(texto)) - 1)
        else
           palavra3 := Copy(Trim(texto),1,Length(Trim(texto)));
     end;
  end;
  if Trim(palavra2) <> EmptyStr then
     Result := Trim(palavra1 + ' ' + palavra2 + ' ' + palavra3)
  else
     Result := frase;
end;


Procedure ordenarTituloGrid(Grid : TDBGrid; Column : TColumn);
{$J+}
const PreviousColumnIndex : integer = -1;
{$J+}
begin
  if Grid.DataSource.DataSet is TCustomADODataSet then
     With TCustomADODataSet(Grid.DataSource.DataSet) do
     begin
       try
         Grid.Columns[PreviousColumnIndex].title.Font.Style :=
         Grid.Columns[PreviousColumnIndex].title.Font.Style - [fsBold];
       except
         // nada
       end;

       Column.title.Font.Style := Column.title.Font.Style + [fsBold];
       PreviousColumnIndex := Column.Index;

       if (Pos(Column.Field.FieldName, Sort) = 1) and (Pos(' DESC', Sort)= 0) then
          Sort := Column.Field.FieldName + ' DESC'
       else
          Sort := Column.Field.FieldName + ' ASC';
     end;
end;

function montaLista(Memo: TMemo): String;
var
  i: Integer;
  lista: String;
begin
  for i := 0 to Memo.Lines.Count - 1 do
  begin
    lista := lista + QuotedStr(Trim(Memo.Lines[i])) + ',';
  end;
  lista  := LeftStr(lista, Length(lista) - 1);
  lista  := '(' + lista + ')';
  Result := lista;  
end;

function montaListaString(listaRemessas: TStringList): String;
var
  i: Integer;
  lista: String;
begin
  for i := 0 to listaRemessas.Count - 1 do
  begin
    lista := lista + QuotedStr(Trim(listaRemessas.Strings[i])) + ',';
  end;
  lista  := LeftStr(lista, Length(lista) - 1);
  lista  := '(' + lista + ')';
  Result := lista;
end;

Function tiraMinutos(num: integer): string;
var
  month0,day0,hour0,min0,sec0: string;
  year,month,day,hour,min,sec,millli: Word;
  aux: integer;
begin
  sec0 := EmptyStr;
  DecodeDate(Now, year, month, day);
  DecodeTime(Now,hour,min,sec,millli);
  if min - num < 0 then begin
     aux  := num - min;
     min  := 60 - aux;
     if hour - 1 < 0 then begin
        hour := 23;
        day  := day - 1;
        if day <= 0 then begin
           month := month - 1;
           if month <= 0 then begin
           year := year - 1;
           month := 12;
           end;
           if month = 2 then begin
           if anoBissexto(year) then
              day := 29
           else
              day := 28;
           end;
           case month of
             1:  day := 31;
             3:  day := 31;
             4:  day := 30;
             5:  day := 31;
             6:  day := 30;
             7:  day := 31;
             8:  day := 31;
             9:  day := 30;
             10: day := 31;
             11: day := 30;
             12: day := 31;
          end;
        end;

     end
     else
       hour := hour - 1;
  end
  else
    min := min - num;
  if Length(IntToStr(sec)) = 1 then
     sec0 := '0' + IntToStr(sec)
  else
     sec0 := IntToStr(sec);
  if Length(IntToStr(min)) = 1 then
     min0 := '0' + IntToStr(min)
  else
     min0 := IntToStr(min);
  if Length(IntToStr(hour)) = 1 then
     hour0 := '0' + IntToStr(hour)
  else
     hour0 := IntToStr(hour);
  if Length(IntToStr(day)) = 1 then
     day0 := '0' + IntToStr(day)
  else
     day0 := IntToStr(day);
  if Length(IntToStr(month)) = 1 then
     month0 := '0' + IntToStr(month)
  else
     month0 := IntToStr(month);

  Result := IntToStr(year) + '-' + month0 + '-' + day0 + ' ' + hour0 + ':' + min0 + ':' + sec0;
end;

function anoBissexto(ano: integer): Boolean;
begin
  if (ano mod 4 = 0) or (ano mod 400 = 0) then begin
      if ano mod 100 <> 0 then
         Result := True;
  end
  else
    Result := False;
  
end;


Function RetiraCaracteresEspeciaisExportacao(wLinha: String): String;
var i: Integer;
    linha,caracter: String;
    aChar:PChar;
Const
  // Apenas caracteres que o Harpia aceita.
  CharEspc: set of Char = [#0..#255] - ['a'..'z','A'..'Z','1'..'9','0','.',';',',',':', '-'];
begin
  wLinha := RemoveAcentos(wLinha);

  if (Length(wLinha) = 1) and (Trim(wLinha) = '-')then
     result := QuotedStr('')
  else begin
     For i := 1 To Length(wLinha) do
     begin
     aChar := pChar(Copy(wLinha, i, 1 ));
     if ((aChar^ in CharEspc)) then
        caracter := ' '
     else
        caracter :=  wLinha[i];
        linha := linha + caracter;
     end;
     result := QuotedStr(linha);
  end;
end;

Function  SoNumerosRecintos(wLinha: String): String;
var I: integer;
    S: string;
begin
  S := '';
  for I := 1 To Length(wLinha) Do
  begin
    if (wLinha[I] in ['0'..'9', '.']) then
    begin
      S := S + Copy(wLinha, I, 1);
    end;
  end;
  result := S;
end;

function validaNumeroMaster(master: String): Boolean;
var
  Dv: Real;
begin
  Dv := StrToInt(Copy(master, 4, 7)) Mod 7;

  if Copy(FloatToStr(Dv), 1, 1) <> Copy(master, 11, 1) then
     Result := False
  else
     Result := True;
end;

//Ler excel
Function XlsToStringGrid(AGrid: TStringGrid; AXLSFile: string): Boolean;
const
  xlCellTypeLastCell = $0000000B;
var
  XLApp, Sheet: OLEVariant;
  RangeMatrix: Variant;
  x, y, k, r: Integer;
begin
  Result:=False;
  //Cria Excel- OLE Object
  XLApp:=CreateOleObject('Excel.Application');
  try
    //Esconde Excel
    XLApp.Visible:=False;
    //Abre o Workbook
    XLApp.Workbooks.Open(AXLSFile);
    Sheet:=XLApp.Workbooks[ExtractFileName(AXLSFile)].WorkSheets[1];
    Sheet.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
    //Pegar o número da última linha
    x:=XLApp.ActiveCell.Row;
    //Pegar o número da última coluna
    y:=XLApp.ActiveCell.Column;
    //Seta Stringgrid linha e coluna
    AGrid.RowCount:=x;
    AGrid.ColCount:=y;
    //totLinhas  := x;
    //totColunas := y;
    //Associaca a variant WorkSheet com a variant do Delphi
    RangeMatrix:=XLApp.Range['A1', XLApp.Cells.Item[X, Y]].Value;
    //Cria o loop para listar os registros no TStringGrid
    k:=1;
    repeat
      for r:=1 to y do
          AGrid.Cells[(r - 1),(k - 1)]:=RangeMatrix[K, R];
      Inc(k,1);
    until k > x;
    RangeMatrix:=Unassigned;
  finally
    //Fecha o Excel
    if not VarIsEmpty(XLApp) then
    begin
      XLApp.Quit;
      XLAPP:=Unassigned;
      Sheet:=Unassigned;
      Result:=True;
    end;
  end;
end;

end.




