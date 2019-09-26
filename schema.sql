-- --------------------------------------------------------
-- Host:                         instancia1.c0rsww6fazdz.us-east-1.rds.amazonaws.com
-- Versión del servidor:         5.7.21-log - MySQL Community Server (GPL)
-- SO del servidor:              Linux
-- HeidiSQL Versión:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Volcando estructura para tabla banana.attributes
CREATE TABLE IF NOT EXISTS `attributes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `type_attribute` varchar(1) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'S' COMMENT 'Tipo Select, Radio, Color (S, R, C)',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_attributes_users` (`created_by`),
  KEY `FK_attributes_users_2` (`updated_by`),
  CONSTRAINT `FK_attributes_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_attributes_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='Atributos para el uso en la creacion de productos';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.attribute_details
CREATE TABLE IF NOT EXISTS `attribute_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attribute_id` int(11) NOT NULL,
  `reference` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(45) CHARACTER SET latin1 NOT NULL,
  `color` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attribute_id` (`attribute_id`),
  KEY `FK_attribute_details_users` (`created_by`),
  KEY `FK_attribute_details_users_2` (`updated_by`),
  CONSTRAINT `FK_attribute_details_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_attribute_details_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `attribute_details_ibfk_1` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Detalles de un atributo. Opciones del atributo';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.attribute_detail_product_detail
CREATE TABLE IF NOT EXISTS `attribute_detail_product_detail` (
  `attribute_detail_id` int(11) NOT NULL,
  `product_detail_id` int(11) NOT NULL,
  PRIMARY KEY (`attribute_detail_id`,`product_detail_id`),
  KEY `FK_attribute_detail_product_detail_product_details` (`product_detail_id`),
  CONSTRAINT `FK_attribute_detail_product_detail_attribute_details` FOREIGN KEY (`attribute_detail_id`) REFERENCES `attribute_details` (`id`),
  CONSTRAINT `FK_attribute_detail_product_detail_product_details` FOREIGN KEY (`product_detail_id`) REFERENCES `product_details` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Relacion entre el detalle del atributo con el detalle del producto';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.audits
CREATE TABLE IF NOT EXISTS `audits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `table_id` int(10) unsigned NOT NULL,
  `type` varchar(50) NOT NULL,
  `context` text,
  `context_id` int(11) DEFAULT NULL,
  `module` varchar(50) DEFAULT NULL,
  `organization` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `mac_address` varchar(50) DEFAULT NULL,
  `ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_audits_users` (`user_id`),
  KEY `FK_audits_tables` (`table_id`),
  CONSTRAINT `FK_audits_tables` FOREIGN KEY (`table_id`) REFERENCES `tables` (`id`),
  CONSTRAINT `FK_audits_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1246 DEFAULT CHARSET=utf8 COMMENT='Auditoria de banana';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.bodies_reports
CREATE TABLE IF NOT EXISTS `bodies_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `context` text NOT NULL,
  `image_id` int(11) DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__users_body_report` (`created_by`),
  KEY `FK__users_2_body_report` (`updated_by`),
  CONSTRAINT `FK__users_2_body_report` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK__users_body_report` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cuerpo de los reportes';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.body_documents
CREATE TABLE IF NOT EXISTS `body_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reference_document` varchar(1000) NOT NULL,
  `reference` varchar(50) DEFAULT NULL,
  `product_detail_id` int(11) DEFAULT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `price` decimal(20,8) NOT NULL DEFAULT '0.00000000',
  `dimensions` varchar(50) DEFAULT '0' COMMENT 'Calculo de la dimension del producto, resultado es equivalente a la unidad',
  `quantity` int(11) NOT NULL DEFAULT '0',
  `discount` varchar(50) DEFAULT '0',
  `discount_cal` decimal(20,8) NOT NULL DEFAULT '0.00000000',
  `net_price` decimal(20,8) NOT NULL DEFAULT '0.00000000',
  `tax_id` int(11) DEFAULT NULL,
  `sale_rep_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_body_documents_bpartners` (`sale_rep_id`),
  KEY `FK_body_documents_warehouses` (`warehouse_id`),
  KEY `FK_body_documents_taxes` (`tax_id`),
  KEY `FK_body_documents_users` (`created_by`),
  KEY `FK_body_documents_users_2` (`updated_by`),
  KEY `FK_body_documents_product_details` (`product_detail_id`),
  KEY `FK_body_documents_documents` (`reference_document`),
  CONSTRAINT `FK_body_documents_bpartners` FOREIGN KEY (`sale_rep_id`) REFERENCES `bpartners` (`id`),
  CONSTRAINT `FK_body_documents_documents` FOREIGN KEY (`reference_document`) REFERENCES `documents` (`reference`),
  CONSTRAINT `FK_body_documents_product_details` FOREIGN KEY (`product_detail_id`) REFERENCES `product_details` (`id`),
  CONSTRAINT `FK_body_documents_taxes` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`),
  CONSTRAINT `FK_body_documents_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_body_documents_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_body_documents_warehouses` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8 COMMENT='Reglones de los documentos';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.body_report_organization
CREATE TABLE IF NOT EXISTS `body_report_organization` (
  `body_report_id` int(11) NOT NULL,
  `organization_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`body_report_id`,`organization_id`),
  KEY `foreign_key_b_r_o_org_id` (`organization_id`),
  CONSTRAINT `foreign_key_b_r_o_body_report_id` FOREIGN KEY (`body_report_id`) REFERENCES `bodies_reports` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `foreign_key_b_r_o_org_id` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Relacion entre el cuerpo del reporte y la organizacion';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.bpartners
CREATE TABLE IF NOT EXISTS `bpartners` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Business Partner id internal reference',
  `logo` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `cif` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `is_customer` tinyint(4) DEFAULT '0' COMMENT 'The customer checkbox indicates if this Business Partner is a customer. If it is select additional fields will display which further define this customer.\n\nfrom: Yes-No',
  `is_vendor` tinyint(4) DEFAULT '0' COMMENT 'The Vendor checkbox indicates if this Business Partner is a Vendor. If it is selected, additional fields will display which further identify this vendor.\n\nfrom: Yes-No',
  `alias` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `email` varchar(120) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `name` varchar(120) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL COMMENT 'Alphanumeric identifier of the entity',
  `name_2` varchar(120) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'additional name',
  `is_employee` tinyint(4) DEFAULT '0' COMMENT 'The Employee checkbox indicates if this Business Partner is an Employee. If it is selected, additional fields will display which further identify this employee.\n\nfrom: Yes-No',
  `is_prospect` tinyint(4) DEFAULT '0' COMMENT 'The Prospect checkbox indicates an entity that is an active prospect.\n\nfrom: Yes-No',
  `is_sales_rep` tinyint(4) DEFAULT '0' COMMENT 'The Sales Rep checkbox indicates if this business partner is a sales representative. A sales representative may also be an employee, but does not need to be.\n\nfrom: Yes-No',
  `reference_no` varchar(25) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'The reference number can be printed on orders and invoices to allow your business partner to faster identify your records.\n',
  `sales_rep_id` int(10) DEFAULT NULL COMMENT 'The Sales Representative indicates the Sales Rep for this state. Any Sales Rep must be a valid internal user.\n\nfrom: table',
  `credit_status` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'Credit Management is inactive if Credit Status is No Credit Check, Credit Stop or if the Credit Limit is 0.\nIf active, the status is set automatically set to Credit Hold, if the Total Open Balance (including Vendor activities) is higher then the Credit Limit. It is set to Credit Watch, if above 90% of the Credit Limit and Credit OK otherwise.\n\nfrom: list',
  `credit_limit` double DEFAULT NULL COMMENT '	The Credit Limit indicates the total amount allowed "on account" in primary accounting currency. If the Credit Limit is 0, no check is performed. Credit Management is based on the Total Open Amount, which includes Vendor activities.\n\namount',
  `total_open_balance` double DEFAULT '0' COMMENT 'The Total Open Balance Amount is the calculated open item amount for customer and Vendor activity. If the Balance is below zero, we owe the Business Partner. The amount is used for Credit Management.\nInvoices and Payment Allocations determine the Open Balance (i.e. not Orders or Payments).',
  `tax_id` int(11) DEFAULT NULL COMMENT 'The Tax id field identifies the legal Identification number of this Entity.(NIF, ITIN)',
  `is_tax_exempt` tinyint(4) DEFAULT '0' COMMENT 'If a business partner is exempt from tax on sales, the exempt tax rate is used. For this, you need to set up a tax rate with a 0% rate and indicate that this is your tax exempt rate. This is required for tax reporting, so that you can track tax exempt transactions.\nYes-No',
  `is_po_tax_exempt` tinyint(4) DEFAULT '0' COMMENT '	If a business partner is exempt from tax on purchases, the exempt tax rate is used. For this, you need to set up a tax rate with a 0% rate and indicate that this is your tax exempt rate. This is required for tax reporting, so that you can track tax exempt transactions.\nYes-No',
  `url` varchar(120) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'The url defines an fully qualified web address like http://www.domain.com',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'A description is limited to 255 characters.',
  `is_summary` tinyint(4) DEFAULT '0' COMMENT 'A summary entity represents a branch in a tree rather than an end-node. Summary entities are used for reporting and do not have own values.\nYes-No\n',
  `archived` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.\nThere are two reasons for de-activating and not deleting records: (1) The system requires the record for audit purposes. (2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.\nYes-No\n',
  `price_list_id` int(10) DEFAULT NULL COMMENT 'Price Lists are used to determine the pricing, margin and cost of items purchased or sold.\n\nfrom: Table Direct',
  `delivery_rule` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'The Delivery Rule indicates when an order should be delivered. For example should the order be delivered when the entire order is complete, when a line is complete or as the products become available.\n\nfrom:list',
  `delivery_via_rule` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'The Delivery Via indicates how the products should be delivered. For example, will the order be picked up or shipped.\n\nlist\n\nOJO PREFIERO CAMBIAR ESTO POR UNA TABA',
  `flat_discount` double DEFAULT NULL COMMENT 'Flat discount percentage',
  `is_manufacturer` tinyint(4) DEFAULT '0' COMMENT 'Indicate role of this Business partner as Manufacturer',
  `po_price_list_id` int(10) DEFAULT NULL COMMENT 'Identifies the price list used by a Vendor for products purchased by this organization.',
  `language_id` int(11) DEFAULT NULL COMMENT 'The Language identifies the language to use for display and formatting documents. It requires, that on client level, Multi-Lingual documents are selected and that you have created/loaded the language.\n\nfrom: table',
  `greeting_id` int(10) DEFAULT NULL COMMENT 'The Greeting identifies the greeting to print on correspondence.',
  `currency_id` int(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cif_UNIQUE` (`cif`),
  UNIQUE KEY `reference_no` (`reference_no`),
  KEY `foreign_language_id_idx` (`language_id`),
  KEY `foreign_sales_rep_id_idx` (`sales_rep_id`),
  KEY `FK_bpartners_users` (`created_by`),
  KEY `FK_bpartners_users_2` (`updated_by`),
  KEY `FK_bpartners_taxes` (`tax_id`),
  KEY `FK_bpartners_price_lists` (`price_list_id`),
  KEY `FK_bpartners_currencies` (`currency_id`),
  CONSTRAINT `FK_bpartners_currencies` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`),
  CONSTRAINT `FK_bpartners_price_lists` FOREIGN KEY (`price_list_id`) REFERENCES `price_lists` (`id`),
  CONSTRAINT `FK_bpartners_taxes` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`),
  CONSTRAINT `FK_bpartners_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_bpartners_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `foreign_language_id` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `foreign_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `bpartners` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1661 DEFAULT CHARSET=utf8 COMMENT='Business Partners (socio comercial) La tabla Business Partner le permite definir a cualquier parte con quien realice transacciones. Esto incluye clientes, vendedores y empleados. ';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.bpartner_contact
CREATE TABLE IF NOT EXISTS `bpartner_contact` (
  `bpartner_id` int(11) NOT NULL,
  `contact_id` int(10) NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`bpartner_id`,`contact_id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `foreign_bpartner_contact_contact_id_idx` (`contact_id`),
  CONSTRAINT `FK_bpartner_contact_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `foreign_bpartner_contact_bpartner_id` FOREIGN KEY (`bpartner_id`) REFERENCES `bpartners` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `foreign_bpartner_contact_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='relacion entre el tercero y contactos.\r\nSon los contactos del tercero, estos contactos pueden tener acceso a banana mediante a un usuario';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.bpartner_locations
CREATE TABLE IF NOT EXISTS `bpartner_locations` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `bpartner_id` int(10) NOT NULL,
  `location_id` int(10) NOT NULL,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL COMMENT 'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',
  `archived` tinyint(4) DEFAULT '0' COMMENT 'There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.\nThere are two reasons for de-activating and not deleting records: (1) The system requires the record for audit purposes. (2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.\nYes-No',
  `is_ship_to` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'If the Ship address is selected, the location is used to ship goods to a customer or receive goods from a vendor.',
  `is_bill_to` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'If the Invoice address is selected, the location is used to send invoices to a customer or receive invoices from a vendor.',
  `is_pay_from` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'If the Pay-From address is selected, this location is the address the Business Partner pays from and where dunning letters will be sent to.',
  `is_remit_to` tinyint(4) NOT NULL COMMENT 'If the Remit-To address is selected, the location is used to send payments to the vendor.',
  `phone` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'The phone field identifies a telephone number',
  `phone_2` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'The 2nd phone field identifies an alternate telephone number.',
  `fax` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'The fax identifies a facsimile number for this Business Partner or Location',
  `isdn` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `principal` tinyint(4) DEFAULT '0',
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_bpartner_locations_location_id_bpartner_id` (`location_id`,`bpartner_id`),
  KEY `fk_BPartner_Locations_Locations1_idx` (`location_id`),
  KEY `foreign_bpartner_location_id_idx` (`bpartner_id`),
  KEY `FK_bpartner_locations_users` (`created_by`),
  KEY `FK_bpartner_locations_users_2` (`updated_by`),
  CONSTRAINT `FK_bpartner_locations_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_bpartner_locations_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `foreign_bpartner_location_bpartner_id` FOREIGN KEY (`bpartner_id`) REFERENCES `bpartners` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `foreign_bpartner_location_location_id` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1798 DEFAULT CHARSET=utf8 COMMENT='Define Location\n The Location Tab defines the physical location of a business partner. A business partner may have multiple location records.';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.bpartner_location_contact
CREATE TABLE IF NOT EXISTS `bpartner_location_contact` (
  `bpartner_location_id` int(10) NOT NULL,
  `contact_id` int(10) NOT NULL,
  PRIMARY KEY (`bpartner_location_id`,`contact_id`),
  KEY `foreign_branch_contact_id_idx` (`contact_id`),
  CONSTRAINT `foreign_branch_branch_id` FOREIGN KEY (`bpartner_location_id`) REFERENCES `bpartner_locations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `foreign_branch_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contactos de la sucursal del tercero';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.bpartner_module
CREATE TABLE IF NOT EXISTS `bpartner_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bpartner_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `create_at` timestamp NULL DEFAULT NULL,
  `expire_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bpartner_id_module_id` (`bpartner_id`,`module_id`),
  KEY `foreing_key_modules_id` (`module_id`),
  CONSTRAINT `foreing_key_bpartners_id` FOREIGN KEY (`bpartner_id`) REFERENCES `bpartners` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `foreing_key_modules_id` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 COMMENT='Modulos banana que tiene el tercero asociado';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 NOT NULL,
  `parent_id` int(10) DEFAULT NULL COMMENT 'Si una categoria pertenece a otra. NO puede pertenecer a si misma',
  `color` varchar(45) CHARACTER SET utf8mb4 DEFAULT NULL,
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categories_parent_id_foreign` (`parent_id`),
  KEY `FK_categories_users` (`created_by`),
  KEY `FK_categories_users_2` (`updated_by`),
  CONSTRAINT `FK_categories_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_categories_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8 COMMENT='Categorias para la agrupacion de productos';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.charges
CREATE TABLE IF NOT EXISTS `charges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  `report_to` int(11) DEFAULT NULL COMMENT 'a que cargo reporta este cargo.',
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_charges_charges` (`report_to`),
  KEY `FK_charges_users` (`created_by`),
  KEY `FK_charges_users_2` (`updated_by`),
  CONSTRAINT `FK_charges_charges` FOREIGN KEY (`report_to`) REFERENCES `charges` (`id`),
  CONSTRAINT `FK_charges_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_charges_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='Cargos que maneja la organizacion en su area de trabajo';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.child_table
CREATE TABLE IF NOT EXISTS `child_table` (
  `table_id` int(10) unsigned NOT NULL,
  `child_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`table_id`,`child_id`),
  KEY `FK_child_table_tables_2` (`child_id`),
  CONSTRAINT `FK_child_table_tables` FOREIGN KEY (`table_id`) REFERENCES `tables` (`id`),
  CONSTRAINT `FK_child_table_tables_2` FOREIGN KEY (`child_id`) REFERENCES `tables` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Indica que tabla pertenece a otra para su uso en la migracion';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.cities
CREATE TABLE IF NOT EXISTS `cities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `state_id` int(10) unsigned NOT NULL,
  `city` varchar(45) CHARACTER SET utf8mb4 NOT NULL,
  `capital` tinyint(1) DEFAULT '0',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cities_state_id_foreign` (`state_id`),
  KEY `FK_cities_users` (`created_by`),
  KEY `FK_cities_users_2` (`updated_by`),
  CONSTRAINT `FK_cities_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_cities_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `cities_state_id_foreign` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=512 DEFAULT CHARSET=utf8 COMMENT='Ciudades';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.columns
CREATE TABLE IF NOT EXISTS `columns` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table_id` int(10) unsigned NOT NULL COMMENT 'Tabla a la que pertenece',
  `column_type_id` int(11) unsigned DEFAULT NULL COMMENT 'tipo de columna. String, number, date, etc',
  `column_name` varchar(45) CHARACTER SET utf8mb4 NOT NULL,
  `description` varchar(45) CHARACTER SET utf8mb4 DEFAULT NULL,
  `is_reference` tinyint(4) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `columns_table_id_foreign` (`table_id`),
  KEY `foreign_column_type_foreign_idx` (`column_type_id`),
  CONSTRAINT `columns_table_id_foreign` FOREIGN KEY (`table_id`) REFERENCES `tables` (`id`),
  CONSTRAINT `foreign_column_type_foreign` FOREIGN KEY (`column_type_id`) REFERENCES `column_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=997 DEFAULT CHARSET=utf8 COMMENT='Indica las columnas usadas para la permisologia de banana';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.column_type
CREATE TABLE IF NOT EXISTS `column_type` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='tipos de columna para la creacion de columnas dinamicas en formularios';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.conditions
CREATE TABLE IF NOT EXISTS `conditions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET latin1 DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_conditions_users` (`created_by`),
  KEY `FK_conditions_users_2` (`updated_by`),
  CONSTRAINT `FK_conditions_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_conditions_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Condicion/estado de los productos';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.contacts
CREATE TABLE IF NOT EXISTS `contacts` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL COMMENT 'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'A description is limited to 255 characters.',
  `comments` text CHARACTER SET utf8 COLLATE utf8_spanish_ci COMMENT 'The comments field allows for free form entry of additional information.',
  `archived` tinyint(4) DEFAULT '0',
  `email` varchar(60) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'The Email address is the Electronic Mail id for this User and should be fully qualified (e.g. joe.smith@company.com). The Email address is used to access the self service application functionality from the web.',
  `phone` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'The phone field identifies a telephone number',
  `phone_2` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'The 2nd phone field identifies an alternate telephone number.',
  `fax` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'The fax identifies a facsimile number for this Business Partner or Location',
  `title` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'The Title indicates the name that an entity is referred to as.',
  `charge` int(11) DEFAULT NULL,
  `birthday` date DEFAULT NULL COMMENT 'Birthday or Anniversary day',
  `last_contact` date DEFAULT NULL COMMENT 'The Last Contact indicates the date that this Business Partner Contact was last contacted.',
  `last_result` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'The Last Result identifies the result of the last contact made.',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_contacts_charges` (`charge`),
  KEY `FK_contacts_users` (`created_by`),
  KEY `FK_contacts_users_2` (`updated_by`),
  CONSTRAINT `FK_contacts_charges` FOREIGN KEY (`charge`) REFERENCES `charges` (`id`),
  CONSTRAINT `FK_contacts_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_contacts_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8 COMMENT='Maintain Contacts\nThe Contact Window allows you to maintain Contacts who are individuals you deal with. Contacts may also be internal or external users who can log into the system and have access to functionality via one or more roles. A contact can also be a business partner contact.';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.contact_organization
CREATE TABLE IF NOT EXISTS `contact_organization` (
  `contact_id` int(10) NOT NULL,
  `organization_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`contact_id`,`organization_id`),
  KEY `foreign_organization_id_idx` (`organization_id`),
  CONSTRAINT `foreign_contact_organization_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `foreign_contact_organization_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A que organizacion pertenece este contacto';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.counter_series
CREATE TABLE IF NOT EXISTS `counter_series` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_document_id` int(11) DEFAULT NULL COMMENT 'enlace al tipo de documento',
  `serie` varchar(25) NOT NULL COMMENT 'serie a la que pertenece el contado (cada serie tendra su propio contador)',
  `counter` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'último número de documento usado',
  `name` varchar(50) DEFAULT NULL COMMENT 'descripcion o nombre de la serie',
  `organization_id` int(10) unsigned DEFAULT NULL COMMENT 'Organización a la que pertenece esa serie\\\\n',
  `user_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `is_default_serie` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `type_document_id_serie` (`type_document_id`,`serie`),
  KEY `fk_counter_series_type_documents1_idx` (`type_document_id`),
  KEY `fk_counter_series_organizations1_idx` (`organization_id`),
  KEY `FK_counter_series_users` (`created_by`),
  KEY `FK_counter_series_users_2` (`updated_by`),
  KEY `FK_counter_series_users_3` (`user_id`),
  CONSTRAINT `FK_counter_series_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_counter_series_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_counter_series_users_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_counter_series_organizations1` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_counter_series_type_documents1` FOREIGN KEY (`type_document_id`) REFERENCES `type_documents` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='Series y Contadores\nIndica los contadores para cada serie que se asignan a cada documento\na su vez cada serie es asignada a cada organización';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.countries
CREATE TABLE IF NOT EXISTS `countries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iso` varchar(2) CHARACTER SET utf8mb4 NOT NULL,
  `country` varchar(45) CHARACTER SET utf8mb4 NOT NULL,
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `countries_iso_unique` (`iso`),
  UNIQUE KEY `countries_country_unique` (`country`),
  KEY `FK_countries_users` (`created_by`),
  KEY `FK_countries_users_2` (`updated_by`),
  CONSTRAINT `FK_countries_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_countries_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=362 DEFAULT CHARSET=utf8 COMMENT='Paises';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.currencies
CREATE TABLE IF NOT EXISTS `currencies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `isocode` varchar(3) CHARACTER SET latin1 DEFAULT NULL,
  `language` varchar(3) CHARACTER SET latin1 DEFAULT NULL,
  `name` varchar(45) CHARACTER SET latin1 NOT NULL,
  `money` varchar(45) CHARACTER SET latin1 DEFAULT NULL,
  `symbol` varchar(3) CHARACTER SET latin1 DEFAULT NULL,
  `archived` tinyint(4) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_currencies_users` (`created_by`),
  KEY `FK_currencies_users_2` (`updated_by`),
  CONSTRAINT `FK_currencies_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_currencies_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='Monedas. Necesario para lista de precios, documentos etc';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.custom_column
CREATE TABLE IF NOT EXISTS `custom_column` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `table_id` int(10) unsigned NOT NULL,
  `type_id` int(11) unsigned NOT NULL,
  `name` varchar(45) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`),
  KEY `foreing_tableid_idx` (`table_id`),
  CONSTRAINT `foreing_tableid` FOREIGN KEY (`table_id`) REFERENCES `tables` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='columnas creadas indicando a que tabla pertenece y su tipo';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.custom_column_value
CREATE TABLE IF NOT EXISTS `custom_column_value` (
  `number_value` double DEFAULT NULL,
  `string_value` text CHARACTER SET latin1,
  `date` date DEFAULT NULL,
  `custom_column_id` int(11) NOT NULL,
  `context_id` int(11) NOT NULL,
  `bool_value` tinyint(4) DEFAULT NULL,
  KEY `foreign_custom_column_id_idx` (`custom_column_id`),
  CONSTRAINT `foreign_custom_column_id` FOREIGN KEY (`custom_column_id`) REFERENCES `custom_column` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='valor de la columna creada en custom_value';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.databases
CREATE TABLE IF NOT EXISTS `databases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `host` varchar(100) NOT NULL,
  `user` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `driver` varchar(25) NOT NULL,
  `dns` varchar(100) NOT NULL,
  `name_conecction` varchar(50) NOT NULL,
  `bpartner_id` int(11) NOT NULL,
  `storage_type` varchar(45) DEFAULT 'HOST',
  `autorization_token_storage` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dns` (`dns`),
  UNIQUE KEY `bpartner_id` (`bpartner_id`),
  CONSTRAINT `foeing_key_bpartner_database` FOREIGN KEY (`bpartner_id`) REFERENCES `bpartners` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COMMENT='Credenciales de las base de datos de los terceros';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.discounts
CREATE TABLE IF NOT EXISTS `discounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `print_name` varchar(20) DEFAULT NULL,
  `validfrom` date DEFAULT NULL,
  `rate` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `notes` text,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_discounts_users` (`created_by`),
  KEY `FK_discounts_users_2` (`updated_by`),
  CONSTRAINT `FK_discounts_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_discounts_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tasa de descuentos';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.discounts_footers_documents
CREATE TABLE IF NOT EXISTS `discounts_footers_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discount` varchar(50) NOT NULL DEFAULT '0',
  `discount_cal` decimal(20,8) NOT NULL DEFAULT '0.00000000',
  `remainder` decimal(20,8) DEFAULT '0.00000000',
  `description` varchar(50) NOT NULL DEFAULT '',
  `footer_document_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_discounts_footers_documents_footer_documents` (`footer_document_id`),
  CONSTRAINT `FK_discounts_footers_documents_footer_documents` FOREIGN KEY (`footer_document_id`) REFERENCES `footer_documents` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COMMENT='Discuentos y cargos aplicados al pie del documento';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.discount_type_document
CREATE TABLE IF NOT EXISTS `discount_type_document` (
  `discount_id` int(11) NOT NULL,
  `type_document_id` int(11) NOT NULL,
  PRIMARY KEY (`discount_id`,`type_document_id`),
  KEY `fk_discount_type_document_type_document_idx` (`type_document_id`),
  CONSTRAINT `fk_discount_type_document_discount` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_discount_type_document_type_document` FOREIGN KEY (`type_document_id`) REFERENCES `type_documents` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Relacion entre el descuento y los documentos de forma predeterminada';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.documents
CREATE TABLE IF NOT EXISTS `documents` (
  `id` int(11) NOT NULL COMMENT 'El numero del id segun el valor del contador de la serie',
  `counter_serie_id` int(11) NOT NULL,
  `type_document_id` int(11) NOT NULL,
  `bpartner_id` int(11) NOT NULL,
  `reference` varchar(1000) NOT NULL COMMENT 'llave primaria del documento, segun nombre de la serie y el contador',
  `header_project_id` int(11) NOT NULL,
  `address` mediumtext,
  `valid_from` date DEFAULT NULL,
  `valid_until` date DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `sale_represent_id` int(11) DEFAULT NULL,
  `price_list_id` int(11) DEFAULT NULL,
  `currency_client` int(11) DEFAULT NULL,
  `currency_document` int(11) DEFAULT NULL,
  `rate` decimal(20,8) DEFAULT '0.00000000',
  `status_id` int(11) NOT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`reference`),
  UNIQUE KEY `id_counter_serie_id` (`id`,`counter_serie_id`),
  KEY `FK__header_projects` (`header_project_id`),
  KEY `FK__counter_series` (`counter_serie_id`),
  KEY `FK_documents_users` (`created_by`),
  KEY `FK_documents_users_2` (`updated_by`),
  KEY `FK_documents_status` (`status_id`),
  KEY `FK_documents_warehouses` (`warehouse_id`),
  KEY `FK_documents_bpartners` (`sale_represent_id`),
  KEY `FK_documents_price_lists` (`price_list_id`),
  KEY `FK_documents_currencies` (`currency_client`),
  KEY `FK_documents_currencies_2` (`currency_document`),
  KEY `FK_documents_type_documents` (`type_document_id`),
  KEY `FK_documents_bpartners_2` (`bpartner_id`),
  CONSTRAINT `FK__counter_series` FOREIGN KEY (`counter_serie_id`) REFERENCES `counter_series` (`id`),
  CONSTRAINT `FK__header_projects` FOREIGN KEY (`header_project_id`) REFERENCES `header_projects` (`id`),
  CONSTRAINT `FK_documents_bpartners` FOREIGN KEY (`sale_represent_id`) REFERENCES `bpartners` (`id`),
  CONSTRAINT `FK_documents_bpartners_2` FOREIGN KEY (`bpartner_id`) REFERENCES `bpartners` (`id`),
  CONSTRAINT `FK_documents_currencies` FOREIGN KEY (`currency_client`) REFERENCES `currencies` (`id`),
  CONSTRAINT `FK_documents_currencies_2` FOREIGN KEY (`currency_document`) REFERENCES `currencies` (`id`),
  CONSTRAINT `FK_documents_price_lists` FOREIGN KEY (`price_list_id`) REFERENCES `price_lists` (`id`),
  CONSTRAINT `FK_documents_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`),
  CONSTRAINT `FK_documents_type_documents` FOREIGN KEY (`type_document_id`) REFERENCES `type_documents` (`id`),
  CONSTRAINT `FK_documents_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_documents_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_documents_warehouses` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cotizaciones, presupuestos, pedidos, facturas, etc';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.field_configurations
CREATE TABLE IF NOT EXISTS `field_configurations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `position` int(10) unsigned NOT NULL,
  `input_type_id` int(10) NOT NULL,
  `required` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `column_id` int(10) DEFAULT NULL,
  `custom_column_id` int(10) DEFAULT NULL,
  `column_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `foreign_input_type_id_idx` (`input_type_id`),
  CONSTRAINT `foreign_input_type_id` FOREIGN KEY (`input_type_id`) REFERENCES `input_types` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COMMENT='Configuracion del input creado en custom_columns o de la columna en la tabla Columns';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.footers_reports
CREATE TABLE IF NOT EXISTS `footers_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `context` text NOT NULL,
  `image_id` int(11) DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__users_footer_report` (`created_by`),
  KEY `FK__users_2_footer_report` (`updated_by`),
  CONSTRAINT `FK__users_2_footer_report` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK__users_footer_report` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='pie de los reportes';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.footer_documents
CREATE TABLE IF NOT EXISTS `footer_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reference_document` varchar(1000) NOT NULL,
  `quantity_total` int(11) DEFAULT NULL,
  `gross_total` decimal(20,8) NOT NULL DEFAULT '0.00000000',
  `discount_total` decimal(20,8) NOT NULL DEFAULT '0.00000000',
  `tax_total` decimal(20,8) NOT NULL DEFAULT '0.00000000',
  `neto_total` decimal(20,8) NOT NULL DEFAULT '0.00000000',
  `internal_note` varchar(50) DEFAULT NULL,
  `client_note` varchar(50) DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_footer_documents_users` (`created_by`),
  KEY `FK_footer_documents_users_2` (`updated_by`),
  KEY `FK_footer_documents_documents` (`reference_document`),
  CONSTRAINT `FK_footer_documents_documents` FOREIGN KEY (`reference_document`) REFERENCES `documents` (`reference`),
  CONSTRAINT `FK_footer_documents_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_footer_documents_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8 COMMENT='Pie de los documentos. Indica los totales de los documentos';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.footer_grouped_taxes
CREATE TABLE IF NOT EXISTS `footer_grouped_taxes` (
  `tax` int(11) NOT NULL,
  `gross` decimal(20,8) NOT NULL DEFAULT '0.00000000',
  `total` decimal(20,8) NOT NULL DEFAULT '0.00000000',
  `footer_document_id` int(11) NOT NULL,
  PRIMARY KEY (`tax`,`footer_document_id`),
  KEY `FK_footer_grouped_taxes_footer_documents` (`footer_document_id`),
  CONSTRAINT `FK_footer_grouped_taxes_footer_documents` FOREIGN KEY (`footer_document_id`) REFERENCES `footer_documents` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='impuestos agrupados del pie de los documentos';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.footer_report_organization
CREATE TABLE IF NOT EXISTS `footer_report_organization` (
  `footer_report_id` int(11) NOT NULL,
  `organization_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`footer_report_id`,`organization_id`),
  KEY `foreign_key_f_r_o_org_id` (`organization_id`),
  CONSTRAINT `foreign_key_f_r_o_footer_report_id` FOREIGN KEY (`footer_report_id`) REFERENCES `footers_reports` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `foreign_key_f_r_o_org_id` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Indica que organizacion pertenece a pie del reporte';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.headers_reports
CREATE TABLE IF NOT EXISTS `headers_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `context` text NOT NULL,
  `image_id` int(11) DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__users_header_report` (`created_by`),
  KEY `FK__users_2_header_report` (`updated_by`),
  CONSTRAINT `FK__users_2_header_report` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK__users_header_report` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Cabecera de los reportes';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.header_projects
CREATE TABLE IF NOT EXISTS `header_projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bpartner_id` int(11) NOT NULL,
  `organization_id` int(10) unsigned NOT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__bpartners` (`bpartner_id`),
  KEY `FK_header_projects_users` (`created_by`),
  KEY `FK_header_projects_users_2` (`updated_by`),
  KEY `FK_header_projects_organizations` (`organization_id`),
  CONSTRAINT `FK__bpartners` FOREIGN KEY (`bpartner_id`) REFERENCES `bpartners` (`id`),
  CONSTRAINT `FK_header_projects_organizations` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`),
  CONSTRAINT `FK_header_projects_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_header_projects_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8 COMMENT='Maneja los documentos de los terceros como un proyecto';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.header_report_organization
CREATE TABLE IF NOT EXISTS `header_report_organization` (
  `header_report_id` int(11) NOT NULL,
  `organization_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`header_report_id`,`organization_id`),
  KEY `foreign_key_h_r_o_org_id` (`organization_id`),
  CONSTRAINT `foreign_key_h_r_o_header_report_id` FOREIGN KEY (`header_report_id`) REFERENCES `headers_reports` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `foreign_key_h_r_o_org_id` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Indica a que organizacion pertenece la cabecera del reporte';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.images_reports
CREATE TABLE IF NOT EXISTS `images_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `path` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Direccion de las imagenes de los reportes';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.images_reports_tmp
CREATE TABLE IF NOT EXISTS `images_reports_tmp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `path` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COMMENT='direccion temporal de los reportes';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.image_report_organization
CREATE TABLE IF NOT EXISTS `image_report_organization` (
  `image_report_id` int(11) NOT NULL,
  `organization_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`image_report_id`,`organization_id`),
  KEY `foreign_key_i_r_o_org_id` (`organization_id`),
  CONSTRAINT `foreign_key_i_r_o_image_report_id` FOREIGN KEY (`image_report_id`) REFERENCES `images_reports` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `foreign_key_i_r_o_org_id` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Indica a que organizacion pertenece la image del documento';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.image_rules
CREATE TABLE IF NOT EXISTS `image_rules` (
  `id` int(10) unsigned DEFAULT NULL,
  `width` int(10) unsigned zerofill DEFAULT '0000000000',
  `height` int(10) unsigned zerofill DEFAULT '0000000000',
  `size` int(10) unsigned zerofill DEFAULT '0000000000',
  `table_id` int(11) unsigned NOT NULL DEFAULT '0',
  KEY `FK_image_rules_tables` (`id`),
  CONSTRAINT `FK_image_rules_tables` FOREIGN KEY (`id`) REFERENCES `tables` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='La siguiente tabla esta elaborada para gestionar la reglas de la imagenes del sistema banana';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.imports
CREATE TABLE IF NOT EXISTS `imports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NULL DEFAULT NULL,
  `register` int(10) DEFAULT NULL,
  `table_id` int(10) unsigned DEFAULT NULL,
  `aprove` tinyint(4) DEFAULT '0',
  `active` tinyint(4) DEFAULT '0',
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `foreing_imports_table_idx` (`table_id`),
  KEY `FK_imports_users` (`created_by`),
  KEY `FK_imports_users_2` (`updated_by`),
  CONSTRAINT `FK_imports_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_imports_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `foreing_imports_table` FOREIGN KEY (`table_id`) REFERENCES `tables` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='Fecha, hora y estatus de las importaciones hechas';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.input_types
CREATE TABLE IF NOT EXISTS `input_types` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `input_name` varchar(45) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `input_name_UNIQUE` (`input_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='Tipos de input para la creacion de campos libres';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.languages
CREATE TABLE IF NOT EXISTS `languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `languagescol` varchar(45) CHARACTER SET latin1 NOT NULL,
  `iso` varchar(45) CHARACTER SET latin1 NOT NULL,
  `archived` tinyint(4) DEFAULT '0',
  `date_format` varchar(45) CHARACTER SET latin1 DEFAULT 'm/d/Y',
  `datetime_format` varchar(45) CHARACTER SET latin1 DEFAULT 'm/d/Y H:i:s',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `description` varchar(55) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_languages_users` (`created_by`),
  KEY `FK_languages_users_2` (`updated_by`),
  CONSTRAINT `FK_languages_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_languages_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Lenguajes para la internalizacion';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_attributes
CREATE TABLE IF NOT EXISTS `language_attributes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_attributes_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_attribute_details
CREATE TABLE IF NOT EXISTS `language_attribute_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_attribute_details_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_body_documents
CREATE TABLE IF NOT EXISTS `language_body_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_body_documents_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_bpartners
CREATE TABLE IF NOT EXISTS `language_bpartners` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `fk_language_id_idx` (`language_id`),
  CONSTRAINT `fk_language_id` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_bpartner_locations
CREATE TABLE IF NOT EXISTS `language_bpartner_locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_bpartner_locations_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_categories
CREATE TABLE IF NOT EXISTS `language_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_categories_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_charges
CREATE TABLE IF NOT EXISTS `language_charges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_charges_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_cities
CREATE TABLE IF NOT EXISTS `language_cities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_cities_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_clients
CREATE TABLE IF NOT EXISTS `language_clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_clients_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_conditions
CREATE TABLE IF NOT EXISTS `language_conditions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_conditions_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_contacts
CREATE TABLE IF NOT EXISTS `language_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_contacts_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_counter_series
CREATE TABLE IF NOT EXISTS `language_counter_series` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_counter_series_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_countries
CREATE TABLE IF NOT EXISTS `language_countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_countries_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_currencies
CREATE TABLE IF NOT EXISTS `language_currencies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_currencies_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_documents
CREATE TABLE IF NOT EXISTS `language_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_documents_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_footer_documents
CREATE TABLE IF NOT EXISTS `language_footer_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_footer_documents_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_global
CREATE TABLE IF NOT EXISTS `language_global` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_global_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_hashes
CREATE TABLE IF NOT EXISTS `language_hashes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `table_id` int(11) unsigned NOT NULL,
  `hash` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_language_hash_tables` (`table_id`),
  CONSTRAINT `FK_language_hash_tables` FOREIGN KEY (`table_id`) REFERENCES `tables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_header_projects
CREATE TABLE IF NOT EXISTS `language_header_projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_header_projects_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_imports
CREATE TABLE IF NOT EXISTS `language_imports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_imports_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_languages
CREATE TABLE IF NOT EXISTS `language_languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_languages_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_locations
CREATE TABLE IF NOT EXISTS `language_locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_locations_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_manufacturers
CREATE TABLE IF NOT EXISTS `language_manufacturers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_manufacturers_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_organizations
CREATE TABLE IF NOT EXISTS `language_organizations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_organizations_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_payment_terms
CREATE TABLE IF NOT EXISTS `language_payment_terms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_payment_terms_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_price_lists
CREATE TABLE IF NOT EXISTS `language_price_lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_price_lists_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_products
CREATE TABLE IF NOT EXISTS `language_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_products_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_product_details
CREATE TABLE IF NOT EXISTS `language_product_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_product_details_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_product_image
CREATE TABLE IF NOT EXISTS `language_product_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_product_image_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_reports
CREATE TABLE IF NOT EXISTS `language_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_reports_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_rols
CREATE TABLE IF NOT EXISTS `language_rols` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_rols_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_settings
CREATE TABLE IF NOT EXISTS `language_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_settings_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_setup_configurations
CREATE TABLE IF NOT EXISTS `language_setup_configurations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_setup_configurations_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_setup_sales
CREATE TABLE IF NOT EXISTS `language_setup_sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_setup_sales_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_states
CREATE TABLE IF NOT EXISTS `language_states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_states_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_status
CREATE TABLE IF NOT EXISTS `language_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_status_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_stocks
CREATE TABLE IF NOT EXISTS `language_stocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_stocks_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_tag
CREATE TABLE IF NOT EXISTS `language_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_lang` int(11) DEFAULT NULL,
  `id_table` int(10) unsigned DEFAULT NULL,
  `tag` varchar(200) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE_TAG` (`id_lang`,`id_table`,`tag`),
  KEY `fk_language_tag_table_idx` (`id_table`),
  KEY `fk_language_tag_language_tag_idx` (`parent_tag`),
  CONSTRAINT `fk_language_tag_lag` FOREIGN KEY (`id_lang`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_language_tag_language_tag` FOREIGN KEY (`parent_tag`) REFERENCES `language_tag` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_language_tag_table` FOREIGN KEY (`id_table`) REFERENCES `tables` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_taxes
CREATE TABLE IF NOT EXISTS `language_taxes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_taxes_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_term_types
CREATE TABLE IF NOT EXISTS `language_term_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_term_types_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_type_documents
CREATE TABLE IF NOT EXISTS `language_type_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_type_documents` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_units
CREATE TABLE IF NOT EXISTS `language_units` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_units_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_users
CREATE TABLE IF NOT EXISTS `language_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_users_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.language_warehouses
CREATE TABLE IF NOT EXISTS `language_warehouses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `tag` varchar(200) COLLATE utf8_bin NOT NULL,
  `description` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `parent_tag` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`,`tag`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `language_warehouses_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.locations
CREATE TABLE IF NOT EXISTS `locations` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `archived` tinyint(4) DEFAULT '0' COMMENT '	There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.\nThere are two reasons for de-activating and not deleting records: (1) The system requires the record for audit purposes. (2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.\nYes-No',
  `address_1` varchar(60) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'The address 1 identifies the address for an entity''s location',
  `city_id` int(10) unsigned DEFAULT NULL COMMENT 'city in a country',
  `postal` varchar(10) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'The postal Code or ZIP identifies the postal code for this entity''s address.',
  `state_id` int(10) unsigned DEFAULT NULL COMMENT 'The state identifies a unique state for this Country.\n\nfrom:table',
  `country_id` int(10) unsigned DEFAULT NULL COMMENT 'The Country defines a Country. Each Country must be defined before it can be used in any document.',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `foreign_city_idx` (`city_id`),
  KEY `foreign_state_idx` (`state_id`),
  KEY `foreign_country_idx` (`country_id`),
  KEY `FK_locations_users` (`created_by`),
  KEY `FK_locations_users_2` (`updated_by`),
  CONSTRAINT `FK_locations_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_locations_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `foreign_city` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `foreign_country` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `foreign_state` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1855 DEFAULT CHARSET=utf8 COMMENT='Define Location\nThe Location Tab defines the location of an Organization.';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.manufacturers
CREATE TABLE IF NOT EXISTS `manufacturers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(90) CHARACTER SET latin1 NOT NULL,
  `archived` tinyint(4) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_manufacturers_users` (`created_by`),
  KEY `FK_manufacturers_users_2` (`updated_by`),
  CONSTRAINT `FK_manufacturers_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_manufacturers_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8 COMMENT='Fabricantes de productos';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.migration_table_configs
CREATE TABLE IF NOT EXISTS `migration_table_configs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `table_id` int(11) unsigned NOT NULL DEFAULT '0',
  `table_ref_id` int(11) unsigned NOT NULL DEFAULT '0',
  `column_ref_id` int(11) unsigned NOT NULL DEFAULT '0',
  `has_one` tinyint(4) NOT NULL DEFAULT '0',
  `has_many` tinyint(4) NOT NULL DEFAULT '0',
  `table_pivot` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_migration_table_configs_tables` (`table_id`),
  KEY `FK_migration_table_configs_tables_2` (`table_ref_id`),
  KEY `FK_migration_table_configs_columns` (`column_ref_id`),
  CONSTRAINT `FK_migration_table_configs_columns` FOREIGN KEY (`column_ref_id`) REFERENCES `columns` (`id`),
  CONSTRAINT `FK_migration_table_configs_tables` FOREIGN KEY (`table_id`) REFERENCES `tables` (`id`),
  CONSTRAINT `FK_migration_table_configs_tables_2` FOREIGN KEY (`table_ref_id`) REFERENCES `tables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='Configuracion de la migracion por tablas';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.modules
CREATE TABLE IF NOT EXISTS `modules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(50) NOT NULL,
  `name` varchar(45) NOT NULL,
  `icon` varchar(45) DEFAULT NULL,
  `route` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COMMENT='Modulos en el mercado banana';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.module_table
CREATE TABLE IF NOT EXISTS `module_table` (
  `module_id` int(11) NOT NULL,
  `table_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`module_id`,`table_id`),
  KEY `FK_module_table_tables` (`table_id`),
  CONSTRAINT `FK_module_table_modules` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`),
  CONSTRAINT `FK_module_table_tables` FOREIGN KEY (`table_id`) REFERENCES `tables` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Indica que tabla pertence a cada modulo';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.oauth_access_tokens
CREATE TABLE IF NOT EXISTS `oauth_access_tokens` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1598 DEFAULT CHARSET=utf8 COMMENT='Token de inicio de sesion del usuario';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.organizations
CREATE TABLE IF NOT EXISTS `organizations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8mb4 NOT NULL,
  `reference_no` varchar(25) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL COMMENT 'The reference number can be printed on orders and invoices to allow your business partner to faster identify your records.\\n',
  `description` text CHARACTER SET utf8mb4,
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `location_id` int(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reference_no_UNIQUE` (`reference_no`),
  KEY `organization_location_id_idx` (`location_id`),
  KEY `FK_organizations_users` (`created_by`),
  KEY `FK_organizations_users_2` (`updated_by`),
  CONSTRAINT `FK_organizations_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_organizations_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `organization_location_id` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8 COMMENT='Organizaciones con las que trabaja el cliente.\r\nLas tablas maestras son comparten mediante a una organizacion';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.organization_bpartner
CREATE TABLE IF NOT EXISTS `organization_bpartner` (
  `bpartner_id` int(11) NOT NULL,
  `organization_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`bpartner_id`,`organization_id`),
  KEY `foreign_key_b_o_org_id_idx` (`organization_id`),
  CONSTRAINT `foreign_key_b_o_org_id` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `foreign_key_b_o_third_id` FOREIGN KEY (`bpartner_id`) REFERENCES `bpartners` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Relacion entre los terceros y las organizaciones. A que organizaciones pertenece el tercero';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.organization_price_list
CREATE TABLE IF NOT EXISTS `organization_price_list` (
  `price_list_id` int(11) NOT NULL,
  `organization_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`price_list_id`,`organization_id`),
  KEY `foreign_organization_price_list_organization_id` (`organization_id`),
  CONSTRAINT `foreign_organization_price_list_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `foreign_organization_price_list_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `price_lists` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Indica que organizacion tiene acceso a las listas de precios';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.organization_product
CREATE TABLE IF NOT EXISTS `organization_product` (
  `organization_id` int(10) unsigned NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`organization_id`,`product_id`),
  KEY `FK_organization_product_products` (`product_id`),
  CONSTRAINT `FK_organization_product_organizations` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`),
  CONSTRAINT `FK_organization_product_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Indica que organizacion tiene acceso a los productos';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.organization_report
CREATE TABLE IF NOT EXISTS `organization_report` (
  `report_id` int(11) NOT NULL,
  `organization_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`report_id`,`organization_id`),
  KEY `foreign_key_r_o_org_id` (`organization_id`),
  CONSTRAINT `foreign_key_r_o_org_id` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `foreign_key_r_o_report_id` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Indica que organizacion tiene acceso a los reportes';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.organization_rol
CREATE TABLE IF NOT EXISTS `organization_rol` (
  `rol_id` int(10) unsigned NOT NULL,
  `organization_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`rol_id`,`organization_id`),
  KEY `foreign_organization_rol_orrganization_id_idx` (`organization_id`),
  CONSTRAINT `foreign_organization_rol_orrganization_id` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `foreign_organization_rol_rol_id` FOREIGN KEY (`rol_id`) REFERENCES `rols` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Indica que organizaciones tiene el rol';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.organization_user
CREATE TABLE IF NOT EXISTS `organization_user` (
  `user_id` int(10) unsigned NOT NULL,
  `organization_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`organization_id`),
  KEY `organization_user_organization_id_foreign` (`organization_id`),
  CONSTRAINT `organization_user_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`),
  CONSTRAINT `organization_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Indica que organizaciones tiene este usuario';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.payment_terms
CREATE TABLE IF NOT EXISTS `payment_terms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 NOT NULL,
  `notes` text CHARACTER SET utf8mb4,
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_payment_terms_users` (`created_by`),
  KEY `FK_payment_terms_users_2` (`updated_by`),
  CONSTRAINT `FK_payment_terms_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_payment_terms_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Terminos de pagos';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.payroll_column_rules
CREATE TABLE IF NOT EXISTS `payroll_column_rules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `column_id` int(10) unsigned NOT NULL DEFAULT '0',
  `payroll_table_id` int(10) unsigned NOT NULL DEFAULT '0',
  `tag` varchar(50) NOT NULL DEFAULT '0',
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_payroll_column_rules_payroll_tables` (`payroll_table_id`),
  KEY `FK_payroll_column_rules_columns` (`column_id`),
  CONSTRAINT `FK_payroll_column_rules_columns` FOREIGN KEY (`column_id`) REFERENCES `columns` (`id`),
  CONSTRAINT `FK_payroll_column_rules_payroll_tables` FOREIGN KEY (`payroll_table_id`) REFERENCES `payroll_tables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.payroll_imports
CREATE TABLE IF NOT EXISTS `payroll_imports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `table_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_payroll_imports_tables` (`table_id`),
  CONSTRAINT `FK_payroll_imports_tables` FOREIGN KEY (`table_id`) REFERENCES `tables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.payroll_tables
CREATE TABLE IF NOT EXISTS `payroll_tables` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table_id` int(10) unsigned NOT NULL DEFAULT '0',
  `payroll_import_id` int(10) unsigned NOT NULL DEFAULT '0',
  `taxonomy_column_id` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_payroll_tables_tables` (`table_id`),
  KEY `FK_payroll_tables_payroll_imports` (`payroll_import_id`),
  CONSTRAINT `FK_payroll_tables_payroll_imports` FOREIGN KEY (`payroll_import_id`) REFERENCES `payroll_imports` (`id`),
  CONSTRAINT `FK_payroll_tables_tables` FOREIGN KEY (`table_id`) REFERENCES `tables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.permissions_rols
CREATE TABLE IF NOT EXISTS `permissions_rols` (
  `rol_id` int(10) unsigned NOT NULL,
  `column_id` int(10) unsigned NOT NULL,
  `create` tinyint(1) DEFAULT '0',
  `read` tinyint(1) DEFAULT '0',
  `update` tinyint(1) DEFAULT '0',
  `delete` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`rol_id`,`column_id`),
  KEY `permissions_rols_rol_id_foreign` (`rol_id`),
  KEY `permissions_rols_column_id_foreign` (`column_id`),
  KEY `FK_permissions_rols_users` (`created_by`),
  KEY `FK_permissions_rols_users_2` (`updated_by`),
  CONSTRAINT `FK_permissions_rols_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_permissions_rols_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `permissions_rols_column_id_foreign` FOREIGN KEY (`column_id`) REFERENCES `columns` (`id`),
  CONSTRAINT `permissions_rols_rol_id_foreign` FOREIGN KEY (`rol_id`) REFERENCES `rols` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Permisos asociados al rol por columna.\r\nCrear, Leer, Actualizar, Borrar.';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.permissions_users
CREATE TABLE IF NOT EXISTS `permissions_users` (
  `user_id` int(10) unsigned NOT NULL,
  `column_id` int(10) unsigned NOT NULL,
  `create` tinyint(1) DEFAULT '0',
  `read` tinyint(1) DEFAULT '0',
  `update` tinyint(1) DEFAULT '0',
  `delete` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`user_id`,`column_id`),
  KEY `permissions_users_user_id_foreign` (`user_id`),
  KEY `permissions_users_column_id_foreign` (`column_id`),
  KEY `FK_permissions_users_users` (`created_by`),
  KEY `FK_permissions_users_users_2` (`updated_by`),
  CONSTRAINT `FK_permissions_users_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_permissions_users_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `permissions_users_column_id_foreign` FOREIGN KEY (`column_id`) REFERENCES `columns` (`id`),
  CONSTRAINT `permissions_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Permisos asociados al usuario por columna.\r\nCrear, Leer, Actualizar, Borrar';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.prices
CREATE TABLE IF NOT EXISTS `prices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price_list_id` int(11) NOT NULL,
  `product_detail_id` int(11) NOT NULL,
  `grossprice` decimal(20,8) DEFAULT NULL,
  `discount` varchar(45) DEFAULT '0',
  `discount_calc` decimal(20,8) DEFAULT NULL COMMENT 'Es el descuento calculador procedente del campo decuento\\\\nEj: campo decuento tiene (10%+10%) el campo descuento calculado tendría 19%\\\\n',
  `netprice` decimal(20,8) DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `price_list_id_product_detail_id` (`price_list_id`,`product_detail_id`),
  KEY `fk_price_lists_has_product_details_product_details1_idx` (`product_detail_id`),
  KEY `fk_price_lists_has_product_details_price_lists1_idx` (`price_list_id`),
  KEY `FK_prices_users` (`created_by`),
  KEY `FK_prices_users_2` (`updated_by`),
  CONSTRAINT `FK_prices_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_prices_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_price_lists_has_product_details_price_lists1` FOREIGN KEY (`price_list_id`) REFERENCES `price_lists` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_price_lists_has_product_details_product_details1` FOREIGN KEY (`product_detail_id`) REFERENCES `product_details` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3447 DEFAULT CHARSET=utf8 COMMENT='Precios de las listas de precios. Indicando el producto y descuento';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.price_lists
CREATE TABLE IF NOT EXISTS `price_lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reference` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `name` varchar(45) CHARACTER SET latin1 NOT NULL,
  `valid_from` date DEFAULT NULL,
  `valid_until` date DEFAULT NULL,
  `tax_include` tinyint(4) DEFAULT '0',
  `tax_id` int(11) DEFAULT NULL,
  `currency_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `alternative` int(11) DEFAULT NULL COMMENT 'Lista de precios alternativa',
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reference` (`reference`),
  KEY `foreign_price_list_currencie_id_idx` (`currency_id`),
  KEY `FK_price_lists_price_lists` (`alternative`),
  KEY `FK_price_lists_taxes` (`tax_id`),
  KEY `FK_price_lists_users` (`created_by`),
  KEY `FK_price_lists_users_2` (`updated_by`),
  CONSTRAINT `FK_price_lists_price_lists` FOREIGN KEY (`alternative`) REFERENCES `price_lists` (`id`),
  CONSTRAINT `FK_price_lists_taxes` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`),
  CONSTRAINT `FK_price_lists_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_price_lists_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `foreign_price_list_currencie_id` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8 COMMENT='Lista de precios indicando impuesto, moneda y vigencia';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reference` varchar(50) NOT NULL,
  `name` varchar(255) CHARACTER SET latin1 NOT NULL,
  `description` text CHARACTER SET latin1,
  `type` char(1) CHARACTER SET latin1 DEFAULT 'P' COMMENT 'P=STOCKABLE PRODUCT\nS=SERVICE\nC=CONSUMABLE',
  `is_salable` tinyint(4) DEFAULT '1',
  `is_purchasable` tinyint(4) DEFAULT '1',
  `unit_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `manufacture_id` int(11) DEFAULT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `archived` tinyint(4) DEFAULT '0',
  `is_combination` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Si tiene combinacions o no',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reference` (`reference`),
  KEY `foreign_key_units_unit_id_idx` (`unit_id`),
  KEY `foreign_key_categories_categories_id_idx` (`category_id`),
  KEY `foreign_key_manufacturer_manufacture_id_idx` (`manufacture_id`),
  KEY `FK_products_taxes` (`tax_id`),
  KEY `FK_products_users` (`created_by`),
  KEY `FK_products_users_2` (`updated_by`),
  CONSTRAINT `FK_products_taxes` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`),
  CONSTRAINT `FK_products_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_products_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `foreign_key_categories_categories_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `foreign_key_manufacturer_manufacture_id` FOREIGN KEY (`manufacture_id`) REFERENCES `manufacturers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `foreign_key_units_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1109 DEFAULT CHARSET=utf8 COMMENT='Descripcion general del producto';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.product_details
CREATE TABLE IF NOT EXISTS `product_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reference` varchar(50) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `product_id` int(11) NOT NULL,
  `sku` varchar(45) DEFAULT NULL,
  `ean13` varchar(13) DEFAULT NULL,
  `upc` varchar(12) DEFAULT NULL,
  `cost` double unsigned DEFAULT NULL,
  `sale_price` double unsigned DEFAULT NULL,
  `condition_id` int(11) DEFAULT NULL,
  `price_list_id` int(11) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `archived` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reference` (`reference`),
  KEY `FK_product_details_conditions` (`condition_id`),
  KEY `FK_product_details_price_lists` (`price_list_id`),
  KEY `FK_product_details_products` (`product_id`),
  KEY `FK_product_details_users` (`created_by`),
  KEY `FK_product_details_users_2` (`updated_by`),
  CONSTRAINT `FK_product_details_conditions` FOREIGN KEY (`condition_id`) REFERENCES `conditions` (`id`),
  CONSTRAINT `FK_product_details_price_lists` FOREIGN KEY (`price_list_id`) REFERENCES `price_lists` (`id`),
  CONSTRAINT `FK_product_details_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `FK_product_details_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_product_details_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1107 DEFAULT CHARSET=utf8 COMMENT='Detalles del producto. Un producto tiene al menos un detalle\r\nEsta es la informacion especifica del producto y sus detalles';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.product_images
CREATE TABLE IF NOT EXISTS `product_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `image` varchar(45) CHARACTER SET latin1 DEFAULT NULL,
  `default` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_product_images_products1_idx` (`product_id`),
  CONSTRAINT `fk_product_images_products1` FOREIGN KEY (`product_id`) REFERENCES `product_details` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Imagenes del producto';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.reports
CREATE TABLE IF NOT EXISTS `reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text,
  `table_id` int(10) unsigned DEFAULT NULL,
  `header_id` int(11) NOT NULL,
  `body_id` int(11) NOT NULL,
  `footer_id` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__tables` (`table_id`),
  KEY `FK__users` (`created_by`),
  KEY `FK__users_2` (`updated_by`),
  KEY `FK_reports_headers_reports` (`header_id`),
  KEY `FK_reports_bodys_reports` (`body_id`),
  KEY `FK_reports_bodys_reports_2` (`footer_id`),
  CONSTRAINT `FK__tables` FOREIGN KEY (`table_id`) REFERENCES `tables` (`id`),
  CONSTRAINT `FK__users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK__users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_reports_bodys_reports` FOREIGN KEY (`body_id`) REFERENCES `bodies_reports` (`id`),
  CONSTRAINT `FK_reports_bodys_reports_2` FOREIGN KEY (`footer_id`) REFERENCES `bodies_reports` (`id`),
  CONSTRAINT `FK_reports_headers_reports` FOREIGN KEY (`header_id`) REFERENCES `headers_reports` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reporte segun tabla y partes del reporte, (Header, body, footer)';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.reports_old
CREATE TABLE IF NOT EXISTS `reports_old` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `table` varchar(255) NOT NULL,
  `template` varchar(255) NOT NULL,
  `title` varchar(32) NOT NULL,
  `description` varchar(64) DEFAULT NULL,
  `picture` varchar(255) DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `FK_reports_users` (`created_by`),
  KEY `FK_reports_users_2` (`updated_by`),
  CONSTRAINT `FK_reports_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_reports_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `reports_old_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='schema anterior de reportes';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.rols
CREATE TABLE IF NOT EXISTS `rols` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 NOT NULL,
  `description` varchar(45) CHARACTER SET utf8mb4 NOT NULL,
  `all_access_column` tinyint(1) NOT NULL DEFAULT '0',
  `all_access_organization` tinyint(4) NOT NULL DEFAULT '0',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rols_rol_name_unique` (`name`),
  KEY `FK_rols_users` (`created_by`),
  KEY `FK_rols_users_2` (`updated_by`),
  CONSTRAINT `FK_rols_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_rols_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8 COMMENT='Los roles tienen permisos segun columnas y organizaciones';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.settings
CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `country_id` int(10) unsigned DEFAULT NULL,
  `state_id` int(10) unsigned DEFAULT NULL,
  `city_id` int(10) unsigned DEFAULT NULL,
  `language_id` int(11) DEFAULT NULL,
  `default` tinyint(3) unsigned DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `foreign_country_country_id_idx` (`country_id`),
  KEY `foreign_settings_state_id_idx` (`state_id`),
  KEY `foreign_settings_city_id_idx` (`city_id`),
  KEY `foreign_settings_language_id_idx` (`language_id`),
  KEY `FK_settings_users` (`created_by`),
  KEY `FK_settings_users_2` (`updated_by`),
  CONSTRAINT `FK_settings_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_settings_users_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_settings_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `foreign_settings_city_id` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `foreign_settings_country_id` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `foreign_settings_language_id` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `foreign_settings_state_id` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.setup_configurations
CREATE TABLE IF NOT EXISTS `setup_configurations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `setting` json NOT NULL,
  `default` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `FK_setup_configurations_users_2` (`created_by`),
  KEY `FK_setup_configurations_users_3` (`updated_by`),
  CONSTRAINT `FK_setup_configurations_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_setup_configurations_users_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_setup_configurations_users_3` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='Configuracion general del modulo configurations';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.setup_sales
CREATE TABLE IF NOT EXISTS `setup_sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `setting` json NOT NULL DEFAULT 'null',
  `default` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `FK_setup_sales_users_2` (`created_by`),
  KEY `FK_setup_sales_users_3` (`updated_by`),
  CONSTRAINT `FK_setup_sales_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_setup_sales_users_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_setup_sales_users_3` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='configuracion del modulo Sales';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.states
CREATE TABLE IF NOT EXISTS `states` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `country_id` int(10) unsigned NOT NULL,
  `state` varchar(45) CHARACTER SET utf8mb4 NOT NULL,
  `iso` varchar(5) CHARACTER SET utf8mb4 NOT NULL,
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `state_UNIQUE` (`state`),
  UNIQUE KEY `iso_UNIQUE` (`iso`),
  KEY `states_country_id_foreign` (`country_id`),
  KEY `FK_states_users` (`created_by`),
  KEY `FK_states_users_2` (`updated_by`),
  CONSTRAINT `FK_states_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_states_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `states_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COMMENT='Estados';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.status
CREATE TABLE IF NOT EXISTS `status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_status_users` (`created_by`),
  KEY `FK_status_users_2` (`updated_by`),
  CONSTRAINT `FK_status_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_status_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Estatus de los documentos. Activo, bloqueado, etc';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.stocks
CREATE TABLE IF NOT EXISTS `stocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `warehouse_id` int(11) NOT NULL DEFAULT '1',
  `product_detail_id` int(11) NOT NULL,
  `real_stock` decimal(10,0) DEFAULT NULL,
  `ordered_stock` decimal(10,0) DEFAULT NULL COMMENT 'stock purchase ordered',
  `reserved_stock` decimal(10,0) DEFAULT NULL COMMENT 'stock sales ordered\n',
  `available_stock` decimal(10,0) DEFAULT NULL COMMENT 'Avaible = (Real + Ordered - Reserved)',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`warehouse_id`,`product_detail_id`),
  UNIQUE KEY `id` (`id`),
  KEY `fk_stocks_warehouses1_idx` (`warehouse_id`),
  KEY `fk_stocks_products1_idx` (`product_detail_id`),
  CONSTRAINT `fk_stocks_products1` FOREIGN KEY (`product_detail_id`) REFERENCES `product_details` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_stocks_warehouses1` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1115 DEFAULT CHARSET=utf8 COMMENT='Stock del producto en cada inventario';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.tables
CREATE TABLE IF NOT EXISTS `tables` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table_name` varchar(45) CHARACTER SET utf8mb4 NOT NULL,
  `description` varchar(45) CHARACTER SET utf8mb4 NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `angular_icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_menuitem` tinyint(4) DEFAULT '0',
  `is_available` tinyint(4) DEFAULT '0',
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `table_name_UNIQUE` (`table_name`),
  UNIQUE KEY `description_UNIQUE` (`description`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COMMENT='Tablas para la permisologia de banana';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.table_list_settings
CREATE TABLE IF NOT EXISTS `table_list_settings` (
  `user_id` int(10) unsigned NOT NULL,
  `table_id` int(10) unsigned NOT NULL,
  `setting` json NOT NULL,
  PRIMARY KEY (`user_id`,`table_id`),
  KEY `FK_table_list_settings_tables` (`table_id`),
  CONSTRAINT `FK_table_list_settings_tables` FOREIGN KEY (`table_id`) REFERENCES `tables` (`id`),
  CONSTRAINT `FK_table_list_settings_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Configuracion del componente lista segun la tabla';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.taxes
CREATE TABLE IF NOT EXISTS `taxes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `print_name` varchar(20) DEFAULT NULL,
  `validfrom` date NOT NULL,
  `rate` decimal(10,0) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `notes` text,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_taxes_users` (`created_by`),
  KEY `FK_taxes_users_2` (`updated_by`),
  CONSTRAINT `FK_taxes_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_taxes_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='Impuestos necesarios para el producto y documentos';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.tax_type_document
CREATE TABLE IF NOT EXISTS `tax_type_document` (
  `tax_id` int(11) NOT NULL,
  `type_document_id` int(11) NOT NULL,
  PRIMARY KEY (`tax_id`,`type_document_id`),
  KEY `fk_tax_type_document_type_document_id_idx` (`type_document_id`),
  CONSTRAINT `fk_tax_type_document_tax_id` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tax_type_document_type_document_id` FOREIGN KEY (`type_document_id`) REFERENCES `type_documents` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Impuestos predeterminados del tipo de documento';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.term_types
CREATE TABLE IF NOT EXISTS `term_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `payment_terms_id` int(10) unsigned NOT NULL,
  `type` char(1) CHARACTER SET utf8mb4 NOT NULL,
  `day` int(10) unsigned DEFAULT NULL,
  `typeid` tinyint(1) NOT NULL DEFAULT '0',
  `typeem` tinyint(1) NOT NULL DEFAULT '0',
  `typenm` tinyint(1) NOT NULL DEFAULT '0',
  `daydxpp` int(10) unsigned DEFAULT NULL,
  `percentdxpp` double(5,2) DEFAULT NULL,
  `fixed_amount` double(15,2) DEFAULT NULL,
  `percentage` double(5,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `term_types_payment_terms_id_foreign` (`payment_terms_id`),
  KEY `FK_term_types_users` (`created_by`),
  KEY `FK_term_types_users_2` (`updated_by`),
  CONSTRAINT `FK_term_types_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_term_types_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `term_types_payment_terms_id_foreign` FOREIGN KEY (`payment_terms_id`) REFERENCES `payment_terms` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Tipos de terminos de los terminos de pago';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.type_documents
CREATE TABLE IF NOT EXISTS `type_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL COMMENT 'descripcion del tipo de documentos\nej: cotización, pedido de venta, pedido de compra, factura de venta, etc.',
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `FK_type_documents_users` (`created_by`),
  KEY `FK_type_documents_users_2` (`updated_by`),
  CONSTRAINT `FK_type_documents_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_type_documents_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Tipo de documentos\nGuarda información sobre los tipos de documentos\nej: pedidos venta , facturas venta, pedidos compra, notas de recepcion, etc';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.type_document_settings
CREATE TABLE IF NOT EXISTS `type_document_settings` (
  `type_document_id` int(10) NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `setting` json NOT NULL,
  PRIMARY KEY (`type_document_id`,`user_id`),
  KEY `FK_type_document_settings_users` (`user_id`),
  CONSTRAINT `FK_type_document_settings_type_documents` FOREIGN KEY (`type_document_id`) REFERENCES `type_documents` (`id`),
  CONSTRAINT `FK_type_document_settings_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Configuracion del tipo de documento';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.units
CREATE TABLE IF NOT EXISTS `units` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 NOT NULL,
  `quantity` decimal(15,2) DEFAULT NULL,
  `archived` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_units_users` (`created_by`),
  KEY `FK_units_users_2` (`updated_by`),
  CONSTRAINT `FK_units_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_units_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='Unidades para asignar al producto';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 DEFAULT NULL,
  `email` varchar(45) CHARACTER SET utf8mb4 NOT NULL,
  `all_access_organization` tinyint(1) NOT NULL DEFAULT '0',
  `all_access_column` tinyint(1) NOT NULL DEFAULT '0',
  `password` varchar(65) CHARACTER SET utf8mb4 NOT NULL,
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `remember_token` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `contact_id` int(10) NOT NULL,
  `image_name` text,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `contact_id_UNIQUE` (`contact_id`),
  UNIQUE KEY `users_user_name_unique` (`name`),
  KEY `FK_users_users` (`created_by`),
  KEY `FK_users_users_2` (`updated_by`),
  CONSTRAINT `FK_users_contacts` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`),
  CONSTRAINT `FK_users_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_users_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 COMMENT='Credenciales de un contacto para el acceso a banana';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.user_rol
CREATE TABLE IF NOT EXISTS `user_rol` (
  `user_id` int(10) unsigned NOT NULL,
  `rol_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`rol_id`),
  KEY `fk_user_rol_rol_id_idx` (`rol_id`),
  CONSTRAINT `fk_user_rol_rol_id` FOREIGN KEY (`rol_id`) REFERENCES `rols` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_rol_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Los roles que tiene asignado el usuario';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.warehouses
CREATE TABLE IF NOT EXISTS `warehouses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) unsigned DEFAULT NULL,
  `reference` varchar(45) CHARACTER SET latin1 DEFAULT NULL,
  `name` varchar(45) CHARACTER SET latin1 NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `notes` text CHARACTER SET latin1,
  `default` tinyint(4) NOT NULL DEFAULT '0',
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_warehouses_users` (`created_by`),
  KEY `FK_warehouses_users_2` (`updated_by`),
  CONSTRAINT `FK_warehouses_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_warehouses_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='Cada inventario pertenece a una y sola una organizacion';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.zaudit
CREATE TABLE IF NOT EXISTS `zaudit` (
  `audit_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user` varchar(255) DEFAULT NULL,
  `table_name` varchar(255) DEFAULT NULL,
  `pk1` varchar(255) DEFAULT NULL,
  `pk2` varchar(255) DEFAULT NULL,
  `action` varchar(6) DEFAULT NULL COMMENT 'Values: insert|update|delete',
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`audit_id`),
  KEY `pk_index` (`table_name`,`pk1`,`pk2`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=30422 DEFAULT CHARSET=utf8 COMMENT='Tabla para la auditoria';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banana.zaudit_meta
CREATE TABLE IF NOT EXISTS `zaudit_meta` (
  `audit_meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `audit_id` bigint(20) unsigned NOT NULL,
  `col_name` varchar(255) NOT NULL,
  `old_value` longtext,
  `new_value` longtext,
  PRIMARY KEY (`audit_meta_id`),
  KEY `zaudit_meta_index` (`audit_id`,`col_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=43859 DEFAULT CHARSET=utf8 COMMENT='Tabla para auditoria';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para vista banana.zvw_audit_attributes
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_attributes` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`type_attribute_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`type_attribute_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_attributes_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_attributes_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_attribute_details
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_attribute_details` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`attribute_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`attribute_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`reference_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`reference_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`color_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`color_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`position_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`position_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_attribute_details_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_attribute_details_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_bpartners
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_bpartners` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`logo_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`logo_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`cif_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`cif_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_customer_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_customer_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_vendor_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_vendor_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`alias_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`alias_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`email_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`email_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_2_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_2_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_employee_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_employee_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_prospect_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_prospect_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_sales_rep_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_sales_rep_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`reference_no_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`reference_no_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`sales_rep_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`sales_rep_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`credit_status_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`credit_status_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`credit_limit_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`credit_limit_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`total_open_balance_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`total_open_balance_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`tax_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`tax_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_tax_exempt_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_tax_exempt_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_po_tax_exempt_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_po_tax_exempt_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`url_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`url_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`description_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`description_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_summary_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_summary_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`price_list_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`price_list_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`delivery_rule_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`delivery_rule_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`delivery_via_rule_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`delivery_via_rule_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`flat_discount_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`flat_discount_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_manufacturer_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_manufacturer_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`po_price_list_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`po_price_list_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`language_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`language_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`greeting_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`greeting_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_bpartners_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_bpartners_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_bpartner_locations
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_bpartner_locations` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`bpartner_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`bpartner_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`location_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`location_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_ship_to_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_ship_to_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_bill_to_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_bill_to_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_pay_from_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_pay_from_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_remit_to_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_remit_to_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`phone_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`phone_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`phone_2_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`phone_2_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`fax_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`fax_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`isdn_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`isdn_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`principal_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`principal_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_bpartner_locations_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_bpartner_locations_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_categories
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_categories` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`parent_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`parent_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`color_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`color_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_categories_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_categories_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_charges
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_charges` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`description_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`description_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`report_to_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`report_to_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_charges_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_charges_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_cities
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_cities` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`state_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`state_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`city_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`city_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`capital_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`capital_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_cities_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_cities_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_clients
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_clients` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`client_name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`client_name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`description_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`description_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`language_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`language_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_clients_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_clients_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_conditions
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_conditions` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_conditions_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_conditions_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_contacts
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_contacts` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`description_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`description_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`comments_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`comments_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`email_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`email_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`phone_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`phone_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`phone_2_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`phone_2_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`fax_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`fax_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`title_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`title_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`charge_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`charge_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`birthday_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`birthday_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`last_contact_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`last_contact_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`last_result_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`last_result_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_contacts_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_contacts_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_counter_series
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_counter_series` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`type_document_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`type_document_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`serie_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`serie_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`counter_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`counter_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`organization_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`organization_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_counter_series_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_counter_series_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_countries
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_countries` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`iso_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`iso_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`country_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`country_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_countries_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_countries_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_currencies
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_currencies` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`isocode_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`isocode_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`language_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`language_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`money_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`money_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`symbol_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`symbol_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_currencies_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_currencies_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_imports
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_imports` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`date_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`date_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`register_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`register_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`table_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`table_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`aprove_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`aprove_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`active_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`active_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_imports_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_imports_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_languages
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_languages` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`languagescol_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`languagescol_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`iso_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`iso_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`date_format_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`date_format_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`datetime_format_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`datetime_format_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`description_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`description_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_languages_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_languages_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_locations
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_locations` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`address_1_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`address_1_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`city_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`city_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`postal_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`postal_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`state_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`state_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`country_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`country_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_locations_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_locations_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_manufacturers
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_manufacturers` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_manufacturers_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_manufacturers_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_organizations
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_organizations` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`reference_no_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`reference_no_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`description_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`description_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`location_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`location_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_organizations_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_organizations_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_payment_terms
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_payment_terms` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`notes_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`notes_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_payment_terms_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_payment_terms_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_prices
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_prices` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`price_list_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`price_list_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`product_detail_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`product_detail_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`grossprice_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`grossprice_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`discount_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`discount_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`discount_calc_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`discount_calc_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`netprice_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`netprice_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_prices_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_prices_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_price_lists
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_price_lists` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`reference_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`reference_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`valid_from_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`valid_from_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`valid_until_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`valid_until_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`tax_include_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`tax_include_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`tax_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`tax_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`currency_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`currency_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`alternative_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`alternative_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_price_lists_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_price_lists_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_products
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_products` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`reference_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`reference_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`description_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`description_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`type_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`type_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_salable_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_salable_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_purchasable_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_purchasable_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`unit_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`unit_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`category_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`category_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`manufacture_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`manufacture_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`tax_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`tax_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_combination_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`is_combination_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_products_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_products_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_product_details
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_product_details` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`reference_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`reference_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`product_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`product_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`sku_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`sku_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`ean13_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`ean13_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`upc_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`upc_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`cost_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`cost_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`sale_price_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`sale_price_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`condition_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`condition_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`price_list_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`price_list_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`image_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`image_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_product_details_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_product_details_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_reports
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_reports` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`description_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`description_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`table_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`table_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`header_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`header_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`body_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`body_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`footer_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`footer_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_reports_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_reports_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_rols
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_rols` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`description_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`description_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`all_access_column_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`all_access_column_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`all_access_organization_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`all_access_organization_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_rols_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_rols_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_settings
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_settings` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`user_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`user_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`country_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`country_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`state_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`state_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`city_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`city_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`language_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`language_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`default_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`default_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_settings_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_settings_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_setup_configurations
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_setup_configurations` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`user_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`user_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`country_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`country_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`state_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`state_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`city_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`city_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`language_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`language_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`manufacturer_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`manufacturer_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`unit_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`unit_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`currency_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`currency_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`organization_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`organization_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`default_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`default_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_setup_configurations_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_setup_configurations_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_states
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_states` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`country_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`country_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`state_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`state_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`iso_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`iso_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_states_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_states_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_taxes
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_taxes` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`print_name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`print_name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`validfrom_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`validfrom_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`rate_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`rate_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`notes_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`notes_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_taxes_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_taxes_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_term_types
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_term_types` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`payment_terms_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`payment_terms_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`type_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`type_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`day_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`day_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`typeid_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`typeid_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`typeem_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`typeem_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`typenm_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`typenm_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`daydxpp_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`daydxpp_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`percentdxpp_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`percentdxpp_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`fixed_amount_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`fixed_amount_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`percentage_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`percentage_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_term_types_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_term_types_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_type_documents
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_type_documents` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_type_documents_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_type_documents_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_units
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_units` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`quantity_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`quantity_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_units_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_units_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_users
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_users` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`email_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`email_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`all_access_organization_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`all_access_organization_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`all_access_column_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`all_access_column_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`password_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`password_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`archived_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`remember_token_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`remember_token_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`contact_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`contact_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`image_name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`image_name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_users_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_users_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_warehouses
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_warehouses` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL,
	`id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`organization_id_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`organization_id_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`reference_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`reference_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`name_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_at_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`notes_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`notes_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`created_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_old` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`updated_by_new` LONGTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista banana.zvw_audit_warehouses_meta
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `zvw_audit_warehouses_meta` (
	`audit_id` BIGINT(20) UNSIGNED NOT NULL,
	`audit_meta_id` BIGINT(20) UNSIGNED NOT NULL,
	`user` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk1` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`pk2` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`action` VARCHAR(6) NULL COMMENT 'Values: insert|update|delete' COLLATE 'utf8_general_ci',
	`col_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`old_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`new_value` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`timestamp` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para procedimiento banana.CR_InserFieldConfiguration
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InserFieldConfiguration`( IN `bp_position` int, IN  `bp_input_type_id` INT, IN `bp_required` boolean, IN `bp_column_id` int, IN `bp_custom_column_id` INT, IN`bp_column_type_id` int )
BEGIN

INSERT INTO `banana`.`field_configurations`
(
`position`,
`input_type_id`,
`required`,
`created_at`,
`updated_at`,
`column_id`,
`custom_column_id`,
`column_type_id`)
VALUES
(
`bp_position`, `bp_input_type_id`, `bp_required`,NOW(),NOW(), `bp_column_id`, `bp_custom_column_id`,`bp_column_type_id`
);


END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertAttribute
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertAttribute`(
	IN `bp_name` VARCHAR(45),
	IN `bp_type_attribute` VARCHAR(1)
,
	IN `bp_created_by` INT
)
BEGIN
	DECLARE id int;
    
    INSERT INTO attributes (`name`, `type_attribute`, `created_at`, `updated_at`, `created_by`)
		VALUES(`bp_name`, `bp_type_attribute`, NOW(), NOW(), bp_created_by);
    
    SET id = LAST_INSERT_ID();
	SELECT id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertAttributeDetail
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertAttributeDetail`(
	IN `bp_attribute_id` INT,
	IN `bp_name` VARCHAR(45),
	IN `bp_color` VARCHAR(10),
	IN `bp_position` INT
,
	IN `bp_reference` VARCHAR(50)
,
	IN `bp_created_by` INT
)
BEGIN
	DECLARE id int;
    
    INSERT INTO attribute_details (`attribute_id`, `name`, `color`, `position`, `reference`, `created_at`, `updated_at`, `created_by`)
		VALUES(`bp_attribute_id`, `bp_name`, `bp_color`, `bp_position`, `bp_reference`, NOW(), NOW(), bp_created_by);
    
    SET id = LAST_INSERT_ID();
	SELECT id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertAttributeDetailProductDetail
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertAttributeDetailProductDetail`(
	IN `bp_attribute_id` INT,
	IN `bp_product_id` INT
)
BEGIN
	INSERT INTO attribute_detail_product_detail VALUES (bp_attribute_id,bp_product_id);
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertAudit
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertAudit`(
	IN `bp_user` INT,
	IN `bp_table` INT,
	IN `bp_type` VARCHAR(50),
	IN `bp_context` TEXT
,
	IN `bp_context_id` INT

,
	IN `bp_mac` INT,
	IN `bp_ip` INT

,
	IN `bp_module` VARCHAR(50)
,
	IN `bp_organization` INT
)
BEGIN

	DECLARE ID INT;

	INSERT INTO audits (`user_id`, `table_id`, `type`, `context`, `context_id`, `module`, `organization`, `date`, `time`, `mac_address`, `ip_address`)
	VALUES (bp_user, bp_table, bp_type, bp_context, bp_context_id, bp_module, bp_organization, CURDATE(), CURTIME(), bp_mac, bp_ip);
	
	SET ID = LAST_INSERT_ID();
	SELECT ID;

END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertBodyDocument
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertBodyDocument`(
	IN `bp_reference_document` VARCHAR(1000),
	IN `bp_reference` VARCHAR(50),
	IN `bp_product_detail_id` INT,
	IN `bp_name` VARCHAR(50),
	IN `bp_price` DECIMAL(20,8),
	IN `bp_net_price` DECIMAL(20,8),
	IN `bp_dimensions` VARCHAR(50),
	IN `bp_quantity` INT,
	IN `bp_discount` VARCHAR(50),
	IN `bp_discount_cal` DECIMAL(20,8),
	IN `bp_tax_id` INT,
	IN `bp_sale_rep_id` INT,
	IN `bp_warehouse_id` INT,
	IN `bp_user_id` INT



)
BEGIN

DECLARE id int;

INSERT INTO `body_documents` (
    `reference_document`,
    `reference`,
    `product_detail_id`,
    `name`,
    `price`,
    `net_price`,
    `dimensions`,
    `quantity`,
    `discount`,
    `discount_cal`,
    `tax_id`,
    `sale_rep_id`,
    `warehouse_id`,
    `created_by`
)
VALUES (
    `bp_reference_document`,
    `bp_reference`,
    `bp_product_detail_id`,
    `bp_name`,
    `bp_price`,
    `bp_net_price`,
    `bp_dimensions`,
    `bp_quantity`,
    `bp_discount`,
    `bp_discount_cal`,
    `bp_tax_id`,
    `bp_sale_rep_id`,
    `bp_warehouse_id`,
    `bp_user_id`
);

SET id = LAST_INSERT_ID();
SELECT id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertBodyReport
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertBodyReport`(
	IN `bp_name` varchar(50),
	IN `bp_context` TEXT,
	IN `bp_image_id` INT,
	IN `bp_created_by` INT
)
BEGIN
	DECLARE LID INT;
	
	INSERT INTO `bodies_reports` (`name`, `context`, `image_id`, `created_by`)
	VALUES (bp_name, bp_context, bp_image_id, bp_created_by);
	
	SET LID = LAST_INSERT_ID();
	SELECT LID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertBodyReportOrganization
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertBodyReportOrganization`(
	IN `bp_org_id` INT,
	IN `bp_body_report_id` INT
)
BEGIN
	DECLARE exist INT;
	
	SET exist = (SELECT count(organization_id) FROM body_report_organization WHERE body_report_id = bp_body_report_id AND organization_id = bp_org_id );
	
	IF exist = 0 THEN
		INSERT INTO body_report_organization
		VALUES (bp_body_report_id, bp_org_id);
	END IF;
	
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertBpartnerContact
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertBpartnerContact`(
	IN `bp_bpartner_id` INT,
	IN `bp_contact_id` INT
,
	IN `bp_user_id` INT
)
BEGIN
	INSERT INTO bpartner_contact (bpartner_id, contact_id, user_id)
    VALUES ( bp_bpartner_id, bp_contact_id, bp_user_id );
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertBpartnerLocation
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertBpartnerLocation`(
	IN `bp_bpartner_id` INT,
	IN `bp_location_id` INT,
	IN `bp_name` VARCHAR(60),
	IN `bp_is_ship_to` BOOLEAN,
	IN `bp_is_bill_to` BOOLEAN,
	IN `bp_is_pay_from` BOOLEAN,
	IN `bp_is_remit_to` BOOLEAN,
	IN `bp_phone` VARCHAR(45),
	IN `bp_phone_2` VARCHAR(45),
	IN `bp_fax` VARCHAR(45),
	IN `bp_isdn` VARCHAR(45)
,
	IN `bp_created_by` INT
)
BEGIN
	DECLARE LID int;
	INSERT INTO bpartner_locations
		(
			bpartner_id, location_id, 
            name, is_ship_to, is_bill_to, is_pay_from, is_remit_to, phone,
            phone_2, fax, isdn,
			created_at, updated_at, created_by
		)
    VALUES (
    		bp_bpartner_id, bp_location_id, 
            bp_name, bp_is_ship_to, bp_is_bill_to, bp_is_pay_from, bp_is_remit_to, bp_phone,
            bp_phone_2, bp_fax, bp_isdn,
			NOW(), NOW(), bp_created_by
		);
	SET LID = LAST_INSERT_ID();
	SELECT LID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_insertBpartnerMigration
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_insertBpartnerMigration`()
BEGIN
	DECLARE bp_id int; 
	DECLARE bp_org_id int; 
    DECLARE bp_cif varchar(45);
	DECLARE bp_Logo varchar(45); 
	DECLARE bp_is_customer boolean; 
	DECLARE bp_is_Vendor boolean; 
	DECLARE bp_name varchar(120); 
	DECLARE bp_name2 varchar(120); 
	DECLARE bp_is_Employee boolean;  
	DECLARE bp_is_Prospect boolean; 
	DECLARE bp_is_SalesRep boolean; 
	DECLARE bp_ReferenceNo varchar(25); 
	DECLARE bp_SalesRep_id int; 
	DECLARE bp_CreditStatus char(1); 
	DECLARE bp_CreditLimit double;
	DECLARE bp_TaxId int; 
	DECLARE bp_is_TaxExempt boolean;
	DECLARE bp_is_POTaxExempt boolean;
	DECLARE bp_URL varchar(120);
	DECLARE bp_description varchar(255);
	DECLARE bp_is_Summary boolean;
	DECLARE bp_PriceList_id int; 
	DECLARE bp_DeliveryRule char(1); 
	DECLARE bp_DeliveryViaRule char(1); 
	DECLARE bp_FlatDiscount double; 
	DECLARE bp_is_Manufacturer boolean; 
	DECLARE bp_PO_PriceList_id int; 
	DECLARE bp_Language_id int; 
	DECLARE bp_Greeting_id int;
    DECLARE bp_address_1 VARCHAR(60);
	DECLARE bp_address_2 VARCHAR(60);
	DECLARE bp_address_3 VARCHAR(60);
	DECLARE bp_address_4 VARCHAR(60);
	DECLARE bp_city_id INT;
	DECLARE bp_city_name VARCHAR(60);
	DECLARE bp_postal VARCHAR(10);
	DECLARE bp_postal_add VARCHAR(10);
	DECLARE bp_state_id INT;
	DECLARE bp_state_name VARCHAR(45);
	DECLARE bp_country_id INT;
	DECLARE bp_comments TEXT;
    DECLARE bp_archived boolean;
    DECLARE bp_location_id INT;
    
    DECLARE CIF_REP boolean;
    DECLARE id_exist boolean;
	DECLARE LID int;
	DECLARE import_id int;
	DECLARE done INT DEFAULT 0;
    
	DECLARE CURSOR1 CURSOR FOR SELECT 
    `bpartners_tmp`.`id`,
    `bpartners_tmp`.`logo`,
    `bpartners_tmp`.`cif`,
    `bpartners_tmp`.`is_customer`,
    `bpartners_tmp`.`is_vendor`,
    `bpartners_tmp`.`name`,
    `bpartners_tmp`.`name_2`,
    `bpartners_tmp`.`is_employee`,
    `bpartners_tmp`.`is_prospect`,
    `bpartners_tmp`.`is_sales_rep`,
    `bpartners_tmp`.`reference_no`,
    `bpartners_tmp`.`sales_rep_id`,
    `bpartners_tmp`.`credit_status`,
    `bpartners_tmp`.`credit_limit`,
    `bpartners_tmp`.`tax_id`,
    `bpartners_tmp`.`is_tax_exempt`,
    `bpartners_tmp`.`is_po_tax_exempt`,
    `bpartners_tmp`.`url`,
    `bpartners_tmp`.`description`,
    `bpartners_tmp`.`is_summary`,
    `bpartners_tmp`.`archived`,
    `bpartners_tmp`.`price_list_id`,
    `bpartners_tmp`.`delivery_rule`,
    `bpartners_tmp`.`delivery_via_rule`,
    `bpartners_tmp`.`flat_discount`,
    `bpartners_tmp`.`is_manufacturer`,
    `bpartners_tmp`.`po_price_list_id`,
    `bpartners_tmp`.`language_id`,
    `bpartners_tmp`.`greeting_id`
FROM `banana`.`bpartners_tmp`;

	DECLARE CURSOR2 CURSOR FOR SELECT `locations_tmp`.`id`,
    `locations_tmp`.`address_1`,
    `locations_tmp`.`address_2`,
    `locations_tmp`.`address_3`,
    `locations_tmp`.`address_4`,
    `locations_tmp`.`city_name`,
    `locations_tmp`.`city_id`,
    `locations_tmp`.`postal`,
    `locations_tmp`.`postal_add`,
    `locations_tmp`.`state_id`,
    `locations_tmp`.`state_name`,
    `locations_tmp`.`country_id`,
    `locations_tmp`.`comments`
FROM `banana`.`locations_tmp`;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
SET  CIF_REP = 0; 
SET id_exist = 0;
OPEN CURSOR1;
OPEN CURSOR2;
read_loop: LOOP
    FETCH CURSOR1 INTO bp_id, bp_Logo, bp_cif, bp_is_customer, bp_is_Vendor, bp_name, bp_name2, bp_is_Employee, 
		bp_is_Prospect, bp_is_SalesRep, bp_ReferenceNo, bp_SalesRep_id, bp_CreditStatus, bp_CreditLimit, bp_TaxId, 
        bp_is_TaxExempt,bp_is_POTaxExempt,bp_URL,bp_description,bp_is_Summary,bp_archived,bp_PriceList_id, bp_DeliveryRule, 
        bp_DeliveryViaRule, bp_FlatDiscount, bp_is_Manufacturer, bp_PO_PriceList_id, bp_Language_id, bp_Greeting_id;
        
		IF done = 1 THEN
            LEAVE read_loop;
        END IF;
     
		FETCH CURSOR2 INTO bp_location_id, bp_address_1, bp_address_2, bp_address_3, bp_address_4, bp_city_name, bp_city_id,  
			bp_postal, bp_postal_add, bp_state_id, bp_state_name, bp_country_id, bp_comments;
            
            set CIF_REP = (select if(id is null, 0, 1) as rep FROM bpartners_tmp  where cif = bp_cif and id <> bp_id );
            -- select CIF_REP;
            set id_exist = (select if(id is null, 0, 1) as exist from bpartners where id = bp_id);
            
            if CIF_REP is null then
		
				if id_exist is null then 
				
			   
				
					CALL CR_InsertBpartners( bp_logo, bp_is_customer, bp_is_Vendor, bp_name, bp_name2, bp_is_Employee, 
						bp_is_Prospect, bp_is_SalesRep, bp_ReferenceNo, bp_SalesRep_id, bp_CreditStatus, bp_CreditLimit, bp_TaxId, 
						bp_is_TaxExempt, bp_is_POTaxExempt, bp_URL, bp_description, bp_is_Summary, bp_PriceList_id, bp_DeliveryRule, 
						bp_DeliveryViaRule, bp_FlatDiscount, bp_is_Manufacturer, bp_PO_PriceList_id, bp_Language_id, bp_Greeting_id,bp_id, bp_cif);
				else
					CALL UP_UpdateBpartners( bp_id , bp_logo, bp_is_customer, bp_is_Vendor, bp_name, bp_name2, bp_is_Employee, 
						bp_is_Prospect, bp_is_SalesRep, bp_ReferenceNo, bp_SalesRep_id, bp_CreditStatus, bp_CreditLimit, bp_TaxId, 
						bp_is_TaxExempt, bp_is_POTaxExempt, bp_URL, bp_description, bp_is_Summary, bp_PriceList_id, bp_DeliveryRule, 
						bp_DeliveryViaRule, bp_FlatDiscount, bp_is_Manufacturer, bp_PO_PriceList_id, bp_Language_id, bp_Greeting_id, bp_cif);
				
				end if;
	 
					DELETE FROM bpartners_tmp WHERE id = bp_id;
					
					CALL CR_InsertLocation(bp_address_1, bp_address_2, bp_address_3, bp_address_4, bp_city_id, bp_city_name, bp_postal, 
												bp_postal_add, bp_state_id, bp_state_name, bp_country_id, bp_comments);
					
					set LID = LAST_INSERT_ID();

					
					DELETE FROM locations_tmp WHERE id = bp_location_id;
												
												
					CALL CR_InsertBpartnerLocation(bp_id, LID, bp_name, 1, 1, 1, 1, '', '', '', '');
			
            else 
				iterate read_loop; 
			end if;


	END LOOP;
	CLOSE CURSOR2;
  CLOSE CURSOR1;

	set import_id = (select id from imports where active = 1 limit 1 ) ; 
	update imports set aprove = 1, active = 0  where id = import_id ;
           

END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertBpartnerOrganization
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertBpartnerOrganization`(
	IN `bp_bpartner_id` INT,
	IN `bp_organization_id` INT

)
BEGIN
	DECLARE exist INT;
	
	SET exist = (SELECT count(organization_id) FROM `organization_bpartner` WHERE bpartner_id = bp_bpartner_id AND organization_id = bp_organization_id );
	
	IF exist = 0 THEN
		INSERT INTO `organization_bpartner`
	   VALUES (bp_bpartner_id, bp_organization_id);
	END IF;
	/*
	INSERT INTO bpartner_organization
	   VALUES (bp_bpartner_id, bp_organization_id);
	*/
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertBpartners
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertBpartners`(
	IN `bp_Logo` varchar(45),
	IN `bp_is_customer` boolean,
	IN `bp_is_Vendor` boolean,
	IN `bp_name` varchar(120),
	IN `bp_name2` varchar(120),
	IN `bp_is_Employee` boolean,
	IN `bp_is_Prospect` boolean,
	IN `bp_is_SalesRep` boolean,
	IN `bp_ReferenceNo` varchar(25),
	IN `bp_SalesRep_id` int,
	IN `bp_CreditStatus` char(1),
	IN `bp_CreditLimit` double,
	IN `bp_TaxId` int,
	IN `bp_is_TaxExempt` boolean,
	IN `bp_is_POTaxExempt` boolean,
	IN `bp_URL` varchar(120),
	IN `bp_description` varchar(255),
	IN `bp_is_Summary` boolean,
	IN `bp_PriceList_id` int,
	IN `bp_DeliveryRule` char(1),
	IN `bp_DeliveryViaRule` char(1),
	IN `bp_FlatDiscount` double,
	IN `bp_is_Manufacturer` boolean,
	IN `bp_PO_PriceList_id` int,
	IN `bp_Language_id` int,
	IN `bp_Greeting_id` int,
	IN `bp_id` int ,
	IN `bp_cif` varchar (45),
	IN `bp_alias` varchar(45),
	IN `bp_email` varchar(120)

,
	IN `bp_currency_id` INT,
	IN `bp_created_by` INT


)
BEGIN

DECLARE LID int;

INSERT INTO `banana`.`bpartners` (`logo`, `is_customer`, `is_vendor`, `name`, `name_2`,
	`is_employee`, `is_prospect`, `is_sales_rep`, `reference_no`, `sales_rep_id`, `credit_status`, `credit_limit`,
    `tax_id`, `is_tax_exempt`, `is_po_tax_exempt`, `url`, `description`, `is_summary`,
    `price_list_id`, `delivery_rule`, `delivery_via_rule`, `flat_discount`, `is_manufacturer`, `po_price_list_id`,
    `language_id`, `greeting_id`, `created_at`, `updated_at`,`id`,`cif`,`alias`,`email`, `currency_id`, `created_by` ) VALUES 
(
bp_Logo, 
bp_is_customer, 
bp_is_Vendor, 
bp_name, 
bp_name2, 
bp_is_Employee, 
bp_is_Prospect, 
bp_is_SalesRep, 
bp_ReferenceNo, 
bp_SalesRep_id, 
bp_CreditStatus, 
bp_CreditLimit, 
bp_TaxId, 
bp_is_TaxExempt,
bp_is_POTaxExempt,
bp_URL,
bp_description,
bp_is_Summary,
bp_PriceList_id, 
bp_DeliveryRule, 
bp_DeliveryViaRule, 
bp_FlatDiscount, 
bp_is_Manufacturer, 
bp_PO_PriceList_id, 
bp_Language_id, 
bp_Greeting_id,
NOW(),
NOW(),
bp_id,
bp_cif,
bp_alias,
bp_email,
bp_currency_id,
bp_created_by
);
SET LID = LAST_INSERT_ID();
SELECT LID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertCategory
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertCategory`(
	IN `bp_name` varchar(45),
	IN `bp_color` varchar(45),
	IN `bp_parent_id` int
,
	IN `bp_created_by` INT
)
BEGIN

DECLARE LID int;

INSERT INTO `categories` (`name`, `color`, `parent_id`, `created_at`, `updated_at`, `created_by`)
VALUES (bp_name, bp_color, bp_parent_id, NOW(), NOW(), bp_created_by);

SET LID = LAST_INSERT_ID();
SELECT LID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertCharge
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertCharge`(
	IN `bp_name` varchar(45),
	IN `bp_description` text,
	IN `bp_report_to` int
 ,
	IN `bp_created_by` INT
)
BEGIN

	DECLARE LID int;
	INSERT INTO `charges`
	(
	`name`,
	`description`,
	`report_to`,
	`created_by`
	)
	VALUES
	(
	bp_name,
	bp_description,
	bp_report_to,
	bp_created_by
	);


	SET LID = LAST_INSERT_ID();
	SELECT LID;
	

END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertCity
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertCity`(
	IN `bp_state_id` INT,
	IN `bp_city_name` VARCHAR(45),
	IN `bp_capital` BOOLEAN 
,
	IN `bp_created_by` INT
)
BEGIN
	DECLARE LID INT;
	INSERT INTO cities (state_id, city, capital, created_at, updated_at, created_by)
   VALUES ( bp_state_id, bp_city_name, bp_capital, NOW(), NOW(), bp_created_by);
	SET LID = LAST_INSERT_ID();
	SELECT LID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertColumnType
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertColumnType`( IN bp_name VARCHAR(45) )
BEGIN
	INSERT INTO column_type
    (name)
    VALUES (bp_name);
    SELECT 1;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertCondition
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertCondition`(
	IN `bp_tag` varchar(45)
,
	IN `bp_created_by` INT
)
BEGIN

DECLARE LID int;

INSERT INTO `conditions` (`name`, `created_at`, `updated_at`, `created_by`)
VALUES (bp_tag, NOW(), NOW(), bp_created_by);

SET LID = LAST_INSERT_ID();
SELECT LID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertContacts
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertContacts`(
	IN `bp_name` VARCHAR(60),
	IN `bp_description` VARCHAR(255),
	IN `bp_comments` TEXT,
	IN `bp_email` VARCHAR(60),
	IN `bp_phone` VARCHAR(45),
	IN `bp_phone_2` VARCHAR(45),
	IN `bp_fax` VARCHAR(45),
	IN `bp_title` VARCHAR(45),
	IN `bp_charge` INT,
	IN `bp_birthday` DATE,
	IN `bp_last_contact` DATE,
	IN `bp_last_result` VARCHAR(255)



,
	IN `bp_created_by` INT
)
BEGIN
	DECLARE LID int;
	INSERT INTO `contacts` (
		`name`,
		description,
		comments,
		email,
		phone,
		phone_2,
		fax,
		title,
		charge,
		birthday,
		last_contact,
		last_result,
        created_at,
        updated_at,
        created_by
	) VALUES(
		bp_name,
		bp_description,
		bp_comments,
		bp_email,
		bp_phone,
		bp_phone_2,
		bp_fax,
		bp_title,
		bp_charge,
		bp_birthday,
		bp_last_contact,
		bp_last_result,
        NOW(),
        NOW(),
        bp_created_by
	);
    SET LID = LAST_INSERT_ID();
	SELECT LID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertCounterSerie
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertCounterSerie`(
	IN `bp_type_document_id` INT,
	IN `bp_serie` VARCHAR(10),
	IN `bp_counter` INT,
	IN `bp_organization_id` INT,
	IN `bp_user_counter` INT,
	IN `bp_user` INT


)
BEGIN
	DECLARE id int;
	INSERT INTO counter_series (type_document_id, serie, counter, organization_id, user_id, created_by)
	VALUES (bp_type_document_id, bp_serie, bp_counter, bp_organization_id, bp_user_counter, bp_user);
	SET id = LAST_INSERT_ID();
	SELECT id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertCountry
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertCountry`(
	IN `bp_country_name` VARCHAR(45),
	IN `bp_iso` VARCHAR(2) ,
	IN `bp_created_by` INT
)
BEGIN
	DECLARE LID int;
	INSERT INTO countries (country, iso, created_at, updated_at, created_by)
    VALUES ( bp_country_name, bp_iso, NOW(), NOW(), bp_created_by);
    SET LID = LAST_INSERT_ID();
	SELECT LID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertCurrency
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertCurrency`(
	IN `bp_isocode` VARCHAR(50),
	IN `bp_language` VARCHAR(50),
	IN `bp_name` VARCHAR(50),
	IN `bp_money` VARCHAR(50),
	IN `bp_symbol` VARCHAR(50)


,
	IN `bp_created_by` INT
)
BEGIN
	DECLARE LID INT;
	INSERT INTO currencies (isocode, language, name, money, symbol, created_at, updated_at, created_by )
	VALUES (bp_isocode,bp_language,bp_name, bp_money, bp_symbol,NOW(), NOW(), bp_created_by);
	SET LID = LAST_INSERT_ID();
	SELECT LID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertCustomColumn
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertCustomColumn`( bp_table_id INT, bp_type_id INT, bp_name VARCHAR(45))
BEGIN
	DECLARE LID int;
	INSERT INTO custom_column
    (table_id, type_id, name)
    VALUES (bp_table_id, bp_type_id, bp_name);
    SET LID = LAST_INSERT_ID();
	SELECT LID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertCustomColumnValue
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertCustomColumnValue`(
bp_bool_value boolean,
bp_number_value VARCHAR(45),
bp_string_value VARCHAR(45),
bp_date TIMESTAMP,
bp_custom_column_id INT,
bp_context_id INT
)
BEGIN
	DECLARE LID int;
    DELETE FROM custom_column_value WHERE custom_column_id = bp_custom_column_id AND context_id = bp_context_id;
	INSERT INTO custom_column_value
    (bool_value ,number_value, string_value, date, custom_column_id, context_id)
    VALUES (bp_bool_value, bp_number_value, bp_string_value, bp_date, bp_custom_column_id, bp_context_id);
    SET LID = LAST_INSERT_ID();
	SELECT LID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertDBUser
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertDBUser`(in bn_id int, in bn_hostBD text, in bn_pass text)
BEGIN
    DECLARE userNameBD varchar(50);
    
	SET userNameBd = CONCAT('user_',bn_id);
    SET bn_hostBD = @@hostname;
	SET @VV_CONSDINAM = CONCAT('CREATE USER ', userNameBd, '@localhost  ;');

	PREPARE SENTENCIA FROM @VV_CONSDINAM;

	EXECUTE SENTENCIA;
    
    SET @VV_CONSDINAM = CONCAT('GRANT ALL PRIVILEGES ON * . * TO ',  userNameBd, '@localhost' );
	PREPARE SENTENCIA FROM @VV_CONSDINAM;

	EXECUTE SENTENCIA;
		
	-- CREATE USER userNameBd @'%'; 
    -- GRANT DELETE, INSERT, SELECT, UPDATE ON * . * TO userNameBd @'%';
    FLUSH PRIVILEGES;
    

END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertDiscountFooterDocument
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertDiscountFooterDocument`(
	IN `bp_discount` VARCHAR(50),
	IN `bp_discount_cal` DECIMAL(20,8),
	IN `bp_remainder` DECIMAL(20,8),
	IN `bp_description` VARCHAR(50),
	IN `bp_footer_document_id` INT


)
BEGIN

DECLARE id int;

INSERT INTO `discounts_footers_documents` (
    `discount`,
    `discount_cal`,
    `remainder`,
    `description`,
    `footer_document_id`
)
VALUES (
    `bp_discount`,
    `bp_discount_cal`,
    `bp_remainder`,
    `bp_description`,
    `bp_footer_document_id`
);

SET id = LAST_INSERT_ID();
SELECT id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertField
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertField`(
IN `bp_input_type_id` INT,
IN `bp_position` INT,
IN `bp_required` BOOLEAN,
IN `bp_column_id` INT,
IN `bp_custom_column_id` INT )
BEGIN
	DECLARE LID int;
	INSERT INTO field_configurations (position, input_type_id, required, created_at, updated_at, column_id, custom_column_id)
    VALUES ( bp_position, bp_input_type_id, bp_required, NOW(), NOW(), bp_column_id, bp_custom_column_id );
    SET LID = LAST_INSERT_ID();
	SELECT LID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertFooterDocument
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertFooterDocument`(
	IN `bp_document_reference` VARCHAR(1000),
	IN `bp_quantity_total` INT,
	IN `bp_gross_total` DECIMAL(20,8),
	IN `bp_discount_total` DECIMAL(20,8),
	IN `bp_tax_total` DECIMAL(20,8),
	IN `bp_neto_total` DECIMAL(20,8),
	IN `bp_internal_note` VARCHAR(50),
	IN `bp_client_note` VARCHAR(50),
	IN `bp_user_id` INT



)
BEGIN

DECLARE id int;

INSERT INTO `footer_documents` (
    `reference_document`,
    `quantity_total`,
    `gross_total`,
    `discount_total`,
    `tax_total`,
    `neto_total`,
    `internal_note`,
    `client_note`,
    `created_by`
)
VALUES (
    `bp_document_reference`,
    `bp_quantity_total`,
    `bp_gross_total`,
    `bp_discount_total`,
    `bp_tax_total`,
    `bp_neto_total`,
    `bp_internal_note`,
    `bp_client_note`,
    `bp_user_id`
);

SET id = LAST_INSERT_ID();
SELECT id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertFooterGroupedTax
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertFooterGroupedTax`(
	IN `bp_tax` INT,
	IN `bp_gross` DECIMAL(20,8),
	IN `bp_total` DECIMAL(20,8),
	IN `bp_footer_document_id` INT





)
BEGIN
/*	DECLARE exist INT;
	
	SET exist = (SELECT count(tax) FROM `footer_grouped_taxes` WHERE `footer_document_id` = `bp_footer_document_id` AND `tax` = `bp_tax` );
	
	IF exist = 1 THEN

		DELETE FROM `footer_grouped_taxes` WHERE `footer_document_id` = `bp_footer_document_id` AND `tax` = `bp_tax`;

	END IF; */

	INSERT INTO `footer_grouped_taxes` (
    	`tax`,
    	`gross`,
      `total`,
	   `footer_document_id`
	)
	VALUES (
	    `bp_tax`,
	    `bp_gross`,
	    `bp_total`,
	    `bp_footer_document_id`
	);
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertFooterReport
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertFooterReport`(
	IN `bp_name` varchar(50),
	IN `bp_context` TEXT,
	IN `bp_image_id` INT,
	IN `bp_created_by` INT
)
BEGIN
	DECLARE LID INT;
	
	INSERT INTO `footers_reports` (`name`, `context`, `image_id`, `created_by`)
	VALUES (bp_name, bp_context, bp_image_id, bp_created_by);
	
	SET LID = LAST_INSERT_ID();
	SELECT LID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertFooterReportOrganization
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertFooterReportOrganization`(
	IN `bp_org_id` INT,
	IN `bp_footer_report_id` INT
)
BEGIN
	DECLARE exist INT;
	
	SET exist = (SELECT count(organization_id) FROM footer_report_organization WHERE footer_report_id = bp_footer_report_id AND organization_id = bp_org_id );
	
	IF exist = 0 THEN
		INSERT INTO footer_report_organization
		VALUES (bp_footer_report_id, bp_org_id);
	END IF;
	
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertHeaderDocument
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertHeaderDocument`(
	IN `bp_header_project_id` INT,
	IN `bp_counter_serie_id` INT,
	IN `bp_type_document_id` INT,
	IN `bp_bpartner_id` INT,
	IN `bp_address` VARCHAR(50),
	IN `bp_valid_from` DATE,
	IN `bp_valid_until` DATE,
	IN `bp_warehouse_id` INT,
	IN `bp_sale_represent_id` INT,
	IN `bp_price_list_id` INT,
	IN `bp_reference` VARCHAR(1000),
	IN `bp_currency_client` INT,
	IN `bp_currency_document` INT,
	IN `bp_rate` DECIMAL(20,8),
	IN `bp_status_id` INT,
	IN `bp_user_id` INT







)
BEGIN

DECLARE bp_id int;
DECLARE bv_counter_serie_id int;
DECLARE bv_reference VARCHAR(50);

SET bv_counter_serie_id = ( SELECT IFNULL(bp_counter_serie_id, 1) );

UPDATE `counter_series` SET
	counter = counter + 1
WHERE
	id = bv_counter_serie_id;

SET bp_id = ( SELECT counter FROM `counter_series` WHERE id = bv_counter_serie_id );
SET bv_reference = ( SELECT CONCAT(serie,'-',counter) reference FROM `counter_series` WHERE id = bv_counter_serie_id );

INSERT INTO `documents` (
 	 `id`,
    `header_project_id`,
    `counter_serie_id`,
    `type_document_id`,
    `bpartner_id`,
    `address`,
    `valid_from`,
    `valid_until`,
    `warehouse_id`,
    `sale_represent_id`,
    `price_list_id`,
    `reference`,
    `currency_client`,
    `currency_document`,
    `rate`,
    `status_id`,
    `created_by`
)
VALUES (
	 `bp_id`,
    `bp_header_project_id`,
    `bv_counter_serie_id`,
    `bp_type_document_id`,
    `bp_bpartner_id`,
    `bp_address`,
    `bp_valid_from`,
    `bp_valid_until`,
    `bp_warehouse_id`,
    `bp_sale_represent_id`,
    `bp_price_list_id`,
    `bv_reference`,
    `bp_currency_client`,
    `bp_currency_document`,
    `bp_rate`,
    `bp_status_id`,
    `bp_user_id`
);
SELECT bp_id, bv_reference;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertHeaderProject
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertHeaderProject`(
	IN `bp_bpartner_id` INT,
	IN `bp_organization_id` INT,
	IN `bp_created_by` INT

)
BEGIN

DECLARE id int;

INSERT INTO `header_projects` (`bpartner_id`, `organization_id`, `created_by`)
VALUES (`bp_bpartner_id`, `bp_organization_id`, `bp_created_by`);

SET id = LAST_INSERT_ID();
SELECT id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertHeaderReport
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertHeaderReport`(
	IN `bp_name` varchar(50),
	IN `bp_context` TEXT,
	IN `bp_image_id` INT,
	IN `bp_created_by` INT
)
BEGIN
	DECLARE LID INT;
	
	INSERT INTO `headers_reports` (`name`, `context`, `image_id`, `created_by`)
	VALUES (bp_name, bp_context, bp_image_id, bp_created_by);
	
	SET LID = LAST_INSERT_ID();
	SELECT LID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertHeaderReportOrganization
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertHeaderReportOrganization`(
	IN `bp_org_id` INT,
	IN `bp_header_report_id` INT
)
BEGIN
	DECLARE exist INT;
	
	SET exist = (SELECT count(organization_id) FROM header_report_organization WHERE header_report_id = bp_header_report_id AND organization_id = bp_org_id );
	
	IF exist = 0 THEN
		INSERT INTO header_report_organization
		VALUES (bp_header_report_id, bp_org_id);
	END IF;
	
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertImageReport
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertImageReport`(
	IN `bp_name` varchar(50),
	IN `bp_path` varchar(50)
)
BEGIN
	DECLARE LID INT;
	
	INSERT INTO `images_reports` (`name`, `path`)
	VALUES (bp_name, bp_path);
	
	SET LID = LAST_INSERT_ID();
	SELECT LID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertImageReportOrganization
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertImageReportOrganization`(
	IN `bp_org_id` INT,
	IN `bp_image_report_id` INT
)
BEGIN
	DECLARE exist INT;
	
	SET exist = (SELECT count(organization_id) FROM image_report_organization WHERE image_report_id = bp_image_report_id AND organization_id = bp_org_id );
	
	IF exist = 0 THEN
		INSERT INTO image_report_organization
		VALUES (bp_image_report_id, bp_org_id);
	END IF;
	
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_insertImport
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_insertImport`(in bp_tabla varchar(120))
BEGIN

-- DECLARE param_registre int;
DECLARE param_table_id INT; 
DECLARE param_tmp_name varchar(120); 

set param_tmp_name = CONCAT( bp_tabla, '_tmp');

set param_table_id = (select id from tables t1  where t1.table_name = bp_tabla );


SET @VV_CONSDINAM = CONCAT('set @param_registre = (select count(id) from  ',param_tmp_name,');');

PREPARE SENTENCIA FROM @VV_CONSDINAM;

EXECUTE SENTENCIA;

UPDATE imports set active = 0 where id <> -1;

INSERT INTO imports ( date, register, table_id, aprove, active ) values ( now(), 
@param_registre, param_table_id, 0, 1);


END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_insertLanguage
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_insertLanguage`(
in languagescol_param varchar(45), 
in iso_param varchar(45))
BEGIN
INSERT INTO `banana`.`languages`
(
`languagescol`,
`iso`,
`archived`,

`created_at`,
`updated_at`,
`description`)
VALUES
(

languagescol_param,
iso_param,
0,
now(),
now(),
languagescol_param);

END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_insertLanguageTag
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_insertLanguageTag`(in id_lang_param int, in id_table_param int, in tag_param varchar(200) ,in description_param varchar(255), in id_parent_param int ,in code_param varchar(255))
BEGIN

 declare LID int;
 
 declare table_param varchar(255);
 
 set table_param = 'language_global';
 
 if  id_table_param != 0 then
 
 set table_param = (SELECT  CONCAT( '`language_' , table_name ,'`')  FROM `tables` where id = id_table_param);

end if;


SET @VV_CONSDINAM = CONCAT('INSERT INTO  ',
table_param,
'(
`language_id`,
`tag`,
`description`,
`parent_tag`,
`code`)
VALUES
(',id_lang_param,' , "',tag_param,'" , "',description_param,'" , ',id_parent_param,' , "',code_param,'");');

PREPARE SENTENCIA FROM @VV_CONSDINAM;

EXECUTE SENTENCIA;


 set LID =  LAST_INSERT_ID();
 select LID;

-- UPDATE `language_tag` SET `parent_tag` = LID WHERE `id` = LID;

END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertLocation
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertLocation`(
	IN `bp_address_1` VARCHAR(60),
	IN `bp_city_id` INT,
	IN `bp_postal` VARCHAR(10),
	IN `bp_state_id` INT,
	IN `bp_country_id` INT

,
	IN `bp_created_by` INT
)
BEGIN

	DECLARE LID int;
    
	INSERT INTO locations
		(
			address_1, city_id, 
			postal, state_id,country_id,
			created_at, updated_at, created_by
			)
    VALUES (
    		bp_address_1, bp_city_id,
			bp_postal, bp_state_id, bp_country_id,
			NOW(), NOW(), bp_created_by
		);
	SET LID = LAST_INSERT_ID();
	SELECT LID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertManufacturer
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertManufacturer`(
	IN `bp_name` varchar(45)
,
	IN `bp_created_by` INT
)
BEGIN

DECLARE LID int;

INSERT INTO `manufacturers` (`name`, `created_at`, `updated_at`, `created_by`)
VALUES (bp_name, NOW(), NOW(), bp_created_by);

SET LID = LAST_INSERT_ID();
SELECT LID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertOrganization
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertOrganization`(
	IN `bp_name` varchar(60),
	IN `bp_ref_num` varchar(25),
	IN `bp_description` text,
	IN `bp_location_id` int


,
	IN `bp_created_by` INT

)
BEGIN

DECLARE LID int;

INSERT INTO `organizations` (`name`, `reference_no`, `description`, `location_id`, `created_at`, `updated_at`, created_by)
VALUES (bp_name, bp_ref_num, bp_description, bp_location_id, NOW(), NOW(), bp_created_by);

SET LID = LAST_INSERT_ID();

SELECT LID;
CALL CR_InsertWarehouse(LID,'PRINCIPAL','PRINCIPAL','PRINCIPAL');

END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertOrganizationPriceList
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertOrganizationPriceList`(
	IN `bp_org` INT,
	IN `bp_price_list_id` INT

)
BEGIN
	DECLARE exist INT;
	
	SET exist = (SELECT count(organization_id) FROM organization_price_list WHERE price_list_id = bp_price_list_id AND organization_id = bp_org );
	
	IF exist = 0 THEN

		INSERT INTO organization_price_list (`price_list_id`, `organization_id`)
		VALUES (bp_price_list_id, bp_org);
		
	END IF;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertOrganizationProduct
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertOrganizationProduct`(
	IN `bp_org_id` INT,
	IN `bp_prod_id` INT

)
BEGIN
	DECLARE exist INT;
	
	SET exist = (SELECT count(organization_id) FROM organization_product WHERE product_id = bp_prod_id AND organization_id = bp_org_id );
	
	IF exist = 0 THEN
		INSERT INTO organization_product
		VALUES (bp_org_id, bp_prod_id);
	END IF;
	
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertOrganizationReport
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertOrganizationReport`(
	IN `bp_org_id` INT,
	IN `bp_report_id` INT
)
BEGIN
	DECLARE exist INT;
	
	SET exist = (SELECT count(organization_id) FROM organization_report WHERE report_id = bp_report_id AND organization_id = bp_org_id );
	
	IF exist = 0 THEN
		INSERT INTO organization_report
		VALUES (bp_report_id, bp_org_id);
	END IF;
	
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertOrganizationRol
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertOrganizationRol`(
	IN `bp_org_id` INT,
	IN `bp_rol_id` INT

)
BEGIN
	DECLARE exist INT;
	
	SET exist = (SELECT count(organization_id) FROM organization_rol WHERE rol_id = bp_rol_id AND organization_id = bp_org_id );
	
	IF exist = 0 THEN
	
		INSERT INTO organization_rol
	   VALUES (bp_rol_id, bp_org_id);
	   
	END IF;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertOrganizationUser
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertOrganizationUser`(
	IN `bp_org_id` INT,
	IN `bp_user_id` INT


)
BEGIN
	DECLARE exist INT;
	
	SET exist = (SELECT count(organization_id) FROM organization_user WHERE user_id = bp_user_id AND organization_id = bp_org_id );
	
	IF exist = 0 THEN
	
		INSERT INTO organization_user
	   VALUES (bp_user_id, bp_org_id);
	   
	END IF;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertPermitsRol
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertPermitsRol`(
	IN `bp_rol_id` INT,
	IN `bp_column_id` INT,
	IN `bp_create` BOOLEAN,
	IN `bp_read` BOOLEAN,
	IN `bp_update` BOOLEAN,
	IN `bp_delete` BOOLEAN
)
BEGIN
	DECLARE LID int;
	IF bp_create = 0 AND bp_read = 0 AND bp_update = 0 AND bp_delete = 0 THEN
		SELECT 0;
	ELSE
		INSERT INTO permissions_rols (rol_id, column_id, permissions_rols.create, permissions_rols.read, permissions_rols.update, permissions_rols.delete, created_at, updated_at) 
		VALUES (bp_rol_id, bp_column_id, bp_create, bp_read, bp_update, bp_delete, NOW(), NOW());
	    SET LID = LAST_INSERT_ID();
		SELECT LID;
	END IF;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertPermitsUser
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertPermitsUser`(
	IN `bp_user_id` INT,
	IN `bp_column_id` INT,
	IN `bp_create` BOOLEAN,
	IN `bp_read` BOOLEAN,
	IN `bp_update` BOOLEAN,
	IN `bp_delete` BOOLEAN
)
BEGIN
	DECLARE LID int;
	IF bp_create = 0 AND bp_read = 0 AND bp_update = 0 AND bp_delete = 0 THEN
		SELECT 0;
	ELSE
		INSERT INTO permissions_users (user_id, column_id, permissions_users.create, permissions_users.read, permissions_users.update, permissions_users.delete, created_at, updated_at) 
		VALUES (bp_user_id, bp_column_id, bp_create, bp_read, bp_update, bp_delete, NOW(), NOW());
	    SET LID = LAST_INSERT_ID();
		SELECT LID;
	END IF;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertPrice
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertPrice`(
	IN `bp_price_list` INT,
	IN `bp_product_detail` INT,
	IN `bp_grossprice` DECIMAL(20,8),
	IN `bp_discount` VARCHAR(45)






,
	IN `bp_discount_calc` DECIMAL(20,8),
	IN `bp_netprice` DECIMAL(20,8)




,
	IN `bp_created_by` INT

)
BEGIN	
	DECLARE id INT;

	INSERT INTO prices (price_list_id, product_detail_id, grossprice, discount, discount_calc, netprice, created_by)
	VALUES (bp_price_list, bp_product_detail, bp_grossprice, bp_discount, bp_discount_calc, bp_netprice, bp_created_by);
	
	SET id = LAST_INSERT_ID();
	SELECT id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertPriceList
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertPriceList`(
	IN `bp_reference` varchar(20),
	IN `bp_name` varchar(45),
	IN `bp_valid_from` date,
	IN `bp_valid_until` date,
	IN `bp_tax_include` boolean,
	IN `bp_currency_id` int
,
	IN `bp_alternative` INT
,
	IN `bp_tax_id` INT

,
	IN `bp_created_by` INT
)
BEGIN

DECLARE LID int;

INSERT INTO `price_lists`
	(
		`reference`,
		`name`,
		`valid_from`,
		`valid_until`,
		`tax_include`,
		`currency_id`,
		`created_at`,
		`updated_at`,
		`alternative`,
		`tax_id`,
		`created_by`
	)
	VALUES (
		bp_reference,
		bp_name,
		bp_valid_from,
		bp_valid_until,
		bp_tax_include,
		bp_currency_id,
		NOW(),
      NOW(),
      bp_alternative,
      bp_tax_id,
      bp_created_by
	);

SET LID = LAST_INSERT_ID();
SELECT LID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertProduct
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertProduct`(
	IN `bp_name` varchar(255),
	IN `bp_reference` VARCHAR(50),
	IN `bp_description` varchar(255),
	IN `bp_type` CHAR(1),
	IN `bp_is_salable` TINYINT,
	IN `bp_is_purchasable` TINYINT,
	IN `bp_unit_id` INT(11),
	IN `bp_category_id` INT,
	IN `bp_manufacture_id` INT(11)
,
	IN `bp_tax_id` INT

,
	IN `bp_combination` TINYINT
,
	IN `bp_created_by` INT
)
BEGIN
DECLARE LID int;
INSERT INTO products
(
`name`,
`reference`,
`description`,
`type`,
`is_salable`,
`is_purchasable`,
`unit_id`,
`category_id`,
`manufacture_id`,
`tax_id`,
`is_combination`,
`created_at`,
`updated_at`,
`created_by`
)
VALUES(
bp_name,
bp_reference,
bp_description,
bp_type,
bp_is_salable,
bp_is_purchasable,
bp_unit_id,
bp_category_id,
bp_manufacture_id,
bp_tax_id,
bp_combination,
NOW(),
NOW(),
bp_created_by
);
SET LID = LAST_INSERT_ID();
SELECT LID;

END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertProductDetail
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertProductDetail`(
	IN `bp_name` VARCHAR(50),
	IN `bp_product_id` INT(11),
	IN `bp_reference` VARCHAR(50),
	IN `bp_sku` varchar(45),
	IN `bp_ean13` varchar(13),
	IN `bp_upc` varchar(12),
	IN `bp_cost` DOUBLE,
	IN `bp_sale_price` DOUBLE,
	IN `bp_condition_id` INT(11),
	IN `bp_price_list_id` INT(11)





,
	IN `bp_created_by` INT
)
BEGIN
    DECLARE LID int;
    INSERT INTO product_details
    (
    	`name`,
        `product_id`,
        `reference`,
        `sku`,
        `ean13`,
        `upc`,
        `cost`,
        `sale_price`,
        `condition_id`,
        `price_list_id`,
        `created_at`,
        `updated_at`,
        created_by
    )
    VALUES(
    	bp_name,
        bp_product_id,
        bp_reference,
        bp_sku,
        bp_ean13,
        bp_upc,
        bp_cost,
        bp_sale_price,
        bp_condition_id,
        bp_price_list_id,
        NOW(),
        NOW(),
        bp_created_by
    );
    SET LID = LAST_INSERT_ID();
    SELECT LID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertProspect
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertProspect`(
	IN `bp_cif` VARCHAR(50),
	IN `bp_alias` VARCHAR(50),
	IN `bp_name` VARCHAR(50),
	IN `bp_name_2` VARCHAR(50),
	IN `bp_url` VARCHAR(50),
	IN `bp_email` VARCHAR(50),
	IN `bp_represent_id` INT,
	IN `bp_address` VARCHAR(50),
	IN `bp_country_id` INT,
	IN `bp_state_id` INT,
	IN `bp_city_id` INT,
	IN `bp_postal` VARCHAR(50),
	IN `bp_phone` VARCHAR(50)
,
	IN `bp_created_by` INT
)
BEGIN
	DECLARE id_third INT;
	DECLARE id_location INT;
	DECLARE id_branch INT;
-- { cif,business_name,trade_name,alias,address,postal_code,phone,email,site_web,country_id,state_id,city_id}
	INSERT INTO bpartners (cif, alias, name, name_2, url, email, is_prospect, sales_rep_id, created_at, updated_at, created_by)
	VALUES (bp_cif, bp_alias, bp_name, bp_name_2, bp_url, bp_email, 1, bp_represent_id, NOW(), NOW(), bp_created_by);
	SET id_third = LAST_INSERT_ID();

	INSERT INTO locations (address_1, country_id, state_id, city_id, postal, created_at, updated_at)
	VALUES (bp_address, bp_country_id, bp_state_id, bp_city_id, bp_postal, NOW(), NOW());
	SET id_location = LAST_INSERT_ID();
	
	INSERT INTO bpartner_locations (bpartner_id, location_id, name, is_ship_to, is_bill_to, is_pay_from, is_remit_to, phone, created_at, updated_at)
	VALUES (id_third, id_location, bp_name, 1, 1, 1, 1, bp_phone, NOW(), NOW());
	SET id_branch = LAST_INSERT_ID();
	
	SELECT id_third;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertRealStockProductDetail
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertRealStockProductDetail`(
	IN `bp_product_detail` INT,
	IN `bp_real_stock` DECIMAL(10,0)
)
BEGIN
	DECLARE vp_warehouse_id INT;
	
	SET vp_warehouse_id = (SELECT w.id FROM warehouses w INNER JOIN setup_sales s_s ON w.id = s_s.warehouse_id AND s_s.`default` = 1 LIMIT 1);

	INSERT INTO stocks (warehouse_id, product_id, real_stock, ordered_stock, reserved_stock, available_stock, created_at, updated_at)
		VALUES (vp_warehouse_id, bp_product_detail, bp_real_stock, 0, 0, 0, NOW(), NOW());
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertReport
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertReport`(
	IN `bp_name` varchar(50),
	IN `bp_description` varchar(50),
	IN `bp_table_id` INT,
	IN `bp_header_id` INT,
	IN `bp_body_id` INT,
	IN `bp_footer_id` INT,
	IN `bp_created_by` INT
)
BEGIN
	DECLARE LID INT;
	
	INSERT INTO `reports` (`name`, `description`, `table_id`, `header_id`, `body_id`, `footer_id`, `created_by`)
	VALUES (bp_name, bp_description, bp_table_id, bp_header_id, bp_body_id, bp_footer_id, bp_created_by);
	
	SET LID = LAST_INSERT_ID();
	SELECT LID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertReportOld
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertReportOld`(
	IN `bp_uid` INT(10),
	IN `bp_table` VARCHAR(255),
	IN `bp_template` VARCHAR(255),
	IN `bp_title` VARCHAR(32),
	IN `bp_description` VARCHAR(64),
	IN `bp_picture` VARCHAR(255)
	
)
BEGIN
		DECLARE id int;
			INSERT INTO reports (`user_id`, `table`, `template`, `title`, `description`, `picture`)
			VALUES(`bp_uid`, `bp_table`, `bp_template`, `bp_title`, `bp_description`, `bp_picture`);
			SET id = LAST_INSERT_ID();
		SELECT id;
	END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertRol
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertRol`(
	IN `bp_rol_name` VARCHAR(45),
	IN `bp_description` VARCHAR(45),
	IN `bp_all_access_column` BOOLEAN,
	IN `bp_all_access_organization` BOOLEAN,
	IN `bp_created_by` INT
)
BEGIN
	DECLARE id int;
	INSERT INTO rols (`name`, description, all_access_column, all_access_organization, created_at, updated_at, created_by)
    VALUES (bp_rol_name, bp_description, bp_all_access_column, bp_all_access_organization, NOW(), NOW(), bp_created_by);
	SET id = LAST_INSERT_ID();
	SELECT id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertSetting
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertSetting`(
	IN `bp_user` INT
,
	IN `bp_country` INT,
	IN `bp_state` INT,
	IN `bp_city` INT,
	IN `bp_language` INT

)
BEGIN
	DECLARE id INT;
	
	INSERT INTO settings (user_id, country_id, state_id, city_id, language_id, created_at, updated_at)
	VALUES (bp_user, bp_country, bp_state, bp_city, bp_language, NOW(), NOW());
	
	SET id = LAST_INSERT_ID();
	SELECT id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertSetupConfiguration
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertSetupConfiguration`(
	IN `bp_user` INT,
	IN `bp_setting` JSON,
	IN `bp_default` BOOLEAN




)
BEGIN
	DECLARE id INT;
	
	INSERT INTO setup_configurations (user_id, setting, `default`, created_at, updated_at)
	VALUES
	(bp_user, bp_setting, bp_default, NOW(), NOW());
	
	SET id = LAST_INSERT_ID();
	SELECT id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertSetupSale
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertSetupSale`(
	IN `bp_user` INT,
	IN `bp_setting` JSON,
	IN `bp_default` BOOLEAN
)
BEGIN
	DECLARE id INT;
	
	INSERT INTO setup_sales (user_id, setting, `default`, created_at, updated_at)
	VALUES
	(bp_user, bp_setting, bp_default, NOW(), NOW());
	
	SET id = LAST_INSERT_ID();
	SELECT id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertState
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertState`(
	IN `bp_country_id` INT,
	IN `bp_state_name` VARCHAR(45),
	IN `bp_iso` VARCHAR(5) ,
	IN `bp_created_by` INT
)
BEGIN
	DECLARE LID int;
	INSERT INTO states (country_id, state, iso, created_at, updated_at, created_by)
    VALUES ( bp_country_id, bp_state_name, bp_iso, NOW(), NOW(), bp_created_by );
    SET LID = LAST_INSERT_ID();
	SELECT LID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertTableListSetting
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertTableListSetting`(
	IN `bp_user` INT,
	IN `bp_table` INT,
	IN `bp_setting` JSON

)
BEGIN	
	INSERT INTO table_list_settings (`user_id`, `table_id`, `setting`)
	VALUES (`bp_user`, `bp_table`, `bp_setting`);
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertTax
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertTax`(
	IN `bp_name` VARCHAR(50),
	IN `bp_print_name` VARCHAR(50),
	IN `bp_validfrom` DATETIME,
	IN `bp_rate` DECIMAL(10,0),
	IN `bp_notes` TEXT


,
	IN `bp_created_by` INT
)
BEGIN
	DECLARE LID int;
	INSERT INTO taxes (name, print_name, validfrom, rate, created_at, updated_at, notes, created_by )
    VALUES ( bp_name, bp_print_name, bp_validfrom,bp_rate, NOW(), NOW(), bp_notes, bp_created_by );
    SET LID = LAST_INSERT_ID();
	SELECT LID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertToken
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertToken`(
	IN `bp_user_id` INT,
	IN `bp_name` VARCHAR(191),
	IN `bp_token` VARCHAR(255),
	IN `bp_revoked` BOOLEAN
)
    COMMENT 'Abre una sesion en BD al usuario mediante su id,  nombre del cliente, token y si es revocado'
BEGIN
	DELETE FROM oauth_access_tokens WHERE user_id = bp_user_id and `name` = bp_name;
	INSERT INTO oauth_access_tokens (user_id, name, token, revoked, created_at, updated_at, expires_at)
    VALUES (bp_user_id, bp_name, bp_token, bp_revoked, NOW(), NOW(),  DATE_ADD(now(), INTERVAL 60 MINUTE));
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertTypeDocumentSetting
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertTypeDocumentSetting`(
	IN `bp_type_document` INT,
	IN `bp_setting` JSON
,
	IN `bp_user` INT
)
BEGIN	
	INSERT INTO `type_document_settings` (`type_document_id`, `setting`, `user_id`)
	VALUES (`bp_type_document`, `bp_setting`, `bp_user`);
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertUnits
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertUnits`(
	IN `bp_tag` varchar(45),
	IN `bp_quantity` double

,
	IN `bp_created_by` INT
)
BEGIN

DECLARE LID int;

INSERT INTO `units` (`name`, `quantity`, `created_at`, `updated_at`, `created_by`)
VALUES (bp_tag, bp_quantity, NOW(), NOW(), bp_created_by);
SET LID = LAST_INSERT_ID();
SELECT LID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertUser
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertUser`(
	IN `bp_user_name` VARCHAR(45),
	IN `bp_password` VARCHAR(65),
	IN `bp_email` VARCHAR(45),
	IN `bp_remember_token` VARCHAR(100),
	IN `bp_contact_id` INT
,
	IN `bp_created_by` INT
)
BEGIN
	DECLARE id int;
	INSERT INTO users (`name`, `password`, email, remember_token, contact_id, created_at, updated_at, created_by)
    VALUES (bp_user_name, bp_password, bp_email, bp_remember_token, bp_contact_id, NOW(), NOW(), bp_created_by);
    SET id = LAST_INSERT_ID();
	SELECT id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertUserRol
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertUserRol`(
	IN `bp_user_id` INT,
	IN `bp_rol_id` INT
)
BEGIN
	INSERT INTO user_rol (user_id, rol_id)
    VALUES ( bp_user_id, bp_rol_id );
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.CR_InsertWarehouse
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `CR_InsertWarehouse`(
	IN `bp_organization_id` INT,
	IN `bp_reference` VARCHAR(50),
	IN `bp_name` VARCHAR(50),
	IN `bp_notes` VARCHAR(50)
)
BEGIN

DECLARE LID int;

INSERT INTO `warehouses` ( `organization_id`, `reference`, `name`, `created_at`, `updated_at`, `notes`) 
VALUES (`bp_organization_id`, `bp_reference`, `bp_name`, NOW(), NOW(), `bp_notes`);



SET LID = LAST_INSERT_ID();
SELECT LID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_ArchivedBranch
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_ArchivedBranch`(IN `bp_branch_id` INT, IN `bp_archived` BOOLEAN)
BEGIN
	UPDATE bpartner_locations
    SET archived = bp_archived
    WHERE id = bp_branch_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_ArchivedCategory
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_ArchivedCategory`(
	IN `bp_category_id` INT,
	IN `bp_archived` BOOLEAN

,
	IN `bp_archived_by` INT
)
BEGIN
	UPDATE categories
	SET archived = bp_archived, updated_by = bp_archived_by
	WHERE id = bp_category_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_ArchivedCity
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_ArchivedCity`(
	IN `bp_city_id` INT,
	IN `bp_archived` BOOLEAN


,
	IN `bp_archived_by` INT
)
    DETERMINISTIC
BEGIN
	UPDATE cities
    SET archived = bp_archived, updated_by = bp_archived_by
    WHERE id = bp_city_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_ArchivedContact
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_ArchivedContact`(
	IN `bp_contact_id` INT,
	IN `bp_archived` BOOLEAN,
	IN `bp_archived_by` INT
)
BEGIN
	UPDATE contacts SET archived = bp_archived, updated_by = bp_archived_by WHERE id = bp_contact_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_ArchivedCountry
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_ArchivedCountry`(
	IN `bp_country_id` INT,
	IN `bp_archived` BOOLEAN,
	IN `bp_archived_by` INT
)
BEGIN
	UPDATE countries
    SET archived = bp_archived, updated_by = bp_archived_by
    WHERE id = bp_country_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_ArchivedCurrency
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_ArchivedCurrency`(
	IN `bp_id_currency` INT,
	IN `bp_archived` BOOLEAN

,
	IN `bp_archived_b` INT

)
BEGIN
	UPDATE currencies
	SET archived = bp_archived, updated_by = bp_archived_b
	WHERE id = bp_id_currency;

END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_ArchivedLanguage
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_ArchivedLanguage`(
	IN `bp_lang_id` INT,
	IN `bp_archived` BOOLEAN

)
BEGIN

	UPDATE languages
    SET archived = bp_archived
    WHERE id = bp_lang_id;

END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_ArchivedManufacturer
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_ArchivedManufacturer`(
	IN `bp_manufacturer_id` int,
	IN `bp_archived` boolean
,
	IN `bp_archived_by` INT
)
BEGIN

UPDATE `manufacturers`
SET archived= bp_archived, updated_by = bp_archived_by
WHERE id = bp_manufacturer_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_ArchivedOrganization
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_ArchivedOrganization`(
	IN `bp_id` int,
	IN `bp_archived` boolean
,
	IN `bp_archived_by` INT
)
BEGIN

UPDATE `organizations`
SET archived= bp_archived, updated_by = bp_archived_by
WHERE id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_ArchivedProduct
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_ArchivedProduct`(
	IN `bp_id` INT,
	IN `bp_archived` TINYINT
,
	IN `bp_archived_by` INT
)
BEGIN
	UPDATE products SET
		archived = bp_archived,
		updated_by = bp_archived_by
	WHERE id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_ArchivedProductDetail
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_ArchivedProductDetail`(
	IN `bp_id` INT(11),
	IN `bp_archived` TINYINT
,
	IN `bp_archived_by` INT
)
BEGIN
    UPDATE product_details SET
        `archived` = bp_archived,
        `updated_by` = bp_archived_by
    WHERE
        id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_ArchivedRol
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_ArchivedRol`(
	IN `bp_rol_id` INT,
	IN `bp_archived` BOOLEAN,
	IN `bp_archived_by` INT
)
BEGIN
	UPDATE rols 
	SET archived = bp_archived, updated_by = bp_archived_by
	WHERE id = bp_rol_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_ArchivedState
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_ArchivedState`(
	IN `bp_state_id` INT,
	IN `bp_archived` BOOLEAN,
	IN `bp_archived_by` INT
)
BEGIN
	UPDATE states
    SET archived = bp_archived, updated_by = bp_archived_by
    WHERE id = bp_state_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_ArchivedThird
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_ArchivedThird`(
	IN `bp_third_id` INT,
	IN `bp_archived` BOOLEAN,
	IN `bp_archived_by` INT
)
BEGIN
	UPDATE bpartners
    SET archived = bp_archived, updated_by = bp_archived_by
    WHERE id = bp_third_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_ArchivedUnits
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_ArchivedUnits`(
	IN `bp_unit_id` INT,
	IN `bp_archived` BOOLEAN

,
	IN `bp_archived_by` INT
)
BEGIN
	UPDATE units
	SET archived = bp_archived, updated_by = bp_archived_by
	WHERE id = bp_unit_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_ArchivedUser
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_ArchivedUser`(
	IN `bp_user_id` INT,
	IN `bp_archived` BOOLEAN,
	IN `bp_archived_by` INT
)
BEGIN
	UPDATE users 
	SET archived = bp_archived, updated_by = bp_archived_by
	WHERE id = bp_user_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_BpartnerContactRelation
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_BpartnerContactRelation`(
	IN `bp_bpartner_id` INT,
	IN `bp_contact_id` INT,
    IN `bp_user` INT
)
BEGIN
	
    
	DECLARE user_id INT DEFAULT 0;
    DELETE FROM bpartner_contact
    WHERE
		bpartner_id = bp_bpartner_id
        AND
        contact_id = bp_contact_id;
   
   SET user_id = (SELECT id FROM users WHERE contact_id = bp_contact_id);
   
   IF user_id > 0 THEN
   
   	CALL DL_DeleteUser(user_id, bp_user);
	
   END IF;
   set @contacts_delete = bp_user;
   DELETE FROM contacts
	WHERE
	id = bp_contact_id;
    /*
    DELETE FROM bpartners WHERE id = bp_bpartner_id;
    DELETE FROM locations WHERE id = bp_location_id;
    */
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteAllDetailsOfProduct
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteAllDetailsOfProduct`(
	IN `bp_id` INT

)
BEGIN
	DELETE FROM attribute_detail_product_detail
	WHERE
		product_detail_id IN ( SELECT d.id FROM product_details d WHERE d.product_id = bp_id );
		
   DELETE FROM product_details
   WHERE
   	product_id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteAttribute
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteAttribute`(
	IN `bp_id` INT,
	IN `bp_user` INT
)
BEGIN
	SET @attribute_details_delete = bp_user;
    DELETE FROM attribute_details
    WHERE
		attribute_id = bp_id;
		
	SET @attributes_delete = bp_user;
	DELETE FROM attributes
    WHERE id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteAttributeDetail
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteAttributeDetail`(
	IN `bp_id` INT,
	IN `bp_user` INT
)
BEGIN
	SET @attribute_details_delete = bp_user;
	DELETE FROM attribute_details
    WHERE
		id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteAttributeDetailProductDetail
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteAttributeDetailProductDetail`(
	IN `bp_product_detail_id` INT
)
BEGIN
	DELETE FROM attribute_detail_product_detail WHERE product_detail_id = bp_product_detail_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteAudit
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteAudit`(
	IN `bp_id` INT
)
BEGIN

	DELETE FROM audits WHERE id = bp_id;

END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteBodyDocument
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteBodyDocument`(
    IN `bp_id` INT
)
BEGIN
    DELETE FROM `body_documents` WHERE `id` = `bp_id`;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteBodyReport
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteBodyReport`(
	IN `bp_id` INT
)
BEGIN	
	DELETE FROM `bodies_reports`
    WHERE
        id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteBodyReportOrganization
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteBodyReportOrganization`(
	IN `bp_body_report_id` INT,
	IN `bp_org_id` INT
)
BEGIN
	DELETE FROM body_report_organization WHERE body_report_id = bp_body_report_id AND organization_id = bp_org_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteBpartnerData
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteBpartnerData`(
	IN `bp_bpartner_id` INT,
	IN `bp_user` int
)
BEGIN
	
	DELETE FROM organization_bpartner
		WHERE
			bpartner_id = bp_bpartner_id;
	
	
	CREATE TEMPORARY TABLE tmp_b_l AS
		(
			SELECT location_id id FROM bpartner_locations b_l WHERE b_l.bpartner_id = bp_bpartner_id
        );
	set @bpartner_locations_delete = bp_user;
    DELETE FROM bpartner_locations
    WHERE
		bpartner_id = bp_bpartner_id;
	
    
	set @locations_delete = bp_user;
	DELETE FROM locations WHERE id IN (SELECT id FROM tmp_b_l);
    
    CREATE TEMPORARY TABLE tmp_b_c AS
		(
			SELECT contact_id id FROM bpartner_contact b_c WHERE b_c.bpartner_id = bp_bpartner_id
        );
	

    DELETE FROM bpartner_contact
    WHERE
		bpartner_id = bp_bpartner_id;
        
	set @contacts_delete = bp_user;
    DELETE FROM contacts WHERE id IN (SELECT id FROM tmp_b_c);
    
    set @bpartners_delete = bp_user;
    DELETE FROM bpartners WHERE id = bp_bpartner_id;
    
    DROP TABLE tmp_b_l, tmp_b_c;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteBpartnerOrganization
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteBpartnerOrganization`(
	IN `bp_third_id` INT,
	IN `bp_org_id` INT
)
BEGIN    
/*    DELETE FROM bpartner_organization
    WHERE
		bpartner_id = bp_bpartner_id;*/
	DELETE FROM `organization_bpartner` WHERE bpartner_id = bp_third_id AND organization_id = bp_org_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteBranch
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteBranch`(
	IN `bp_branch_id` INT,
	IN `bp_location_id` INT,
	IN `bp_user` INT

)
BEGIN

	set @bpartner_locations_delete = bp_user;
    DELETE FROM bpartner_locations
    WHERE
		id = bp_branch_id;
	DELETE FROM locations
    WHERE
		id = bp_location_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteCategory
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteCategory`(
	IN `bp_category_id` INT,
	IN `bp_user_id` INT
)
BEGIN
	SET @categories_delete = bp_user_id;
   DELETE FROM categories WHERE
	id = bp_category_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteCharge
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteCharge`(
	IN `bp_id` int,
	IN `bp_user` INT
)
BEGIN
	SET @charges_delete = bp_user;
	DELETE FROM `charges`
	WHERE id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteCity
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteCity`(
	IN `bp_id` int,
	IN `bp_user` INT
)
BEGIN
SET @cities_delete = bp_user;
DELETE FROM cities WHERE id=bp_id; 
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteCondition
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteCondition`(
	IN `bp_condition_id` INT
)
BEGIN    
    DELETE FROM conditions
    WHERE
		id = bp_condition_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteCounterSerie
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteCounterSerie`(
	IN `bp_id` INT,
	IN `bp_user` INT
)
BEGIN
	SET @counter_series_delete = bp_user;
    DELETE FROM counter_series
    WHERE
		id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteCountry
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteCountry`(
	IN `bp_id` int,
	IN `bp_user` INT
)
BEGIN
	SET @countries_delete = bp_user;
	DELETE FROM countries WHERE id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteCurrency
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteCurrency`(
	IN `bp_currency_id` INT

,
	IN `bp_user` INT
)
BEGIN
	SET @currencies_delete = bp_user;
	DELETE FROM currencies WHERE id=bp_currency_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteDiscountFooter
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteDiscountFooter`(
    IN `bp_id` INT
)
BEGIN
    DELETE FROM `discounts_footers_documents` WHERE `id` = `bp_id`;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteDocument
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteDocument`(
	IN `bp_reference` VARCHAR(1000),
	IN `bp_user` INT

)
BEGIN
    DECLARE bv_project_id INT;
    DECLARE bv_count_documents INT;
    DECLARE bv_footer_id INT;

    SET bv_project_id = (SELECT `header_project_id` FROM `documents` WHERE `reference` =  `bp_reference`);
    SET bv_count_documents = (
        SELECT COUNT(d.reference) FROM `documents` d
        INNER JOIN `header_projects` h_p ON h_p.id = d.header_project_id
        WHERE d.reference = `bp_reference`
    );
    SET bv_footer_id = (SELECT `id` FROM `footer_documents` WHERE `reference_document` =  `bp_reference`);


    DELETE FROM `discounts_footers_documents` WHERE `footer_document_id` =  `bv_footer_id`;
    DELETE FROM `footer_grouped_taxes` WHERE `footer_document_id` =  `bv_footer_id`;
    
    SET @footer_documents = bp_user;
    DELETE FROM `footer_documents` WHERE `reference_document` =  `bp_reference`;

    SET @body_documents = bp_user;
    DELETE FROM `body_documents` WHERE `reference_document` =  `bp_reference`;

    SET @documents = bp_user;
    DELETE FROM `documents` WHERE `reference` =  `bp_reference`;

    IF bv_count_documents = 1 THEN
        SET @header_projects = bp_user;
        DELETE FROM `header_projects` WHERE `id` = bv_project_id;
    END IF;
    
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteFooterGroupedTax
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteFooterGroupedTax`(
	IN `bp_footer_document_id` INT
)
BEGIN
	DELETE FROM `footer_grouped_taxes` WHERE `footer_document_id` = `bp_footer_document_id`;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteFooterReport
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteFooterReport`(
	IN `bp_id` INT
)
BEGIN	
	DELETE FROM `footers_reports`
    WHERE
        id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteFooterReportOrganization
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteFooterReportOrganization`(
	IN `bp_footer_report_id` INT,
	IN `bp_org_id` INT
)
BEGIN
	DELETE FROM footer_report_organization WHERE footer_report_id = bp_footer_report_id AND organization_id = bp_org_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteHeaderReport
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteHeaderReport`(
	IN `bp_id` INT
)
BEGIN	
	DELETE FROM `headers_reports`
    WHERE
        id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteHeaderReportOrganization
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteHeaderReportOrganization`(
	IN `bp_header_report_id` INT,
	IN `bp_org_id` INT
)
BEGIN
	DELETE FROM header_report_organization WHERE header_report_id = bp_header_report_id AND organization_id = bp_org_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteImageReport
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteImageReport`(
	IN `bp_id` INT
)
BEGIN	
	DELETE FROM `images_reports`
    WHERE
        id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteImageReportOrganization
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteImageReportOrganization`(
	IN `bp_image_report_id` INT,
	IN `bp_org_id` INT
)
BEGIN
	DELETE FROM image_report_organization WHERE image_report_id = bp_image_report_id AND organization_id = bp_org_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteLanguage
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteLanguage`(
	IN `bp_id` int
)
BEGIN
DELETE FROM languages WHERE id=bp_id ;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteLanguageTag
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteLanguageTag`(
	IN `id_table_param` INT,
	IN `tag_id` INT
)
BEGIN

	DECLARE table_param varchar(255);
	SET table_param = 'language_global';
	
	IF  id_table_param != 0 THEN
	
		SET table_param = (SELECT  CONCAT( '`language_' , table_name ,'`')  FROM banana.tables where id = id_table_param);
	
	END IF;
	
	SET @VV_CONSDINAM = CONCAT('DELETE FROM ', table_param, ' WHERE parent_tag =', tag_id, ';');
	
	PREPARE SENTENCIA FROM @VV_CONSDINAM;
	
	EXECUTE SENTENCIA;

END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteManufacturer
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteManufacturer`(
	IN `bp_manufacturer_id` int
,
	IN `bp_user` INT
)
BEGIN
	SET @manufacturers_delete = bp_user;
	DELETE FROM `manufacturers`
	WHERE id = bp_manufacturer_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteOrganization
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteOrganization`(
	IN `bp_id` int

,
	IN `bp_user` INT



)
BEGIN
DECLARE location_id INT;

SET location_id = (SELECT location_id FROM organizations WHERE id = bp_id);

SET @warehouses_delete = bp_user;
DELETE FROM warehouses
	WHERE organization_id = bp_id;

SET @counter_series_delete = bp_user;
DELETE FROM counter_series
	WHERE organization_id = bp_id;

SET @organizations_delete = bp_user;
DELETE FROM organizations
WHERE id = bp_id;

SET @locations_delete = bp_user;
DELETE FROM locations
WHERE id = location_id;

END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteOrganizationPriceList
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteOrganizationPriceList`(
	IN `bp_price_list_id` INT
,
	IN `bp_org_id` INT
)
BEGIN
	DELETE FROM organization_price_list WHERE price_list_id = bp_price_list_id AND organization_id = bp_org_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteOrganizationProduct
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteOrganizationProduct`(
	IN `bp_product_id` INT
,
	IN `bp_org_id` INT
)
BEGIN
	DELETE FROM organization_product
	WHERE product_id = bp_product_id AND organization_id = bp_org_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteOrganizationReport
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteOrganizationReport`(
	IN `bp_report_id` INT,
	IN `bp_org_id` INT
)
BEGIN
	DELETE FROM organization_report WHERE report_id = bp_report_id AND organization_id = bp_org_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteOrganizationRol
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteOrganizationRol`(
	IN `bp_rol_id` INT,
	IN `bp_org_id` INT
)
BEGIN    
    DELETE FROM organization_rol
    WHERE
		rol_id = bp_rol_id AND organization_id = bp_org_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteOrganizationUser
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteOrganizationUser`(
	IN `bp_user_id` INT,
	IN `bp_org_id` INT
)
BEGIN    
    DELETE FROM organization_user
    WHERE
		user_id = bp_user_id AND organization_id = bp_org_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeletePrice
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeletePrice`(
	IN `bp_id` INT
,
	IN `bp_user` INT
)
BEGIN
	SET @prices_delete = bp_user;
	DELETE FROM prices WHERE id = bp_id;

END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeletePriceList
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeletePriceList`(
	IN `bp_id` int

,
	IN `bp_user` INT

)
BEGIN
	DELETE FROM organization_price_list
	WHERE price_list_id = bp_id;
	
	SET @prices_delete = bp_user;
	DELETE FROM prices
	WHERE price_list_id = bp_id;
	
	SET @price_lists_delete = bp_user;
	DELETE FROM price_lists
	WHERE id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteProduct
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteProduct`(
	IN `bp_id` INT



,
	IN `bp_user` INT
)
BEGIN
	DELETE FROM attribute_detail_product_detail WHERE product_detail_id IN (
		SELECT id FROM product_details WHERE product_id = bp_id
	);
	
	SET @product_details_delete = bp_user;
	DELETE FROM product_details WHERE product_id = bp_id;
	
	DELETE FROM organization_product WHERE product_id = bp_id;
	SET @products_delete = bp_user;
	DELETE FROM products WHERE id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteProductDetail
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteProductDetail`(
	IN `bp_id` INT(11)

,
	IN `bp_user` INT
)
BEGIN
	DELETE FROM attribute_detail_product_detail
	WHERE
		product_detail_id = bp_id;
	
	SET @product_details_delete = bp_user;
   DELETE FROM product_details
   WHERE
   	id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteReport
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteReport`(
	IN `bp_id` INT
)
BEGIN	
	DELETE FROM `reports` WHERE id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteRol
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteRol`(
	IN `bp_id` INT,
	IN `bp_user` INT
)
BEGIN
	SET @permissions_rols_delete = bp_user;
	DELETE FROM permissions_rols
    WHERE
		rol_id = bp_id;
        
	DELETE FROM organization_rol
    WHERE
		rol_id = bp_id;
	
	SET @rols_delete = bp_user;
    DELETE FROM rols
    WHERE
		id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteRolUser
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteRolUser`(
IN `bp_user_id` INT)
BEGIN    
    DELETE FROM user_rol
    WHERE
		user_id = bp_user_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteState
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteState`(
	IN `bp_id` int,
	IN `bp_user` INT
)
BEGIN
SET @states_delete = bp_user;
DELETE FROM states WHERE id = bp_id ;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteTax
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteTax`(
	IN `bp_tax_id` INT

,
	IN `bp_user` INT
)
BEGIN
SET @taxes_delete = bp_user;
DELETE FROM taxes
    WHERE
		id = bp_tax_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteUnit
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteUnit`(
	IN `bp_unit_id` INT
,
	IN `bp_user` INT
)
BEGIN
	SET @units_delete = bp_user;
    DELETE FROM units
    WHERE
		id = bp_unit_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteUser
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteUser`(
	IN `bp_id` INT,
	IN `bp_user` INT

)
BEGIN
	SET @permissions_users_delete = bp_user;
	DELETE FROM permissions_users
    WHERE
		user_id = bp_id;
        
	DELETE FROM organization_user
    WHERE
		user_id = bp_id;
	
    DELETE FROM user_rol
    WHERE
		user_id = bp_id;
		
	DELETE FROM setup_configurations
    WHERE
		user_id = bp_id;
		
	set @users_delete = bp_user;
    DELETE FROM users
    WHERE
		id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_DeleteWarehouse
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_DeleteWarehouse`(
	IN `bp_id` int

)
BEGIN
	DELETE FROM warehouses
	WHERE id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.DL_LogOut
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `DL_LogOut`(
	IN `bp_id` INT
)
    COMMENT 'revoca la sesion del usuario mediante su id'
BEGIN
    UPDATE oauth_access_tokens  SET revoked = 1 WHERE user_id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.migrateBpartner
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `migrateBpartner`(
	in bp_org_id int, 
	in bp_Logo varchar(45), 
	in bp_is_customer boolean, 
	in bp_is_Vendor boolean, 
	in bp_name varchar(120), 
	in bp_name2 varchar(120), 
	in bp_is_Employee boolean,  
	in bp_is_Prospect boolean, 
	in bp_is_SalesRep boolean, 
	in bp_ReferenceNo varchar(25), 
	in bp_SalesRep_id int, 
	in bp_CreditStatus char(1), 
	in bp_CreditLimit double,
	in bp_TaxId int, 
	in bp_is_TaxExempt boolean,
	in bp_is_POTaxExempt boolean,
	in bp_URL varchar(120),
	in bp_description varchar(255),
	in bp_is_Summary boolean,
	in bp_PriceList_id int, 
	in bp_DeliveryRule char(1), 
	in bp_DeliveryViaRule char(1), 
	in bp_FlatDiscount double, 
	in bp_is_Manufacturer boolean, 
	in bp_PO_PriceList_id int, 
	in bp_Language_id int, 
	in bp_Greeting_id int,
    IN bp_address_1 VARCHAR(60),
	IN bp_address_2 VARCHAR(60),
	IN bp_address_3 VARCHAR(60),
	IN bp_address_4 VARCHAR(60),
	IN bp_city_id INT,
	IN bp_city_name VARCHAR(60),
	IN bp_postal VARCHAR(10),
	IN bp_postal_add VARCHAR(10),
	IN bp_state_id INT,
	IN bp_state_name VARCHAR(45),
	IN bp_country_id INT,
	IN bp_comments TEXT
)
BEGIN
DECLARE LIDBpartners int;
DECLARE LIDLocation int;

call CR_InsertBpartners(
    bp_org_id , 
    bp_Logo , 
    bp_is_customer , 
    bp_is_Vendor , 
    bp_name , 
    bp_name2 , 
    bp_is_Employee ,  
    bp_is_Prospect , 
    bp_is_SalesRep , 
    bp_ReferenceNo , 
    bp_SalesRep_id , 
    bp_CreditStatus , 
    bp_CreditLimit ,
    bp_TaxId , 
    bp_is_TaxExempt ,
    bp_is_POTaxExempt ,
    bp_URL ,
    bp_description ,
    bp_is_Summary ,
    bp_PriceList_id , 
    bp_DeliveryRule , 
    bp_DeliveryViaRule , 
    bp_FlatDiscount , 
    bp_is_Manufacturer , 
    bp_PO_PriceList_id , 
    bp_Language_id , 
    bp_Greeting_id );
    
SET LIDBpartners = LAST_INSERT_ID();

call CR_InsertLocation(
bp_address_1,
bp_address_2,
bp_address_3,
bp_address_4,
bp_city_id,
bp_city_name,
bp_postal,
bp_postal_add,
bp_state_id,
bp_state_name,
bp_country_id,
bp_comments);

SET LIDLocation = LAST_INSERT_ID();

call CR_InsertBpartnerLocation(LIDBpartners,LIDLocation,bp_name,1,1,1,1,null,null,null,null);


END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_child_tables
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_child_tables`( in bp_table_id int, inout childs text)
BEGIN



	DECLARE countChilds INT DEFAULT NULL ;
    
    DECLARE v_finished INTEGER DEFAULT 0;
    DECLARE v_child INT DEFAULT NULL;
    
     -- declare cursor for employee email
 DECLARE child_cursor CURSOR FOR 
	SELECT child_id FROM child_table c WHERE table_id  = bp_table_id;
    
 -- declare NOT FOUND handler
 DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET v_finished = 1;
        SET max_sp_recursion_depth=255;
        
OPEN child_cursor;
 
		 get_childs: LOOP
		 
		 FETCH child_cursor INTO v_child;
		 
		 IF v_finished = 1 THEN 
		 LEAVE get_childs;
		 END IF;
		 
		CALL RD_child_tables(v_child, childs);
            
		 SET childs = CONCAT(v_child,IF(childs != "",',','' ),childs);
		 
		 END LOOP get_childs;
		 
 CLOSE child_cursor;
 


END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_getAllColumnTablesChild
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_getAllColumnTablesChild`(in bp_table_id int)
BEGIN
declare childs text default '';
declare tables_child text;


call banana.RD_child_tables(bp_table_id, childs);


SET @VV_CONSDINAM = CONCAT('SELECT  t2.id table_id,  t1.id id_column, t1.description, t1.column_name, t2.table_name , (if(t3.required is null,0, t3.required)) as required, t4.name as type_data,  0 as selected  from columns t1
        left join tables t2 ON t1.table_id = t2.id
        left join field_configurations t3 ON t1.id = t3.column_id
        left join column_type t4 on t1.column_type_id = t4.id
        where (table_id = ',bp_table_id,' or table_id in  (' ,childs,'))
		  and t1.column_name not like ''organization_id''
		  and t1.column_name not like ''updated_at''
		  and t1.column_name not like ''created_at''
		  and t1.column_name not like ''id''
		  ORDER BY t2.table_name , t1.column_name ; ');


PREPARE SENTENCIA FROM @VV_CONSDINAM;

 EXECUTE SENTENCIA;


END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_GetAllTrackAudit
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_GetAllTrackAudit`(
	IN `bp_table_name` varchar(50)

)
BEGIN




-- select distinct table_name, column_name FROM information_schema.key_column_usage WHERE referenced_table_name = bp_table_name ; 




/*SELECT  IF(referenced_table_name = bp_table_name, true, false )as primaryKey,   IFNULL(referenced_table_name ,  table_name ) as table_name, column_name, table_name as relacional_table

FROM information_schema.key_column_usage
WHERE TABLE_NAME IN (
	SELECT TABLE_NAME
	FROM information_schema.key_column_usage
	WHERE referenced_table_name = bp_table_name AND TABLE_NAME != bp_table_name AND TABLE_SCHEMA = 'banana'
) 
AND TABLE_SCHEMA = 'banana' 

AND column_name not in('created_by', 'updated_by') AND (referenced_table_name IS NOT NULL OR ( column_name = 'id' AND CONSTRAINT_NAME = 'PRIMARY' ) );*/
SELECT IF(referenced_table_name = bp_table_name, true, false )as primaryKey, IFNULL(referenced_table_name, table_name ) as table_name, column_name, table_name as relacional_table
FROM information_schema.key_column_usage
WHERE TABLE_NAME IN (
	SELECT DISTINCT TABLE_NAME
	FROM information_schema.key_column_usage
	WHERE referenced_table_name = bp_table_name AND TABLE_NAME != bp_table_name AND column_name not in('created_by', 'updated_by') AND TABLE_SCHEMA = 'banana'
) 
AND TABLE_SCHEMA = 'banana' 

AND column_name not in('created_by', 'updated_by') AND (referenced_table_name IS NOT NULL);

END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_LoginUser
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_LoginUser`(IN bp_email varchar(45))
BEGIN
	SELECT * FROM users WHERE ( email = bp_email );
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_SelectColumnAccessUser
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_SelectColumnAccessUser`(IN bp_user_id INT, IN bp_table_id int )
BEGIN

	SET @bv_rol_id := (SELECT rol_id FROM users WHERE users.id = bp_user_id);

	SELECT distinct t1.id, t1.column_name 'key', t1.description label,
	t2.position 'order', t2.required ,
		t3.input_name control_type, 
     (select REFERENCED_TABLE_NAME 
	 from information_schema.KEY_COLUMN_USAGE sqT1 
	 where sqT1.COLUMN_NAME = t1.column_name limit 1 ) as REFERENCED_TABLE_NAME
	FROM columns t1 
	left join field_configurations t2 ON t1.id = t2.column_id
	left join input_types t3 ON t2.input_type_id = t3.id
	
	WHERE t1.table_id = bp_table_id AND (
	t1.id IN ( 
			SELECT DISTINCT columns.id
			FROM tables, columns, permissions_rols
			WHERE ( tables.id = columns.table_id )
				AND ( columns.id = permissions_rols.column_id )
				AND ( permissions_rols.rol_id = @bv_rol_id )
				AND tables.id = bp_table_id) 
	OR t1.id IN(
			SELECT DISTINCT columns.id
			FROM tables, columns, permissions_users
			WHERE ( tables.id = columns.table_id )
				AND ( columns.id = permissions_users.column_id )
				AND ( permissions_users.user_id = bp_user_id) 
				AND tables.id = bp_table_id
			ORDER BY id)
	)
    ORDER BY t2.position; 
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_SelectColumnsTable
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_SelectColumnsTable`(IN `bp_table_id` INT)
BEGIN
	SELECT * FROM columns WHERE columns.table_id = bp_table_id ORDER BY column_name;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_SelectFilteredLanguageTag
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_SelectFilteredLanguageTag`(IN `bp_search` varchar(200))
BEGIN

	SELECT *
    FROM language_tag t1
    WHERE
    (t1.id = CAST(bp_search AS SIGNED) collate utf8_spanish_ci)
     OR ( t1.`tag` LIKE bp_search collate utf8_spanish_ci )
     OR ( t1.`description` LIKE bp_search collate utf8_spanish_ci )
     OR ( t1.id_lang = CAST(bp_search AS SIGNED) collate utf8_spanish_ci )
     OR ( t1.id_table = CAST(bp_search AS SIGNED) collate utf8_spanish_ci );
     

END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_SelectFilteredOrganizations
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_SelectFilteredOrganizations`(
	IN `bp_search` varchar(45)
)
BEGIN
		SELECT `id`,  `name`,  `reference_no`,  `description`,
		`archived`,  `location_id`,  `created_at`,  `updated_at`
	FROM organizations
	WHERE
		( `id` = CAST(bp_search AS SIGNED)  collate utf8_spanish_ci )
		OR ( `name` LIKE bp_search collate utf8_spanish_ci )
		OR ( `reference_no` LIKE bp_search collate utf8_spanish_ci )
		OR ( `description` LIKE bp_search collate utf8_spanish_ci )
	ORDER BY `name` ASC;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_SelectFilteredRols
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_SelectFilteredRols`(
	IN `bp_search` varchar(45)
)
BEGIN
	SELECT `id`, `name`, `description`, `archived`, `all_access_column`,
			`all_access_organization`, `created_at`, `updated_at`
	FROM rols
   WHERE
		( `id` = CAST(bp_search AS SIGNED) collate utf8_spanish_ci )
        OR ( `name` LIKE CONCAT('%', bp_search, '%') collate utf8_spanish_ci )
        OR ( `description` LIKE CONCAT('%', bp_search, '%') collate utf8_spanish_ci )
	ORDER BY `name` ASC;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_SelectFilteredThirds
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_SelectFilteredThirds`(
	IN `bp_search` varchar(45)
)
BEGIN
	SELECT `b`.`id`, `b`.`logo`,  `b`.`cif`,  `b`.`is_customer`,  `b`.`is_vendor`,  `b`.`user_id`,  `b`.`alias`,
	`b`.`email`, `b`.`name`, `b`.`name_2`,  `b`.`is_employee`,  `b`.`is_prospect`,  `b`.`is_sales_rep`,  `b`.`reference_no`,
	`b`.`sales_rep_id`,  `b`.`credit_status`,  `b`.`credit_limit`,  `b`.`total_open_balance`,  `b`.`tax_id`,  `b`.`is_tax_exempt`,
	`b`.`is_po_tax_exempt`,  `b`.`url`,  `b`.`description`,  `b`.`is_summary`,  `b`.`archived`,  `b`.`price_list_id`,
	`b`.`delivery_rule`,  `b`.`delivery_via_rule`,  `b`.`flat_discount`,  `b`.`is_manufacturer`, `b`.`po_price_list_id`,
	`b`.`language_id`,  `b`.`greeting_id`,  `b`.`created_at`,  `b`.`updated_at`, `l`.`address_1` address, `c`.`country`, `s`.`state`, `ciu`.`city`
	FROM bpartners b
	LEFT JOIN bpartner_locations b_l ON `b`.`id` = `b_l`.`bpartner_id` AND `b_l`.principal = 1
	LEFT JOIN locations l ON `l`.`id` = `b_l`.`location_id`
	LEFT JOIN countries c ON `c`.`id` = `l`.`country_id`
	LEFT JOIN states s ON `s`.`id` = `l`.`state_id`
	LEFT JOIN cities ciu ON `ciu`.`id` = `l`.`city_id`
   WHERE
		( b.id = CAST(bp_search AS SIGNED) collate utf8_spanish_ci )
   	OR ( b.`cif` LIKE bp_search collate utf8_spanish_ci )
      OR ( b.`reference_no` LIKE bp_search collate utf8_spanish_ci )
      OR ( b.`name` LIKE bp_search collate utf8_spanish_ci )
      OR ( b.name_2 LIKE bp_search collate utf8_spanish_ci )
      OR ( b.url LIKE bp_search collate utf8_spanish_ci )
      OR ( l.address_1 LIKE bp_search collate utf8_spanish_ci )
      OR ( c.country LIKE bp_search collate utf8_spanish_ci )
      OR ( s.state LIKE bp_search collate utf8_spanish_ci )
      OR ( ciu.city LIKE bp_search collate utf8_spanish_ci )
	ORDER BY b.`name`;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_SelectFilteredUsers
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_SelectFilteredUsers`(
	IN `bp_search` varchar(45)
)
BEGIN
	SELECT `id`, `name`, `email`, `all_access_column`,
		`all_access_organization`, `archived`, `created_at`, `updated_at`
    FROM users
    WHERE
		( `id` = CAST(bp_search AS SIGNED) collate utf8_spanish_ci )
        OR ( `name` LIKE CONCAT('%', bp_search, '%') collate utf8_spanish_ci )
        OR ( `email` LIKE CONCAT('%', bp_search, '%') collate utf8_spanish_ci )
	ORDER BY `name` ASC;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_SelectOrganizationsByUser
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_SelectOrganizationsByUser`(
	IN `bp_id` INT



)
BEGIN

	DECLARE all_a INT;
	
	SET all_a = (SELECT all_access_organization FROM users WHERE id = bp_id);
	
	IF all_a = 1 THEN
		SELECT id, name text
		FROM organizations
		WHERE archived = 0
		ORDER BY name ASC;
	ELSE
		SELECT DISTINCT o.id, o.name text
	    FROM organizations o
	    INNER JOIN organization_rol o_r ON o_r.organization_id = o.id
	    INNER JOIN rols r ON o_r.rol_id = r.id AND r.id IN (
	        SELECT r.id
	        FROM user_rol user_r
	        INNER JOIN users u ON u.id = bp_id
	        INNER JOIN rols r ON r.id = user_r.rol_id AND u.id = user_r.user_id
	) UNION
	    SELECT o.id, o.name text
	    FROM organizations o
	    INNER JOIN organization_user o_u ON o_u.organization_id = o.id
	    INNER JOIN users u ON o_u.user_id = u.id AND u.id = bp_id;	
	END IF;

END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_SelectPermitsAssociatesAll
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_SelectPermitsAssociatesAll`(
	IN `bp_rol_id` INT

)
BEGIN
	SELECT  
	t1.table_id, t2.table_name, t2.description table_description,
	t1.id column_id,
    t1.column_name, t1.description column_description,
	(if(t3.create = 1,1,0)) as `create`,
	(if(t3.read = 1,1,0)) as `read`,
	(if(t3.delete = 1,1,0)) as `delete`,
    (if(t3.update = 1,1,0)) as `update`,
    (if(t3.rol_id is not null,1,0)) selected
	FROM columns t1
	inner join tables t2 on t1.table_id = t2.id 
	left JOIN permissions_rols t3 on t1.id = t3.column_id and t3.rol_id = bp_rol_id
	ORDER BY t2.table_name, t1.column_name;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_SelectPermitsAssociatesUserAll
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_SelectPermitsAssociatesUserAll`(
	IN `bp_user_id` INT

)
BEGIN
	SELECT  
	t1.table_id, t2.table_name, t2.description table_description,
	t1.id column_id,
    t1.column_name, t1.description column_description,
	(if(t3.create = 1,1,0)) as `create`,
	(if(t3.read = 1,1,0)) as `read`,
	(if(t3.delete = 1,1,0)) as `delete`,
    (if(t3.update = 1,1,0)) as `update`,
    (if(t3.user_id is not null,1,0)) selected
	FROM columns t1
	inner join tables t2 on t1.table_id = t2.id 
	left JOIN permissions_users t3 on t1.id = t3.column_id and t3.user_id = bp_user_id
	ORDER BY t2.table_name, t1.column_name;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_SelectPermitsNotAssociates
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_SelectPermitsNotAssociates`(
	IN `bp_rol_id` INT


)
BEGIN
	SELECT  
	t1.table_id, t2.table_name, t2.description table_description,
	t1.id column_id,
    t1.column_name, t1.description column_description,
    (if(t3.create = 1,1,0)) as `create`,
	(if(t3.read = 1,1,0)) as `read`,
	(if(t3.delete = 1,1,0)) as `delete`,
    (if(t3.update = 1,1,0)) as `update`,
    (if(t3.rol_id is not null,1,0)) selected
	FROM columns t1
	inner join tables t2 on t1.table_id = t2.id 
	left JOIN permissions_rols t3 on t1.id = t3.column_id and t3.rol_id = bp_rol_id
   where t3.rol_id is null and t3.column_id is null
	ORDER BY t2.table_name, t1.column_name;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_SelectPermitsNotAssociatesUser
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_SelectPermitsNotAssociatesUser`(
	IN `bp_user_id` INT

)
BEGIN
	SELECT  
	t1.table_id, t2.table_name, t2.description table_description,
	t1.id column_id,
    t1.column_name, t1.description column_description,
	(if(t3.create = 1,1,0)) as `create`,
	(if(t3.read = 1,1,0)) as `read`,
	(if(t3.delete = 1,1,0)) as `delete`,
    (if(t3.update = 1,1,0)) as `update`,
    (if(t3.user_id is not null,1,0)) selected
	FROM columns t1
	inner join tables t2 on t1.table_id = t2.id 
	left JOIN permissions_users t3 on t1.id = t3.column_id and t3.user_id = bp_user_id
   where t3.user_id is null and t3.column_id is null
   ORDER BY t2.table_name, t1.column_name;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_SelectPermitsRol
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_SelectPermitsRol`(IN `bp_rol_id` INT)
BEGIN
	SELECT permissions_rols.*, columns.column_name
    FROM permissions_rols, columns
    WHERE ( rol_id = bp_rol_id ) AND ( columns.id = permissions_rols.column_id );
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_SelectPermitsUser
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_SelectPermitsUser`(IN `bp_user_id` INT)
BEGIN
	SELECT permissions_users.*, columns.column_name
    FROM permissions_users, columns
    WHERE ( user_id = bp_user_id ) AND ( columns.id = permissions_users.column_id );
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_SelectPermitsYesAssociates
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_SelectPermitsYesAssociates`(
	IN `bp_rol_id` INT


)
BEGIN
	SELECT  
	t1.table_id, t2.table_name, t2.description table_description,
	t1.id column_id,
    t1.column_name, t1.description column_description,
    (if(t3.create = 1,1,0)) as `create`,
	(if(t3.read = 1,1,0)) as `read`,
	(if(t3.delete = 1,1,0)) as `delete`,
    (if(t3.update = 1,1,0)) as `update`,
    (if(t3.rol_id is not null,1,0)) selected
	FROM columns t1
	inner join tables t2 on t1.table_id = t2.id 
	left JOIN permissions_rols t3 on t1.id = t3.column_id and t3.rol_id = bp_rol_id
   where t3.rol_id is not null and t3.column_id is not null
	ORDER BY t2.table_name, t1.column_name;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_SelectPermitsYesAssociatesUser
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_SelectPermitsYesAssociatesUser`(
	IN `bp_user_id` INT

)
BEGIN
	SELECT  
	t1.table_id, t2.table_name, t2.description table_description,
	t1.id column_id,
    t1.column_name, t1.description column_description,
	(if(t3.create = 1,1,0)) as `create`,
	(if(t3.read = 1,1,0)) as `read`,
	(if(t3.delete = 1,1,0)) as `delete`,
    (if(t3.update = 1,1,0)) as `update`,
    (if(t3.user_id is not null,1,0)) selected
	FROM columns t1
	inner join tables t2 on t1.table_id = t2.id 
	left JOIN permissions_users t3 on t1.id = t3.column_id and t3.user_id = bp_user_id
   where t3.user_id is not null and t3.column_id is not null
	ORDER BY t2.table_name, t1.column_name;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_SelectRols
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_SelectRols`()
BEGIN
	SELECT * FROM rols ORDER BY rol_name, id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_SelectTableAccessUser
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_SelectTableAccessUser`(
	IN `bp_user_id` INT


)
BEGIN

	DECLARE access_column BOOLEAN;
	DECLARE has_rol BOOLEAN;
   DECLARE bv_rol_id INT;
   DECLARE n_rols INT;
    
    SET n_rols = (
		SELECT COUNT(*) FROM rols r
		INNER JOIN user_rol u_r ON u_r.user_id = bp_user_id AND u_r.rol_id = r.id
	);
    
    IF n_rols = 0 THEN
    
		SET access_column := (SELECT all_access_column FROM users where id = bp_user_id);
        
		IF access_column = 1 THEN
			SELECT * FROM `tables` where tables.is_menuitem = 1 AND tables.is_available = 1 ;
		ELSE			
			SELECT DISTINCT tables.*
			FROM tables, columns, permissions_users
			WHERE ( tables.id = columns.table_id )
				AND ( columns.id = permissions_users.column_id )
				   AND ( permissions_users.user_id = bp_user_id )
				   AND tables.is_menuitem = 1 AND tables.is_available = 1
			ORDER BY id;
			
		END IF;
		
	ELSE
	
		SET access_column := (SELECT all_access_column FROM users where id = bp_user_id);
        
		IF access_column = 1 THEN
			SELECT * FROM `tables` where tables.is_menuitem = 1 AND tables.is_available = 1 ;
		ELSE
			
			SELECT DISTINCT tables.*
			FROM tables, columns, permissions_rols
			WHERE ( tables.id = columns.table_id )
				AND ( columns.id = permissions_rols.column_id )
				AND ( tables.is_menuitem = 1 AND tables.is_available = 1 )
				AND permissions_rols.rol_id IN (
					SELECT user_r.rol_id id
					FROM user_rol user_r
					INNER JOIN rols r ON r.id = user_r.rol_id
					WHERE user_r.user_id = bp_user_id
				)
			UNION
			SELECT DISTINCT tables.*
			FROM tables, columns, permissions_users
			WHERE ( tables.id = columns.table_id )
				AND ( columns.id = permissions_users.column_id )
				AND ( permissions_users.user_id = bp_user_id )
				AND tables.is_menuitem = 1 AND tables.is_available = 1
			ORDER BY id;
			
		END IF;
	
	END IF;

	/*SET access_column := (SELECT all_access_column FROM users where id = bp_user_id);
	
    IF access_column THEN
		SELECT * FROM `tables` where tables.is_menuitem = 1 AND tables.is_available = 1 ;
	ELSE    
		SET bv_rol_id := (SELECT rol_id FROM users WHERE users.id = bp_user_id);
		
		SELECT DISTINCT tables.*
		FROM tables, columns, permissions_rols
		WHERE ( tables.id = columns.table_id )
			AND ( columns.id = permissions_rols.column_id )
			   AND ( permissions_rols.rol_id = bv_rol_id )
				 AND tables.is_menuitem = 1 AND tables.is_available = 1
		UNION
		SELECT DISTINCT tables.*
		FROM tables, columns, permissions_users
		WHERE ( tables.id = columns.table_id )
			AND ( columns.id = permissions_users.column_id )
			   AND ( permissions_users.user_id = bp_user_id )
               AND tables.is_menuitem = 1 AND tables.is_available = 1
		ORDER BY id;
	END IF;*/
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_SelectTotalAccess
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_SelectTotalAccess`(
	IN `bp_user_id` INT

)
BEGIN
	SELECT  
		t1.table_id, t2.table_name, t2.description table_description,
		t1.id column_id,
		t1.column_name, t1.description column_description,
		t3.create,
		t3.read,
		t3.delete,
		t3.update,
		(if(t3.rol_id IS NOT NULL,1,0)) selected
	FROM columns t1
	INNER JOIN tables t2 ON t1.table_id = t2.id 
	LEFT JOIN permissions_rols t3 ON t1.id = t3.column_id
		AND t3.rol_id IN (
			SELECT user_r.rol_id id
			FROM user_rol user_r
			INNER JOIN rols r ON r.id = user_r.rol_id
			WHERE user_r.user_id = bp_user_id
		)
		AND t1.id NOT IN (
			SELECT permissions_users.column_id
			FROM permissions_users
			LEFT JOIN users ON permissions_users.user_id = users.id
			WHERE users.id = bp_user_id
	    )
	WHERE t3.rol_id IS NOT NULL
		AND t3.column_id IS NOT NULL
	UNION
	SELECT DISTINCT
		t1.table_id, t2.table_name, t2.description table_description,
		t1.id column_id,
		t1.column_name, t1.description column_description,
		t3.create,
		t3.read,
		t3.delete,
		t3.update,
		(if(t3.user_id IS NOT NULL,1,0)) selected
	FROM columns t1
	INNER JOIN tables t2 ON t1.table_id = t2.id 
	LEFT JOIN permissions_users t3 ON t1.id = t3.column_id
		AND t3.user_id = bp_user_id
	WHERE t3.user_id IS NOT NULL
		AND t3.column_id IS NOT NULL;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_SelectTotalAccessTable
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_SelectTotalAccessTable`(
	IN `bp_table_id` INT,
	IN `bp_user_id` INT

)
BEGIN
	DECLARE a_c INT;
	
	SET a_c = (SELECT all_access_column FROM users WHERE id = bp_user_id);
	
	IF a_c = 1 THEN
		SELECT 1 all_access_column;
	ELSE
		
		SELECT
			t1.table_id, t2.table_name, t2.description table_description,
			t1.id column_id,
			t1.column_name, t1.description column_description,
			t3.create,
			t3.read,
			t3.delete,
			t3.update,
			(if(t3.rol_id IS NOT NULL,1,0)) selected
		FROM columns t1
		INNER JOIN tables t2 ON t1.table_id = t2.id AND t2.id = bp_table_id
		LEFT JOIN permissions_rols t3 ON t1.id = t3.column_id
			AND t3.rol_id IN (
				SELECT user_r.rol_id id
				FROM user_rol user_r
				INNER JOIN rols r ON r.id = user_r.rol_id
				WHERE user_r.user_id = bp_user_id
			)
			AND t1.id NOT IN (
				SELECT permissions_users.column_id
				FROM permissions_users
				LEFT JOIN users ON permissions_users.user_id = users.id
				WHERE users.id = bp_user_id
		    )
		WHERE t3.rol_id IS NOT NULL
			AND t3.column_id IS NOT NULL
		UNION
		SELECT DISTINCT
			t1.table_id, t2.table_name, t2.description table_description,
			t1.id column_id,
			t1.column_name, t1.description column_description,
			t3.create,
			t3.read,
			t3.delete,
			t3.update,
			(if(t3.user_id IS NOT NULL,1,0)) selected
		FROM columns t1
		INNER JOIN tables t2 ON t1.table_id = t2.id AND t2.id = bp_table_id
		LEFT JOIN permissions_users t3 ON t1.id = t3.column_id
			AND t3.user_id = bp_user_id
		WHERE t3.user_id IS NOT NULL
			AND t3.column_id IS NOT NULL;
			
	END IF;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.RD_SelectUsers
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `RD_SelectUsers`()
BEGIN
	SELECT users.id, users.rol_id, rols.rol_name, users.user_name,
		users.email, users.all_access_organization, users.all_access_column,
		users.archived, users.created_at, users.updated_at
    FROM users, rols
    WHERE rols.id = users.rol_id
    ORDER BY user_name;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateAttribute
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateAttribute`(
	IN `bp_id` INT,
	IN `bp_name` VARCHAR(45),
	IN `bp_type_attribute` VARCHAR(1)
,
	IN `bp_updated_by` INT
)
BEGIN
	UPDATE attributes SET
    `name` = `bp_name`,  `type_attribute` = `bp_type_attribute`, `updated_at` = NOW(), `updated_by` = bp_updated_by
    WHERE `id` = `bp_id`;    
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateAttributeDetail
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateAttributeDetail`(
	IN `bp_id` INT,
	IN `bp_name` VARCHAR(45),
	IN `bp_color` VARCHAR(10),
	IN `bp_position` INT
,
	IN `bp_reference` VARCHAR(50)
,
	IN `bp_updated_by` INT
)
BEGIN    
    UPDATE attribute_details SET
    `name` = `bp_name`, `color` = `bp_color`, `position` = `bp_position`, `reference` = `bp_reference`, `updated_at` = NOW(), updated_by = bp_updated_by
    WHERE `id` = `bp_id`;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateBodyDocument
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateBodyDocument`(
	IN `bp_id` VARCHAR(1000),
	IN `bp_reference` VARCHAR(50),
	IN `bp_product_detail_id` INT,
	IN `bp_name` VARCHAR(50),
	IN `bp_price` DECIMAL(20,8),
	IN `bp_net_price` DECIMAL(20,8),
	IN `bp_dimensions` VARCHAR(50),
	IN `bp_quantity` INT,
	IN `bp_discount` VARCHAR(50),
	IN `bp_discount_cal` DECIMAL(20,8),
	IN `bp_tax_id` INT,
	IN `bp_sale_rep_id` INT,
	IN `bp_warehouse_id` INT,
	IN `bp_user_id` INT


)
BEGIN
    UPDATE `body_documents` SET
        `id` = `bp_id`,
        `reference` = `bp_reference`,
        `product_detail_id` = `bp_product_detail_id`,
        `name` = `bp_name`,
        `price` = `bp_price`,
        `net_price` = `bp_net_price`,
        `dimensions` = `bp_dimensions`,
        `quantity` = `bp_quantity`,
        `discount` = `bp_discount`,
        `discount_cal` = `bp_discount_cal`,
        `tax_id` = `bp_tax_id`,
        `sale_rep_id` = `bp_sale_rep_id`,
        `warehouse_id` = `bp_warehouse_id`,
        `updated_by` = `bp_user_id`
    WHERE
        `id` = `bp_id`;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateBodyReport
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateBodyReport`(
	IN `bp_id` INT,
	IN `bp_name` varchar(50),
	IN `bp_context` TEXT,
	IN `bp_image_id` INT,
	IN `bp_updated_by` INT
)
BEGIN	
	UPDATE `bodies_reports` SET
        `name` = bp_name,
        `context` = bp_context,
        `image_id` = bp_image_id,
        `updated_by` = bp_updated_by
    WHERE
        id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateBpartnerContact
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateBpartnerContact`(
	IN `bp_third` INT,
	IN `bp_contact` INT,
	IN `bp_user` INT
)
BEGIN

	UPDATE bpartner_contact SET
		user_id = bp_user
	WHERE
		bpartner_id = bp_third AND contact_id = bp_contact;

END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateBpartnerLocation
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateBpartnerLocation`(
	IN `bp_bpartner_location_id` INT,
	IN `bp_name` VARCHAR(60),
	IN `bp_is_ship_to` BOOLEAN,
	IN `bp_is_bill_to` BOOLEAN,
	IN `bp_is_pay_from` BOOLEAN,
	IN `bp_is_remit_to` BOOLEAN,
	IN `bp_phone` VARCHAR(45),
	IN `bp_phone_2` VARCHAR(45),
	IN `bp_fax` VARCHAR(45),
	IN `bp_isdn` VARCHAR(45)
,
	IN `bp_updated_by` INT
)
BEGIN
	UPDATE bpartner_locations SET
		`name` = bp_name,
        is_ship_to = bp_is_ship_to,
        is_bill_to = bp_is_bill_to,
        is_pay_from = bp_is_pay_from,
        is_remit_to = bp_is_remit_to,
        phone = bp_phone,
		phone_2 = bp_phone_2,
        fax = bp_fax,
        isdn = bp_isdn,
		updated_at = NOW(),
		updated_by = bp_updated_by
    WHERE ID = bp_bpartner_location_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateBpartners
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateBpartners`(
	IN `bp_third_id` int,
	IN `bp_Logo` varchar(45),
	IN `bp_is_customer` boolean,
	IN `bp_is_Vendor` boolean,
	IN `bp_name` varchar(120),
	IN `bp_name2` varchar(120),
	IN `bp_is_Employee` boolean,
	IN `bp_is_Prospect` boolean,
	IN `bp_is_SalesRep` boolean,
	IN `bp_ReferenceNo` varchar(25),
	IN `bp_SalesRep_id` int,
	IN `bp_CreditStatus` char(1),
	IN `bp_CreditLimit` double,
	IN `bp_TaxId` int,
	IN `bp_is_TaxExempt` boolean,
	IN `bp_is_POTaxExempt` boolean,
	IN `bp_URL` varchar(120),
	IN `bp_description` varchar(255),
	IN `bp_is_Summary` boolean,
	IN `bp_PriceList_id` int,
	IN `bp_DeliveryRule` char(1),
	IN `bp_DeliveryViaRule` char(1),
	IN `bp_FlatDiscount` double,
	IN `bp_is_Manufacturer` boolean,
	IN `bp_PO_PriceList_id` int,
	IN `bp_Language_id` int,
	IN `bp_Greeting_id` int,
	IN `bp_cif` varchar (45),
	IN `bp_alias` varchar(45),
	IN `bp_email` varchar(120)
,
	IN `bp_currency_id` INT,
	IN `bp_updated_by` INT


)
BEGIN
	UPDATE bpartners SET
	logo = bp_Logo,
	is_customer = bp_is_customer,
	is_vendor = bp_is_Vendor,
	name = bp_name,
	name_2 = bp_name2,
	is_employee = bp_is_Employee,
	is_prospect = bp_is_Prospect,
	is_sales_rep = bp_is_SalesRep,
	reference_no = bp_ReferenceNo,
	sales_rep_id = bp_SalesRep_id,
	credit_status = bp_CreditStatus,
	credit_limit = bp_CreditLimit,
    tax_id = bp_TaxId,
    is_tax_exempt = bp_is_TaxExempt,
    is_po_tax_exempt = bp_is_POTaxExempt,
    url = bp_URL,
    description = bp_description,
    is_summary = bp_is_Summary,
    price_list_id = bp_PriceList_id,
    delivery_rule = bp_DeliveryRule,
    delivery_via_rule = bp_DeliveryViaRule,
    flat_discount = bp_FlatDiscount,
    is_manufacturer = bp_is_Manufacturer,
    po_price_list_id = bp_PO_PriceList_id,
    language_id = bp_Language_id,
    greeting_id = bp_Greeting_id,
    cif = bp_cif,
    alias = bp_alias,
    email = bp_email,
    currency_id = bp_currency_id,
    updated_at = NOW(),
    updated_by = bp_updated_by
    WHERE id = bp_third_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateCategory
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateCategory`(
	IN `bp_category_id` INT,
	IN `bp_name` varchar(45),
	IN `bp_color` varchar(45),
	IN `bp_parent_id` int

,
	IN `bp_updated_by` INT
)
BEGIN
	UPDATE categories
	SET name = bp_name,
		color = bp_color,
        parent_id = bp_parent_id,
        updated_at = NOW(),
        updated_by = bp_updated_by
	WHERE id = bp_category_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateCharge
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateCharge`(
	IN `bp_id` int,
	IN `bp_name` varchar(45),
	IN `bp_description` text,
	IN `bp_report_to` int
,
	IN `bp_updated_by` INT
)
BEGIN


UPDATE `charges`
SET
`name` = bp_name,
`description` = bp_description,
`report_to` = bp_report_to,
`updated_by` = bp_updated_by
WHERE `id` = bp_id;

END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateCity
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateCity`(
	IN `bp_city_id` INT,
	IN `bp_state_id` INT,
	IN `bp_city_name` VARCHAR(45),
	IN `bp_capital` BOOLEAN 
,
	IN `bp_updated_by` INT
)
BEGIN
	UPDATE cities
    SET city = bp_city_name, capital = bp_capital, updated_at = NOW(), state_id = bp_state_id, updated_by = bp_updated_by
    WHERE id = bp_city_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateCondition
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateCondition`(
	IN `bp_condition_id` INT,
	IN `bp_tag` varchar(45)
,
	IN `bp_updated_by` INT
)
BEGIN
	UPDATE conditions
	SET name = bp_tag,
        updated_at = NOW(),
        updated_by = bp_updated_by
	WHERE id = bp_condition_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateContact
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateContact`(
	IN `bp_contact_id` INT,
	IN `bp_name` VARCHAR(60),
	IN `bp_description` VARCHAR(255),
	IN `bp_comments` TEXT,
	IN `bp_email` VARCHAR(60),
	IN `bp_phone` VARCHAR(45),
	IN `bp_phone_2` VARCHAR(45),
	IN `bp_fax` VARCHAR(45),
	IN `bp_title` VARCHAR(45),
	IN `bp_charge` VARCHAR(50),
	IN `bp_birthday` DATE,
	IN `bp_last_contact` DATE,
	IN `bp_last_result` VARCHAR(255)


,
	IN `bp_updated_by` INT
)
BEGIN
	UPDATE contacts SET
	name = bp_name,
	description = bp_description,
	comments = bp_comments,
	email = bp_email,
	phone = bp_phone,
	phone_2 = bp_phone_2,
	fax = bp_fax,
	title = bp_title,
	charge = bp_charge,
	birthday = bp_birthday,
	last_contact = bp_last_contact,
	last_result = bp_last_result,
    updated_at = NOW(),
    updated_by = bp_updated_by
    WHERE id = bp_contact_id;
    SELECT 1;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateCounterSerie
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateCounterSerie`(
	IN `bp_id` INT,
	IN `bp_type_document_id` INT,
	IN `bp_serie` VARCHAR(10),
	IN `bp_counter` INT,
	IN `bp_organization_id` INT,
	IN `bp_user_counter` INT,
	IN `bp_user` INT


)
BEGIN
	UPDATE counter_series SET
		type_document_id = bp_type_document_id,
		serie = bp_serie,
		counter = bp_counter,
		organization_id = bp_organization_id,
		user_id = bp_user_counter,
		updated_by = bp_user
	WHERE
		id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateCountry
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateCountry`(
	IN `bp_country_id` INT,
	IN `bp_country_name` VARCHAR(45),
	IN `bp_iso` VARCHAR(2) ,
	IN `bp_updated_by` INT
)
BEGIN
	UPDATE countries
    SET country = bp_country_name, iso = bp_iso, updated_at = NOW(), updated_by = bp_updated_by
    WHERE id = bp_country_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateCurrency
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateCurrency`(
	IN `bp_id` INT,
	IN `bp_isocode` VARCHAR(50),
	IN `bp_language` VARCHAR(50),
	IN `bp_name` VARCHAR(50),
	IN `bp_money` VARCHAR(50),
	IN `bp_symbol` VARCHAR(50)




,
	IN `bp_updated_by` INT
)
BEGIN
	UPDATE currencies
	SET   isocode =bp_isocode, 
	      language=bp_language, 
		   name = bp_name,
		   money = bp_money, 
		   symbol = bp_symbol,
		   updated_at = NOW(),
		   updated_by = bp_updated_by
	WHERE id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateDiscountFooterDocument
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateDiscountFooterDocument`(
	IN `bp_id` INT,
	IN `bp_discount` VARCHAR(50),
	IN `bp_discount_cal` DECIMAL(20,8),
	IN `bp_remainder` DECIMAL(20,8),
	IN `bp_description` VARCHAR(50),
	IN `bp_footer_document_id` INT

)
BEGIN
    UPDATE `discounts_footers_documents` SET
        `discount` = `bp_discount`,
        `discount_cal` = `bp_discount_cal`,
        `remainder` = `bp_remainder`,
        `description` = `bp_description`,
        `footer_document_id` = `bp_footer_document_id`
    WHERE
        `id` = `bp_id`;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateFieldConf
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateFieldConf`(
IN `bp_input_type_id` INT,
IN `bp_position` INT,
IN `bp_required` BOOLEAN,
IN `bp_column_id` INT,
IN `bp_custom_column_id` INT)
BEGIN
declare haveconf int default 0;

if  bp_custom_column_id is null then
	set haveconf = (select if(exists( select  id from field_configurations where column_id = bp_column_id) = 1,1,0)) ; 
else
	set haveconf = (select if(exists( select  id from field_configurations where custom_column_id = bp_custom_column_id) = 1,2,0)) ;
end if;

select haveconf;
   
if haveconf = 0 then
	call CR_InsertField(bp_input_type_id,bp_position,bp_required,bp_column_id, bp_custom_column_id);
elseif haveconf = 1 then

	UPDATE
		field_configurations
	SET
	position = bp_position,
	input_type_id = bp_input_type_id,
	required = bp_required
	WHERE
	column_id = bp_column_id;
 
elseif  haveconf = 2 then

	UPDATE
		field_configurations
	SET
	position = bp_position,
	input_type_id = bp_input_type_id,
	required = bp_required
	WHERE
	custom_column_id = bp_custom_column_id ;

end if ;


END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateFooterDocument
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateFooterDocument`(
	IN `bp_id` INT,
	IN `bp_quantity_total` INT,
	IN `bp_gross_total` DECIMAL(20,8),
	IN `bp_discount_total` DECIMAL(20,8),
	IN `bp_tax_total` DECIMAL(20,8),
	IN `bp_neto_total` DECIMAL(20,8),
	IN `bp_internal_note` VARCHAR(50),
	IN `bp_client_note` VARCHAR(50),
	IN `bp_user_id` INT


)
BEGIN
    UPDATE `footer_documents` SET
        `quantity_total` = `bp_quantity_total`,
        `gross_total` = `bp_gross_total`,
        `discount_total` = `bp_discount_total`,
        `tax_total` = `bp_tax_total`,
        `neto_total` = `bp_neto_total`,
        `internal_note` = `bp_internal_note`,
        `client_note` = `bp_client_note`,
        `updated_by` = `bp_user_id`
    WHERE
        `id` = `bp_id`;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateFooterReport
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateFooterReport`(
	IN `bp_id` INT,
	IN `bp_name` varchar(50),
	IN `bp_context` TEXT,
	IN `bp_image_id` INT,
	IN `bp_updated_by` INT
)
BEGIN	
	UPDATE `footers_reports` SET
        `name` = bp_name,
        `context` = bp_context,
        `image_id` = bp_image_id,
        `updated_by` = bp_updated_by
    WHERE
        id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateHeaderDocument
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateHeaderDocument`(
	IN `bp_address` VARCHAR(50),
	IN `bp_bpartner_id` INT,
	IN `bp_valid_from` DATE,
	IN `bp_valid_until` DATE,
	IN `bp_warehouse_id` INT,
	IN `bp_sale_represent_id` INT,
	IN `bp_price_list_id` INT,
	IN `bp_reference` VARCHAR(1000),
	IN `bp_currency_client` INT,
	IN `bp_currency_document` INT,
	IN `bp_rate` DECIMAL(20,8),
	IN `bp_status_id` INT,
	IN `bp_user_id` INT


)
BEGIN

    UPDATE `documents` SET
        `address` = `bp_address`,
        `bpartner_id` = `bp_bpartner_id`,
        `valid_from` = `bp_valid_from`,
        `valid_until` = `bp_valid_until`,
        `warehouse_id` = `bp_warehouse_id`,
        `sale_represent_id` = `bp_sale_represent_id`,
        `price_list_id` = `bp_price_list_id`,
        `currency_client` = `bp_currency_client`,
        `currency_document` = `bp_currency_document`,
        `rate` = `bp_rate`,
        `status_id` = `bp_status_id`,
        `updated_by` = `bp_user_id`
    WHERE
        `reference` = `bp_reference`;

END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateHeaderProject
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateHeaderProject`(
	IN `bp_id` INT,
	IN `bp_bpartner_id` INT,
	IN `bp_organization_id` INT,
	IN `bp_user` INT
)
BEGIN

    UPDATE header_projects SET
        `bpartner_id` = `bp_bpartner_id`,
        `organization_id` =  `bp_organization_id`,
        `updated_by` = `bp_user`
    WHERE
        `id` = `bp_id`;

END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateHeaderReport
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateHeaderReport`(
	IN `bp_id` INT,
	IN `bp_name` varchar(50),
	IN `bp_context` TEXT,
	IN `bp_image_id` INT,
	IN `bp_updated_by` INT
)
BEGIN	
	UPDATE `headers_reports` SET
        `name` = bp_name,
        `context` = bp_context,
        `image_id` = bp_image_id,
        `updated_by` = bp_updated_by
    WHERE
        id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateImageReport
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateImageReport`(
	IN `bp_id` INT,
	IN `bp_name` varchar(50),
	IN `bp_path` varchar(50)
)
BEGIN	
	UPDATE `images_reports` SET
        `name` = bp_name,
        `path` = bp_path        
    WHERE
        id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateLanguage
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateLanguage`(
in id_param int,
in languagescol_param varchar(45), 
in iso_param varchar(45))
BEGIN

UPDATE `banana`.`languages`
SET
`languagescol` = languagescol_param
,`iso` = iso_param
-- ,`date_format` = <{date_format: m/d/Y}>
-- ,`datetime_format` = <{datetime_format: m/d/Y H:i:s}>
,`updated_at` = NOW()
,`description` = languagescol_param
WHERE `id` = id_param;


END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateLanguageHash
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateLanguageHash`(in `bp_hash` text, in bp_table_id int)
BEGIN

 DECLARE id int;
 
 set id = (select count(*) from language_hashes where table_id = bp_table_id );
 
 select id;
 
	if id = 0 then 
	
			INSERT INTO `language_hashes`
			(
			`table_id`,
			`hash`)
			VALUES
			(bp_table_id,
			bp_hash);
	else
		UPDATE `language_hashes`
			SET
			`hash` = bp_hash
			WHERE `table_id` = bp_table_id;

	END IF;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateLanguageTag
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateLanguageTag`(in id_lang_param int, in id_table_param int, in tag_param varchar(200) ,in description_param varchar(255), in id_param int, in id_parent_param int)
BEGIN



declare table_param varchar(255);
 
 set table_param = 'language_global';
 
 if  id_table_param != 0 then
 
 set table_param = (SELECT  CONCAT( '`language_' , table_name ,'`')  FROM banana.tables where id = id_table_param);

end if;

SET @VV_CONSDINAM = CONCAT(
' UPDATE  ',table_param,
' SET ',
'`language_id` = ', id_lang_param,
', `tag` = "', tag_param,
'" , `description` = "', description_param,
'" , `parent_tag` = ', id_parent_param,
' WHERE `id` = ', id_param,';');

select  @VV_CONSDINAM;

PREPARE SENTENCIA FROM @VV_CONSDINAM; 

EXECUTE SENTENCIA;



END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateLocation
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateLocation`(
	IN `bp_location_id` INT,
	IN `bp_address_1` VARCHAR(60),
	IN `bp_city_id` INT,
	IN `bp_postal` VARCHAR(10),
	IN `bp_state_id` INT,
	IN `bp_country_id` INT
,
	IN `bp_updated_by` INT
)
BEGIN
	UPDATE locations SET
	address_1 = bp_address_1,
    city_id = bp_city_id,
	postal = bp_postal,
    state_id = bp_state_id,
    country_id = bp_country_id,
	updated_at = NOW(),
	updated_by = bp_updated_by
    WHERE id = bp_location_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateManufacturer
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateManufacturer`(
	IN `bp_manufacturer_id` int,
	IN `bp_name` varchar(45)
,
	IN `bp_updated_by` INT
)
BEGIN

UPDATE `manufacturers`
SET name = bp_name,
    updated_at = NOW(),
    updated_by = bp_updated_by
WHERE id = bp_manufacturer_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateOrganization
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateOrganization`(
	IN `bp_id` int,
	IN `bp_name` varchar(60),
	IN `bp_ref_num` varchar(25),
	IN `bp_description` text,
	IN `bp_location_id` int
,
	IN `bp_updated_by` INT
)
BEGIN

UPDATE `organizations`
SET `name` = bp_name,
	`reference_no` = bp_ref_num,
	`description` = bp_description,
    `location_id` = bp_location_id,
    updated_by = bp_updated_by,
	updated_at = NOW()
WHERE id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdatePassword
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdatePassword`(
	IN `bp_id` INT,
	IN `bp_password` VARCHAR(50)
)
BEGIN
	UPDATE users 
	SET
	password = bp_password,
	updated_at = NOW()
	WHERE id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdatePermitsRol
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdatePermitsRol`(
	IN `bp_rol_id` INT,
	IN `bp_column_id` INT,
	IN `bp_create` BOOLEAN,
	IN `bp_read` BOOLEAN,
	IN `bp_update` BOOLEAN,
	IN `bp_delete` BOOLEAN
)
BEGIN
	DECLARE exist BOOLEAN;
    
    SET exist = (SELECT 1 FROM permissions_rols WHERE ( rol_id = bp_rol_id ) AND ( column_id = bp_column_id ) );
    
    IF exist = TRUE THEN
    	IF bp_create = 0 AND bp_read = 0 AND bp_update = 0 AND bp_delete = 0 THEN
			DELETE FROM permissions_rols WHERE rol_id = bp_rol_id AND column_id = bp_column_id;
		ELSE
			UPDATE permissions_rols per_r
			SET per_r.create = bp_create, per_r.read = bp_read, per_r.update = bp_update, per_r.delete = bp_delete, updated_at = NOW()
			WHERE per_r.rol_id = bp_rol_id AND per_r.column_id = bp_column_id;
		END IF;
	
    ELSE
		
        CALL CR_InsertPermitsRol(bp_rol_id,bp_column_id, bp_create, bp_read, bp_update, bp_delete);
        
    END IF;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdatePermitsUser
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdatePermitsUser`(
	IN `bp_user_id` INT,
	IN `bp_column_id` INT,
	IN `bp_create` BOOLEAN,
	IN `bp_read` BOOLEAN,
	IN `bp_update` BOOLEAN,
	IN `bp_delete` BOOLEAN

)
BEGIN
	DECLARE exist BOOLEAN;
	
	SET exist = (SELECT 1 FROM permissions_users WHERE ( user_id = bp_user_id ) AND ( column_id = bp_column_id ) );
    
	IF exist = TRUE THEN
	
		IF bp_create = 0 AND bp_read = 0 AND bp_update = 0 AND bp_delete = 0 THEN
			DELETE FROM permissions_users WHERE user_id = bp_user_id AND column_id = bp_column_id;
		ELSE
			UPDATE permissions_users per_u
			SET per_u.create = bp_create, per_u.read = bp_read, per_u.update = bp_update, per_u.delete = bp_delete, updated_at = NOW()
			WHERE per_u.user_id = bp_user_id AND per_u.column_id = bp_column_id;
		END IF;
		
   ELSE
    
		CALL CR_InsertPermitsUser(bp_user_id,bp_column_id, bp_create, bp_read, bp_update, bp_delete);
        
	END IF;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdatePrice
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdatePrice`(
	IN `bp_price_list` INT,
	IN `bp_product_detail` INT,
	IN `bp_grossprice` DECIMAL(20,8),
	IN `bp_discount` VARCHAR(50),
	IN `bp_discount_calc` DECIMAL(20,8),
	IN `bp_netprice` DECIMAL(20,8)





,
	IN `bp_created_by` INT

)
BEGIN
	DECLARE exist INT;
	/*
	DECLARE bv_discount DOUBLE DEFAULT 0.00;
	DECLARE bv_netprice DOUBLE DEFAULT 0.00;
	
	DECLARE bv_old_discount DOUBLE;
	DECLARE bv_old_netprice DOUBLE;
	DECLARE bv_old_grossprice DOUBLE ;

	DECLARE bv_position_char_neg INT;
	DECLARE bv_position_char_plus INT;
	DECLARE bv_discount_gross DOUBLE DEFAULT 0.00;
	*/
	SET exist = (
		SELECT count(p.grossprice) exist FROM prices p
		WHERE p.price_list_id = bp_price_list AND p.product_detail_id = bp_product_detail
	);
	
	IF  exist = 0  THEN
	
		CALL CR_InsertPrice(bp_price_list, bp_product_detail, bp_grossprice, bp_discount, bp_discount_calc, bp_netprice, bp_created_by);
	
	ELSE
	
	UPDATE prices SET
		grossprice = bp_grossprice,
		discount = bp_discount,
		discount_calc = bp_discount_calc,
		netprice = bp_netprice,
		created_by = bp_created_by
	WHERE
		price_list_id = bp_price_list AND
		product_detail_id = bp_product_detail;
	
	SELECT -1 exist;
	
	/*	SET bv_old_discount = ( SELECT discount FROM prices p WHERE p.price_list_id = bp_price_list AND p.product_detail_id = bp_product_detail );
		SET bv_old_netprice = ( SELECT netprice FROM prices p WHERE p.price_list_id = bp_price_list AND p.product_detail_id = bp_product_detail );
		SET bv_old_grossprice = ( SELECT grossprice FROM prices p WHERE p.price_list_id = bp_price_list AND p.product_detail_id = bp_product_detail );
			
	*/
	
	
	END IF;

END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdatePriceList
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdatePriceList`(
	IN `bp_id` int,
	IN `bp_reference` varchar(20),
	IN `bp_name` varchar(45),
	IN `bp_valid_from` date,
	IN `bp_valid_until` date,
	IN `bp_tax_include` boolean,
	IN `bp_currency_id` int
,
	IN `bp_alternative` INT
,
	IN `bp_tax_id` INT


,
	IN `bp_user` INT
)
BEGIN
	UPDATE price_lists
	SET reference = bp_reference,
		`name` = bp_name,
        valid_from = bp_valid_from,
        valid_until = bp_valid_until,
        tax_include = bp_tax_include,
        currency_id = bp_currency_id,
        updated_at = NOW(),
        alternative = bp_alternative,
        tax_id= bp_tax_id,
        updated_by = bp_user
	WHERE id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdatePrincipalBranch
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdatePrincipalBranch`(IN `bp_branch_id` INT, IN `bp_bpartner_id` INT)
BEGIN
	UPDATE bpartner_locations b
    SET b.principal = 0
    WHERE b.bpartner_id = bp_bpartner_id;
    
    UPDATE bpartner_locations b
    SET b.principal = 1
    WHERE b.id = bp_branch_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateProduct
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateProduct`(
	IN `bp_id` INT,
	IN `bp_reference` VARCHAR(50),
	IN `bp_name` VARCHAR(50),
	IN `bp_description` TEXT,
	IN `bp_type` CHAR(1),
	IN `bp_is_salable` TINYINT,
	IN `bp_is_purchasable` TINYINT,
	IN `bp_unit_id` INT,
	IN `bp_category_id` INT,
	IN `bp_manufacture_id` INT
,
	IN `bp_tax_id` INT

,
	IN `bp_combination` TINYINT
,
	IN `bp_updated_by` INT
)
BEGIN
UPDATE products SET
    name = bp_name,
    reference = bp_reference,
    description = bp_description,
    type = bp_type,
    is_salable = bp_is_salable,
    is_purchasable = bp_is_purchasable,
    unit_id = bp_unit_id,
    category_id = bp_category_id,
    manufacture_id = bp_manufacture_id,
    tax_id = bp_tax_id,
    is_combination = bp_combination,
    updated_at = NOW(),
    updated_by = bp_updated_by
WHERE id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateProductDetail
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateProductDetail`(
	IN `bp_id` INT,
	IN `bp_reference` VARCHAR(50),
	IN `bp_name` VARCHAR(50),
	IN `bp_sku` varchar(45),
	IN `bp_ean13` varchar(13),
	IN `bp_upc` varchar(12),
	IN `bp_cost` DOUBLE,
	IN `bp_sale_price` DOUBLE,
	IN `bp_condition_id` INT(11),
	IN `bp_price_list_id` INT(11)









,
	IN `bp_updated_by` INT
)
BEGIN
--	DECLARE exist BOOLEAN;
	
--	SET exist = (SELECT 1 FROM product_details WHERE id = bp_id);
	
--	IF exits = 1 THEN
	
	    UPDATE product_details SET
	    	`name` = bp_name,
	    	`reference` = bp_reference,
	        `sku` = bp_sku,
	        `ean13` = bp_ean13,
	        `upc` = bp_upc,
	        `cost` = bp_cost,
	        `sale_price` = bp_sale_price,
	        `condition_id` = bp_condition_id,
	        `price_list_id` = bp_price_list_id,
	        `updated_at` = NOW(),
	        updated_by = bp_updated_by
	    WHERE
	        id = bp_id;
--	ELSE
	
	--	CALL CR_InsertProductDetail(bp_name,bp_product_id,bp_sku,bp_ean13,bp_upc,bp_cost,bp_sale_price,bp_condition_id,bp_price_list_id);
	
--	END IF;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateProspect
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateProspect`(
	IN `bp_id` INT,
	IN `bp_cif` VARCHAR(50),
	IN `bp_alias` VARCHAR(50),
	IN `bp_name` VARCHAR(50),
	IN `bp_name_2` VARCHAR(50),
	IN `bp_url` VARCHAR(50),
	IN `bp_email` VARCHAR(50)
,
	IN `bp_update_by` INT
)
BEGIN
	UPDATE bpartners SET
		cif = bp_cif,
		alias = bp_alias,
		name = bp_name,
		name_2 = bp_name_2,
		url = bp_url,
		email = bp_email,
		update_by = bp_update_by
	WHERE id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateRealStockProductDetail
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateRealStockProductDetail`(
	IN `bp_id` INT,
	IN `bp_stock` DECIMAL(10,0)

)
BEGIN
	DECLARE vp_warehouse_id INT;
	
	SET vp_warehouse_id = (SELECT w.id FROM warehouses w INNER JOIN setup_sales s_s ON w.id = s_s.warehouse_id AND s_s.`default` = 1 LIMIT 1);
	
	UPDATE stocks
	SET real_stock = bp_stock
	WHERE warehouse_id = vp_warehouse_id AND product_id = bp_id;
	
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateReport
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateReport`(
	IN `bp_id` INT,
	IN `bp_name` VARCHAR(50),
	IN `bp_description` varchar(50),
	IN `bp_table_id` INT,
	IN `bp_header_id` INT,
	IN `bp_body_id` INT,
	IN `bp_footer_id` INT,
	IN `bp_updated_by` INT

)
BEGIN	
	UPDATE `reports` SET
        `name` = bp_name,
        `description` = bp_description,
        `table_id` = bp_table_id,
        `header_id` = bp_header_id,
        `body_id` = bp_body_id,
        `footer_id` = bp_footer_id,
        `updated_by` = bp_updated_by
   WHERE
   	id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateReportOld
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateReportOld`(
	IN `bp_id` INT(10),
	IN `bp_template` VARCHAR(255),
	IN `bp_title` VARCHAR(32),
	IN `bp_description` VARCHAR(64),
	IN `bp_picture` VARCHAR(255)
	
)
BEGIN
		UPDATE `reports` SET
		`template`    = `bp_template`,
		`title`       = `bp_title`,
		`description` = `bp_description`,
		`picture`     = `bp_picture`
		WHERE `id`    = `bp_id`;
	END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateRol
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateRol`(
	IN `bp_rol_id` INT,
	IN `bp_rol_name` VARCHAR(45),
	IN `bp_description` VARCHAR(45),
	IN `bp_all_access_column` BOOLEAN,
	IN `bp_all_access_organization` BOOLEAN,
	IN `bp_updated_by` INT
)
BEGIN
	UPDATE rols 
	SET `name` = bp_rol_name, description = bp_description, all_access_column = bp_all_access_column,
		all_access_organization = bp_all_access_organization, updated_at = NOW(), updated_by = bp_updated_by
	WHERE id = bp_rol_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateSetting
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateSetting`(
	IN `bp_id` INT
,
	IN `bp_country_id` INT,
	IN `bp_state_id` INT,
	IN `bp_city_id` INT,
	IN `bp_language_id` INT


)
BEGIN
	UPDATE settings
	SET
		country_id = bp_country_id,
		state_id = bp_state_id,
      city_id = bp_city_id,
      language_id = bp_language_id,
      updated_at = NOW()
	WHERE id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateSetupConfiguration
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateSetupConfiguration`(
	IN `bp_id` INT,
	IN `bp_user` INT,
	IN `bp_setting` JSON,
	IN `bp_default` BOOLEAN






)
BEGIN
	DECLARE exist BOOLEAN DEFAULT FALSE;

	SET exist = (SELECT TRUE FROM setup_configurations s_c WHERE s_c.id = bp_id );
	
	IF exist = TRUE THEN
	
		UPDATE setup_configurations SET
			setting = bp_setting,
			`default` = bp_default
		WHERE
			id = bp_id;
			
		SELECT 0 id;
	
	ELSE	
	
		CALL CR_InsertSetupConfiguration(bp_user, bp_setting, bp_default);
	
	END IF;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateSetupSale
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateSetupSale`(
	IN `bp_id` INT,
	IN `bp_user` INT,
	IN `bp_setting` JSON,
	IN `bp_default` BOOLEAN

)
BEGIN
	DECLARE exist BOOLEAN DEFAULT FALSE;

	SET exist = (SELECT TRUE FROM setup_sales s_s WHERE s_s.id = bp_id );
	
	IF exist = TRUE THEN
	
		UPDATE setup_sales SET
			setting = bp_setting,
			`default` = bp_default
		WHERE
			id = bp_id;
			
		SELECT 0 id;
	
	ELSE	
	
		CALL CR_InsertSetupSale(bp_user, bp_setting, bp_default);
	
	END IF;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateState
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateState`(
	IN `bp_state_id` INT,
	IN `bp_country_id` INT,
	IN `bp_state_name` VARCHAR(45),
	IN `bp_iso` VARCHAR(5) 
,
	IN `bp_updated_by` INT
)
BEGIN
	UPDATE states
    SET state = bp_state_name, iso = bp_iso, updated_at = NOW(), country_id = bp_country_id, updated_by = bp_updated_by
    WHERE id = bp_state_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateTableListSetting
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateTableListSetting`(
	IN `bp_user` INT,
	IN `bp_table` INT,
	IN `bp_setting` JSON

)
BEGIN
	DECLARE exist BOOLEAN;
	
	SET exist = (SELECT 1 FROM table_list_settings t_l_s
		INNER JOIN users u ON t_l_s.user_id = u.id AND u.id = `bp_user`
		INNER JOIN tables t ON t.id = t_l_s.table_id AND t.id = `bp_table`
	);
	
	IF exist = TRUE THEN
	
		UPDATE table_list_settings SET
		`setting` = `bp_setting`
		WHERE `user_id` = `bp_user` AND `table_id` = `bp_table`;
	
	ELSE
	
		CALL CR_InsertTableListSetting(`bp_user`, `bp_table`, `bp_setting`);
	
	END IF;
	
	
	
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateTax
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateTax`(
	IN `bp_id` INT
,
	IN `bp_name` VARCHAR(50),
	IN `bp_print_name` VARCHAR(50),
	IN `bp_validfrom` DATETIME,
	IN `bp_rate` DECIMAL(10,0),
	IN `bp_notes` TEXT

,
	IN `bp_updated_by` INT
)
BEGIN
UPDATE taxes
    SET name = bp_name, print_name = bp_print_name, validfrom= bp_validfrom, rate = bp_rate, updated_at = NOW(), notes= bp_notes, updated_by = bp_updated_by
    WHERE id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateTypeDocumentSetting
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateTypeDocumentSetting`(
	IN `bp_type_document` INT,
	IN `bp_setting` JSON
,
	IN `bp_user` INT
)
BEGIN
	DECLARE exist BOOLEAN;
	
	SET exist = (
        SELECT count(t_d_s.type_document_id) FROM `type_document_settings` t_d_s
        INNER JOIN `type_documents` t_d ON t_d.id = t_d_s.type_document_id
        INNER JOIN `users` u ON u.id = t_d_s.user_id
        WHERE t_d.id = `bp_type_document` AND u.id = `bp_user`
	);
	
	IF exist = TRUE THEN
	
		UPDATE `type_document_settings` SET
		`setting` = `bp_setting`
		WHERE `type_document_id` = `bp_type_document` AND user_id = `bp_user`;
	
	ELSE
	
		CALL CR_InsertTypeDocumentSetting(`bp_type_document`, `bp_setting`, `bp_user`);
	
	END IF;
	
	
	
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateUnits
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateUnits`(
	IN `bp_unit_id` INT,
	IN `bp_tag` VARCHAR(45),
	IN `bp_quantity` DOUBLE

,
	IN `bp_updated_by` INT
)
BEGIN
	UPDATE units
	SET name = bp_tag,
		quantity = bp_quantity,
      updated_at = NOW(),
      updated_by = bp_updated_by
	WHERE id = bp_unit_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateUser
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateUser`(
	IN `bp_user_id` INT,
	IN `bp_user_name` VARCHAR(45),
	IN `bp_email` VARCHAR(45),
	IN `bp_all_access_organization` BOOLEAN,
	IN `bp_all_access_column` BOOLEAN


,
	IN `bp_updated_by` INT
)
BEGIN
	UPDATE users 
	SET 
    `name` = bp_user_name, 
    email = bp_email,
	all_access_organization = bp_all_access_organization, 
    all_access_column = bp_all_access_column,
	updated_at = NOW(),
	updated_by = bp_updated_by
	WHERE id = bp_user_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.UP_UpdateWarehouse
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `UP_UpdateWarehouse`(
	IN `bp_id` int,
	IN `bp_reference` varchar(45),
	IN `bp_name` varchar(45),
	IN `bp_organization_id` INT,
	IN `bp_notes` text


)
BEGIN
	UPDATE warehouses
	SET reference = bp_reference,
		`name` = bp_name,
        bp_organization_id = bp_organization_id,
        notes = bp_notes,
        updated_at = NOW()
	WHERE id = bp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.zsp_generate_audit
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `zsp_generate_audit`(IN audit_schema_name VARCHAR(255), IN audit_table_name VARCHAR(255), OUT script LONGTEXT, OUT errors LONGTEXT)
main_block: BEGIN

	DECLARE trg_insert, trg_update, trg_delete, vw_audit, vw_audit_meta, out_errors LONGTEXT;
	DECLARE stmt, stmtins,stmtdel, header LONGTEXT;
	DECLARE at_id1, at_id2 LONGTEXT;
	DECLARE c INTEGER;

	-- Default max length of GROUP_CONCAT IS 1024
	SET SESSION group_concat_max_len = 100000;

	SET out_errors := '';

	-- Check to see if the specified table exists
	SET c := (SELECT COUNT(*) FROM information_schema.tables
			WHERE BINARY TABLE_SCHEMA = BINARY audit_schema_name 
				AND BINARY table_name = BINARY audit_table_name);
	IF c <> 1 THEN
		SET out_errors := CONCAT( out_errors, '\n', 'The table you specified `', audit_schema_name, '`.`', audit_table_name, '` does not exists.' );
		LEAVE main_block;
	END IF;


	-- Check audit and meta table exists
	SET c := (SELECT COUNT(*) FROM information_schema.tables
			WHERE BINARY TABLE_SCHEMA = BINARY audit_schema_name 
				AND (BINARY table_name = BINARY 'zaudit' OR BINARY table_name = BINARY 'zaudit_meta') );
	IF c <> 2 THEN
		SET out_errors := CONCAT( out_errors, '\n', 'Audit table structure do not exists, please check or run the audit setup script again.' );
	END IF;


	-- Check triggers exists
	SET c := ( SELECT GROUP_CONCAT( TRIGGER_NAME SEPARATOR ', ') FROM information_schema.triggers
			WHERE BINARY EVENT_OBJECT_SCHEMA = BINARY audit_schema_name 
				AND BINARY EVENT_OBJECT_TABLE = BINARY audit_table_name 
				AND BINARY ACTION_TIMING = BINARY 'AFTER' AND BINARY TRIGGER_NAME NOT LIKE BINARY CONCAT('z', audit_table_name, '_%') GROUP BY EVENT_OBJECT_TABLE );
	IF c IS NOT NULL AND LENGTH(c) > 0 THEN
		SET out_errors := CONCAT( out_errors, '\n', 'MySQL 5 only supports one trigger per insert/update/delete action. Currently there are these triggers (', c, ') already assigned to `', audit_schema_name, '`.`', audit_table_name, '`. You must remove them before the audit trigger can be applied' );
	END IF;

	

	-- Get the first primary key 
	SET at_id1 := (SELECT COLUMN_NAME FROM information_schema.columns
			WHERE BINARY TABLE_SCHEMA = BINARY audit_schema_name 
				AND BINARY table_name = BINARY audit_table_name
			AND column_key = 'PRI' LIMIT 1);

	-- Get the second primary key 
	SET at_id2 := (SELECT COLUMN_NAME FROM information_schema.columns
			WHERE BINARY TABLE_SCHEMA = BINARY audit_schema_name 
				AND BINARY table_name = BINARY audit_table_name
			AND column_key = 'PRI' LIMIT 1,1);

	-- Check at least one id exists
	IF at_id1 IS NULL AND at_id2 IS NULL THEN 
		SET out_errors := CONCAT( out_errors, '\n', 'The table you specified `', audit_schema_name, '`.`', audit_table_name, '` does not have any primary key.' );
	END IF;



	SET header := CONCAT( 
		'-- --------------------------------------------------------------------\n',
		'-- MySQL Audit Trigger\n',
		'-- Copyright (c) 2014 Du T. Dang. MIT License\n',
		'-- https://github.com/hotmit/mysql-sp-audit\n',
		'-- --------------------------------------------------------------------\n\n'		
	);

	
	SET trg_insert := CONCAT( 'DROP TRIGGER IF EXISTS `', audit_schema_name, '`.`z', audit_table_name, '_AINS`\n$$\n',
						'CREATE TRIGGER `', audit_schema_name, '`.`z', audit_table_name, '_AINS` AFTER INSERT ON `', audit_schema_name, '`.`', audit_table_name, '` FOR EACH ROW \nBEGIN\n', header );
	SET trg_update := CONCAT( 'DROP TRIGGER IF EXISTS `', audit_schema_name, '`.`z', audit_table_name, '_AUPD`\n$$\n',
						'CREATE TRIGGER `', audit_schema_name, '`.`z', audit_table_name, '_AUPD` AFTER UPDATE ON `', audit_schema_name, '`.`', audit_table_name, '` FOR EACH ROW \nBEGIN\n', header );
	SET trg_delete := CONCAT( 'DROP TRIGGER IF EXISTS `', audit_schema_name, '`.`z', audit_table_name, '_ADEL`\n$$\n',
						'CREATE TRIGGER `', audit_schema_name, '`.`z', audit_table_name, '_ADEL` AFTER DELETE ON `', audit_schema_name, '`.`', audit_table_name, '` FOR EACH ROW \nBEGIN\n', header );

	SET stmt := 'DECLARE zaudit_last_inserted_id BIGINT(20);\n\n';
	SET trg_insert := CONCAT( trg_insert, stmt );
	SET trg_update := CONCAT( trg_update, stmt );
	SET trg_delete := CONCAT( trg_delete, stmt );


	-- ----------------------------------------------------------
	-- [ Create Insert Statement Into Audit & Audit Meta Tables ]
	-- ----------------------------------------------------------

	SET stmt := CONCAT( 'INSERT IGNORE INTO `', audit_schema_name, '`.zaudit (user, table_name, pk1, ', CASE WHEN at_id2 IS NULL THEN '' ELSE 'pk2, ' END , 'action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), ', 
		'''', audit_table_name, ''', ', 'NEW.`', at_id1, '`, ', IFNULL( CONCAT('NEW.`', at_id2, '`, ') , '') );

	SET trg_insert := CONCAT( trg_insert, stmt, '''INSERT''); \n\n');

	SET stmt := CONCAT( 'INSERT IGNORE INTO `', audit_schema_name, '`.zaudit (user, table_name, pk1, ', CASE WHEN at_id2 IS NULL THEN '' ELSE 'pk2, ' END , 'action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), ', 
		'''', audit_table_name, ''', ', 'OLD.`', at_id1, '`, ', IFNULL( CONCAT('OLD.`', at_id2, '`, ') , '') );

	SET stmtdel := CONCAT( 'INSERT IGNORE INTO `', audit_schema_name, '`.zaudit (user, table_name, pk1, ', CASE WHEN at_id2 IS NULL THEN '' ELSE 'pk2, ' END , 'action)  VALUE ( IFNULL( @',audit_table_name,'_delete , USER() ), ', 
			'''', audit_table_name, ''', ', 'OLD.`', at_id1, '`, ', IFNULL( CONCAT('OLD.`', at_id2, '`, ') , '') );
        
	SET trg_update := CONCAT( trg_update, stmt, '''UPDATE''); \n\n' );
	SET trg_delete := CONCAT( trg_delete, stmtdel, '''DELETE''); \n\n' );


	SET stmt := 'SET zaudit_last_inserted_id = LAST_INSERT_ID();\n';
	SET trg_insert := CONCAT( trg_insert, stmt );
	SET trg_update := CONCAT( trg_update, stmt );
	SET trg_delete := CONCAT( trg_delete, stmt );
	
	SET stmt := CONCAT( 'INSERT IGNORE INTO `', audit_schema_name, '`.zaudit_meta (audit_id, col_name, old_value, new_value)  \n' );
	SET trg_insert := CONCAT( trg_insert, '\n', stmt );
	SET trg_update := CONCAT( trg_update, '\n', stmt, 'select * from (  ' );
	SET trg_delete := CONCAT( trg_delete, '\n', stmt );

	SET stmt := ( SELECT GROUP_CONCAT(' zaudit_last_inserted_id, ''', COLUMN_NAME, ''', NULL, ',	
						CASE WHEN INSTR( '|binary|varbinary|tinyblob|blob|mediumblob|longblob|', LOWER(DATA_TYPE) ) <> 0 THEN 
							'''[UNSUPPORTED BINARY DATATYPE]''' 
						ELSE 						
							CONCAT('NEW.`', COLUMN_NAME, '`')
						END,
						CONCAT(' where NEW.`', COLUMN_NAME, '`<=> OLD.`', COLUMN_NAME, '` UNION ALL ')
					SEPARATOR ' \n')
					FROM information_schema.columns
						WHERE BINARY TABLE_SCHEMA = BINARY audit_schema_name
							AND BINARY TABLE_NAME = BINARY audit_table_name );
	
	SET stmt := CONCAT( TRIM( TRAILING 'UNION ALL' FROM stmt ), ') tmp ;\n\nEND\n$$' );
    
    SET stmtins := CONCAT('VALUES (zaudit_last_inserted_id, ''id'', NULL, NEW.`id`)' , ';\n\nEND\n$$' );
    
	SET trg_insert := CONCAT( trg_insert, stmtins );



	SET stmt := ( SELECT GROUP_CONCAT(' SELECT  zaudit_last_inserted_id as ''LID'', ''', COLUMN_NAME, ''' as ''col'', ', 
						CASE WHEN INSTR( '|binary|varbinary|tinyblob|blob|mediumblob|longblob|', LOWER(DATA_TYPE) ) <> 0 THEN
							'''[SAME]'''
						ELSE
							CONCAT('OLD.`', COLUMN_NAME, '` as ''OLD.`', COLUMN_NAME,'`''')
						END,
						', ',
						CASE WHEN INSTR( '|binary|varbinary|tinyblob|blob|mediumblob|longblob|', LOWER(DATA_TYPE) ) <> 0 THEN
							CONCAT('CASE WHEN BINARY OLD.`', COLUMN_NAME, '` <=> BINARY NEW.`', COLUMN_NAME, '` THEN ''[SAME]'' ELSE ''[CHANGED]'' END')
						ELSE
							CONCAT('NEW.`', COLUMN_NAME, '` as ''NEW.`', COLUMN_NAME,'`''')
						END,
						CONCAT(' WHERE  NOT(NEW.`', COLUMN_NAME, '` <=>  OLD.`', COLUMN_NAME, '`) UNION ALL')
					SEPARATOR '\n') 
					FROM information_schema.columns
						WHERE BINARY TABLE_SCHEMA = BINARY audit_schema_name 
							AND BINARY TABLE_NAME = BINARY audit_table_name );

	SET stmt := CONCAT( TRIM( TRAILING 'UNION ALL' FROM stmt ), ') tmp ;\n\nEND\n$$' );
	SET trg_update := CONCAT( trg_update, stmt );


	SET stmt := ( SELECT GROUP_CONCAT('  (zaudit_last_inserted_id, ''', COLUMN_NAME, ''', ', 
						CASE WHEN INSTR( '|binary|varbinary|tinyblob|blob|mediumblob|longblob|', LOWER(DATA_TYPE) ) <> 0 THEN 
							'''[UNSUPPORTED BINARY DATATYPE]''' 
						ELSE 						
							CONCAT('OLD.`', COLUMN_NAME, '`')
						END,
						', NULL ),'
					SEPARATOR '\n') 
					FROM information_schema.columns
						WHERE BINARY TABLE_SCHEMA = BINARY audit_schema_name 
							AND BINARY TABLE_NAME = BINARY audit_table_name );


	SET stmt := CONCAT( TRIM( TRAILING ',' FROM stmt ), ';\n set @',audit_table_name,'_delete = null;   \n\nEND\n$$' );
	SET trg_delete := CONCAT( trg_delete,' VALUES ', stmt );

	-- -----------------------------------------------
	-- [ Generating Helper Views For The Audit Table ] 
	-- -----------------------------------------------
	SET stmt := CONCAT( 'DROP VIEW IF EXISTS `', audit_schema_name, '`.`zvw_audit_', audit_table_name, '_meta`\n$$\n',
						'CREATE VIEW `', audit_schema_name, '`.`zvw_audit_', audit_table_name, '_meta` AS \n', header,
						'SELECT za.audit_id, zm.audit_meta_id, za.user, \n',
						'	za.pk1, za.pk2,\n',
						'	za.action, zm.col_name, zm.old_value, zm.new_value, za.timestamp\n',
						'FROM `', audit_schema_name, '`.zaudit za \n', 
						'INNER JOIN `', audit_schema_name, '`.zaudit_meta zm ON za.audit_id = zm.audit_id \n',
						'WHERE za.table_name = ''', audit_table_name, '''');

	SET vw_audit_meta := CONCAT( stmt, '$$' );


	SET stmt := ( SELECT GROUP_CONCAT( 	'		MAX((CASE WHEN zm.col_name = ''', COLUMN_NAME, ''' THEN zm.old_value ELSE NULL END)) AS `', COLUMN_NAME, '_old`, \n',
										'		MAX((CASE WHEN zm.col_name = ''', COLUMN_NAME, ''' THEN zm.new_value ELSE NULL END)) AS `', COLUMN_NAME, '_new`, \n' 
						SEPARATOR '\n') 
					FROM information_schema.columns
						WHERE BINARY TABLE_SCHEMA = BINARY audit_schema_name 
							AND BINARY TABLE_NAME = BINARY audit_table_name 
				);
	SET stmt := TRIM( TRAILING ', \n' FROM stmt );		
	SET stmt := ( SELECT CONCAT( 	'DROP VIEW IF EXISTS `', audit_schema_name, '`.`zvw_audit_', audit_table_name, '`\n$$\n',
									'CREATE VIEW `', audit_schema_name, '`.`zvw_audit_', audit_table_name, '` AS \n', header,
									'SELECT za.audit_id, za.user, za.pk1, za.pk2,\n', 
									'za.action, za.timestamp, \n', 
									stmt , '\n',
									'	FROM `', audit_schema_name, '`.zaudit za \n', 
									'	INNER JOIN `', audit_schema_name, '`.zaudit_meta zm ON za.audit_id = zm.audit_id \n'
									'WHERE za.table_name = ''', audit_table_name, '''\n',
									'GROUP BY zm.audit_id') );

	SET vw_audit := CONCAT( stmt, '\n$$' );


	-- SELECT trg_insert, trg_update, trg_delete, vw_audit, vw_audit_meta;

	SET stmt = CONCAT( 
		'-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n',
		'-- --------------------------------------------------------------------\n',
		'-- Audit Script For `',audit_schema_name, '`.`', audit_table_name, '`\n',
		'-- Date Generated: ', NOW(), '\n',
		'-- Generated By: ', CURRENT_USER(), '\n',
		'-- BEGIN\n',
		'-- --------------------------------------------------------------------\n\n'	
		'DELIMITER $$',
		'\n\n-- [ `',audit_schema_name, '`.`', audit_table_name, '` After Insert Trigger Code ]\n',		
		'-- -----------------------------------------------------------\n',
		trg_insert,
		'\n\n-- [ `',audit_schema_name, '`.`', audit_table_name, '` After Update Trigger Code ]\n',
		'-- -----------------------------------------------------------\n',
		trg_update,
		'\n\n-- [ `',audit_schema_name, '`.`', audit_table_name, '` After Delete Trigger Code ]\n',		
		'-- -----------------------------------------------------------\n',
		trg_delete,
		'\n\n-- [ `',audit_schema_name, '`.`', audit_table_name, '` Audit Meta View ]\n',		
		'-- -----------------------------------------------------------\n',
		vw_audit_meta,
		'\n\n-- [ `',audit_schema_name, '`.`', audit_table_name, '` Audit View ]\n',		
		'-- -----------------------------------------------------------\n',
		vw_audit,
		'\n\n',
		'-- --------------------------------------------------------------------\n',
		'-- END\n',
		'-- Audit Script For `',audit_schema_name, '`.`', audit_table_name, '`\n',		
		'-- --------------------------------------------------------------------\n\n',
		'-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\n'
		);

	-- SELECT stmt AS `Audit Script`, out_errors AS `ERRORS`;

	SET script := stmt;
	SET errors := out_errors;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.zsp_generate_batch_audit
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `zsp_generate_batch_audit`(IN audit_schema_name VARCHAR(255), IN audit_table_names VARCHAR(255), OUT out_script LONGTEXT, OUT out_error_msgs LONGTEXT)
main_block: BEGIN

	DECLARE s, e, scripts, error_msgs LONGTEXT;
	DECLARE audit_table_name VARCHAR(255);
	DECLARE done INT DEFAULT FALSE;
	DECLARE cursor_table_list CURSOR FOR SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES 
		WHERE BINARY TABLE_TYPE = BINARY 'BASE TABLE' 
			AND BINARY TABLE_SCHEMA = BINARY audit_schema_name
			AND LOCATE( BINARY CONCAT(TABLE_NAME, ','), BINARY CONCAT(audit_table_names, ',') ) > 0;

	DECLARE CONTINUE HANDLER
		FOR NOT FOUND SET done = TRUE;

	SET scripts := '';
	SET error_msgs := '';

	OPEN cursor_table_list;

	cur_loop: LOOP
		FETCH cursor_table_list INTO audit_table_name;

		IF done THEN
			LEAVE cur_loop;
		END IF;

		CALL zsp_generate_audit(audit_schema_name, audit_table_name, s, e);

		SET scripts := CONCAT( scripts, '\n\n', IFNULL(s, '') );
		SET error_msgs := CONCAT( error_msgs, '\n\n', IFNULL(e, '') );

	END LOOP;

	CLOSE cursor_table_list;

	SET out_script := scripts;
	SET out_error_msgs := error_msgs;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.zsp_generate_batch_remove_audit
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `zsp_generate_batch_remove_audit`(IN audit_schema_name VARCHAR(255), IN audit_table_names VARCHAR(255), OUT out_script LONGTEXT)
main_block: BEGIN

	DECLARE s, scripts LONGTEXT;
	DECLARE audit_table_name VARCHAR(255);
	DECLARE done INT DEFAULT FALSE;
	DECLARE cursor_table_list CURSOR FOR SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES 
		WHERE BINARY TABLE_TYPE = BINARY 'BASE TABLE' 
			AND BINARY TABLE_SCHEMA = BINARY audit_schema_name
			AND LOCATE( BINARY CONCAT(TABLE_NAME, ','), BINARY CONCAT(audit_table_names, ',') ) > 0;

	DECLARE CONTINUE HANDLER
		FOR NOT FOUND SET done = TRUE;

	SET scripts := '';

	OPEN cursor_table_list;

	cur_loop: LOOP
		FETCH cursor_table_list INTO audit_table_name;

		IF done THEN
			LEAVE cur_loop;
		END IF;

		CALL zsp_generate_remove_audit(audit_schema_name, audit_table_name, s);

		SET scripts := CONCAT( scripts, '\n\n', IFNULL(s, '') );

	END LOOP;

	CLOSE cursor_table_list;

	SET out_script := scripts;
END//
DELIMITER ;

-- Volcando estructura para procedimiento banana.zsp_generate_remove_audit
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `zsp_generate_remove_audit`(IN audit_schema_name VARCHAR(255), IN audit_table_name VARCHAR(255), OUT script LONGTEXT)
main_block: BEGIN

	SET script := CONCAT(
		'-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n',
		'-- --------------------------------------------------------------------\n',
		'-- Audit Removal Script For `',audit_schema_name, '`.`', audit_table_name, '` \n',
		'-- Date Generated: ', NOW(), '\n',
		'-- Generated By: ', CURRENT_USER(), '\n',
		'-- BEGIN\n',
		'-- --------------------------------------------------------------------\n\n', 
		'DELIMITER $$\n\n',

		'DROP TRIGGER IF EXISTS `', audit_schema_name, '`.`z', audit_table_name, '_AINS`\n$$\n',
		'DROP TRIGGER IF EXISTS `', audit_schema_name, '`.`z', audit_table_name, '_AUPD`\n$$\n',
		'DROP TRIGGER IF EXISTS `', audit_schema_name, '`.`z', audit_table_name, '_ADEL`\n$$\n',

		'DROP VIEW IF EXISTS `', audit_schema_name, '`.`zvw_audit_', audit_table_name, '_meta`\n$$\n',
		'DROP VIEW IF EXISTS `', audit_schema_name, '`.`zvw_audit_', audit_table_name, '`\n$$\n',

		'\n\n',
		'-- --------------------------------------------------------------------\n',
		'-- END\n',
		'-- Audit Removal Script For `',audit_schema_name, '`.`', audit_table_name, '`\n',		
		'-- --------------------------------------------------------------------\n\n',
		'-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\n'
	);

END//
DELIMITER ;

-- Volcando estructura para disparador banana.bpartner_locations_BEFORE_INSERT
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `bpartner_locations_BEFORE_INSERT` BEFORE INSERT ON `bpartner_locations` FOR EACH ROW BEGIN
	DECLARE count_branch INT;
    SET count_branch = (SELECT count(*) FROM bpartner_locations WHERE bpartner_id = NEW.bpartner_id );
    
    IF count_branch = 0 THEN
		SET NEW.principal = 1;
	END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.user_rol_after_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `user_rol_after_insert` AFTER INSERT ON `user_rol` FOR EACH ROW BEGIN
	DECLARE t_a_c INT;
	DECLARE t_a_o INT;
	
	SET t_a_c = (
		SELECT r.all_access_column FROM rols r WHERE r.id = NEW.rol_id
	);
	
	SET t_a_o = (
		SELECT r.all_access_organization FROM rols r WHERE r.id = NEW.rol_id
	);
	
	IF t_a_c THEN
		UPDATE users u SET u.all_access_column = 1 WHERE u.id = NEW.user_id;
	END IF;
	
	IF t_a_o THEN
		UPDATE users u SET u.all_access_organization = 1 WHERE u.id = NEW.user_id;
	END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zattributes_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zattributes_ADEL` AFTER DELETE ON `attributes` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @attributes_delete , USER() ), 'attributes', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'name', OLD.`name`, NULL ),
  (zaudit_last_inserted_id, 'type_attribute', OLD.`type_attribute`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @attributes_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zattributes_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zattributes_AINS` AFTER INSERT ON `attributes` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'attributes', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zattributes_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zattributes_AUPD` AFTER UPDATE ON `attributes` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'attributes', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'name' as 'col', OLD.`name` as 'OLD.`name`', NEW.`name` as 'NEW.`name`' WHERE  NOT(NEW.`name` <=>  OLD.`name`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'type_attribute' as 'col', OLD.`type_attribute` as 'OLD.`type_attribute`', NEW.`type_attribute` as 'NEW.`type_attribute`' WHERE  NOT(NEW.`type_attribute` <=>  OLD.`type_attribute`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zattribute_details_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zattribute_details_ADEL` AFTER DELETE ON `attribute_details` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @attribute_details_delete , USER() ), 'attribute_details', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'attribute_id', OLD.`attribute_id`, NULL ),
  (zaudit_last_inserted_id, 'reference', OLD.`reference`, NULL ),
  (zaudit_last_inserted_id, 'name', OLD.`name`, NULL ),
  (zaudit_last_inserted_id, 'color', OLD.`color`, NULL ),
  (zaudit_last_inserted_id, 'position', OLD.`position`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @attribute_details_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zattribute_details_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zattribute_details_AINS` AFTER INSERT ON `attribute_details` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'attribute_details', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zattribute_details_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zattribute_details_AUPD` AFTER UPDATE ON `attribute_details` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'attribute_details', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'attribute_id' as 'col', OLD.`attribute_id` as 'OLD.`attribute_id`', NEW.`attribute_id` as 'NEW.`attribute_id`' WHERE  NOT(NEW.`attribute_id` <=>  OLD.`attribute_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'reference' as 'col', OLD.`reference` as 'OLD.`reference`', NEW.`reference` as 'NEW.`reference`' WHERE  NOT(NEW.`reference` <=>  OLD.`reference`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'name' as 'col', OLD.`name` as 'OLD.`name`', NEW.`name` as 'NEW.`name`' WHERE  NOT(NEW.`name` <=>  OLD.`name`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'color' as 'col', OLD.`color` as 'OLD.`color`', NEW.`color` as 'NEW.`color`' WHERE  NOT(NEW.`color` <=>  OLD.`color`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'position' as 'col', OLD.`position` as 'OLD.`position`', NEW.`position` as 'NEW.`position`' WHERE  NOT(NEW.`position` <=>  OLD.`position`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zbpartners_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zbpartners_ADEL` AFTER DELETE ON `bpartners` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @bpartners_delete , USER() ), 'bpartners', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'logo', OLD.`logo`, NULL ),
  (zaudit_last_inserted_id, 'cif', OLD.`cif`, NULL ),
  (zaudit_last_inserted_id, 'is_customer', OLD.`is_customer`, NULL ),
  (zaudit_last_inserted_id, 'is_vendor', OLD.`is_vendor`, NULL ),
  (zaudit_last_inserted_id, 'alias', OLD.`alias`, NULL ),
  (zaudit_last_inserted_id, 'email', OLD.`email`, NULL ),
  (zaudit_last_inserted_id, 'name', OLD.`name`, NULL ),
  (zaudit_last_inserted_id, 'name_2', OLD.`name_2`, NULL ),
  (zaudit_last_inserted_id, 'is_employee', OLD.`is_employee`, NULL ),
  (zaudit_last_inserted_id, 'is_prospect', OLD.`is_prospect`, NULL ),
  (zaudit_last_inserted_id, 'is_sales_rep', OLD.`is_sales_rep`, NULL ),
  (zaudit_last_inserted_id, 'reference_no', OLD.`reference_no`, NULL ),
  (zaudit_last_inserted_id, 'sales_rep_id', OLD.`sales_rep_id`, NULL ),
  (zaudit_last_inserted_id, 'credit_status', OLD.`credit_status`, NULL ),
  (zaudit_last_inserted_id, 'credit_limit', OLD.`credit_limit`, NULL ),
  (zaudit_last_inserted_id, 'total_open_balance', OLD.`total_open_balance`, NULL ),
  (zaudit_last_inserted_id, 'tax_id', OLD.`tax_id`, NULL ),
  (zaudit_last_inserted_id, 'is_tax_exempt', OLD.`is_tax_exempt`, NULL ),
  (zaudit_last_inserted_id, 'is_po_tax_exempt', OLD.`is_po_tax_exempt`, NULL ),
  (zaudit_last_inserted_id, 'url', OLD.`url`, NULL ),
  (zaudit_last_inserted_id, 'description', OLD.`description`, NULL ),
  (zaudit_last_inserted_id, 'is_summary', OLD.`is_summary`, NULL ),
  (zaudit_last_inserted_id, 'archived', OLD.`archived`, NULL ),
  (zaudit_last_inserted_id, 'price_list_id', OLD.`price_list_id`, NULL ),
  (zaudit_last_inserted_id, 'delivery_rule', OLD.`delivery_rule`, NULL ),
  (zaudit_last_inserted_id, 'delivery_via_rule', OLD.`delivery_via_rule`, NULL ),
  (zaudit_last_inserted_id, 'flat_discount', OLD.`flat_discount`, NULL ),
  (zaudit_last_inserted_id, 'is_manufacturer', OLD.`is_manufacturer`, NULL ),
  (zaudit_last_inserted_id, 'po_price_list_id', OLD.`po_price_list_id`, NULL ),
  (zaudit_last_inserted_id, 'language_id', OLD.`language_id`, NULL ),
  (zaudit_last_inserted_id, 'greeting_id', OLD.`greeting_id`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @bpartners_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zbpartners_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zbpartners_AINS` AFTER INSERT ON `bpartners` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'bpartners', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zbpartners_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zbpartners_AUPD` AFTER UPDATE ON `bpartners` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'bpartners', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'logo' as 'col', OLD.`logo` as 'OLD.`logo`', NEW.`logo` as 'NEW.`logo`' WHERE  NOT(NEW.`logo` <=>  OLD.`logo`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'cif' as 'col', OLD.`cif` as 'OLD.`cif`', NEW.`cif` as 'NEW.`cif`' WHERE  NOT(NEW.`cif` <=>  OLD.`cif`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'is_customer' as 'col', OLD.`is_customer` as 'OLD.`is_customer`', NEW.`is_customer` as 'NEW.`is_customer`' WHERE  NOT(NEW.`is_customer` <=>  OLD.`is_customer`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'is_vendor' as 'col', OLD.`is_vendor` as 'OLD.`is_vendor`', NEW.`is_vendor` as 'NEW.`is_vendor`' WHERE  NOT(NEW.`is_vendor` <=>  OLD.`is_vendor`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'alias' as 'col', OLD.`alias` as 'OLD.`alias`', NEW.`alias` as 'NEW.`alias`' WHERE  NOT(NEW.`alias` <=>  OLD.`alias`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'email' as 'col', OLD.`email` as 'OLD.`email`', NEW.`email` as 'NEW.`email`' WHERE  NOT(NEW.`email` <=>  OLD.`email`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'name' as 'col', OLD.`name` as 'OLD.`name`', NEW.`name` as 'NEW.`name`' WHERE  NOT(NEW.`name` <=>  OLD.`name`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'name_2' as 'col', OLD.`name_2` as 'OLD.`name_2`', NEW.`name_2` as 'NEW.`name_2`' WHERE  NOT(NEW.`name_2` <=>  OLD.`name_2`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'is_employee' as 'col', OLD.`is_employee` as 'OLD.`is_employee`', NEW.`is_employee` as 'NEW.`is_employee`' WHERE  NOT(NEW.`is_employee` <=>  OLD.`is_employee`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'is_prospect' as 'col', OLD.`is_prospect` as 'OLD.`is_prospect`', NEW.`is_prospect` as 'NEW.`is_prospect`' WHERE  NOT(NEW.`is_prospect` <=>  OLD.`is_prospect`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'is_sales_rep' as 'col', OLD.`is_sales_rep` as 'OLD.`is_sales_rep`', NEW.`is_sales_rep` as 'NEW.`is_sales_rep`' WHERE  NOT(NEW.`is_sales_rep` <=>  OLD.`is_sales_rep`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'reference_no' as 'col', OLD.`reference_no` as 'OLD.`reference_no`', NEW.`reference_no` as 'NEW.`reference_no`' WHERE  NOT(NEW.`reference_no` <=>  OLD.`reference_no`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'sales_rep_id' as 'col', OLD.`sales_rep_id` as 'OLD.`sales_rep_id`', NEW.`sales_rep_id` as 'NEW.`sales_rep_id`' WHERE  NOT(NEW.`sales_rep_id` <=>  OLD.`sales_rep_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'credit_status' as 'col', OLD.`credit_status` as 'OLD.`credit_status`', NEW.`credit_status` as 'NEW.`credit_status`' WHERE  NOT(NEW.`credit_status` <=>  OLD.`credit_status`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'credit_limit' as 'col', OLD.`credit_limit` as 'OLD.`credit_limit`', NEW.`credit_limit` as 'NEW.`credit_limit`' WHERE  NOT(NEW.`credit_limit` <=>  OLD.`credit_limit`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'total_open_balance' as 'col', OLD.`total_open_balance` as 'OLD.`total_open_balance`', NEW.`total_open_balance` as 'NEW.`total_open_balance`' WHERE  NOT(NEW.`total_open_balance` <=>  OLD.`total_open_balance`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'tax_id' as 'col', OLD.`tax_id` as 'OLD.`tax_id`', NEW.`tax_id` as 'NEW.`tax_id`' WHERE  NOT(NEW.`tax_id` <=>  OLD.`tax_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'is_tax_exempt' as 'col', OLD.`is_tax_exempt` as 'OLD.`is_tax_exempt`', NEW.`is_tax_exempt` as 'NEW.`is_tax_exempt`' WHERE  NOT(NEW.`is_tax_exempt` <=>  OLD.`is_tax_exempt`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'is_po_tax_exempt' as 'col', OLD.`is_po_tax_exempt` as 'OLD.`is_po_tax_exempt`', NEW.`is_po_tax_exempt` as 'NEW.`is_po_tax_exempt`' WHERE  NOT(NEW.`is_po_tax_exempt` <=>  OLD.`is_po_tax_exempt`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'url' as 'col', OLD.`url` as 'OLD.`url`', NEW.`url` as 'NEW.`url`' WHERE  NOT(NEW.`url` <=>  OLD.`url`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'description' as 'col', OLD.`description` as 'OLD.`description`', NEW.`description` as 'NEW.`description`' WHERE  NOT(NEW.`description` <=>  OLD.`description`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'is_summary' as 'col', OLD.`is_summary` as 'OLD.`is_summary`', NEW.`is_summary` as 'NEW.`is_summary`' WHERE  NOT(NEW.`is_summary` <=>  OLD.`is_summary`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'archived' as 'col', OLD.`archived` as 'OLD.`archived`', NEW.`archived` as 'NEW.`archived`' WHERE  NOT(NEW.`archived` <=>  OLD.`archived`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'price_list_id' as 'col', OLD.`price_list_id` as 'OLD.`price_list_id`', NEW.`price_list_id` as 'NEW.`price_list_id`' WHERE  NOT(NEW.`price_list_id` <=>  OLD.`price_list_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'delivery_rule' as 'col', OLD.`delivery_rule` as 'OLD.`delivery_rule`', NEW.`delivery_rule` as 'NEW.`delivery_rule`' WHERE  NOT(NEW.`delivery_rule` <=>  OLD.`delivery_rule`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'delivery_via_rule' as 'col', OLD.`delivery_via_rule` as 'OLD.`delivery_via_rule`', NEW.`delivery_via_rule` as 'NEW.`delivery_via_rule`' WHERE  NOT(NEW.`delivery_via_rule` <=>  OLD.`delivery_via_rule`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'flat_discount' as 'col', OLD.`flat_discount` as 'OLD.`flat_discount`', NEW.`flat_discount` as 'NEW.`flat_discount`' WHERE  NOT(NEW.`flat_discount` <=>  OLD.`flat_discount`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'is_manufacturer' as 'col', OLD.`is_manufacturer` as 'OLD.`is_manufacturer`', NEW.`is_manufacturer` as 'NEW.`is_manufacturer`' WHERE  NOT(NEW.`is_manufacturer` <=>  OLD.`is_manufacturer`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'po_price_list_id' as 'col', OLD.`po_price_list_id` as 'OLD.`po_price_list_id`', NEW.`po_price_list_id` as 'NEW.`po_price_list_id`' WHERE  NOT(NEW.`po_price_list_id` <=>  OLD.`po_price_list_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'language_id' as 'col', OLD.`language_id` as 'OLD.`language_id`', NEW.`language_id` as 'NEW.`language_id`' WHERE  NOT(NEW.`language_id` <=>  OLD.`language_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'greeting_id' as 'col', OLD.`greeting_id` as 'OLD.`greeting_id`', NEW.`greeting_id` as 'NEW.`greeting_id`' WHERE  NOT(NEW.`greeting_id` <=>  OLD.`greeting_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zbpartner_locations_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zbpartner_locations_ADEL` AFTER DELETE ON `bpartner_locations` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @bpartner_locations_delete , USER() ), 'bpartner_locations', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'bpartner_id', OLD.`bpartner_id`, NULL ),
  (zaudit_last_inserted_id, 'location_id', OLD.`location_id`, NULL ),
  (zaudit_last_inserted_id, 'name', OLD.`name`, NULL ),
  (zaudit_last_inserted_id, 'archived', OLD.`archived`, NULL ),
  (zaudit_last_inserted_id, 'is_ship_to', OLD.`is_ship_to`, NULL ),
  (zaudit_last_inserted_id, 'is_bill_to', OLD.`is_bill_to`, NULL ),
  (zaudit_last_inserted_id, 'is_pay_from', OLD.`is_pay_from`, NULL ),
  (zaudit_last_inserted_id, 'is_remit_to', OLD.`is_remit_to`, NULL ),
  (zaudit_last_inserted_id, 'phone', OLD.`phone`, NULL ),
  (zaudit_last_inserted_id, 'phone_2', OLD.`phone_2`, NULL ),
  (zaudit_last_inserted_id, 'fax', OLD.`fax`, NULL ),
  (zaudit_last_inserted_id, 'isdn', OLD.`isdn`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'principal', OLD.`principal`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @bpartner_locations_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zbpartner_locations_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zbpartner_locations_AINS` AFTER INSERT ON `bpartner_locations` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'bpartner_locations', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zbpartner_locations_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zbpartner_locations_AUPD` AFTER UPDATE ON `bpartner_locations` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'bpartner_locations', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'bpartner_id' as 'col', OLD.`bpartner_id` as 'OLD.`bpartner_id`', NEW.`bpartner_id` as 'NEW.`bpartner_id`' WHERE  NOT(NEW.`bpartner_id` <=>  OLD.`bpartner_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'location_id' as 'col', OLD.`location_id` as 'OLD.`location_id`', NEW.`location_id` as 'NEW.`location_id`' WHERE  NOT(NEW.`location_id` <=>  OLD.`location_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'name' as 'col', OLD.`name` as 'OLD.`name`', NEW.`name` as 'NEW.`name`' WHERE  NOT(NEW.`name` <=>  OLD.`name`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'archived' as 'col', OLD.`archived` as 'OLD.`archived`', NEW.`archived` as 'NEW.`archived`' WHERE  NOT(NEW.`archived` <=>  OLD.`archived`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'is_ship_to' as 'col', OLD.`is_ship_to` as 'OLD.`is_ship_to`', NEW.`is_ship_to` as 'NEW.`is_ship_to`' WHERE  NOT(NEW.`is_ship_to` <=>  OLD.`is_ship_to`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'is_bill_to' as 'col', OLD.`is_bill_to` as 'OLD.`is_bill_to`', NEW.`is_bill_to` as 'NEW.`is_bill_to`' WHERE  NOT(NEW.`is_bill_to` <=>  OLD.`is_bill_to`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'is_pay_from' as 'col', OLD.`is_pay_from` as 'OLD.`is_pay_from`', NEW.`is_pay_from` as 'NEW.`is_pay_from`' WHERE  NOT(NEW.`is_pay_from` <=>  OLD.`is_pay_from`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'is_remit_to' as 'col', OLD.`is_remit_to` as 'OLD.`is_remit_to`', NEW.`is_remit_to` as 'NEW.`is_remit_to`' WHERE  NOT(NEW.`is_remit_to` <=>  OLD.`is_remit_to`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'phone' as 'col', OLD.`phone` as 'OLD.`phone`', NEW.`phone` as 'NEW.`phone`' WHERE  NOT(NEW.`phone` <=>  OLD.`phone`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'phone_2' as 'col', OLD.`phone_2` as 'OLD.`phone_2`', NEW.`phone_2` as 'NEW.`phone_2`' WHERE  NOT(NEW.`phone_2` <=>  OLD.`phone_2`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'fax' as 'col', OLD.`fax` as 'OLD.`fax`', NEW.`fax` as 'NEW.`fax`' WHERE  NOT(NEW.`fax` <=>  OLD.`fax`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'isdn' as 'col', OLD.`isdn` as 'OLD.`isdn`', NEW.`isdn` as 'NEW.`isdn`' WHERE  NOT(NEW.`isdn` <=>  OLD.`isdn`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'principal' as 'col', OLD.`principal` as 'OLD.`principal`', NEW.`principal` as 'NEW.`principal`' WHERE  NOT(NEW.`principal` <=>  OLD.`principal`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zcategories_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zcategories_ADEL` AFTER DELETE ON `categories` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @categories_delete , USER() ), 'categories', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'name', OLD.`name`, NULL ),
  (zaudit_last_inserted_id, 'parent_id', OLD.`parent_id`, NULL ),
  (zaudit_last_inserted_id, 'color', OLD.`color`, NULL ),
  (zaudit_last_inserted_id, 'archived', OLD.`archived`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @categories_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zcategories_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zcategories_AINS` AFTER INSERT ON `categories` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'categories', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zcategories_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zcategories_AUPD` AFTER UPDATE ON `categories` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'categories', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'name' as 'col', OLD.`name` as 'OLD.`name`', NEW.`name` as 'NEW.`name`' WHERE  NOT(NEW.`name` <=>  OLD.`name`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'parent_id' as 'col', OLD.`parent_id` as 'OLD.`parent_id`', NEW.`parent_id` as 'NEW.`parent_id`' WHERE  NOT(NEW.`parent_id` <=>  OLD.`parent_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'color' as 'col', OLD.`color` as 'OLD.`color`', NEW.`color` as 'NEW.`color`' WHERE  NOT(NEW.`color` <=>  OLD.`color`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'archived' as 'col', OLD.`archived` as 'OLD.`archived`', NEW.`archived` as 'NEW.`archived`' WHERE  NOT(NEW.`archived` <=>  OLD.`archived`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zcharges_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zcharges_ADEL` AFTER DELETE ON `charges` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @charges_delete , USER() ), 'charges', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'name', OLD.`name`, NULL ),
  (zaudit_last_inserted_id, 'description', OLD.`description`, NULL ),
  (zaudit_last_inserted_id, 'report_to', OLD.`report_to`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @charges_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zcharges_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zcharges_AINS` AFTER INSERT ON `charges` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'charges', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zcharges_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zcharges_AUPD` AFTER UPDATE ON `charges` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'charges', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'name' as 'col', OLD.`name` as 'OLD.`name`', NEW.`name` as 'NEW.`name`' WHERE  NOT(NEW.`name` <=>  OLD.`name`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'description' as 'col', OLD.`description` as 'OLD.`description`', NEW.`description` as 'NEW.`description`' WHERE  NOT(NEW.`description` <=>  OLD.`description`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'report_to' as 'col', OLD.`report_to` as 'OLD.`report_to`', NEW.`report_to` as 'NEW.`report_to`' WHERE  NOT(NEW.`report_to` <=>  OLD.`report_to`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zcities_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zcities_ADEL` AFTER DELETE ON `cities` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @cities_delete , USER() ), 'cities', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'state_id', OLD.`state_id`, NULL ),
  (zaudit_last_inserted_id, 'city', OLD.`city`, NULL ),
  (zaudit_last_inserted_id, 'capital', OLD.`capital`, NULL ),
  (zaudit_last_inserted_id, 'archived', OLD.`archived`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @cities_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zcities_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zcities_AINS` AFTER INSERT ON `cities` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'cities', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zcities_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zcities_AUPD` AFTER UPDATE ON `cities` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'cities', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'state_id' as 'col', OLD.`state_id` as 'OLD.`state_id`', NEW.`state_id` as 'NEW.`state_id`' WHERE  NOT(NEW.`state_id` <=>  OLD.`state_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'city' as 'col', OLD.`city` as 'OLD.`city`', NEW.`city` as 'NEW.`city`' WHERE  NOT(NEW.`city` <=>  OLD.`city`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'capital' as 'col', OLD.`capital` as 'OLD.`capital`', NEW.`capital` as 'NEW.`capital`' WHERE  NOT(NEW.`capital` <=>  OLD.`capital`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'archived' as 'col', OLD.`archived` as 'OLD.`archived`', NEW.`archived` as 'NEW.`archived`' WHERE  NOT(NEW.`archived` <=>  OLD.`archived`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zconditions_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zconditions_ADEL` AFTER DELETE ON `conditions` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @conditions_delete , USER() ), 'conditions', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'name', OLD.`name`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @conditions_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zconditions_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zconditions_AINS` AFTER INSERT ON `conditions` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'conditions', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zconditions_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zconditions_AUPD` AFTER UPDATE ON `conditions` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'conditions', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'name' as 'col', OLD.`name` as 'OLD.`name`', NEW.`name` as 'NEW.`name`' WHERE  NOT(NEW.`name` <=>  OLD.`name`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zcontacts_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zcontacts_ADEL` AFTER DELETE ON `contacts` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @contacts_delete , USER() ), 'contacts', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'name', OLD.`name`, NULL ),
  (zaudit_last_inserted_id, 'description', OLD.`description`, NULL ),
  (zaudit_last_inserted_id, 'comments', OLD.`comments`, NULL ),
  (zaudit_last_inserted_id, 'archived', OLD.`archived`, NULL ),
  (zaudit_last_inserted_id, 'email', OLD.`email`, NULL ),
  (zaudit_last_inserted_id, 'phone', OLD.`phone`, NULL ),
  (zaudit_last_inserted_id, 'phone_2', OLD.`phone_2`, NULL ),
  (zaudit_last_inserted_id, 'fax', OLD.`fax`, NULL ),
  (zaudit_last_inserted_id, 'title', OLD.`title`, NULL ),
  (zaudit_last_inserted_id, 'charge', OLD.`charge`, NULL ),
  (zaudit_last_inserted_id, 'birthday', OLD.`birthday`, NULL ),
  (zaudit_last_inserted_id, 'last_contact', OLD.`last_contact`, NULL ),
  (zaudit_last_inserted_id, 'last_result', OLD.`last_result`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @contacts_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zcontacts_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zcontacts_AINS` AFTER INSERT ON `contacts` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'contacts', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zcontacts_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zcontacts_AUPD` AFTER UPDATE ON `contacts` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'contacts', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'name' as 'col', OLD.`name` as 'OLD.`name`', NEW.`name` as 'NEW.`name`' WHERE  NOT(NEW.`name` <=>  OLD.`name`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'description' as 'col', OLD.`description` as 'OLD.`description`', NEW.`description` as 'NEW.`description`' WHERE  NOT(NEW.`description` <=>  OLD.`description`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'comments' as 'col', OLD.`comments` as 'OLD.`comments`', NEW.`comments` as 'NEW.`comments`' WHERE  NOT(NEW.`comments` <=>  OLD.`comments`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'archived' as 'col', OLD.`archived` as 'OLD.`archived`', NEW.`archived` as 'NEW.`archived`' WHERE  NOT(NEW.`archived` <=>  OLD.`archived`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'email' as 'col', OLD.`email` as 'OLD.`email`', NEW.`email` as 'NEW.`email`' WHERE  NOT(NEW.`email` <=>  OLD.`email`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'phone' as 'col', OLD.`phone` as 'OLD.`phone`', NEW.`phone` as 'NEW.`phone`' WHERE  NOT(NEW.`phone` <=>  OLD.`phone`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'phone_2' as 'col', OLD.`phone_2` as 'OLD.`phone_2`', NEW.`phone_2` as 'NEW.`phone_2`' WHERE  NOT(NEW.`phone_2` <=>  OLD.`phone_2`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'fax' as 'col', OLD.`fax` as 'OLD.`fax`', NEW.`fax` as 'NEW.`fax`' WHERE  NOT(NEW.`fax` <=>  OLD.`fax`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'title' as 'col', OLD.`title` as 'OLD.`title`', NEW.`title` as 'NEW.`title`' WHERE  NOT(NEW.`title` <=>  OLD.`title`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'charge' as 'col', OLD.`charge` as 'OLD.`charge`', NEW.`charge` as 'NEW.`charge`' WHERE  NOT(NEW.`charge` <=>  OLD.`charge`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'birthday' as 'col', OLD.`birthday` as 'OLD.`birthday`', NEW.`birthday` as 'NEW.`birthday`' WHERE  NOT(NEW.`birthday` <=>  OLD.`birthday`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'last_contact' as 'col', OLD.`last_contact` as 'OLD.`last_contact`', NEW.`last_contact` as 'NEW.`last_contact`' WHERE  NOT(NEW.`last_contact` <=>  OLD.`last_contact`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'last_result' as 'col', OLD.`last_result` as 'OLD.`last_result`', NEW.`last_result` as 'NEW.`last_result`' WHERE  NOT(NEW.`last_result` <=>  OLD.`last_result`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zcounter_series_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zcounter_series_ADEL` AFTER DELETE ON `counter_series` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @counter_series_delete , USER() ), 'counter_series', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'type_document_id', OLD.`type_document_id`, NULL ),
  (zaudit_last_inserted_id, 'serie', OLD.`serie`, NULL ),
  (zaudit_last_inserted_id, 'counter', OLD.`counter`, NULL ),
  (zaudit_last_inserted_id, 'organization_id', OLD.`organization_id`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @counter_series_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zcounter_series_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zcounter_series_AINS` AFTER INSERT ON `counter_series` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'counter_series', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zcounter_series_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zcounter_series_AUPD` AFTER UPDATE ON `counter_series` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'counter_series', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'type_document_id' as 'col', OLD.`type_document_id` as 'OLD.`type_document_id`', NEW.`type_document_id` as 'NEW.`type_document_id`' WHERE  NOT(NEW.`type_document_id` <=>  OLD.`type_document_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'serie' as 'col', OLD.`serie` as 'OLD.`serie`', NEW.`serie` as 'NEW.`serie`' WHERE  NOT(NEW.`serie` <=>  OLD.`serie`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'counter' as 'col', OLD.`counter` as 'OLD.`counter`', NEW.`counter` as 'NEW.`counter`' WHERE  NOT(NEW.`counter` <=>  OLD.`counter`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'organization_id' as 'col', OLD.`organization_id` as 'OLD.`organization_id`', NEW.`organization_id` as 'NEW.`organization_id`' WHERE  NOT(NEW.`organization_id` <=>  OLD.`organization_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zcountries_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zcountries_ADEL` AFTER DELETE ON `countries` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @countries_delete , USER() ), 'countries', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'iso', OLD.`iso`, NULL ),
  (zaudit_last_inserted_id, 'country', OLD.`country`, NULL ),
  (zaudit_last_inserted_id, 'archived', OLD.`archived`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @countries_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zcountries_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zcountries_AINS` AFTER INSERT ON `countries` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'countries', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zcountries_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zcountries_AUPD` AFTER UPDATE ON `countries` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'countries', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'iso' as 'col', OLD.`iso` as 'OLD.`iso`', NEW.`iso` as 'NEW.`iso`' WHERE  NOT(NEW.`iso` <=>  OLD.`iso`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'country' as 'col', OLD.`country` as 'OLD.`country`', NEW.`country` as 'NEW.`country`' WHERE  NOT(NEW.`country` <=>  OLD.`country`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'archived' as 'col', OLD.`archived` as 'OLD.`archived`', NEW.`archived` as 'NEW.`archived`' WHERE  NOT(NEW.`archived` <=>  OLD.`archived`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zcurrencies_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zcurrencies_ADEL` AFTER DELETE ON `currencies` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @currencies_delete , USER() ), 'currencies', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'isocode', OLD.`isocode`, NULL ),
  (zaudit_last_inserted_id, 'language', OLD.`language`, NULL ),
  (zaudit_last_inserted_id, 'name', OLD.`name`, NULL ),
  (zaudit_last_inserted_id, 'money', OLD.`money`, NULL ),
  (zaudit_last_inserted_id, 'symbol', OLD.`symbol`, NULL ),
  (zaudit_last_inserted_id, 'archived', OLD.`archived`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @currencies_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zcurrencies_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zcurrencies_AINS` AFTER INSERT ON `currencies` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'currencies', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zcurrencies_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zcurrencies_AUPD` AFTER UPDATE ON `currencies` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'currencies', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'isocode' as 'col', OLD.`isocode` as 'OLD.`isocode`', NEW.`isocode` as 'NEW.`isocode`' WHERE  NOT(NEW.`isocode` <=>  OLD.`isocode`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'language' as 'col', OLD.`language` as 'OLD.`language`', NEW.`language` as 'NEW.`language`' WHERE  NOT(NEW.`language` <=>  OLD.`language`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'name' as 'col', OLD.`name` as 'OLD.`name`', NEW.`name` as 'NEW.`name`' WHERE  NOT(NEW.`name` <=>  OLD.`name`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'money' as 'col', OLD.`money` as 'OLD.`money`', NEW.`money` as 'NEW.`money`' WHERE  NOT(NEW.`money` <=>  OLD.`money`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'symbol' as 'col', OLD.`symbol` as 'OLD.`symbol`', NEW.`symbol` as 'NEW.`symbol`' WHERE  NOT(NEW.`symbol` <=>  OLD.`symbol`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'archived' as 'col', OLD.`archived` as 'OLD.`archived`', NEW.`archived` as 'NEW.`archived`' WHERE  NOT(NEW.`archived` <=>  OLD.`archived`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zimports_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zimports_ADEL` AFTER DELETE ON `imports` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @imports_delete , USER() ), 'imports', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'date', OLD.`date`, NULL ),
  (zaudit_last_inserted_id, 'register', OLD.`register`, NULL ),
  (zaudit_last_inserted_id, 'table_id', OLD.`table_id`, NULL ),
  (zaudit_last_inserted_id, 'aprove', OLD.`aprove`, NULL ),
  (zaudit_last_inserted_id, 'active', OLD.`active`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @imports_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zimports_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zimports_AINS` AFTER INSERT ON `imports` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'imports', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zimports_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zimports_AUPD` AFTER UPDATE ON `imports` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'imports', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'date' as 'col', OLD.`date` as 'OLD.`date`', NEW.`date` as 'NEW.`date`' WHERE  NOT(NEW.`date` <=>  OLD.`date`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'register' as 'col', OLD.`register` as 'OLD.`register`', NEW.`register` as 'NEW.`register`' WHERE  NOT(NEW.`register` <=>  OLD.`register`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'table_id' as 'col', OLD.`table_id` as 'OLD.`table_id`', NEW.`table_id` as 'NEW.`table_id`' WHERE  NOT(NEW.`table_id` <=>  OLD.`table_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'aprove' as 'col', OLD.`aprove` as 'OLD.`aprove`', NEW.`aprove` as 'NEW.`aprove`' WHERE  NOT(NEW.`aprove` <=>  OLD.`aprove`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'active' as 'col', OLD.`active` as 'OLD.`active`', NEW.`active` as 'NEW.`active`' WHERE  NOT(NEW.`active` <=>  OLD.`active`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zlanguages_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zlanguages_ADEL` AFTER DELETE ON `languages` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @languages_delete , USER() ), 'languages', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'languagescol', OLD.`languagescol`, NULL ),
  (zaudit_last_inserted_id, 'iso', OLD.`iso`, NULL ),
  (zaudit_last_inserted_id, 'archived', OLD.`archived`, NULL ),
  (zaudit_last_inserted_id, 'date_format', OLD.`date_format`, NULL ),
  (zaudit_last_inserted_id, 'datetime_format', OLD.`datetime_format`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'description', OLD.`description`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @languages_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zlanguages_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zlanguages_AINS` AFTER INSERT ON `languages` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'languages', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zlanguages_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zlanguages_AUPD` AFTER UPDATE ON `languages` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'languages', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'languagescol' as 'col', OLD.`languagescol` as 'OLD.`languagescol`', NEW.`languagescol` as 'NEW.`languagescol`' WHERE  NOT(NEW.`languagescol` <=>  OLD.`languagescol`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'iso' as 'col', OLD.`iso` as 'OLD.`iso`', NEW.`iso` as 'NEW.`iso`' WHERE  NOT(NEW.`iso` <=>  OLD.`iso`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'archived' as 'col', OLD.`archived` as 'OLD.`archived`', NEW.`archived` as 'NEW.`archived`' WHERE  NOT(NEW.`archived` <=>  OLD.`archived`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'date_format' as 'col', OLD.`date_format` as 'OLD.`date_format`', NEW.`date_format` as 'NEW.`date_format`' WHERE  NOT(NEW.`date_format` <=>  OLD.`date_format`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'datetime_format' as 'col', OLD.`datetime_format` as 'OLD.`datetime_format`', NEW.`datetime_format` as 'NEW.`datetime_format`' WHERE  NOT(NEW.`datetime_format` <=>  OLD.`datetime_format`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'description' as 'col', OLD.`description` as 'OLD.`description`', NEW.`description` as 'NEW.`description`' WHERE  NOT(NEW.`description` <=>  OLD.`description`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zlocations_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zlocations_ADEL` AFTER DELETE ON `locations` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @locations_delete , USER() ), 'locations', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'archived', OLD.`archived`, NULL ),
  (zaudit_last_inserted_id, 'address_1', OLD.`address_1`, NULL ),
  (zaudit_last_inserted_id, 'city_id', OLD.`city_id`, NULL ),
  (zaudit_last_inserted_id, 'postal', OLD.`postal`, NULL ),
  (zaudit_last_inserted_id, 'state_id', OLD.`state_id`, NULL ),
  (zaudit_last_inserted_id, 'country_id', OLD.`country_id`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @locations_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zlocations_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zlocations_AINS` AFTER INSERT ON `locations` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'locations', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zlocations_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zlocations_AUPD` AFTER UPDATE ON `locations` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'locations', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'archived' as 'col', OLD.`archived` as 'OLD.`archived`', NEW.`archived` as 'NEW.`archived`' WHERE  NOT(NEW.`archived` <=>  OLD.`archived`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'address_1' as 'col', OLD.`address_1` as 'OLD.`address_1`', NEW.`address_1` as 'NEW.`address_1`' WHERE  NOT(NEW.`address_1` <=>  OLD.`address_1`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'city_id' as 'col', OLD.`city_id` as 'OLD.`city_id`', NEW.`city_id` as 'NEW.`city_id`' WHERE  NOT(NEW.`city_id` <=>  OLD.`city_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'postal' as 'col', OLD.`postal` as 'OLD.`postal`', NEW.`postal` as 'NEW.`postal`' WHERE  NOT(NEW.`postal` <=>  OLD.`postal`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'state_id' as 'col', OLD.`state_id` as 'OLD.`state_id`', NEW.`state_id` as 'NEW.`state_id`' WHERE  NOT(NEW.`state_id` <=>  OLD.`state_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'country_id' as 'col', OLD.`country_id` as 'OLD.`country_id`', NEW.`country_id` as 'NEW.`country_id`' WHERE  NOT(NEW.`country_id` <=>  OLD.`country_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zmanufacturers_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zmanufacturers_ADEL` AFTER DELETE ON `manufacturers` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @manufacturers_delete , USER() ), 'manufacturers', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'name', OLD.`name`, NULL ),
  (zaudit_last_inserted_id, 'archived', OLD.`archived`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @manufacturers_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zmanufacturers_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zmanufacturers_AINS` AFTER INSERT ON `manufacturers` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'manufacturers', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zmanufacturers_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zmanufacturers_AUPD` AFTER UPDATE ON `manufacturers` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'manufacturers', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'name' as 'col', OLD.`name` as 'OLD.`name`', NEW.`name` as 'NEW.`name`' WHERE  NOT(NEW.`name` <=>  OLD.`name`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'archived' as 'col', OLD.`archived` as 'OLD.`archived`', NEW.`archived` as 'NEW.`archived`' WHERE  NOT(NEW.`archived` <=>  OLD.`archived`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zorganizations_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zorganizations_ADEL` AFTER DELETE ON `organizations` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @organizations_delete , USER() ), 'organizations', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'name', OLD.`name`, NULL ),
  (zaudit_last_inserted_id, 'reference_no', OLD.`reference_no`, NULL ),
  (zaudit_last_inserted_id, 'description', OLD.`description`, NULL ),
  (zaudit_last_inserted_id, 'archived', OLD.`archived`, NULL ),
  (zaudit_last_inserted_id, 'location_id', OLD.`location_id`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @organizations_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zorganizations_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zorganizations_AINS` AFTER INSERT ON `organizations` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'organizations', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zorganizations_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zorganizations_AUPD` AFTER UPDATE ON `organizations` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'organizations', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'name' as 'col', OLD.`name` as 'OLD.`name`', NEW.`name` as 'NEW.`name`' WHERE  NOT(NEW.`name` <=>  OLD.`name`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'reference_no' as 'col', OLD.`reference_no` as 'OLD.`reference_no`', NEW.`reference_no` as 'NEW.`reference_no`' WHERE  NOT(NEW.`reference_no` <=>  OLD.`reference_no`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'description' as 'col', OLD.`description` as 'OLD.`description`', NEW.`description` as 'NEW.`description`' WHERE  NOT(NEW.`description` <=>  OLD.`description`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'archived' as 'col', OLD.`archived` as 'OLD.`archived`', NEW.`archived` as 'NEW.`archived`' WHERE  NOT(NEW.`archived` <=>  OLD.`archived`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'location_id' as 'col', OLD.`location_id` as 'OLD.`location_id`', NEW.`location_id` as 'NEW.`location_id`' WHERE  NOT(NEW.`location_id` <=>  OLD.`location_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zpayment_terms_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zpayment_terms_ADEL` AFTER DELETE ON `payment_terms` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @payment_terms_delete , USER() ), 'payment_terms', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'name', OLD.`name`, NULL ),
  (zaudit_last_inserted_id, 'notes', OLD.`notes`, NULL ),
  (zaudit_last_inserted_id, 'archived', OLD.`archived`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @payment_terms_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zpayment_terms_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zpayment_terms_AINS` AFTER INSERT ON `payment_terms` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'payment_terms', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zpayment_terms_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zpayment_terms_AUPD` AFTER UPDATE ON `payment_terms` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'payment_terms', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'name' as 'col', OLD.`name` as 'OLD.`name`', NEW.`name` as 'NEW.`name`' WHERE  NOT(NEW.`name` <=>  OLD.`name`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'notes' as 'col', OLD.`notes` as 'OLD.`notes`', NEW.`notes` as 'NEW.`notes`' WHERE  NOT(NEW.`notes` <=>  OLD.`notes`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'archived' as 'col', OLD.`archived` as 'OLD.`archived`', NEW.`archived` as 'NEW.`archived`' WHERE  NOT(NEW.`archived` <=>  OLD.`archived`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zprices_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zprices_ADEL` AFTER DELETE ON `prices` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @prices_delete , USER() ), 'prices', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'price_list_id', OLD.`price_list_id`, NULL ),
  (zaudit_last_inserted_id, 'product_detail_id', OLD.`product_detail_id`, NULL ),
  (zaudit_last_inserted_id, 'grossprice', OLD.`grossprice`, NULL ),
  (zaudit_last_inserted_id, 'discount', OLD.`discount`, NULL ),
  (zaudit_last_inserted_id, 'discount_calc', OLD.`discount_calc`, NULL ),
  (zaudit_last_inserted_id, 'netprice', OLD.`netprice`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @prices_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zprices_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zprices_AINS` AFTER INSERT ON `prices` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'prices', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zprices_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zprices_AUPD` AFTER UPDATE ON `prices` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'prices', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'price_list_id' as 'col', OLD.`price_list_id` as 'OLD.`price_list_id`', NEW.`price_list_id` as 'NEW.`price_list_id`' WHERE  NOT(NEW.`price_list_id` <=>  OLD.`price_list_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'product_detail_id' as 'col', OLD.`product_detail_id` as 'OLD.`product_detail_id`', NEW.`product_detail_id` as 'NEW.`product_detail_id`' WHERE  NOT(NEW.`product_detail_id` <=>  OLD.`product_detail_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'grossprice' as 'col', OLD.`grossprice` as 'OLD.`grossprice`', NEW.`grossprice` as 'NEW.`grossprice`' WHERE  NOT(NEW.`grossprice` <=>  OLD.`grossprice`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'discount' as 'col', OLD.`discount` as 'OLD.`discount`', NEW.`discount` as 'NEW.`discount`' WHERE  NOT(NEW.`discount` <=>  OLD.`discount`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'discount_calc' as 'col', OLD.`discount_calc` as 'OLD.`discount_calc`', NEW.`discount_calc` as 'NEW.`discount_calc`' WHERE  NOT(NEW.`discount_calc` <=>  OLD.`discount_calc`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'netprice' as 'col', OLD.`netprice` as 'OLD.`netprice`', NEW.`netprice` as 'NEW.`netprice`' WHERE  NOT(NEW.`netprice` <=>  OLD.`netprice`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zprice_lists_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zprice_lists_ADEL` AFTER DELETE ON `price_lists` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @price_lists_delete , USER() ), 'price_lists', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'reference', OLD.`reference`, NULL ),
  (zaudit_last_inserted_id, 'name', OLD.`name`, NULL ),
  (zaudit_last_inserted_id, 'valid_from', OLD.`valid_from`, NULL ),
  (zaudit_last_inserted_id, 'valid_until', OLD.`valid_until`, NULL ),
  (zaudit_last_inserted_id, 'tax_include', OLD.`tax_include`, NULL ),
  (zaudit_last_inserted_id, 'tax_id', OLD.`tax_id`, NULL ),
  (zaudit_last_inserted_id, 'currency_id', OLD.`currency_id`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'alternative', OLD.`alternative`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @price_lists_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zprice_lists_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zprice_lists_AINS` AFTER INSERT ON `price_lists` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'price_lists', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zprice_lists_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zprice_lists_AUPD` AFTER UPDATE ON `price_lists` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'price_lists', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'reference' as 'col', OLD.`reference` as 'OLD.`reference`', NEW.`reference` as 'NEW.`reference`' WHERE  NOT(NEW.`reference` <=>  OLD.`reference`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'name' as 'col', OLD.`name` as 'OLD.`name`', NEW.`name` as 'NEW.`name`' WHERE  NOT(NEW.`name` <=>  OLD.`name`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'valid_from' as 'col', OLD.`valid_from` as 'OLD.`valid_from`', NEW.`valid_from` as 'NEW.`valid_from`' WHERE  NOT(NEW.`valid_from` <=>  OLD.`valid_from`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'valid_until' as 'col', OLD.`valid_until` as 'OLD.`valid_until`', NEW.`valid_until` as 'NEW.`valid_until`' WHERE  NOT(NEW.`valid_until` <=>  OLD.`valid_until`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'tax_include' as 'col', OLD.`tax_include` as 'OLD.`tax_include`', NEW.`tax_include` as 'NEW.`tax_include`' WHERE  NOT(NEW.`tax_include` <=>  OLD.`tax_include`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'tax_id' as 'col', OLD.`tax_id` as 'OLD.`tax_id`', NEW.`tax_id` as 'NEW.`tax_id`' WHERE  NOT(NEW.`tax_id` <=>  OLD.`tax_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'currency_id' as 'col', OLD.`currency_id` as 'OLD.`currency_id`', NEW.`currency_id` as 'NEW.`currency_id`' WHERE  NOT(NEW.`currency_id` <=>  OLD.`currency_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'alternative' as 'col', OLD.`alternative` as 'OLD.`alternative`', NEW.`alternative` as 'NEW.`alternative`' WHERE  NOT(NEW.`alternative` <=>  OLD.`alternative`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zproducts_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zproducts_ADEL` AFTER DELETE ON `products` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @products_delete , USER() ), 'products', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'reference', OLD.`reference`, NULL ),
  (zaudit_last_inserted_id, 'name', OLD.`name`, NULL ),
  (zaudit_last_inserted_id, 'description', OLD.`description`, NULL ),
  (zaudit_last_inserted_id, 'type', OLD.`type`, NULL ),
  (zaudit_last_inserted_id, 'is_salable', OLD.`is_salable`, NULL ),
  (zaudit_last_inserted_id, 'is_purchasable', OLD.`is_purchasable`, NULL ),
  (zaudit_last_inserted_id, 'unit_id', OLD.`unit_id`, NULL ),
  (zaudit_last_inserted_id, 'category_id', OLD.`category_id`, NULL ),
  (zaudit_last_inserted_id, 'manufacture_id', OLD.`manufacture_id`, NULL ),
  (zaudit_last_inserted_id, 'tax_id', OLD.`tax_id`, NULL ),
  (zaudit_last_inserted_id, 'archived', OLD.`archived`, NULL ),
  (zaudit_last_inserted_id, 'is_combination', OLD.`is_combination`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @products_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zproducts_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zproducts_AINS` AFTER INSERT ON `products` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'products', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zproducts_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zproducts_AUPD` AFTER UPDATE ON `products` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'products', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'reference' as 'col', OLD.`reference` as 'OLD.`reference`', NEW.`reference` as 'NEW.`reference`' WHERE  NOT(NEW.`reference` <=>  OLD.`reference`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'name' as 'col', OLD.`name` as 'OLD.`name`', NEW.`name` as 'NEW.`name`' WHERE  NOT(NEW.`name` <=>  OLD.`name`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'description' as 'col', OLD.`description` as 'OLD.`description`', NEW.`description` as 'NEW.`description`' WHERE  NOT(NEW.`description` <=>  OLD.`description`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'type' as 'col', OLD.`type` as 'OLD.`type`', NEW.`type` as 'NEW.`type`' WHERE  NOT(NEW.`type` <=>  OLD.`type`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'is_salable' as 'col', OLD.`is_salable` as 'OLD.`is_salable`', NEW.`is_salable` as 'NEW.`is_salable`' WHERE  NOT(NEW.`is_salable` <=>  OLD.`is_salable`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'is_purchasable' as 'col', OLD.`is_purchasable` as 'OLD.`is_purchasable`', NEW.`is_purchasable` as 'NEW.`is_purchasable`' WHERE  NOT(NEW.`is_purchasable` <=>  OLD.`is_purchasable`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'unit_id' as 'col', OLD.`unit_id` as 'OLD.`unit_id`', NEW.`unit_id` as 'NEW.`unit_id`' WHERE  NOT(NEW.`unit_id` <=>  OLD.`unit_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'category_id' as 'col', OLD.`category_id` as 'OLD.`category_id`', NEW.`category_id` as 'NEW.`category_id`' WHERE  NOT(NEW.`category_id` <=>  OLD.`category_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'manufacture_id' as 'col', OLD.`manufacture_id` as 'OLD.`manufacture_id`', NEW.`manufacture_id` as 'NEW.`manufacture_id`' WHERE  NOT(NEW.`manufacture_id` <=>  OLD.`manufacture_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'tax_id' as 'col', OLD.`tax_id` as 'OLD.`tax_id`', NEW.`tax_id` as 'NEW.`tax_id`' WHERE  NOT(NEW.`tax_id` <=>  OLD.`tax_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'archived' as 'col', OLD.`archived` as 'OLD.`archived`', NEW.`archived` as 'NEW.`archived`' WHERE  NOT(NEW.`archived` <=>  OLD.`archived`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'is_combination' as 'col', OLD.`is_combination` as 'OLD.`is_combination`', NEW.`is_combination` as 'NEW.`is_combination`' WHERE  NOT(NEW.`is_combination` <=>  OLD.`is_combination`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zproduct_details_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zproduct_details_ADEL` AFTER DELETE ON `product_details` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @product_details_delete , USER() ), 'product_details', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'reference', OLD.`reference`, NULL ),
  (zaudit_last_inserted_id, 'name', OLD.`name`, NULL ),
  (zaudit_last_inserted_id, 'product_id', OLD.`product_id`, NULL ),
  (zaudit_last_inserted_id, 'sku', OLD.`sku`, NULL ),
  (zaudit_last_inserted_id, 'ean13', OLD.`ean13`, NULL ),
  (zaudit_last_inserted_id, 'upc', OLD.`upc`, NULL ),
  (zaudit_last_inserted_id, 'cost', OLD.`cost`, NULL ),
  (zaudit_last_inserted_id, 'sale_price', OLD.`sale_price`, NULL ),
  (zaudit_last_inserted_id, 'condition_id', OLD.`condition_id`, NULL ),
  (zaudit_last_inserted_id, 'price_list_id', OLD.`price_list_id`, NULL ),
  (zaudit_last_inserted_id, 'image', OLD.`image`, NULL ),
  (zaudit_last_inserted_id, 'archived', OLD.`archived`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @product_details_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zproduct_details_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zproduct_details_AINS` AFTER INSERT ON `product_details` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'product_details', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zproduct_details_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zproduct_details_AUPD` AFTER UPDATE ON `product_details` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'product_details', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'reference' as 'col', OLD.`reference` as 'OLD.`reference`', NEW.`reference` as 'NEW.`reference`' WHERE  NOT(NEW.`reference` <=>  OLD.`reference`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'name' as 'col', OLD.`name` as 'OLD.`name`', NEW.`name` as 'NEW.`name`' WHERE  NOT(NEW.`name` <=>  OLD.`name`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'product_id' as 'col', OLD.`product_id` as 'OLD.`product_id`', NEW.`product_id` as 'NEW.`product_id`' WHERE  NOT(NEW.`product_id` <=>  OLD.`product_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'sku' as 'col', OLD.`sku` as 'OLD.`sku`', NEW.`sku` as 'NEW.`sku`' WHERE  NOT(NEW.`sku` <=>  OLD.`sku`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'ean13' as 'col', OLD.`ean13` as 'OLD.`ean13`', NEW.`ean13` as 'NEW.`ean13`' WHERE  NOT(NEW.`ean13` <=>  OLD.`ean13`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'upc' as 'col', OLD.`upc` as 'OLD.`upc`', NEW.`upc` as 'NEW.`upc`' WHERE  NOT(NEW.`upc` <=>  OLD.`upc`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'cost' as 'col', OLD.`cost` as 'OLD.`cost`', NEW.`cost` as 'NEW.`cost`' WHERE  NOT(NEW.`cost` <=>  OLD.`cost`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'sale_price' as 'col', OLD.`sale_price` as 'OLD.`sale_price`', NEW.`sale_price` as 'NEW.`sale_price`' WHERE  NOT(NEW.`sale_price` <=>  OLD.`sale_price`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'condition_id' as 'col', OLD.`condition_id` as 'OLD.`condition_id`', NEW.`condition_id` as 'NEW.`condition_id`' WHERE  NOT(NEW.`condition_id` <=>  OLD.`condition_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'price_list_id' as 'col', OLD.`price_list_id` as 'OLD.`price_list_id`', NEW.`price_list_id` as 'NEW.`price_list_id`' WHERE  NOT(NEW.`price_list_id` <=>  OLD.`price_list_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'image' as 'col', OLD.`image` as 'OLD.`image`', NEW.`image` as 'NEW.`image`' WHERE  NOT(NEW.`image` <=>  OLD.`image`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'archived' as 'col', OLD.`archived` as 'OLD.`archived`', NEW.`archived` as 'NEW.`archived`' WHERE  NOT(NEW.`archived` <=>  OLD.`archived`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zreports_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zreports_ADEL` AFTER DELETE ON `reports` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @reports_delete , USER() ), 'reports', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'name', OLD.`name`, NULL ),
  (zaudit_last_inserted_id, 'description', OLD.`description`, NULL ),
  (zaudit_last_inserted_id, 'table_id', OLD.`table_id`, NULL ),
  (zaudit_last_inserted_id, 'header_id', OLD.`header_id`, NULL ),
  (zaudit_last_inserted_id, 'body_id', OLD.`body_id`, NULL ),
  (zaudit_last_inserted_id, 'footer_id', OLD.`footer_id`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL );
 set @reports_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zreports_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zreports_AINS` AFTER INSERT ON `reports` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'reports', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zreports_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zreports_AUPD` AFTER UPDATE ON `reports` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'reports', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'name' as 'col', OLD.`name` as 'OLD.`name`', NEW.`name` as 'NEW.`name`' WHERE  NOT(NEW.`name` <=>  OLD.`name`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'description' as 'col', OLD.`description` as 'OLD.`description`', NEW.`description` as 'NEW.`description`' WHERE  NOT(NEW.`description` <=>  OLD.`description`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'table_id' as 'col', OLD.`table_id` as 'OLD.`table_id`', NEW.`table_id` as 'NEW.`table_id`' WHERE  NOT(NEW.`table_id` <=>  OLD.`table_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'header_id' as 'col', OLD.`header_id` as 'OLD.`header_id`', NEW.`header_id` as 'NEW.`header_id`' WHERE  NOT(NEW.`header_id` <=>  OLD.`header_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'body_id' as 'col', OLD.`body_id` as 'OLD.`body_id`', NEW.`body_id` as 'NEW.`body_id`' WHERE  NOT(NEW.`body_id` <=>  OLD.`body_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'footer_id' as 'col', OLD.`footer_id` as 'OLD.`footer_id`', NEW.`footer_id` as 'NEW.`footer_id`' WHERE  NOT(NEW.`footer_id` <=>  OLD.`footer_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zrols_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zrols_ADEL` AFTER DELETE ON `rols` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @rols_delete , USER() ), 'rols', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'name', OLD.`name`, NULL ),
  (zaudit_last_inserted_id, 'description', OLD.`description`, NULL ),
  (zaudit_last_inserted_id, 'all_access_column', OLD.`all_access_column`, NULL ),
  (zaudit_last_inserted_id, 'all_access_organization', OLD.`all_access_organization`, NULL ),
  (zaudit_last_inserted_id, 'archived', OLD.`archived`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @rols_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zrols_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zrols_AINS` AFTER INSERT ON `rols` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'rols', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zrols_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zrols_AUPD` AFTER UPDATE ON `rols` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'rols', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'name' as 'col', OLD.`name` as 'OLD.`name`', NEW.`name` as 'NEW.`name`' WHERE  NOT(NEW.`name` <=>  OLD.`name`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'description' as 'col', OLD.`description` as 'OLD.`description`', NEW.`description` as 'NEW.`description`' WHERE  NOT(NEW.`description` <=>  OLD.`description`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'all_access_column' as 'col', OLD.`all_access_column` as 'OLD.`all_access_column`', NEW.`all_access_column` as 'NEW.`all_access_column`' WHERE  NOT(NEW.`all_access_column` <=>  OLD.`all_access_column`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'all_access_organization' as 'col', OLD.`all_access_organization` as 'OLD.`all_access_organization`', NEW.`all_access_organization` as 'NEW.`all_access_organization`' WHERE  NOT(NEW.`all_access_organization` <=>  OLD.`all_access_organization`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'archived' as 'col', OLD.`archived` as 'OLD.`archived`', NEW.`archived` as 'NEW.`archived`' WHERE  NOT(NEW.`archived` <=>  OLD.`archived`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zsettings_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zsettings_ADEL` AFTER DELETE ON `settings` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @settings_delete , USER() ), 'settings', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'user_id', OLD.`user_id`, NULL ),
  (zaudit_last_inserted_id, 'country_id', OLD.`country_id`, NULL ),
  (zaudit_last_inserted_id, 'state_id', OLD.`state_id`, NULL ),
  (zaudit_last_inserted_id, 'city_id', OLD.`city_id`, NULL ),
  (zaudit_last_inserted_id, 'language_id', OLD.`language_id`, NULL ),
  (zaudit_last_inserted_id, 'default', OLD.`default`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @settings_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zsettings_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zsettings_AINS` AFTER INSERT ON `settings` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'settings', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zsettings_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zsettings_AUPD` AFTER UPDATE ON `settings` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'settings', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'user_id' as 'col', OLD.`user_id` as 'OLD.`user_id`', NEW.`user_id` as 'NEW.`user_id`' WHERE  NOT(NEW.`user_id` <=>  OLD.`user_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'country_id' as 'col', OLD.`country_id` as 'OLD.`country_id`', NEW.`country_id` as 'NEW.`country_id`' WHERE  NOT(NEW.`country_id` <=>  OLD.`country_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'state_id' as 'col', OLD.`state_id` as 'OLD.`state_id`', NEW.`state_id` as 'NEW.`state_id`' WHERE  NOT(NEW.`state_id` <=>  OLD.`state_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'city_id' as 'col', OLD.`city_id` as 'OLD.`city_id`', NEW.`city_id` as 'NEW.`city_id`' WHERE  NOT(NEW.`city_id` <=>  OLD.`city_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'language_id' as 'col', OLD.`language_id` as 'OLD.`language_id`', NEW.`language_id` as 'NEW.`language_id`' WHERE  NOT(NEW.`language_id` <=>  OLD.`language_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'default' as 'col', OLD.`default` as 'OLD.`default`', NEW.`default` as 'NEW.`default`' WHERE  NOT(NEW.`default` <=>  OLD.`default`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zstates_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zstates_ADEL` AFTER DELETE ON `states` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @states_delete , USER() ), 'states', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'country_id', OLD.`country_id`, NULL ),
  (zaudit_last_inserted_id, 'state', OLD.`state`, NULL ),
  (zaudit_last_inserted_id, 'iso', OLD.`iso`, NULL ),
  (zaudit_last_inserted_id, 'archived', OLD.`archived`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @states_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zstates_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zstates_AINS` AFTER INSERT ON `states` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'states', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zstates_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zstates_AUPD` AFTER UPDATE ON `states` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'states', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'country_id' as 'col', OLD.`country_id` as 'OLD.`country_id`', NEW.`country_id` as 'NEW.`country_id`' WHERE  NOT(NEW.`country_id` <=>  OLD.`country_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'state' as 'col', OLD.`state` as 'OLD.`state`', NEW.`state` as 'NEW.`state`' WHERE  NOT(NEW.`state` <=>  OLD.`state`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'iso' as 'col', OLD.`iso` as 'OLD.`iso`', NEW.`iso` as 'NEW.`iso`' WHERE  NOT(NEW.`iso` <=>  OLD.`iso`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'archived' as 'col', OLD.`archived` as 'OLD.`archived`', NEW.`archived` as 'NEW.`archived`' WHERE  NOT(NEW.`archived` <=>  OLD.`archived`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.ztaxes_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `ztaxes_ADEL` AFTER DELETE ON `taxes` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @taxes_delete , USER() ), 'taxes', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'name', OLD.`name`, NULL ),
  (zaudit_last_inserted_id, 'print_name', OLD.`print_name`, NULL ),
  (zaudit_last_inserted_id, 'validfrom', OLD.`validfrom`, NULL ),
  (zaudit_last_inserted_id, 'rate', OLD.`rate`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'notes', OLD.`notes`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @taxes_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.ztaxes_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `ztaxes_AINS` AFTER INSERT ON `taxes` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'taxes', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.ztaxes_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `ztaxes_AUPD` AFTER UPDATE ON `taxes` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'taxes', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'name' as 'col', OLD.`name` as 'OLD.`name`', NEW.`name` as 'NEW.`name`' WHERE  NOT(NEW.`name` <=>  OLD.`name`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'print_name' as 'col', OLD.`print_name` as 'OLD.`print_name`', NEW.`print_name` as 'NEW.`print_name`' WHERE  NOT(NEW.`print_name` <=>  OLD.`print_name`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'validfrom' as 'col', OLD.`validfrom` as 'OLD.`validfrom`', NEW.`validfrom` as 'NEW.`validfrom`' WHERE  NOT(NEW.`validfrom` <=>  OLD.`validfrom`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'rate' as 'col', OLD.`rate` as 'OLD.`rate`', NEW.`rate` as 'NEW.`rate`' WHERE  NOT(NEW.`rate` <=>  OLD.`rate`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'notes' as 'col', OLD.`notes` as 'OLD.`notes`', NEW.`notes` as 'NEW.`notes`' WHERE  NOT(NEW.`notes` <=>  OLD.`notes`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zterm_types_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zterm_types_ADEL` AFTER DELETE ON `term_types` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @term_types_delete , USER() ), 'term_types', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'payment_terms_id', OLD.`payment_terms_id`, NULL ),
  (zaudit_last_inserted_id, 'type', OLD.`type`, NULL ),
  (zaudit_last_inserted_id, 'day', OLD.`day`, NULL ),
  (zaudit_last_inserted_id, 'typeid', OLD.`typeid`, NULL ),
  (zaudit_last_inserted_id, 'typeem', OLD.`typeem`, NULL ),
  (zaudit_last_inserted_id, 'typenm', OLD.`typenm`, NULL ),
  (zaudit_last_inserted_id, 'daydxpp', OLD.`daydxpp`, NULL ),
  (zaudit_last_inserted_id, 'percentdxpp', OLD.`percentdxpp`, NULL ),
  (zaudit_last_inserted_id, 'fixed_amount', OLD.`fixed_amount`, NULL ),
  (zaudit_last_inserted_id, 'percentage', OLD.`percentage`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @term_types_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zterm_types_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zterm_types_AINS` AFTER INSERT ON `term_types` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'term_types', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zterm_types_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zterm_types_AUPD` AFTER UPDATE ON `term_types` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'term_types', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'payment_terms_id' as 'col', OLD.`payment_terms_id` as 'OLD.`payment_terms_id`', NEW.`payment_terms_id` as 'NEW.`payment_terms_id`' WHERE  NOT(NEW.`payment_terms_id` <=>  OLD.`payment_terms_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'type' as 'col', OLD.`type` as 'OLD.`type`', NEW.`type` as 'NEW.`type`' WHERE  NOT(NEW.`type` <=>  OLD.`type`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'day' as 'col', OLD.`day` as 'OLD.`day`', NEW.`day` as 'NEW.`day`' WHERE  NOT(NEW.`day` <=>  OLD.`day`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'typeid' as 'col', OLD.`typeid` as 'OLD.`typeid`', NEW.`typeid` as 'NEW.`typeid`' WHERE  NOT(NEW.`typeid` <=>  OLD.`typeid`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'typeem' as 'col', OLD.`typeem` as 'OLD.`typeem`', NEW.`typeem` as 'NEW.`typeem`' WHERE  NOT(NEW.`typeem` <=>  OLD.`typeem`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'typenm' as 'col', OLD.`typenm` as 'OLD.`typenm`', NEW.`typenm` as 'NEW.`typenm`' WHERE  NOT(NEW.`typenm` <=>  OLD.`typenm`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'daydxpp' as 'col', OLD.`daydxpp` as 'OLD.`daydxpp`', NEW.`daydxpp` as 'NEW.`daydxpp`' WHERE  NOT(NEW.`daydxpp` <=>  OLD.`daydxpp`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'percentdxpp' as 'col', OLD.`percentdxpp` as 'OLD.`percentdxpp`', NEW.`percentdxpp` as 'NEW.`percentdxpp`' WHERE  NOT(NEW.`percentdxpp` <=>  OLD.`percentdxpp`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'fixed_amount' as 'col', OLD.`fixed_amount` as 'OLD.`fixed_amount`', NEW.`fixed_amount` as 'NEW.`fixed_amount`' WHERE  NOT(NEW.`fixed_amount` <=>  OLD.`fixed_amount`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'percentage' as 'col', OLD.`percentage` as 'OLD.`percentage`', NEW.`percentage` as 'NEW.`percentage`' WHERE  NOT(NEW.`percentage` <=>  OLD.`percentage`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.ztype_documents_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `ztype_documents_ADEL` AFTER DELETE ON `type_documents` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @type_documents_delete , USER() ), 'type_documents', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'name', OLD.`name`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @type_documents_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.ztype_documents_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `ztype_documents_AINS` AFTER INSERT ON `type_documents` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'type_documents', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.ztype_documents_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `ztype_documents_AUPD` AFTER UPDATE ON `type_documents` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'type_documents', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'name' as 'col', OLD.`name` as 'OLD.`name`', NEW.`name` as 'NEW.`name`' WHERE  NOT(NEW.`name` <=>  OLD.`name`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zunits_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zunits_ADEL` AFTER DELETE ON `units` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @units_delete , USER() ), 'units', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'name', OLD.`name`, NULL ),
  (zaudit_last_inserted_id, 'quantity', OLD.`quantity`, NULL ),
  (zaudit_last_inserted_id, 'archived', OLD.`archived`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @units_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zunits_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zunits_AINS` AFTER INSERT ON `units` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'units', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zunits_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zunits_AUPD` AFTER UPDATE ON `units` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'units', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'name' as 'col', OLD.`name` as 'OLD.`name`', NEW.`name` as 'NEW.`name`' WHERE  NOT(NEW.`name` <=>  OLD.`name`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'quantity' as 'col', OLD.`quantity` as 'OLD.`quantity`', NEW.`quantity` as 'NEW.`quantity`' WHERE  NOT(NEW.`quantity` <=>  OLD.`quantity`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'archived' as 'col', OLD.`archived` as 'OLD.`archived`', NEW.`archived` as 'NEW.`archived`' WHERE  NOT(NEW.`archived` <=>  OLD.`archived`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zusers_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zusers_ADEL` AFTER DELETE ON `users` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @users_delete , USER() ), 'users', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'name', OLD.`name`, NULL ),
  (zaudit_last_inserted_id, 'email', OLD.`email`, NULL ),
  (zaudit_last_inserted_id, 'all_access_organization', OLD.`all_access_organization`, NULL ),
  (zaudit_last_inserted_id, 'all_access_column', OLD.`all_access_column`, NULL ),
  (zaudit_last_inserted_id, 'password', OLD.`password`, NULL ),
  (zaudit_last_inserted_id, 'archived', OLD.`archived`, NULL ),
  (zaudit_last_inserted_id, 'remember_token', OLD.`remember_token`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'contact_id', OLD.`contact_id`, NULL ),
  (zaudit_last_inserted_id, 'image_name', OLD.`image_name`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @users_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zusers_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zusers_AINS` AFTER INSERT ON `users` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'users', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zusers_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zusers_AUPD` AFTER UPDATE ON `users` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'users', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'name' as 'col', OLD.`name` as 'OLD.`name`', NEW.`name` as 'NEW.`name`' WHERE  NOT(NEW.`name` <=>  OLD.`name`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'email' as 'col', OLD.`email` as 'OLD.`email`', NEW.`email` as 'NEW.`email`' WHERE  NOT(NEW.`email` <=>  OLD.`email`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'all_access_organization' as 'col', OLD.`all_access_organization` as 'OLD.`all_access_organization`', NEW.`all_access_organization` as 'NEW.`all_access_organization`' WHERE  NOT(NEW.`all_access_organization` <=>  OLD.`all_access_organization`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'all_access_column' as 'col', OLD.`all_access_column` as 'OLD.`all_access_column`', NEW.`all_access_column` as 'NEW.`all_access_column`' WHERE  NOT(NEW.`all_access_column` <=>  OLD.`all_access_column`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'password' as 'col', OLD.`password` as 'OLD.`password`', NEW.`password` as 'NEW.`password`' WHERE  NOT(NEW.`password` <=>  OLD.`password`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'archived' as 'col', OLD.`archived` as 'OLD.`archived`', NEW.`archived` as 'NEW.`archived`' WHERE  NOT(NEW.`archived` <=>  OLD.`archived`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'remember_token' as 'col', OLD.`remember_token` as 'OLD.`remember_token`', NEW.`remember_token` as 'NEW.`remember_token`' WHERE  NOT(NEW.`remember_token` <=>  OLD.`remember_token`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'contact_id' as 'col', OLD.`contact_id` as 'OLD.`contact_id`', NEW.`contact_id` as 'NEW.`contact_id`' WHERE  NOT(NEW.`contact_id` <=>  OLD.`contact_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'image_name' as 'col', OLD.`image_name` as 'OLD.`image_name`', NEW.`image_name` as 'NEW.`image_name`' WHERE  NOT(NEW.`image_name` <=>  OLD.`image_name`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zwarehouses_ADEL
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zwarehouses_ADEL` AFTER DELETE ON `warehouses` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( @warehouses_delete , USER() ), 'warehouses', OLD.`id`, 'DELETE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
 VALUES   (zaudit_last_inserted_id, 'id', OLD.`id`, NULL ),
  (zaudit_last_inserted_id, 'organization_id', OLD.`organization_id`, NULL ),
  (zaudit_last_inserted_id, 'reference', OLD.`reference`, NULL ),
  (zaudit_last_inserted_id, 'name', OLD.`name`, NULL ),
  (zaudit_last_inserted_id, 'created_at', OLD.`created_at`, NULL ),
  (zaudit_last_inserted_id, 'updated_at', OLD.`updated_at`, NULL ),
  (zaudit_last_inserted_id, 'notes', OLD.`notes`, NULL ),
  (zaudit_last_inserted_id, 'created_by', OLD.`created_by`, NULL ),
  (zaudit_last_inserted_id, 'updated_by', OLD.`updated_by`, NULL );
 set @warehouses_delete = null;   

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zwarehouses_AINS
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zwarehouses_AINS` AFTER INSERT ON `warehouses` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`created_by`, USER() ), 'warehouses', NEW.`id`, 'INSERT'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
VALUES (zaudit_last_inserted_id, 'id', NULL, NEW.`id`);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador banana.zwarehouses_AUPD
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `zwarehouses_AUPD` AFTER UPDATE ON `warehouses` FOR EACH ROW BEGIN
-- --------------------------------------------------------------------
-- MySQL Audit Trigger
-- Copyright (c) 2014 Du T. Dang. MIT License
-- https://github.com/hotmit/mysql-sp-audit
-- --------------------------------------------------------------------

DECLARE zaudit_last_inserted_id BIGINT(20);

INSERT IGNORE INTO `banana`.zaudit (user, table_name, pk1, action)  VALUE ( IFNULL( NEW.`updated_by`, USER() ), 'warehouses', OLD.`id`, 'UPDATE'); 

SET zaudit_last_inserted_id = LAST_INSERT_ID();

INSERT IGNORE INTO `banana`.zaudit_meta (audit_id, col_name, old_value, new_value)  
select * from (   SELECT  zaudit_last_inserted_id as 'LID', 'id' as 'col', OLD.`id` as 'OLD.`id`', NEW.`id` as 'NEW.`id`' WHERE  NOT(NEW.`id` <=>  OLD.`id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'organization_id' as 'col', OLD.`organization_id` as 'OLD.`organization_id`', NEW.`organization_id` as 'NEW.`organization_id`' WHERE  NOT(NEW.`organization_id` <=>  OLD.`organization_id`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'reference' as 'col', OLD.`reference` as 'OLD.`reference`', NEW.`reference` as 'NEW.`reference`' WHERE  NOT(NEW.`reference` <=>  OLD.`reference`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'name' as 'col', OLD.`name` as 'OLD.`name`', NEW.`name` as 'NEW.`name`' WHERE  NOT(NEW.`name` <=>  OLD.`name`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_at' as 'col', OLD.`created_at` as 'OLD.`created_at`', NEW.`created_at` as 'NEW.`created_at`' WHERE  NOT(NEW.`created_at` <=>  OLD.`created_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_at' as 'col', OLD.`updated_at` as 'OLD.`updated_at`', NEW.`updated_at` as 'NEW.`updated_at`' WHERE  NOT(NEW.`updated_at` <=>  OLD.`updated_at`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'notes' as 'col', OLD.`notes` as 'OLD.`notes`', NEW.`notes` as 'NEW.`notes`' WHERE  NOT(NEW.`notes` <=>  OLD.`notes`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'created_by' as 'col', OLD.`created_by` as 'OLD.`created_by`', NEW.`created_by` as 'NEW.`created_by`' WHERE  NOT(NEW.`created_by` <=>  OLD.`created_by`) UNION ALL
 SELECT  zaudit_last_inserted_id as 'LID', 'updated_by' as 'col', OLD.`updated_by` as 'OLD.`updated_by`', NEW.`updated_by` as 'NEW.`updated_by`' WHERE  NOT(NEW.`updated_by` <=>  OLD.`updated_by`) ) tmp ;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para vista banana.zvw_audit_attributes
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_attributes`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_attributes` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'name') then `zm`.`old_value` else NULL end)) AS `name_old`,max((case when (`zm`.`col_name` = 'name') then `zm`.`new_value` else NULL end)) AS `name_new`,max((case when (`zm`.`col_name` = 'type_attribute') then `zm`.`old_value` else NULL end)) AS `type_attribute_old`,max((case when (`zm`.`col_name` = 'type_attribute') then `zm`.`new_value` else NULL end)) AS `type_attribute_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'attributes') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_attributes_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_attributes_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_attributes_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'attributes');

-- Volcando estructura para vista banana.zvw_audit_attribute_details
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_attribute_details`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_attribute_details` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'attribute_id') then `zm`.`old_value` else NULL end)) AS `attribute_id_old`,max((case when (`zm`.`col_name` = 'attribute_id') then `zm`.`new_value` else NULL end)) AS `attribute_id_new`,max((case when (`zm`.`col_name` = 'reference') then `zm`.`old_value` else NULL end)) AS `reference_old`,max((case when (`zm`.`col_name` = 'reference') then `zm`.`new_value` else NULL end)) AS `reference_new`,max((case when (`zm`.`col_name` = 'name') then `zm`.`old_value` else NULL end)) AS `name_old`,max((case when (`zm`.`col_name` = 'name') then `zm`.`new_value` else NULL end)) AS `name_new`,max((case when (`zm`.`col_name` = 'color') then `zm`.`old_value` else NULL end)) AS `color_old`,max((case when (`zm`.`col_name` = 'color') then `zm`.`new_value` else NULL end)) AS `color_new`,max((case when (`zm`.`col_name` = 'position') then `zm`.`old_value` else NULL end)) AS `position_old`,max((case when (`zm`.`col_name` = 'position') then `zm`.`new_value` else NULL end)) AS `position_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'attribute_details') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_attribute_details_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_attribute_details_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_attribute_details_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'attribute_details');

-- Volcando estructura para vista banana.zvw_audit_bpartners
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_bpartners`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_bpartners` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'logo') then `zm`.`old_value` else NULL end)) AS `logo_old`,max((case when (`zm`.`col_name` = 'logo') then `zm`.`new_value` else NULL end)) AS `logo_new`,max((case when (`zm`.`col_name` = 'cif') then `zm`.`old_value` else NULL end)) AS `cif_old`,max((case when (`zm`.`col_name` = 'cif') then `zm`.`new_value` else NULL end)) AS `cif_new`,max((case when (`zm`.`col_name` = 'is_customer') then `zm`.`old_value` else NULL end)) AS `is_customer_old`,max((case when (`zm`.`col_name` = 'is_customer') then `zm`.`new_value` else NULL end)) AS `is_customer_new`,max((case when (`zm`.`col_name` = 'is_vendor') then `zm`.`old_value` else NULL end)) AS `is_vendor_old`,max((case when (`zm`.`col_name` = 'is_vendor') then `zm`.`new_value` else NULL end)) AS `is_vendor_new`,max((case when (`zm`.`col_name` = 'alias') then `zm`.`old_value` else NULL end)) AS `alias_old`,max((case when (`zm`.`col_name` = 'alias') then `zm`.`new_value` else NULL end)) AS `alias_new`,max((case when (`zm`.`col_name` = 'email') then `zm`.`old_value` else NULL end)) AS `email_old`,max((case when (`zm`.`col_name` = 'email') then `zm`.`new_value` else NULL end)) AS `email_new`,max((case when (`zm`.`col_name` = 'name') then `zm`.`old_value` else NULL end)) AS `name_old`,max((case when (`zm`.`col_name` = 'name') then `zm`.`new_value` else NULL end)) AS `name_new`,max((case when (`zm`.`col_name` = 'name_2') then `zm`.`old_value` else NULL end)) AS `name_2_old`,max((case when (`zm`.`col_name` = 'name_2') then `zm`.`new_value` else NULL end)) AS `name_2_new`,max((case when (`zm`.`col_name` = 'is_employee') then `zm`.`old_value` else NULL end)) AS `is_employee_old`,max((case when (`zm`.`col_name` = 'is_employee') then `zm`.`new_value` else NULL end)) AS `is_employee_new`,max((case when (`zm`.`col_name` = 'is_prospect') then `zm`.`old_value` else NULL end)) AS `is_prospect_old`,max((case when (`zm`.`col_name` = 'is_prospect') then `zm`.`new_value` else NULL end)) AS `is_prospect_new`,max((case when (`zm`.`col_name` = 'is_sales_rep') then `zm`.`old_value` else NULL end)) AS `is_sales_rep_old`,max((case when (`zm`.`col_name` = 'is_sales_rep') then `zm`.`new_value` else NULL end)) AS `is_sales_rep_new`,max((case when (`zm`.`col_name` = 'reference_no') then `zm`.`old_value` else NULL end)) AS `reference_no_old`,max((case when (`zm`.`col_name` = 'reference_no') then `zm`.`new_value` else NULL end)) AS `reference_no_new`,max((case when (`zm`.`col_name` = 'sales_rep_id') then `zm`.`old_value` else NULL end)) AS `sales_rep_id_old`,max((case when (`zm`.`col_name` = 'sales_rep_id') then `zm`.`new_value` else NULL end)) AS `sales_rep_id_new`,max((case when (`zm`.`col_name` = 'credit_status') then `zm`.`old_value` else NULL end)) AS `credit_status_old`,max((case when (`zm`.`col_name` = 'credit_status') then `zm`.`new_value` else NULL end)) AS `credit_status_new`,max((case when (`zm`.`col_name` = 'credit_limit') then `zm`.`old_value` else NULL end)) AS `credit_limit_old`,max((case when (`zm`.`col_name` = 'credit_limit') then `zm`.`new_value` else NULL end)) AS `credit_limit_new`,max((case when (`zm`.`col_name` = 'total_open_balance') then `zm`.`old_value` else NULL end)) AS `total_open_balance_old`,max((case when (`zm`.`col_name` = 'total_open_balance') then `zm`.`new_value` else NULL end)) AS `total_open_balance_new`,max((case when (`zm`.`col_name` = 'tax_id') then `zm`.`old_value` else NULL end)) AS `tax_id_old`,max((case when (`zm`.`col_name` = 'tax_id') then `zm`.`new_value` else NULL end)) AS `tax_id_new`,max((case when (`zm`.`col_name` = 'is_tax_exempt') then `zm`.`old_value` else NULL end)) AS `is_tax_exempt_old`,max((case when (`zm`.`col_name` = 'is_tax_exempt') then `zm`.`new_value` else NULL end)) AS `is_tax_exempt_new`,max((case when (`zm`.`col_name` = 'is_po_tax_exempt') then `zm`.`old_value` else NULL end)) AS `is_po_tax_exempt_old`,max((case when (`zm`.`col_name` = 'is_po_tax_exempt') then `zm`.`new_value` else NULL end)) AS `is_po_tax_exempt_new`,max((case when (`zm`.`col_name` = 'url') then `zm`.`old_value` else NULL end)) AS `url_old`,max((case when (`zm`.`col_name` = 'url') then `zm`.`new_value` else NULL end)) AS `url_new`,max((case when (`zm`.`col_name` = 'description') then `zm`.`old_value` else NULL end)) AS `description_old`,max((case when (`zm`.`col_name` = 'description') then `zm`.`new_value` else NULL end)) AS `description_new`,max((case when (`zm`.`col_name` = 'is_summary') then `zm`.`old_value` else NULL end)) AS `is_summary_old`,max((case when (`zm`.`col_name` = 'is_summary') then `zm`.`new_value` else NULL end)) AS `is_summary_new`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`old_value` else NULL end)) AS `archived_old`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`new_value` else NULL end)) AS `archived_new`,max((case when (`zm`.`col_name` = 'price_list_id') then `zm`.`old_value` else NULL end)) AS `price_list_id_old`,max((case when (`zm`.`col_name` = 'price_list_id') then `zm`.`new_value` else NULL end)) AS `price_list_id_new`,max((case when (`zm`.`col_name` = 'delivery_rule') then `zm`.`old_value` else NULL end)) AS `delivery_rule_old`,max((case when (`zm`.`col_name` = 'delivery_rule') then `zm`.`new_value` else NULL end)) AS `delivery_rule_new`,max((case when (`zm`.`col_name` = 'delivery_via_rule') then `zm`.`old_value` else NULL end)) AS `delivery_via_rule_old`,max((case when (`zm`.`col_name` = 'delivery_via_rule') then `zm`.`new_value` else NULL end)) AS `delivery_via_rule_new`,max((case when (`zm`.`col_name` = 'flat_discount') then `zm`.`old_value` else NULL end)) AS `flat_discount_old`,max((case when (`zm`.`col_name` = 'flat_discount') then `zm`.`new_value` else NULL end)) AS `flat_discount_new`,max((case when (`zm`.`col_name` = 'is_manufacturer') then `zm`.`old_value` else NULL end)) AS `is_manufacturer_old`,max((case when (`zm`.`col_name` = 'is_manufacturer') then `zm`.`new_value` else NULL end)) AS `is_manufacturer_new`,max((case when (`zm`.`col_name` = 'po_price_list_id') then `zm`.`old_value` else NULL end)) AS `po_price_list_id_old`,max((case when (`zm`.`col_name` = 'po_price_list_id') then `zm`.`new_value` else NULL end)) AS `po_price_list_id_new`,max((case when (`zm`.`col_name` = 'language_id') then `zm`.`old_value` else NULL end)) AS `language_id_old`,max((case when (`zm`.`col_name` = 'language_id') then `zm`.`new_value` else NULL end)) AS `language_id_new`,max((case when (`zm`.`col_name` = 'greeting_id') then `zm`.`old_value` else NULL end)) AS `greeting_id_old`,max((case when (`zm`.`col_name` = 'greeting_id') then `zm`.`new_value` else NULL end)) AS `greeting_id_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'bpartners') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_bpartners_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_bpartners_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_bpartners_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'bpartners');

-- Volcando estructura para vista banana.zvw_audit_bpartner_locations
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_bpartner_locations`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_bpartner_locations` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'bpartner_id') then `zm`.`old_value` else NULL end)) AS `bpartner_id_old`,max((case when (`zm`.`col_name` = 'bpartner_id') then `zm`.`new_value` else NULL end)) AS `bpartner_id_new`,max((case when (`zm`.`col_name` = 'location_id') then `zm`.`old_value` else NULL end)) AS `location_id_old`,max((case when (`zm`.`col_name` = 'location_id') then `zm`.`new_value` else NULL end)) AS `location_id_new`,max((case when (`zm`.`col_name` = 'name') then `zm`.`old_value` else NULL end)) AS `name_old`,max((case when (`zm`.`col_name` = 'name') then `zm`.`new_value` else NULL end)) AS `name_new`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`old_value` else NULL end)) AS `archived_old`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`new_value` else NULL end)) AS `archived_new`,max((case when (`zm`.`col_name` = 'is_ship_to') then `zm`.`old_value` else NULL end)) AS `is_ship_to_old`,max((case when (`zm`.`col_name` = 'is_ship_to') then `zm`.`new_value` else NULL end)) AS `is_ship_to_new`,max((case when (`zm`.`col_name` = 'is_bill_to') then `zm`.`old_value` else NULL end)) AS `is_bill_to_old`,max((case when (`zm`.`col_name` = 'is_bill_to') then `zm`.`new_value` else NULL end)) AS `is_bill_to_new`,max((case when (`zm`.`col_name` = 'is_pay_from') then `zm`.`old_value` else NULL end)) AS `is_pay_from_old`,max((case when (`zm`.`col_name` = 'is_pay_from') then `zm`.`new_value` else NULL end)) AS `is_pay_from_new`,max((case when (`zm`.`col_name` = 'is_remit_to') then `zm`.`old_value` else NULL end)) AS `is_remit_to_old`,max((case when (`zm`.`col_name` = 'is_remit_to') then `zm`.`new_value` else NULL end)) AS `is_remit_to_new`,max((case when (`zm`.`col_name` = 'phone') then `zm`.`old_value` else NULL end)) AS `phone_old`,max((case when (`zm`.`col_name` = 'phone') then `zm`.`new_value` else NULL end)) AS `phone_new`,max((case when (`zm`.`col_name` = 'phone_2') then `zm`.`old_value` else NULL end)) AS `phone_2_old`,max((case when (`zm`.`col_name` = 'phone_2') then `zm`.`new_value` else NULL end)) AS `phone_2_new`,max((case when (`zm`.`col_name` = 'fax') then `zm`.`old_value` else NULL end)) AS `fax_old`,max((case when (`zm`.`col_name` = 'fax') then `zm`.`new_value` else NULL end)) AS `fax_new`,max((case when (`zm`.`col_name` = 'isdn') then `zm`.`old_value` else NULL end)) AS `isdn_old`,max((case when (`zm`.`col_name` = 'isdn') then `zm`.`new_value` else NULL end)) AS `isdn_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'principal') then `zm`.`old_value` else NULL end)) AS `principal_old`,max((case when (`zm`.`col_name` = 'principal') then `zm`.`new_value` else NULL end)) AS `principal_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'bpartner_locations') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_bpartner_locations_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_bpartner_locations_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_bpartner_locations_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'bpartner_locations');

-- Volcando estructura para vista banana.zvw_audit_categories
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_categories`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_categories` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'name') then `zm`.`old_value` else NULL end)) AS `name_old`,max((case when (`zm`.`col_name` = 'name') then `zm`.`new_value` else NULL end)) AS `name_new`,max((case when (`zm`.`col_name` = 'parent_id') then `zm`.`old_value` else NULL end)) AS `parent_id_old`,max((case when (`zm`.`col_name` = 'parent_id') then `zm`.`new_value` else NULL end)) AS `parent_id_new`,max((case when (`zm`.`col_name` = 'color') then `zm`.`old_value` else NULL end)) AS `color_old`,max((case when (`zm`.`col_name` = 'color') then `zm`.`new_value` else NULL end)) AS `color_new`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`old_value` else NULL end)) AS `archived_old`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`new_value` else NULL end)) AS `archived_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'categories') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_categories_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_categories_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_categories_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'categories');

-- Volcando estructura para vista banana.zvw_audit_charges
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_charges`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_charges` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'name') then `zm`.`old_value` else NULL end)) AS `name_old`,max((case when (`zm`.`col_name` = 'name') then `zm`.`new_value` else NULL end)) AS `name_new`,max((case when (`zm`.`col_name` = 'description') then `zm`.`old_value` else NULL end)) AS `description_old`,max((case when (`zm`.`col_name` = 'description') then `zm`.`new_value` else NULL end)) AS `description_new`,max((case when (`zm`.`col_name` = 'report_to') then `zm`.`old_value` else NULL end)) AS `report_to_old`,max((case when (`zm`.`col_name` = 'report_to') then `zm`.`new_value` else NULL end)) AS `report_to_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'charges') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_charges_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_charges_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_charges_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'charges');

-- Volcando estructura para vista banana.zvw_audit_cities
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_cities`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_cities` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'state_id') then `zm`.`old_value` else NULL end)) AS `state_id_old`,max((case when (`zm`.`col_name` = 'state_id') then `zm`.`new_value` else NULL end)) AS `state_id_new`,max((case when (`zm`.`col_name` = 'city') then `zm`.`old_value` else NULL end)) AS `city_old`,max((case when (`zm`.`col_name` = 'city') then `zm`.`new_value` else NULL end)) AS `city_new`,max((case when (`zm`.`col_name` = 'capital') then `zm`.`old_value` else NULL end)) AS `capital_old`,max((case when (`zm`.`col_name` = 'capital') then `zm`.`new_value` else NULL end)) AS `capital_new`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`old_value` else NULL end)) AS `archived_old`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`new_value` else NULL end)) AS `archived_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'cities') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_cities_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_cities_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_cities_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'cities');

-- Volcando estructura para vista banana.zvw_audit_clients
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_clients`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_clients` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'client_name') then `zm`.`old_value` else NULL end)) AS `client_name_old`,max((case when (`zm`.`col_name` = 'client_name') then `zm`.`new_value` else NULL end)) AS `client_name_new`,max((case when (`zm`.`col_name` = 'description') then `zm`.`old_value` else NULL end)) AS `description_old`,max((case when (`zm`.`col_name` = 'description') then `zm`.`new_value` else NULL end)) AS `description_new`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`old_value` else NULL end)) AS `archived_old`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`new_value` else NULL end)) AS `archived_new`,max((case when (`zm`.`col_name` = 'language') then `zm`.`old_value` else NULL end)) AS `language_old`,max((case when (`zm`.`col_name` = 'language') then `zm`.`new_value` else NULL end)) AS `language_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'clients') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_clients_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_clients_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_clients_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'clients');

-- Volcando estructura para vista banana.zvw_audit_conditions
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_conditions`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_conditions` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'name') then `zm`.`old_value` else NULL end)) AS `name_old`,max((case when (`zm`.`col_name` = 'name') then `zm`.`new_value` else NULL end)) AS `name_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'conditions') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_conditions_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_conditions_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_conditions_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'conditions');

-- Volcando estructura para vista banana.zvw_audit_contacts
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_contacts`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_contacts` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'name') then `zm`.`old_value` else NULL end)) AS `name_old`,max((case when (`zm`.`col_name` = 'name') then `zm`.`new_value` else NULL end)) AS `name_new`,max((case when (`zm`.`col_name` = 'description') then `zm`.`old_value` else NULL end)) AS `description_old`,max((case when (`zm`.`col_name` = 'description') then `zm`.`new_value` else NULL end)) AS `description_new`,max((case when (`zm`.`col_name` = 'comments') then `zm`.`old_value` else NULL end)) AS `comments_old`,max((case when (`zm`.`col_name` = 'comments') then `zm`.`new_value` else NULL end)) AS `comments_new`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`old_value` else NULL end)) AS `archived_old`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`new_value` else NULL end)) AS `archived_new`,max((case when (`zm`.`col_name` = 'email') then `zm`.`old_value` else NULL end)) AS `email_old`,max((case when (`zm`.`col_name` = 'email') then `zm`.`new_value` else NULL end)) AS `email_new`,max((case when (`zm`.`col_name` = 'phone') then `zm`.`old_value` else NULL end)) AS `phone_old`,max((case when (`zm`.`col_name` = 'phone') then `zm`.`new_value` else NULL end)) AS `phone_new`,max((case when (`zm`.`col_name` = 'phone_2') then `zm`.`old_value` else NULL end)) AS `phone_2_old`,max((case when (`zm`.`col_name` = 'phone_2') then `zm`.`new_value` else NULL end)) AS `phone_2_new`,max((case when (`zm`.`col_name` = 'fax') then `zm`.`old_value` else NULL end)) AS `fax_old`,max((case when (`zm`.`col_name` = 'fax') then `zm`.`new_value` else NULL end)) AS `fax_new`,max((case when (`zm`.`col_name` = 'title') then `zm`.`old_value` else NULL end)) AS `title_old`,max((case when (`zm`.`col_name` = 'title') then `zm`.`new_value` else NULL end)) AS `title_new`,max((case when (`zm`.`col_name` = 'charge') then `zm`.`old_value` else NULL end)) AS `charge_old`,max((case when (`zm`.`col_name` = 'charge') then `zm`.`new_value` else NULL end)) AS `charge_new`,max((case when (`zm`.`col_name` = 'birthday') then `zm`.`old_value` else NULL end)) AS `birthday_old`,max((case when (`zm`.`col_name` = 'birthday') then `zm`.`new_value` else NULL end)) AS `birthday_new`,max((case when (`zm`.`col_name` = 'last_contact') then `zm`.`old_value` else NULL end)) AS `last_contact_old`,max((case when (`zm`.`col_name` = 'last_contact') then `zm`.`new_value` else NULL end)) AS `last_contact_new`,max((case when (`zm`.`col_name` = 'last_result') then `zm`.`old_value` else NULL end)) AS `last_result_old`,max((case when (`zm`.`col_name` = 'last_result') then `zm`.`new_value` else NULL end)) AS `last_result_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'contacts') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_contacts_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_contacts_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_contacts_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'contacts');

-- Volcando estructura para vista banana.zvw_audit_counter_series
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_counter_series`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_counter_series` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'type_document_id') then `zm`.`old_value` else NULL end)) AS `type_document_id_old`,max((case when (`zm`.`col_name` = 'type_document_id') then `zm`.`new_value` else NULL end)) AS `type_document_id_new`,max((case when (`zm`.`col_name` = 'serie') then `zm`.`old_value` else NULL end)) AS `serie_old`,max((case when (`zm`.`col_name` = 'serie') then `zm`.`new_value` else NULL end)) AS `serie_new`,max((case when (`zm`.`col_name` = 'counter') then `zm`.`old_value` else NULL end)) AS `counter_old`,max((case when (`zm`.`col_name` = 'counter') then `zm`.`new_value` else NULL end)) AS `counter_new`,max((case when (`zm`.`col_name` = 'organization_id') then `zm`.`old_value` else NULL end)) AS `organization_id_old`,max((case when (`zm`.`col_name` = 'organization_id') then `zm`.`new_value` else NULL end)) AS `organization_id_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'counter_series') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_counter_series_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_counter_series_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_counter_series_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'counter_series');

-- Volcando estructura para vista banana.zvw_audit_countries
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_countries`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_countries` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'iso') then `zm`.`old_value` else NULL end)) AS `iso_old`,max((case when (`zm`.`col_name` = 'iso') then `zm`.`new_value` else NULL end)) AS `iso_new`,max((case when (`zm`.`col_name` = 'country') then `zm`.`old_value` else NULL end)) AS `country_old`,max((case when (`zm`.`col_name` = 'country') then `zm`.`new_value` else NULL end)) AS `country_new`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`old_value` else NULL end)) AS `archived_old`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`new_value` else NULL end)) AS `archived_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'countries') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_countries_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_countries_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_countries_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'countries');

-- Volcando estructura para vista banana.zvw_audit_currencies
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_currencies`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_currencies` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'isocode') then `zm`.`old_value` else NULL end)) AS `isocode_old`,max((case when (`zm`.`col_name` = 'isocode') then `zm`.`new_value` else NULL end)) AS `isocode_new`,max((case when (`zm`.`col_name` = 'language') then `zm`.`old_value` else NULL end)) AS `language_old`,max((case when (`zm`.`col_name` = 'language') then `zm`.`new_value` else NULL end)) AS `language_new`,max((case when (`zm`.`col_name` = 'name') then `zm`.`old_value` else NULL end)) AS `name_old`,max((case when (`zm`.`col_name` = 'name') then `zm`.`new_value` else NULL end)) AS `name_new`,max((case when (`zm`.`col_name` = 'money') then `zm`.`old_value` else NULL end)) AS `money_old`,max((case when (`zm`.`col_name` = 'money') then `zm`.`new_value` else NULL end)) AS `money_new`,max((case when (`zm`.`col_name` = 'symbol') then `zm`.`old_value` else NULL end)) AS `symbol_old`,max((case when (`zm`.`col_name` = 'symbol') then `zm`.`new_value` else NULL end)) AS `symbol_new`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`old_value` else NULL end)) AS `archived_old`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`new_value` else NULL end)) AS `archived_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'currencies') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_currencies_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_currencies_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_currencies_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'currencies');

-- Volcando estructura para vista banana.zvw_audit_imports
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_imports`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_imports` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'date') then `zm`.`old_value` else NULL end)) AS `date_old`,max((case when (`zm`.`col_name` = 'date') then `zm`.`new_value` else NULL end)) AS `date_new`,max((case when (`zm`.`col_name` = 'register') then `zm`.`old_value` else NULL end)) AS `register_old`,max((case when (`zm`.`col_name` = 'register') then `zm`.`new_value` else NULL end)) AS `register_new`,max((case when (`zm`.`col_name` = 'table_id') then `zm`.`old_value` else NULL end)) AS `table_id_old`,max((case when (`zm`.`col_name` = 'table_id') then `zm`.`new_value` else NULL end)) AS `table_id_new`,max((case when (`zm`.`col_name` = 'aprove') then `zm`.`old_value` else NULL end)) AS `aprove_old`,max((case when (`zm`.`col_name` = 'aprove') then `zm`.`new_value` else NULL end)) AS `aprove_new`,max((case when (`zm`.`col_name` = 'active') then `zm`.`old_value` else NULL end)) AS `active_old`,max((case when (`zm`.`col_name` = 'active') then `zm`.`new_value` else NULL end)) AS `active_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'imports') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_imports_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_imports_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_imports_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'imports');

-- Volcando estructura para vista banana.zvw_audit_languages
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_languages`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_languages` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'languagescol') then `zm`.`old_value` else NULL end)) AS `languagescol_old`,max((case when (`zm`.`col_name` = 'languagescol') then `zm`.`new_value` else NULL end)) AS `languagescol_new`,max((case when (`zm`.`col_name` = 'iso') then `zm`.`old_value` else NULL end)) AS `iso_old`,max((case when (`zm`.`col_name` = 'iso') then `zm`.`new_value` else NULL end)) AS `iso_new`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`old_value` else NULL end)) AS `archived_old`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`new_value` else NULL end)) AS `archived_new`,max((case when (`zm`.`col_name` = 'date_format') then `zm`.`old_value` else NULL end)) AS `date_format_old`,max((case when (`zm`.`col_name` = 'date_format') then `zm`.`new_value` else NULL end)) AS `date_format_new`,max((case when (`zm`.`col_name` = 'datetime_format') then `zm`.`old_value` else NULL end)) AS `datetime_format_old`,max((case when (`zm`.`col_name` = 'datetime_format') then `zm`.`new_value` else NULL end)) AS `datetime_format_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'description') then `zm`.`old_value` else NULL end)) AS `description_old`,max((case when (`zm`.`col_name` = 'description') then `zm`.`new_value` else NULL end)) AS `description_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'languages') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_languages_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_languages_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_languages_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'languages');

-- Volcando estructura para vista banana.zvw_audit_locations
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_locations`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_locations` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`old_value` else NULL end)) AS `archived_old`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`new_value` else NULL end)) AS `archived_new`,max((case when (`zm`.`col_name` = 'address_1') then `zm`.`old_value` else NULL end)) AS `address_1_old`,max((case when (`zm`.`col_name` = 'address_1') then `zm`.`new_value` else NULL end)) AS `address_1_new`,max((case when (`zm`.`col_name` = 'city_id') then `zm`.`old_value` else NULL end)) AS `city_id_old`,max((case when (`zm`.`col_name` = 'city_id') then `zm`.`new_value` else NULL end)) AS `city_id_new`,max((case when (`zm`.`col_name` = 'postal') then `zm`.`old_value` else NULL end)) AS `postal_old`,max((case when (`zm`.`col_name` = 'postal') then `zm`.`new_value` else NULL end)) AS `postal_new`,max((case when (`zm`.`col_name` = 'state_id') then `zm`.`old_value` else NULL end)) AS `state_id_old`,max((case when (`zm`.`col_name` = 'state_id') then `zm`.`new_value` else NULL end)) AS `state_id_new`,max((case when (`zm`.`col_name` = 'country_id') then `zm`.`old_value` else NULL end)) AS `country_id_old`,max((case when (`zm`.`col_name` = 'country_id') then `zm`.`new_value` else NULL end)) AS `country_id_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'locations') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_locations_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_locations_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_locations_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'locations');

-- Volcando estructura para vista banana.zvw_audit_manufacturers
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_manufacturers`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_manufacturers` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'name') then `zm`.`old_value` else NULL end)) AS `name_old`,max((case when (`zm`.`col_name` = 'name') then `zm`.`new_value` else NULL end)) AS `name_new`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`old_value` else NULL end)) AS `archived_old`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`new_value` else NULL end)) AS `archived_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'manufacturers') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_manufacturers_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_manufacturers_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_manufacturers_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'manufacturers');

-- Volcando estructura para vista banana.zvw_audit_organizations
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_organizations`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_organizations` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'name') then `zm`.`old_value` else NULL end)) AS `name_old`,max((case when (`zm`.`col_name` = 'name') then `zm`.`new_value` else NULL end)) AS `name_new`,max((case when (`zm`.`col_name` = 'reference_no') then `zm`.`old_value` else NULL end)) AS `reference_no_old`,max((case when (`zm`.`col_name` = 'reference_no') then `zm`.`new_value` else NULL end)) AS `reference_no_new`,max((case when (`zm`.`col_name` = 'description') then `zm`.`old_value` else NULL end)) AS `description_old`,max((case when (`zm`.`col_name` = 'description') then `zm`.`new_value` else NULL end)) AS `description_new`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`old_value` else NULL end)) AS `archived_old`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`new_value` else NULL end)) AS `archived_new`,max((case when (`zm`.`col_name` = 'location_id') then `zm`.`old_value` else NULL end)) AS `location_id_old`,max((case when (`zm`.`col_name` = 'location_id') then `zm`.`new_value` else NULL end)) AS `location_id_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'organizations') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_organizations_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_organizations_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_organizations_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'organizations');

-- Volcando estructura para vista banana.zvw_audit_payment_terms
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_payment_terms`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_payment_terms` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'name') then `zm`.`old_value` else NULL end)) AS `name_old`,max((case when (`zm`.`col_name` = 'name') then `zm`.`new_value` else NULL end)) AS `name_new`,max((case when (`zm`.`col_name` = 'notes') then `zm`.`old_value` else NULL end)) AS `notes_old`,max((case when (`zm`.`col_name` = 'notes') then `zm`.`new_value` else NULL end)) AS `notes_new`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`old_value` else NULL end)) AS `archived_old`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`new_value` else NULL end)) AS `archived_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'payment_terms') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_payment_terms_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_payment_terms_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_payment_terms_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'payment_terms');

-- Volcando estructura para vista banana.zvw_audit_prices
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_prices`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_prices` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'price_list_id') then `zm`.`old_value` else NULL end)) AS `price_list_id_old`,max((case when (`zm`.`col_name` = 'price_list_id') then `zm`.`new_value` else NULL end)) AS `price_list_id_new`,max((case when (`zm`.`col_name` = 'product_detail_id') then `zm`.`old_value` else NULL end)) AS `product_detail_id_old`,max((case when (`zm`.`col_name` = 'product_detail_id') then `zm`.`new_value` else NULL end)) AS `product_detail_id_new`,max((case when (`zm`.`col_name` = 'grossprice') then `zm`.`old_value` else NULL end)) AS `grossprice_old`,max((case when (`zm`.`col_name` = 'grossprice') then `zm`.`new_value` else NULL end)) AS `grossprice_new`,max((case when (`zm`.`col_name` = 'discount') then `zm`.`old_value` else NULL end)) AS `discount_old`,max((case when (`zm`.`col_name` = 'discount') then `zm`.`new_value` else NULL end)) AS `discount_new`,max((case when (`zm`.`col_name` = 'discount_calc') then `zm`.`old_value` else NULL end)) AS `discount_calc_old`,max((case when (`zm`.`col_name` = 'discount_calc') then `zm`.`new_value` else NULL end)) AS `discount_calc_new`,max((case when (`zm`.`col_name` = 'netprice') then `zm`.`old_value` else NULL end)) AS `netprice_old`,max((case when (`zm`.`col_name` = 'netprice') then `zm`.`new_value` else NULL end)) AS `netprice_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'prices') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_prices_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_prices_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_prices_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'prices');

-- Volcando estructura para vista banana.zvw_audit_price_lists
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_price_lists`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_price_lists` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'reference') then `zm`.`old_value` else NULL end)) AS `reference_old`,max((case when (`zm`.`col_name` = 'reference') then `zm`.`new_value` else NULL end)) AS `reference_new`,max((case when (`zm`.`col_name` = 'name') then `zm`.`old_value` else NULL end)) AS `name_old`,max((case when (`zm`.`col_name` = 'name') then `zm`.`new_value` else NULL end)) AS `name_new`,max((case when (`zm`.`col_name` = 'valid_from') then `zm`.`old_value` else NULL end)) AS `valid_from_old`,max((case when (`zm`.`col_name` = 'valid_from') then `zm`.`new_value` else NULL end)) AS `valid_from_new`,max((case when (`zm`.`col_name` = 'valid_until') then `zm`.`old_value` else NULL end)) AS `valid_until_old`,max((case when (`zm`.`col_name` = 'valid_until') then `zm`.`new_value` else NULL end)) AS `valid_until_new`,max((case when (`zm`.`col_name` = 'tax_include') then `zm`.`old_value` else NULL end)) AS `tax_include_old`,max((case when (`zm`.`col_name` = 'tax_include') then `zm`.`new_value` else NULL end)) AS `tax_include_new`,max((case when (`zm`.`col_name` = 'tax_id') then `zm`.`old_value` else NULL end)) AS `tax_id_old`,max((case when (`zm`.`col_name` = 'tax_id') then `zm`.`new_value` else NULL end)) AS `tax_id_new`,max((case when (`zm`.`col_name` = 'currency_id') then `zm`.`old_value` else NULL end)) AS `currency_id_old`,max((case when (`zm`.`col_name` = 'currency_id') then `zm`.`new_value` else NULL end)) AS `currency_id_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'alternative') then `zm`.`old_value` else NULL end)) AS `alternative_old`,max((case when (`zm`.`col_name` = 'alternative') then `zm`.`new_value` else NULL end)) AS `alternative_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'price_lists') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_price_lists_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_price_lists_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_price_lists_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'price_lists');

-- Volcando estructura para vista banana.zvw_audit_products
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_products`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_products` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'reference') then `zm`.`old_value` else NULL end)) AS `reference_old`,max((case when (`zm`.`col_name` = 'reference') then `zm`.`new_value` else NULL end)) AS `reference_new`,max((case when (`zm`.`col_name` = 'name') then `zm`.`old_value` else NULL end)) AS `name_old`,max((case when (`zm`.`col_name` = 'name') then `zm`.`new_value` else NULL end)) AS `name_new`,max((case when (`zm`.`col_name` = 'description') then `zm`.`old_value` else NULL end)) AS `description_old`,max((case when (`zm`.`col_name` = 'description') then `zm`.`new_value` else NULL end)) AS `description_new`,max((case when (`zm`.`col_name` = 'type') then `zm`.`old_value` else NULL end)) AS `type_old`,max((case when (`zm`.`col_name` = 'type') then `zm`.`new_value` else NULL end)) AS `type_new`,max((case when (`zm`.`col_name` = 'is_salable') then `zm`.`old_value` else NULL end)) AS `is_salable_old`,max((case when (`zm`.`col_name` = 'is_salable') then `zm`.`new_value` else NULL end)) AS `is_salable_new`,max((case when (`zm`.`col_name` = 'is_purchasable') then `zm`.`old_value` else NULL end)) AS `is_purchasable_old`,max((case when (`zm`.`col_name` = 'is_purchasable') then `zm`.`new_value` else NULL end)) AS `is_purchasable_new`,max((case when (`zm`.`col_name` = 'unit_id') then `zm`.`old_value` else NULL end)) AS `unit_id_old`,max((case when (`zm`.`col_name` = 'unit_id') then `zm`.`new_value` else NULL end)) AS `unit_id_new`,max((case when (`zm`.`col_name` = 'category_id') then `zm`.`old_value` else NULL end)) AS `category_id_old`,max((case when (`zm`.`col_name` = 'category_id') then `zm`.`new_value` else NULL end)) AS `category_id_new`,max((case when (`zm`.`col_name` = 'manufacture_id') then `zm`.`old_value` else NULL end)) AS `manufacture_id_old`,max((case when (`zm`.`col_name` = 'manufacture_id') then `zm`.`new_value` else NULL end)) AS `manufacture_id_new`,max((case when (`zm`.`col_name` = 'tax_id') then `zm`.`old_value` else NULL end)) AS `tax_id_old`,max((case when (`zm`.`col_name` = 'tax_id') then `zm`.`new_value` else NULL end)) AS `tax_id_new`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`old_value` else NULL end)) AS `archived_old`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`new_value` else NULL end)) AS `archived_new`,max((case when (`zm`.`col_name` = 'is_combination') then `zm`.`old_value` else NULL end)) AS `is_combination_old`,max((case when (`zm`.`col_name` = 'is_combination') then `zm`.`new_value` else NULL end)) AS `is_combination_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'products') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_products_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_products_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_products_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'products');

-- Volcando estructura para vista banana.zvw_audit_product_details
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_product_details`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_product_details` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'reference') then `zm`.`old_value` else NULL end)) AS `reference_old`,max((case when (`zm`.`col_name` = 'reference') then `zm`.`new_value` else NULL end)) AS `reference_new`,max((case when (`zm`.`col_name` = 'name') then `zm`.`old_value` else NULL end)) AS `name_old`,max((case when (`zm`.`col_name` = 'name') then `zm`.`new_value` else NULL end)) AS `name_new`,max((case when (`zm`.`col_name` = 'product_id') then `zm`.`old_value` else NULL end)) AS `product_id_old`,max((case when (`zm`.`col_name` = 'product_id') then `zm`.`new_value` else NULL end)) AS `product_id_new`,max((case when (`zm`.`col_name` = 'sku') then `zm`.`old_value` else NULL end)) AS `sku_old`,max((case when (`zm`.`col_name` = 'sku') then `zm`.`new_value` else NULL end)) AS `sku_new`,max((case when (`zm`.`col_name` = 'ean13') then `zm`.`old_value` else NULL end)) AS `ean13_old`,max((case when (`zm`.`col_name` = 'ean13') then `zm`.`new_value` else NULL end)) AS `ean13_new`,max((case when (`zm`.`col_name` = 'upc') then `zm`.`old_value` else NULL end)) AS `upc_old`,max((case when (`zm`.`col_name` = 'upc') then `zm`.`new_value` else NULL end)) AS `upc_new`,max((case when (`zm`.`col_name` = 'cost') then `zm`.`old_value` else NULL end)) AS `cost_old`,max((case when (`zm`.`col_name` = 'cost') then `zm`.`new_value` else NULL end)) AS `cost_new`,max((case when (`zm`.`col_name` = 'sale_price') then `zm`.`old_value` else NULL end)) AS `sale_price_old`,max((case when (`zm`.`col_name` = 'sale_price') then `zm`.`new_value` else NULL end)) AS `sale_price_new`,max((case when (`zm`.`col_name` = 'condition_id') then `zm`.`old_value` else NULL end)) AS `condition_id_old`,max((case when (`zm`.`col_name` = 'condition_id') then `zm`.`new_value` else NULL end)) AS `condition_id_new`,max((case when (`zm`.`col_name` = 'price_list_id') then `zm`.`old_value` else NULL end)) AS `price_list_id_old`,max((case when (`zm`.`col_name` = 'price_list_id') then `zm`.`new_value` else NULL end)) AS `price_list_id_new`,max((case when (`zm`.`col_name` = 'image') then `zm`.`old_value` else NULL end)) AS `image_old`,max((case when (`zm`.`col_name` = 'image') then `zm`.`new_value` else NULL end)) AS `image_new`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`old_value` else NULL end)) AS `archived_old`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`new_value` else NULL end)) AS `archived_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'product_details') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_product_details_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_product_details_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_product_details_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'product_details');

-- Volcando estructura para vista banana.zvw_audit_reports
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_reports`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_reports` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'name') then `zm`.`old_value` else NULL end)) AS `name_old`,max((case when (`zm`.`col_name` = 'name') then `zm`.`new_value` else NULL end)) AS `name_new`,max((case when (`zm`.`col_name` = 'description') then `zm`.`old_value` else NULL end)) AS `description_old`,max((case when (`zm`.`col_name` = 'description') then `zm`.`new_value` else NULL end)) AS `description_new`,max((case when (`zm`.`col_name` = 'table_id') then `zm`.`old_value` else NULL end)) AS `table_id_old`,max((case when (`zm`.`col_name` = 'table_id') then `zm`.`new_value` else NULL end)) AS `table_id_new`,max((case when (`zm`.`col_name` = 'header_id') then `zm`.`old_value` else NULL end)) AS `header_id_old`,max((case when (`zm`.`col_name` = 'header_id') then `zm`.`new_value` else NULL end)) AS `header_id_new`,max((case when (`zm`.`col_name` = 'body_id') then `zm`.`old_value` else NULL end)) AS `body_id_old`,max((case when (`zm`.`col_name` = 'body_id') then `zm`.`new_value` else NULL end)) AS `body_id_new`,max((case when (`zm`.`col_name` = 'footer_id') then `zm`.`old_value` else NULL end)) AS `footer_id_old`,max((case when (`zm`.`col_name` = 'footer_id') then `zm`.`new_value` else NULL end)) AS `footer_id_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'reports') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_reports_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_reports_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_reports_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'reports');

-- Volcando estructura para vista banana.zvw_audit_rols
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_rols`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_rols` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'name') then `zm`.`old_value` else NULL end)) AS `name_old`,max((case when (`zm`.`col_name` = 'name') then `zm`.`new_value` else NULL end)) AS `name_new`,max((case when (`zm`.`col_name` = 'description') then `zm`.`old_value` else NULL end)) AS `description_old`,max((case when (`zm`.`col_name` = 'description') then `zm`.`new_value` else NULL end)) AS `description_new`,max((case when (`zm`.`col_name` = 'all_access_column') then `zm`.`old_value` else NULL end)) AS `all_access_column_old`,max((case when (`zm`.`col_name` = 'all_access_column') then `zm`.`new_value` else NULL end)) AS `all_access_column_new`,max((case when (`zm`.`col_name` = 'all_access_organization') then `zm`.`old_value` else NULL end)) AS `all_access_organization_old`,max((case when (`zm`.`col_name` = 'all_access_organization') then `zm`.`new_value` else NULL end)) AS `all_access_organization_new`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`old_value` else NULL end)) AS `archived_old`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`new_value` else NULL end)) AS `archived_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'rols') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_rols_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_rols_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_rols_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'rols');

-- Volcando estructura para vista banana.zvw_audit_settings
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_settings`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_settings` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'user_id') then `zm`.`old_value` else NULL end)) AS `user_id_old`,max((case when (`zm`.`col_name` = 'user_id') then `zm`.`new_value` else NULL end)) AS `user_id_new`,max((case when (`zm`.`col_name` = 'country_id') then `zm`.`old_value` else NULL end)) AS `country_id_old`,max((case when (`zm`.`col_name` = 'country_id') then `zm`.`new_value` else NULL end)) AS `country_id_new`,max((case when (`zm`.`col_name` = 'state_id') then `zm`.`old_value` else NULL end)) AS `state_id_old`,max((case when (`zm`.`col_name` = 'state_id') then `zm`.`new_value` else NULL end)) AS `state_id_new`,max((case when (`zm`.`col_name` = 'city_id') then `zm`.`old_value` else NULL end)) AS `city_id_old`,max((case when (`zm`.`col_name` = 'city_id') then `zm`.`new_value` else NULL end)) AS `city_id_new`,max((case when (`zm`.`col_name` = 'language_id') then `zm`.`old_value` else NULL end)) AS `language_id_old`,max((case when (`zm`.`col_name` = 'language_id') then `zm`.`new_value` else NULL end)) AS `language_id_new`,max((case when (`zm`.`col_name` = 'default') then `zm`.`old_value` else NULL end)) AS `default_old`,max((case when (`zm`.`col_name` = 'default') then `zm`.`new_value` else NULL end)) AS `default_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'settings') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_settings_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_settings_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_settings_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'settings');

-- Volcando estructura para vista banana.zvw_audit_setup_configurations
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_setup_configurations`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_setup_configurations` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'user_id') then `zm`.`old_value` else NULL end)) AS `user_id_old`,max((case when (`zm`.`col_name` = 'user_id') then `zm`.`new_value` else NULL end)) AS `user_id_new`,max((case when (`zm`.`col_name` = 'country_id') then `zm`.`old_value` else NULL end)) AS `country_id_old`,max((case when (`zm`.`col_name` = 'country_id') then `zm`.`new_value` else NULL end)) AS `country_id_new`,max((case when (`zm`.`col_name` = 'state_id') then `zm`.`old_value` else NULL end)) AS `state_id_old`,max((case when (`zm`.`col_name` = 'state_id') then `zm`.`new_value` else NULL end)) AS `state_id_new`,max((case when (`zm`.`col_name` = 'city_id') then `zm`.`old_value` else NULL end)) AS `city_id_old`,max((case when (`zm`.`col_name` = 'city_id') then `zm`.`new_value` else NULL end)) AS `city_id_new`,max((case when (`zm`.`col_name` = 'language_id') then `zm`.`old_value` else NULL end)) AS `language_id_old`,max((case when (`zm`.`col_name` = 'language_id') then `zm`.`new_value` else NULL end)) AS `language_id_new`,max((case when (`zm`.`col_name` = 'manufacturer_id') then `zm`.`old_value` else NULL end)) AS `manufacturer_id_old`,max((case when (`zm`.`col_name` = 'manufacturer_id') then `zm`.`new_value` else NULL end)) AS `manufacturer_id_new`,max((case when (`zm`.`col_name` = 'unit_id') then `zm`.`old_value` else NULL end)) AS `unit_id_old`,max((case when (`zm`.`col_name` = 'unit_id') then `zm`.`new_value` else NULL end)) AS `unit_id_new`,max((case when (`zm`.`col_name` = 'currency_id') then `zm`.`old_value` else NULL end)) AS `currency_id_old`,max((case when (`zm`.`col_name` = 'currency_id') then `zm`.`new_value` else NULL end)) AS `currency_id_new`,max((case when (`zm`.`col_name` = 'organization_id') then `zm`.`old_value` else NULL end)) AS `organization_id_old`,max((case when (`zm`.`col_name` = 'organization_id') then `zm`.`new_value` else NULL end)) AS `organization_id_new`,max((case when (`zm`.`col_name` = 'default') then `zm`.`old_value` else NULL end)) AS `default_old`,max((case when (`zm`.`col_name` = 'default') then `zm`.`new_value` else NULL end)) AS `default_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'setup_configurations') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_setup_configurations_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_setup_configurations_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_setup_configurations_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'setup_configurations');

-- Volcando estructura para vista banana.zvw_audit_states
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_states`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_states` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'country_id') then `zm`.`old_value` else NULL end)) AS `country_id_old`,max((case when (`zm`.`col_name` = 'country_id') then `zm`.`new_value` else NULL end)) AS `country_id_new`,max((case when (`zm`.`col_name` = 'state') then `zm`.`old_value` else NULL end)) AS `state_old`,max((case when (`zm`.`col_name` = 'state') then `zm`.`new_value` else NULL end)) AS `state_new`,max((case when (`zm`.`col_name` = 'iso') then `zm`.`old_value` else NULL end)) AS `iso_old`,max((case when (`zm`.`col_name` = 'iso') then `zm`.`new_value` else NULL end)) AS `iso_new`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`old_value` else NULL end)) AS `archived_old`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`new_value` else NULL end)) AS `archived_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'states') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_states_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_states_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_states_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'states');

-- Volcando estructura para vista banana.zvw_audit_taxes
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_taxes`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_taxes` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'name') then `zm`.`old_value` else NULL end)) AS `name_old`,max((case when (`zm`.`col_name` = 'name') then `zm`.`new_value` else NULL end)) AS `name_new`,max((case when (`zm`.`col_name` = 'print_name') then `zm`.`old_value` else NULL end)) AS `print_name_old`,max((case when (`zm`.`col_name` = 'print_name') then `zm`.`new_value` else NULL end)) AS `print_name_new`,max((case when (`zm`.`col_name` = 'validfrom') then `zm`.`old_value` else NULL end)) AS `validfrom_old`,max((case when (`zm`.`col_name` = 'validfrom') then `zm`.`new_value` else NULL end)) AS `validfrom_new`,max((case when (`zm`.`col_name` = 'rate') then `zm`.`old_value` else NULL end)) AS `rate_old`,max((case when (`zm`.`col_name` = 'rate') then `zm`.`new_value` else NULL end)) AS `rate_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'notes') then `zm`.`old_value` else NULL end)) AS `notes_old`,max((case when (`zm`.`col_name` = 'notes') then `zm`.`new_value` else NULL end)) AS `notes_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'taxes') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_taxes_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_taxes_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_taxes_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'taxes');

-- Volcando estructura para vista banana.zvw_audit_term_types
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_term_types`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_term_types` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'payment_terms_id') then `zm`.`old_value` else NULL end)) AS `payment_terms_id_old`,max((case when (`zm`.`col_name` = 'payment_terms_id') then `zm`.`new_value` else NULL end)) AS `payment_terms_id_new`,max((case when (`zm`.`col_name` = 'type') then `zm`.`old_value` else NULL end)) AS `type_old`,max((case when (`zm`.`col_name` = 'type') then `zm`.`new_value` else NULL end)) AS `type_new`,max((case when (`zm`.`col_name` = 'day') then `zm`.`old_value` else NULL end)) AS `day_old`,max((case when (`zm`.`col_name` = 'day') then `zm`.`new_value` else NULL end)) AS `day_new`,max((case when (`zm`.`col_name` = 'typeid') then `zm`.`old_value` else NULL end)) AS `typeid_old`,max((case when (`zm`.`col_name` = 'typeid') then `zm`.`new_value` else NULL end)) AS `typeid_new`,max((case when (`zm`.`col_name` = 'typeem') then `zm`.`old_value` else NULL end)) AS `typeem_old`,max((case when (`zm`.`col_name` = 'typeem') then `zm`.`new_value` else NULL end)) AS `typeem_new`,max((case when (`zm`.`col_name` = 'typenm') then `zm`.`old_value` else NULL end)) AS `typenm_old`,max((case when (`zm`.`col_name` = 'typenm') then `zm`.`new_value` else NULL end)) AS `typenm_new`,max((case when (`zm`.`col_name` = 'daydxpp') then `zm`.`old_value` else NULL end)) AS `daydxpp_old`,max((case when (`zm`.`col_name` = 'daydxpp') then `zm`.`new_value` else NULL end)) AS `daydxpp_new`,max((case when (`zm`.`col_name` = 'percentdxpp') then `zm`.`old_value` else NULL end)) AS `percentdxpp_old`,max((case when (`zm`.`col_name` = 'percentdxpp') then `zm`.`new_value` else NULL end)) AS `percentdxpp_new`,max((case when (`zm`.`col_name` = 'fixed_amount') then `zm`.`old_value` else NULL end)) AS `fixed_amount_old`,max((case when (`zm`.`col_name` = 'fixed_amount') then `zm`.`new_value` else NULL end)) AS `fixed_amount_new`,max((case when (`zm`.`col_name` = 'percentage') then `zm`.`old_value` else NULL end)) AS `percentage_old`,max((case when (`zm`.`col_name` = 'percentage') then `zm`.`new_value` else NULL end)) AS `percentage_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'term_types') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_term_types_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_term_types_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_term_types_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'term_types');

-- Volcando estructura para vista banana.zvw_audit_type_documents
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_type_documents`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_type_documents` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'name') then `zm`.`old_value` else NULL end)) AS `name_old`,max((case when (`zm`.`col_name` = 'name') then `zm`.`new_value` else NULL end)) AS `name_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'type_documents') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_type_documents_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_type_documents_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_type_documents_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'type_documents');

-- Volcando estructura para vista banana.zvw_audit_units
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_units`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_units` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'name') then `zm`.`old_value` else NULL end)) AS `name_old`,max((case when (`zm`.`col_name` = 'name') then `zm`.`new_value` else NULL end)) AS `name_new`,max((case when (`zm`.`col_name` = 'quantity') then `zm`.`old_value` else NULL end)) AS `quantity_old`,max((case when (`zm`.`col_name` = 'quantity') then `zm`.`new_value` else NULL end)) AS `quantity_new`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`old_value` else NULL end)) AS `archived_old`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`new_value` else NULL end)) AS `archived_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'units') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_units_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_units_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_units_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'units');

-- Volcando estructura para vista banana.zvw_audit_users
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_users`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_users` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'name') then `zm`.`old_value` else NULL end)) AS `name_old`,max((case when (`zm`.`col_name` = 'name') then `zm`.`new_value` else NULL end)) AS `name_new`,max((case when (`zm`.`col_name` = 'email') then `zm`.`old_value` else NULL end)) AS `email_old`,max((case when (`zm`.`col_name` = 'email') then `zm`.`new_value` else NULL end)) AS `email_new`,max((case when (`zm`.`col_name` = 'all_access_organization') then `zm`.`old_value` else NULL end)) AS `all_access_organization_old`,max((case when (`zm`.`col_name` = 'all_access_organization') then `zm`.`new_value` else NULL end)) AS `all_access_organization_new`,max((case when (`zm`.`col_name` = 'all_access_column') then `zm`.`old_value` else NULL end)) AS `all_access_column_old`,max((case when (`zm`.`col_name` = 'all_access_column') then `zm`.`new_value` else NULL end)) AS `all_access_column_new`,max((case when (`zm`.`col_name` = 'password') then `zm`.`old_value` else NULL end)) AS `password_old`,max((case when (`zm`.`col_name` = 'password') then `zm`.`new_value` else NULL end)) AS `password_new`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`old_value` else NULL end)) AS `archived_old`,max((case when (`zm`.`col_name` = 'archived') then `zm`.`new_value` else NULL end)) AS `archived_new`,max((case when (`zm`.`col_name` = 'remember_token') then `zm`.`old_value` else NULL end)) AS `remember_token_old`,max((case when (`zm`.`col_name` = 'remember_token') then `zm`.`new_value` else NULL end)) AS `remember_token_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'contact_id') then `zm`.`old_value` else NULL end)) AS `contact_id_old`,max((case when (`zm`.`col_name` = 'contact_id') then `zm`.`new_value` else NULL end)) AS `contact_id_new`,max((case when (`zm`.`col_name` = 'image_name') then `zm`.`old_value` else NULL end)) AS `image_name_old`,max((case when (`zm`.`col_name` = 'image_name') then `zm`.`new_value` else NULL end)) AS `image_name_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'users') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_users_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_users_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_users_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'users');

-- Volcando estructura para vista banana.zvw_audit_warehouses
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_warehouses`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_warehouses` AS select `za`.`audit_id` AS `audit_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`za`.`timestamp` AS `timestamp`,max((case when (`zm`.`col_name` = 'id') then `zm`.`old_value` else NULL end)) AS `id_old`,max((case when (`zm`.`col_name` = 'id') then `zm`.`new_value` else NULL end)) AS `id_new`,max((case when (`zm`.`col_name` = 'organization_id') then `zm`.`old_value` else NULL end)) AS `organization_id_old`,max((case when (`zm`.`col_name` = 'organization_id') then `zm`.`new_value` else NULL end)) AS `organization_id_new`,max((case when (`zm`.`col_name` = 'reference') then `zm`.`old_value` else NULL end)) AS `reference_old`,max((case when (`zm`.`col_name` = 'reference') then `zm`.`new_value` else NULL end)) AS `reference_new`,max((case when (`zm`.`col_name` = 'name') then `zm`.`old_value` else NULL end)) AS `name_old`,max((case when (`zm`.`col_name` = 'name') then `zm`.`new_value` else NULL end)) AS `name_new`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`old_value` else NULL end)) AS `created_at_old`,max((case when (`zm`.`col_name` = 'created_at') then `zm`.`new_value` else NULL end)) AS `created_at_new`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`old_value` else NULL end)) AS `updated_at_old`,max((case when (`zm`.`col_name` = 'updated_at') then `zm`.`new_value` else NULL end)) AS `updated_at_new`,max((case when (`zm`.`col_name` = 'notes') then `zm`.`old_value` else NULL end)) AS `notes_old`,max((case when (`zm`.`col_name` = 'notes') then `zm`.`new_value` else NULL end)) AS `notes_new`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`old_value` else NULL end)) AS `created_by_old`,max((case when (`zm`.`col_name` = 'created_by') then `zm`.`new_value` else NULL end)) AS `created_by_new`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`old_value` else NULL end)) AS `updated_by_old`,max((case when (`zm`.`col_name` = 'updated_by') then `zm`.`new_value` else NULL end)) AS `updated_by_new` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'warehouses') group by `zm`.`audit_id`;

-- Volcando estructura para vista banana.zvw_audit_warehouses_meta
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `zvw_audit_warehouses_meta`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `zvw_audit_warehouses_meta` AS select `za`.`audit_id` AS `audit_id`,`zm`.`audit_meta_id` AS `audit_meta_id`,`za`.`user` AS `user`,`za`.`pk1` AS `pk1`,`za`.`pk2` AS `pk2`,`za`.`action` AS `action`,`zm`.`col_name` AS `col_name`,`zm`.`old_value` AS `old_value`,`zm`.`new_value` AS `new_value`,`za`.`timestamp` AS `timestamp` from (`zaudit` `za` join `zaudit_meta` `zm` on((`za`.`audit_id` = `zm`.`audit_id`))) where (`za`.`table_name` = 'warehouses');

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
