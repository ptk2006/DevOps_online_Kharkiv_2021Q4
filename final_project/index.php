<?php
  date_default_timezone_set("Europe/Kiev");
  $ch = curl_init();
  curl_setopt($ch, CURLOPT_URL, "http://169.254.169.254/metadata/instance/network/interface/0/ipv4/ipAddress/0/publicIpAddress?api-version=2017-08-01&format=text");
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
  curl_setopt($ch, CURLOPT_HTTPHEADER, array('Metadata: true'));
  curl_setopt($ch, CURLOPT_PROXY, '');
  $data = curl_exec($ch);
  curl_close($ch);
  $ch = curl_init();
  curl_setopt($ch, CURLOPT_URL, "http://169.254.169.254/metadata/instance/compute/name?api-version=2021-01-01&format=text");
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
  curl_setopt($ch, CURLOPT_HTTPHEADER, array('Metadata: true'));
  curl_setopt($ch, CURLOPT_PROXY, '');
  $data2 = curl_exec($ch);
  curl_close($ch);
  echo "Public IP: $data\n" . "<br>";
  echo "VMname: $data2\n" . "<br>";
  echo "Today is " . date("d.m.Y") . date(" l") . "<br>";
  echo "The time is " . date("H:i:s"). "<br>";
  echo "It works!!!";
  echo " Job has done!!!";
?>
