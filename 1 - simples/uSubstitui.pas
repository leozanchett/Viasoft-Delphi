unit uSubstitui;

interface

uses
  uISubstitui;

type

   TSubstitui = class(TInterfacedObject, ISubstitui)
      private
         procedure Custom_Inc(var _PVlr: Cardinal); inline;
         function Custom_Length(const _PStr: String): Cardinal; inline;
      public
         constructor Create;
         destructor Destroy; override;
         class function New: ISubstitui;
         function Substituir(Str, Velho, Novo: String): String;
   end;


implementation


{ TSubstitui }

constructor TSubstitui.Create;
begin

end;

procedure TSubstitui.Custom_Inc(var _PVlr: Cardinal);
begin
   _PVlr := _PVlr + 1;
end;

function TSubstitui.Custom_Length(const _PStr: String): Cardinal;
var
   LCaractere: Char;
begin
   Result := 0;
   for LCaractere in _PStr do
      Result := Result + 1;
end;

destructor TSubstitui.Destroy;
begin

  inherited;
end;

class function TSubstitui.New: ISubstitui;
begin
    Result := Self.Create;
end;


function TSubstitui.Substituir(Str, Velho, Novo: String): String;
var
   x, LPosCaracter, LContador_Match_Velho: Cardinal;
begin
   LContador_Match_Velho := 0;
   for LPosCaracter := 1 to Custom_Length(Str) do begin
      // O contador de matching precisa estar zerado (pois � ignorado o caractere subsequente).
      if LContador_Match_Velho = 0 then begin
         LContador_Match_Velho := 0;
         if Str[LPosCaracter] = Velho[1] then begin
            Custom_Inc(LContador_Match_Velho);
            for x := 1 to Custom_Length(Velho) do begin
                if ((LPosCaracter + x) <= Custom_Length(Str)) and (Str[LPosCaracter + x] = Velho[x + 1]) then begin
                  Custom_Inc(LContador_Match_Velho);
                end;
            end;
         end;
         // Quando o contador de matching tiver o mesmo Length que a STR 'velha' 
         // ou seja, todos os caracteres velhos foram encotrados.
         if LContador_Match_Velho = Custom_Length(Velho) then begin
            Result := Result + Novo;
            // Atribu�do := 1 para que a 'STR' n�o considere o pr�ximo caractere.
            LContador_Match_Velho := 1;
         end else begin
            LContador_Match_Velho := 0;
            Result := Result + Str[LPosCaracter]; 
         end;
      end else
         LContador_Match_Velho := LContador_Match_Velho - 1;
   end;
end;

end.

