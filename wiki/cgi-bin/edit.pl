#!C:\xampp\perl\bin\perl.exe
use strict;
use warnings;
use DBI;
use CGI;

my $q = CGI->new;
my $titulo=$q->param("titulo");
my $nuevoContenido=$q->param("nuevoContenido");
my $contenido;

my $database = "wiki";
my $host = "localhost";
my $port = "3306";
my $user = "root";
my $pw = "71950727joe#";
my $dsn = "BDI:MariaDB:$database:$host:$port";
    
my $dbh = DBI ->connect($dsn,$user,$pw) or die ("No se pudo conectar");
my $sth;

if(defined $nuevoContenido){
    $sth = $dbh->prepare("UPDATE wiki SET Pagina=? WHERE Titulo=?" );
    $sth->execute($nuevoContenido,$titulo) or die "error"; 
}

$sth = $dbh->prepare("SELECT Titulo,Pagina FROM wiki" );
$sth->execute or die "error"; 

while(my @row=$sth->fetchrow_array){
    if($row[0] eq $titulo){
        $contenido=$row[1];
    }
}
$sth ->finish;
$dbh ->disconnect;   


print <<HTML;
<!DOCTYPE html>
<html>
<head>
    
    <link rel="stylesheet" type="text/css" href="../estilosPerl124.css">
    <title>EDIT</title>
</head>
<body>
    <form action="edit.pl" method="get">
        <h1>$titulo<h1>
        <p>texto</p>
        <textarea name="nuevoContenido">$contenido</textarea>
        <input name="titulo" type="text" value="$titulo" style="display:none;">
        <input type="submit">
    </form>
    <br>
    <a href="list.pl">cancelar</a>
HTML
if(defined $nuevoContenido){
    print "<h1>Actualizado con exito</h1>";
}
print <<HTML;
</body>
</html>
HTML

