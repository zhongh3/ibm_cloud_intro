exports.listSysTables = function(ibmdb,connString) {
    return function(req, res) {
	   	   
       ibmdb.open(connString, function(err, conn) {
			if (err ) {
			 res.send("error occurred " + err.message);
			}
			else {
				/* 
					Test shows that column names need to be surrounded by "" for some cases.
					Perhaps it's related to the length of column name.
					e.g. CC doesn't require "", but Coutry_Code does.
				*/
				conn.query('SELECT "Country_Code","Short_Name","Table_Name" FROM LMZ63451.EDSTATS FETCH FIRST 10 ROWS ONLY', function(err, tables, moreResultSets) {
				// conn.query("SELECT * FROM LMZ63451.EDSTATS FETCH FIRST 10 ROWS ONLY", function(err, tables, moreResultSets) {
							
				if ( !err ) { 
					res.render('tablelist', {
						"tablelist" : tables,
						"tableName" : "10 rows of first 3 columns from the EDSTATS table",
						"message": "Congratulations. Your connection to Db2 is successful."
						
					 });
					
				} else {
				   res.send("error occurred " + err.message);
				}

				/*
					Close the connection to the database
					param 1: The callback function to execute on completion of close function.
				*/
				conn.close(function(){
					console.log("Connection Closed");
					});
				});
			}
		} );
	}
}
