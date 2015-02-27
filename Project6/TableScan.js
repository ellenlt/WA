function TableScan() {}

/* Static method sumColumn which returns the sum of all values
in the column named "col" in the table with given id. Non-numeric
values are treated as 0. */
TableScan.sumColumn = function(id, str) {
	var table = document.getElementById(id);

	//Returns 0 if invalid table id or column str
	if(!TableScan.isValid(table) || TableScan.indexOfCol(table.rows[0].cells, str) == -1) return 0;	
	
	var col = TableScan.indexOfCol(table.rows[0].cells, str);
	
	//Sums values in column
	var sum = 0;
	for (var i=1; i < table.rows.length; i++) {
		var cell = table.rows[i].cells[col];
		if(cell != null ) {		//Ignore empty cells
			cell = new Number(cell.textContent);
			if(isNaN(cell)) {	//Ignore non-numeric cells
				cell = 0;
			}
		sum = sum + cell;
		}
	}
	sum = sum.toFixed(2);		//Sets sum to two decimal-pts
	return sum;
};

/* Returns true if table exists and is a valid table element */
TableScan.isValid = function(table) {
	if(!table) return false;
	if(table.nodeName != "TABLE") return false;
	return true;
};

/* Takes an array of the elements in a table row and returns
the index of the column with text content that matches the col string.
Case insensitive. If column name is not found, returns -1. */
TableScan.indexOfCol = function(row, col) {
	for (var i = 0; i < row.length; i++) {
        if (row[i].textContent.toLowerCase() === col.toLowerCase()) {
            return i;
        }
    }
    return -1;
};

//Binds events for the sum calculator
TableScan.bindCalcEvents = function() {
	(document.getElementById("sum_calculator")).onsubmit = function(evt) {
          var sumCalculator = document.getElementById("sum_calculator");
          var tableId = sumCalculator.elements.namedItem("table_id").value;
          var colName = sumCalculator.elements.namedItem("col_name").value;
          var sum = TableScan.sumColumn(tableId, colName);
          document.getElementById("display_sum").innerHTML = "<p>The <i>" + colName + "</i> column in the <i>" + tableId + "</i> table has a sum of: <b>" + sum + "</b></p>";
          event.preventDefault();
    };
};




