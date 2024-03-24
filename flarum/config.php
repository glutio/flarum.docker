<?php return array (
  'debug' => false,
  'database' => 
  array (
    'driver' => 'mysql',
    'host' => getenv('FLARUM_DB_HOST'),
    'port' => getenv('FLARUM_DB_PORT'),
    'database' => getenv('FLARUM_DB'),
    'username' => getenv('FLARUM_DB_USER'),
    'password' => getenv('FLARUM_DB_PASSWORD'),
    'charset' => 'utf8mb4',
    'collation' => 'utf8mb4_unicode_ci',
    'prefix' => NULL,
    'strict' => false,
    'engine' => 'InnoDB',
    'prefix_indexes' => true,
  ),
  'url' => getenv('FLARUM_URL'),
  'paths' => 
  array (
    'api' => 'api',
    'admin' => 'admin',
  ),
  'headers' => 
  array (
    'poweredByHeader' => true,
    'referrerPolicy' => 'same-origin',
  ),
);