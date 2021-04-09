select * from item where locationno = 3
  and productno in (Select ProductNo from item where locationno = 4)
