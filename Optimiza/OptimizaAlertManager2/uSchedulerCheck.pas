unit uSchedulerCheck;

interface

uses
  Classes, dmSchedulerCheck, Windows, abLED, Graphics;

type
  TSchedulerCheck = class(TThread)
  private
    SchedulerCheckDataModule : TSchedulerCheckDataModule;
    Color : TColor;
    NewCap, OldCap : string;
    FAbLed : TAbLed;

    procedure UpdateLed;
  protected
    procedure Execute; override;
  public
    constructor Create(AAbLed : TAbLed);
  end;

const
  Interval = 100;  // poll the database every (Interval * IntervalCount) milliseconds
  IntervalCount = 600;

implementation

constructor TSchedulerCheck.Create(AAbLed : TAbLed);
begin
  FAbLed := AAbLed;
  FreeOnTerminate := True;
  inherited Create(False);
end;

procedure TSchedulerCheck.Execute;
var
  SchedString : string;
  Counter, SchedStatus : integer;

begin
  SchedulerCheckDataModule := TSchedulerCheckDataModule.Create(nil);
  try
    SchedulerCheckDataModule.SVPDatabase.Close;
    OldCap := '';
    Counter := 0;
    while True do begin
      if Counter = IntervalCount then begin
        with SchedulerCheckDataModule do begin
          SVPDatabase.Open;
          try
            SchedStatus := ReadConfigInt(259);
            SchedString := ReadConfigStr(259);
            if SchedStatus = 0 then begin
              Color := clBlack;
              NewCap := 'Scheduler is not running';
            end
            else
              if SchedStatus = 1 then begin
                Color := clSilver;
                NewCap := 'Waiting for next Scheduler Set to begin';
              end
              else
                if SchedStatus = 2 then begin
                  Color := $0040AEFF;
                  NewCap := SchedString; //'Scheduler set has a WARNING';
                end
                else
                  if SchedStatus = 3 then begin
                    Color := clRed;
                    NewCap := SchedString; //'Scheduler set FAILED';
                  end
                  else begin
                    Color := clLime;
                    NewCap := SchedString;
                  end;
          finally
            SVPDatabase.Close;
          end;
          Counter := 0;
        end;
      end;
      if not Terminated then begin
        if NewCap <> OldCap then begin
          Synchronize(UpdateLed);
          OldCap := NewCap;
        end;
        Sleep(Interval);
        inc(Counter);
      end
      else
        Break;
    end;
  finally
//    SchedulerCheckDataModule.Free;
  end;
end;

procedure TSchedulerCheck.UpdateLed;
begin
  FABLed.LED.ColorOff := Color;
  FABLed.Hint := NewCap;
end;

end.
