unit FAG.Utils;

interface

function StrToSQL(caracter: String): String;
function IntToSQL(valor: Integer): String;
function VirgulaPorPonto(Vlr: string): string;
function DateTimeToSQL(DataTime: TDateTime): String;
function DateToSQL(DataTime: TDateTime): String;

implementation

uses
  System.SysUtils;

function StrToSQL(caracter: String): String;
begin
  if caracter <> '' then
    Result := #39 + caracter + #39
  else
    Result := 'NULL';
end;

function IntToSQL(valor: Integer): String;
begin
  if valor <> 0 then
    Result := FormatFloat('0', valor)
  else
    Result := 'NULL';
end;

function VirgulaPorPonto(Vlr: string): string;
var
  I: Integer;
  Str: string;
begin
  Str := Vlr;

  if (Str = '') then
    Result := '0'
  else
  begin
    if Pos(',', Str) > 0 then
    begin
      for I := 1 to 2 do
        if Pos('.', Str) > 0 then
          Delete(Str, Pos('.', Str), 1);

      if Pos(',', Str) > 0 then
        Str[Pos(',', Str)] := '.';
      Result := Str;
    end
    else
      Result := Str;
  end;
end;

function DateTimeToSQL(DataTime: TDateTime): String;
begin
  Result := 'NULL';

  if DataTime <> 0 then
  begin
    Result := #39 + FormatDateTime('yyyy-mm-dd hh:nn:ss', DataTime) + #39
  end;

end;

function DateToSQL(DataTime: TDateTime): String;
begin
  Result := 'NULL';

  if DataTime <> 0 then
  begin
    Result := #39 + FormatDateTime('yyyy-mm-dd', DataTime) + #39
  end;

end;

end.
