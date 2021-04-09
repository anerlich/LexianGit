unit ELFunctions;

interface
  Uses Math;

function ELRoundPer(FloatNum:double;Decimals:Integer):Double;

implementation

function ELRoundPer(FloatNum:double;Decimals:Integer):Double;
begin

  Result := RoundTo(FloatNum,(Decimals*-1));
end;

end.
