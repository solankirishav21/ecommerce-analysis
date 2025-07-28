SELECT
    sub_category,
    SUM(quantity) AS total_quantity,
    SUM(profit) AS total_profit
FROM
    order_details
GROUP BY
    sub_category;

/*OUTPUT:
"sub_category","total_quantity","total_profit"
"Furnishings","310","844.00"
"Stole","671","2559.00"
"Tables","61","-4011.00"
"Bookcases","297","4888.00"
"T-shirt","305","1500.00"
"Accessories","262","3559.00"
"Leggings","186","260.00"
"Saree","782","352.00"
"Trousers","135","2847.00"
"Printers","291","5964.00"
"Shirt","271","1131.00"
"Kurti","164","181.00"
"Hankerchief","754","2098.00"
"Phones","304","2207.00"
"Electronic Games","297","-1236.00"
"Skirt","248","235.00"
"Chairs","277","577.00"
*/