#!C:\xampp\perl\bin\perl.exe
use strict;
use warnings;
use DBI;
use CGI;

my $q = CGI->new;
my $titulo=$q->param("titulo");
my $contenido;

my $database = "wiki";
my $host = "localhost";
my $port = "3306";
my $user = "root";
my $pw = "71950727joe#";
my $dsn = "BDI:MariaDB:$database:$host:$port";
    
my $dbh = DBI ->connect($dsn,$user,$pw) or die ("No se pudo conectar");
my $sth = $dbh->prepare("DELETE FROM wiki WHERE Titulo=?" );

$sth->execute($titulo) or die "error"; 
$sth -> finish;
$dbh -> disconnect;   

print $q->redirect("list.pl");
