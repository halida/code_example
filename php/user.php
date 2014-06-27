<?php
echo $_SERVER['HTTP_USER_AGENT'];

echo '<br>';

if (strpos($_SERVER['HTTP_USER_AGENT'], 'MSIE') !== FALSE) {
    echo 'You are using Internet Explorer.<br />';
}
else {
    echo 'not usning ie';
}

?>