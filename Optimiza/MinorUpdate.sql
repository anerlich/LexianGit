Set Term !! ;

Create Procedure UP_UpdateMinorGroup
As

/* KG 22/11/01 Update Minor Group */

Declare variable xProductNo Integer;
Declare variable xMinorGroupNo Integer;

Begin


For Select productno, GroupMinor2 from item
  where locationno = ?
       Into :xProductNo, :xMinorGroupNo

  Do Begin
    Update Item Set GroupMinor2 = :xMinorGroupNo
     where ProductNo = :xProductNo and LocationNo <> ?;
  End

End!!

Set Term ; !!
