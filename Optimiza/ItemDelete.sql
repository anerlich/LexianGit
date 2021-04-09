
Run the following SQL commands for the deletion of items across all locations (Change the product code accordingly):

1. Delete from item where productno = (Select productno from product where productcode = "2005")
(This will delete items out of all related tables).

2. Delete from tmplt_item where productno = (Select productno from product where productcode = "2005")

3. Delete from product where productcode = "2005"
(This deletes the "master record" out of the product table)

