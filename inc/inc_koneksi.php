<?php 
$host       = "db";
$user       = "root";
$pass       = "rootpassword";
$db         = "exampledb";

$koneksi    = mysqli_connect($host,$user,$pass,$db);
if(!$koneksi){
    die("Gagal terkoneksi");
}