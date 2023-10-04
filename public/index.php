<?php

require_once __DIR__ . '/../vendor/autoload.php';

use Template\ThingThatSaysHelloWorld;

echo (new ThingThatSaysHelloWorld())->sayHelloWorld();
