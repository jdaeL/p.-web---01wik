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
    <title>Listado de paginas</title>
</head>
<body>
    <h1>Nuestras Paginas Wiki</h1>
          
HTML

my $database = "wiki";
my $host = "localhost";
my $port = "3306";
my $user = "root";
my $pw = "71950727joe#";
my $dsn = "BDI:MariaDB:$database:$host:$port";
    
my $dbh = DBI ->connect($dsn,$user,$pw) or die ("No se pudo conectar");
 
my $sth = $dbh->prepare("SELECT titulo FROM wiki" );

$sth->execute or die "error";

print "<ol>";
while(my @row=$sth->fetchrow_array){
    print <<HTML;
    <form>
        <li><a href="view.pl?titulo=$row[0]">$row[0]</a><a href="edit.pl?titulo=$row[0]">E</a><a href="delete.pl?titulo=$row[0]">X</a></li>
    </form>
HTML
}
 
$sth -> finish;
$dbh -> disconnect;                         

print <<HTML;
<br>
    <div>
       <a href="new.pl">Nueva pagina</a>
       <a href="./index.html">Volver al inicio </a>
    </div>
HTML
