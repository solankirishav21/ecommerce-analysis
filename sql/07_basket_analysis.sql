SELECT
    a.sub_category AS item_1,
    b.sub_category AS item_2,
    COUNT(*) AS frequency
FROM
    order_details AS a
JOIN
    order_details AS b ON a.order_id = b.order_id AND a.sub_category < b.sub_category
GROUP BY
    item_1,
    item_2
ORDER BY
    frequency DESC
LIMIT 15;

/* OUTPUT:
"item_1","item_2","frequency"
"Hankerchief","Stole","121"
"Hankerchief","Saree","110"
"Saree","Stole","109"
"Phones","Saree","53"
"Electronic Games","Hankerchief","48"
"Saree","Skirt","48"
"Printers","Saree","47"
"Hankerchief","Skirt","46"
"Saree","T-shirt","45"
"Electronic Games","Saree","44"
"Accessories","Saree","43"
"Bookcases","Saree","42"
"Chairs","Saree","42"
"Printers","Stole","41"
"Bookcases","Stole","41"
*/