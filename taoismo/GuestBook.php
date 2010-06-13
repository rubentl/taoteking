<? 
//inmex estudios valedores!!! 
   $DBhost = "imysql02";   // servidor 
   $DBuser = "i1927500";            // usuario base 
   $DBpass = "ko47woxece5vxnce";            // contrase¤a del host 
   $DBName = "i1927500";            // nombre de la base de datos 
   $table = "guestbook";             // nombre de la tabla 
   $numComments = 10;       // numero de comentarios por pagina 
    
   // conectando al servidor MySQL 
   $DBConn = mysql_connect($DBhost,$DBuser,$DBpass) or die("Error en el 
libro de visitas: " . mysql_error()); 
   // seleccion de MySQL servidor 
   mysql_select_db($DBName, $DBConn) or die("Error en el libro de visitas: 
" . mysql_error()); 
 
   $action = $_GET['action']; 
    
   switch($action) { 
      case 'read' : 
		 $sql = 'SELECT * FROM `' . $table . '`'; 
		 $allComments = mysql_query($sql, $DBConn) or die("Error en el 
libro de visitas: " . mysql_error()); 
		 $numallComments = mysql_num_rows($allComments); 
		 $sql .= ' ORDER BY `time` DESC LIMIT ' . $_GET['NumLow'] . ', 
' . $numComments; 
		 $fewComments = mysql_query($sql, $DBConn) or die("Error en el 
libro de visitas: " . mysql_error()); 
		 $numfewComments = mysql_num_rows($fewComments); 
		 print '&totalEntries=' . $numallComments . '&'; 
		 print "&entries=";	 
		  
		 if($numallComments == 0) { 
		    print "No hay entradas en el libro de visitas, todavía..&"; 
		 } else {  
		    while ($array = mysql_fetch_array($fewComments)) { 
			   $name = mysql_result($fewComments, $i, 'name'); 
			   $email = mysql_result($fewComments, $i, 'email'); 
			   $comments = mysql_result($fewComments, $i, 
'comments'); 
			   $time = mysql_result($fewComments, $i, 'time'); 
			    
			   print '<b>Nombre: </b>' . $name . '<br><b>Email: </b>' . 
$email . '<br><b>Comentario: </b>' . $comments . '<br><i>Fecha: ' . $time . 
'</i><br><br>'; 
			   $i++; 
		    }
		   print "&"; 
		} 
		if($_GET['NumLow'] > $numallComments) { 
		   print 'No hay más entradas!&'; 
		} 
		break; 
		  
	  case 'write' : 
		 $name = ereg_replace("&", "%26", $_POST['yourname']); 
		 $email = ereg_replace("&", "%26", $_POST['youremail']); 
		 $comments = ereg_replace("&", "%26", $_POST['yourcomments']); 
		 $submit = $_POST['submit']; 
		 	  
		 $submitted_on = date ("Y-m-d H:i:s",time()); 
		 		  
		 if($submit == 'Yes'){ 
		 $sql = 'INSERT INTO ' . $table .  
                ' (`ID`,  
				   `name`,  
				   `email`,  
				   `comments`,  
				   `time` 
				  )  
				  VALUES  
				  (\'\',' 
				   . '\'' . $name . '\','  
				   . '\'' . $email . '\','  
				   . '\'' . $comments . '\','  
				   . '\'' . $submitted_on . '\' 
				   )'; 
		 $insert = mysql_query($sql, $DBConn) or die("Error en el 
libro de visitas " . mysql_error()); 
		 
		  
		 print "&gb_status=Gracias.&done=yes&"; 
		 return; 
		 } 
		 print "&_root.write.gb_status=Error!&"; 
		 break; 
   } 
?>
