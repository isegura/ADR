



-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'Drug'
-- ESta tabla solo contiene principios activos (generic drugs)
-- ---

-- ---
-- Table 'has_externalIDEffect'
-- 
-- ---
-- ---
-- Table 'has_ATC'
-- contiene las relaciones entre fármaco y sus códigos atc; un fármaco puede tener varios códigos atc
-- ---

DROP TABLE IF EXISTS `has_ATC`;
		
CREATE TABLE `has_ATC` (
  `idATC` VARCHAR(6) NOT NULL,
  `drugId` INT NOT NULL,
  PRIMARY KEY (`idATC`, `drugId`)
) COMMENT 'contiene las relaciones entre fármaco y sus códigos atc; un ';

-- ---
-- Table 'has_externalIDDrug'
-- contiene los linking con otras bases de datos
-- ---

DROP TABLE IF EXISTS `has_externalIDDrug`;
		
CREATE TABLE `has_externalIDDrug` (
  `drugId` INT NOT NULL,
  `idExternal` VARCHAR(15) NOT NULL,
  `source` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`drugId`, `idExternal`)
) COMMENT 'contiene los linking con otras bases de datos';



DROP TABLE IF EXISTS `DrugEffect`;
		
CREATE TABLE `DrugEffect` (
  `drugId` INT NOT NULL,
  `effectId` INT NOT NULL,
  `effectTypeId` INT NOT NULL,
  PRIMARY KEY (`drugId`, `effectId`, `effectTypeId`)
);

-- ---
-- Table 'DrugSynset'
-- Esta tabla contiene todos los posibles sinónimos. Puede haber sinónimos que sean brand y otros genéricos
-- ---

DROP TABLE IF EXISTS `DrugSynset`;
		
CREATE TABLE `DrugSynset` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `drugId` INT NOT NULL,
  `synName` VARCHAR(100) NOT NULL,
  `isBrand` BINARY DEFAULT '1',
  UNIQUE KEY (`drugId`, `synName`),
  PRIMARY KEY (`id`)
) COMMENT 'Esta tabla contiene todos los posibles sinónimos. Puede habe';

DROP TABLE IF EXISTS `Drug`;
		
CREATE TABLE `Drug` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `reviewed` BINARY DEFAULT '1',
  UNIQUE KEY (`name`),
  PRIMARY KEY (`id`)
) COMMENT 'ESta tabla solo contiene principios activos (generic drugs)';



DROP TABLE IF EXISTS `has_externalIDEffect`;
		
CREATE TABLE `has_externalIDEffect` (
  `effectId` INT NOT NULL,
  `idExternal` VARCHAR(15) NOT NULL,
  `source` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`effectId`, `idExternal`)
);

-- ---
-- Table 'EffectSynset'
-- 
-- ---

DROP TABLE IF EXISTS `EffectSynset`;
		
CREATE TABLE `EffectSynset` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `effectId` INT NOT NULL,
  `synName` VARCHAR(200) NOT NULL,
  UNIQUE KEY (`effectId`, `synName`),
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'Effect'
-- 
-- ---

DROP TABLE IF EXISTS `Effect`;
		
CREATE TABLE `Effect` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `reviewed` BINARY DEFAULT '1',
  UNIQUE KEY (`effectName`),
  PRIMARY KEY (`id`)
);



-- ---
-- Table 'EffectTypes'
-- puede ser indication o side effect
-- ---

DROP TABLE IF EXISTS `EffectTypes`;
		
CREATE TABLE `EffectTypes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `effectTypeName` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY (`effectTypeName`)
) COMMENT 'puede ser indication o side effect';



-- ---
-- Table 'ATCCodes'
-- Contiene todos los Codigos ATC y sus descripciones
-- ---

DROP TABLE IF EXISTS `ATCCodes`;
		
CREATE TABLE `ATCCodes` (
  `idATC` VARCHAR(6) NOT NULL,
  `description` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idATC`)
) COMMENT 'Contiene todos los Codigos ATC y sus descripciones';


-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `DrugEffect` ADD FOREIGN KEY (drugId) REFERENCES `Drug` (`id`);
ALTER TABLE `DrugEffect` ADD FOREIGN KEY (effectId) REFERENCES `Effect` (`id`);
ALTER TABLE `DrugEffect` ADD FOREIGN KEY (effectTypeId) REFERENCES `EffectTypes` (`id`);
ALTER TABLE `DrugSynset` ADD FOREIGN KEY (drugId) REFERENCES `Drug` (`id`);
ALTER TABLE `EffectSynset` ADD FOREIGN KEY (drugEffectId) REFERENCES `Effect` (`id`);
ALTER TABLE `has_ATC` ADD FOREIGN KEY (idATC) REFERENCES `ATCCodes` (`idATC`);
ALTER TABLE `has_ATC` ADD FOREIGN KEY (drugId) REFERENCES `Drug` (`id`);
ALTER TABLE `has_externalIDDrug` ADD FOREIGN KEY (drugId) REFERENCES `DrugSynset` (`id`);
ALTER TABLE `has_externalIDEffect` ADD FOREIGN KEY (effectId) REFERENCES `EffectSynset` (`id`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `Drug` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `DrugEffect` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Effect` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `DrugSynset` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `EffectTypes` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `EffectSynset` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `has_ATC` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `ATCCodes` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `has_externalIDDrug` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `has_externalIDEffect` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `Drug` (`id`,`name`,`reviewed`) VALUES
-- ('','','');
-- INSERT INTO `DrugEffect` (`drugId`,`effectId`,`effectTypeId`) VALUES
-- ('','','');
-- INSERT INTO `Effect` (`id`,`effectName`,`reviewed`) VALUES
-- ('','','');
-- INSERT INTO `DrugSynset` (`id`,`drugId`,`synName`,`isBrand`) VALUES
-- ('','','','');
-- INSERT INTO `EffectTypes` (`id`,`effectTypeName`) VALUES
-- ('','');
-- INSERT INTO `EffectSynset` (`id`,`drugEffectId`,`drugEffectSynName`) VALUES
-- ('','','');
-- INSERT INTO `has_ATC` (`idATC`,`drugId`) VALUES
-- ('','');
-- INSERT INTO `ATCCodes` (`idATC`,`description`) VALUES
-- ('','');
-- INSERT INTO `has_externalIDDrug` (`drugId`,`idExternal`,`source`) VALUES
-- ('','','');
-- INSERT INTO `has_externalIDEffect` (`effectId`,`idExternal`,`source`) VALUES
-- ('','','');

