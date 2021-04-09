CREATE PROCEDURE UP_CONSOLIDATEALLMIN   AS    
begin
  Execute Procedure UP_CONSOLIDATEMIN("1A","1NAT");
  Execute Procedure UP_CONSOLIDATEMIN("2A","2NAT");
  Execute Procedure UP_CONSOLIDATEMIN("3A","3NAT");
  Execute Procedure UP_CONSOLIDATEMIN("4A","4NAT");
  Execute Procedure UP_CONSOLIDATEMIN("5A","5NAT");
  Execute Procedure UP_CONSOLIDATEMIN("6A","6NAT");
  Execute Procedure UP_CONSOLIDATEMIN("1A","HNAT");
end