ALTER TABLE `wmnsffunds`.`transfer_transaction` 
CHANGE COLUMN `id` `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '' ;
	
ALTER TABLE `wmnsffunds`.`transfer_transaction` 
ADD COLUMN `check_number` INT(16) NULL COMMENT '' AFTER `fund_type_id`,
ADD COLUMN `case_number` VARCHAR(45) NULL COMMENT '' AFTER `check_number`,
ADD COLUMN `ci_number` VARCHAR(45) NULL COMMENT '' AFTER `case_number`;


