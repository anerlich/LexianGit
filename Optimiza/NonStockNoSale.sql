/* Set Stocking Indicator where no sales */
Update Item Set StockingIndicator = 'N'
where itemno in (Select Itemno from itemsales 
  where (salesamount_1 + Salesamount_2 + salesamount_3) = 0 )

