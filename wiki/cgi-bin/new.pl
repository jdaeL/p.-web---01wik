#!C:\xampp\perl\bin\perl.exe
use strict;
use warnings;
use DBI;
use CGI;

print "Content-type: text/html\n\n";
print <<HTML;
<!DOCTYPE html>
<html>
<head>    
    <link rel="stylesheet" type="text/css" href="">
    <title>NEW</title>
</head>
<body>
          
HTML
my $q = CGI->new;
my $titulo=$q->param("titulo");
my $contenido=$q->param("contenido");

print <<HTML;
    <h1>$titulo</h1>
    <p>$contenido</p>
    <br>
    <h6>Pagina grabada <a href="list.pl">Listado de paginas</a></h1>
   </body>
</html>
HTML

# conexión a mariaDB
my $database = "wiki";
my $host = "localhost";
my $port = "3306";
my $user = "root";
my $pw = "71950727joe#";
my $dsn = "DBI:MariaDB:$database:$host:$port";
    
my $dbh = DBI ->connect($dsn,$user,$pw) or die ("No se pudo conectar");
my $sth = $dbh->prepare("INSERT INTO wiki (titulo, contenido) VALUES (?, ?)" );

$sth->execute($titulo,$contenido); 
        
$sth ->finish;
$dbh->disconnect;  
