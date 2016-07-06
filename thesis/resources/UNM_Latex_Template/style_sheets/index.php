Please click "README" for information on these files. <br>
<br>

<FONT COLOR="FA0404">
IMPORTANT UPDATE: August 26, 2011: <br>
The unmeethesis.cls style within this directory now conforms <br>
to the new OGS requirement elminiating the title page red box <br>
and the abstract title page!  If you are using the old style sheet,<br>
you can replace it with this new unmeethesis.cls for conformance. <br>
The rest of your document will remain unchanged. <br>
</font>
N. Doren - nedoren@sandia.gov

<?php

$dir="/homes/nedoren/public_html/latex/style_sheets"; // Directory where files are stored

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

