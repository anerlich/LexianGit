unit ELFunctions;

interface
  Uses Math;

function ELRoundPer(FloatNum:double;Decimals:Integer):Double;
function ELRound(FloatNum:double):Double;


implementation

function ELRoundPer(FloatNum:double;Decimals:Integer):Double;
begin

  Result := RoundTo(FloatNum,(Decimals*-1));
end;

function ELRound(FloatNum:double):Double;
begin

  Result := RoundTo(FloatNum,0);
end;

end.
