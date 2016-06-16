Please click "README" for information on these files.

<?php

$dir="/homes/nedoren/public_html/latex/textips_docs"; // Directory where files are stored

if ($dir_list = opendir($dir))
{
while(($filename = readdir($dir_list)) !== false)
{
if ($filename == ".") continue;
if ($filename == "..") continue;
if ($filename == "index.php") continue;
?>
<p><a href="<?php echo $filename; ?>"><?php echo $filename;
?></a></p>
<?php
}
closedir($dir_list);
}

?>

