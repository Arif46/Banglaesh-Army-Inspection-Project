--- 12-12-2022
ALTER TABLE `portal_services` ADD `policy_attachment` VARCHAR(255) NULL DEFAULT NULL AFTER `form_attachment`;
ALTER TABLE `portal_service_permissions` ADD `pr_policy` TINYINT NOT NULL DEFAULT '1' AFTER `pr_rating`;
--above sql already run in live db

-- 26-1-2023
ALTER TABLE `master_countries` ADD `nationality` VARCHAR(100) NULL DEFAULT NULL AFTER `country_name_bn`, ADD `nationality_bn` VARCHAR(100) NULL DEFAULT NULL AFTER `nationality`;
