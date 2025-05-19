<?php
/**
 * This function is called on installation and is used to create database schema for the plugin
 */
function extension_install_location()
{
    $commonObject = new ExtensionCommon;

    $commonObject->sqlQuery("CREATE TABLE IF NOT EXISTS `location` (
        `ID` INT(11) NOT NULL AUTO_INCREMENT,
        `HARDWARE_ID` INT(11) NOT NULL,
        `PERMISSION` VARCHAR(255) DEFAULT NULL,
        `LATITUDE` VARCHAR(255) DEFAULT NULL,
        `LONGITUDE` VARCHAR(255) DEFAULT NULL,
        `ALTITUDE` VARCHAR(255) DEFAULT NULL,
        `HORIZONTALACCURACY` VARCHAR(255) DEFAULT NULL,
        `VERTICALACCURACY` VARCHAR(255) DEFAULT NULL,
        `SPEED` VARCHAR(255) DEFAULT NULL,
        PRIMARY KEY (`ID`, `HARDWARE_ID`)
      ) ENGINE=INNODB;");
}

/**
 * This function is called on removal and is used to destroy database schema for the plugin
 */
function extension_delete_location()
{
    $commonObject = new ExtensionCommon;
    $commonObject->sqlQuery("DROP TABLE `location`;");
}

/**
 * This function is called on plugin upgrade
 */
function extension_upgrade_location()
{
    // Placeholder for future upgrades
}