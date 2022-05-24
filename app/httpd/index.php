<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Docker Training - MongoDB Counter v21.10</title></head><body><p>
<?php
$namespace = "training.counter";
$filter= ['_id' => 1];

if (!empty(getenv('MONGO_CS_FILE'))) {
    $ConnectionString = str_replace(chr(10),"",file_get_contents(getenv('MONGO_CS_FILE')));
} elseif (!empty(getenv('MONGO_CS'))) {
    $ConnectionString = getenv('MONGO_CS');
} else {
    $ConnectionString = "mongodb://localhost:27017";
}

$manager = new MongoDB\Driver\Manager($ConnectionString);

$bulk = new MongoDB\Driver\BulkWrite(['ordered' => true]);
$bulk->update($filter, ['$inc' => ['val' => 1]], ['upsert' => 'true']);
try {
    $manager->executeBulkWrite($namespace, $bulk);
} catch (MongoDB\Driver\Exception\ConnectionException $e) {
    echo "Exception: ", $e->getMessage();
}

$query = new MongoDB\Driver\Query($filter);
$rows = $manager->executeQuery($namespace, $query);
foreach($rows as $r){
   echo "I have been seen " . $r->val . " times! <br />\r\n";
   echo "Response from: " . gethostname() . " \r\n";
}
?>
</p></body></html>