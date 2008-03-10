--
-- Data from XML files etc.
--

CREATE TABLE `consinfo` (
  `constituency` varchar(100) NOT NULL default '',
  `data_key` varchar(100) NOT NULL default '',
  `data_value` text NOT NULL,
  UNIQUE KEY `consinfo_constituency_data_key` (`constituency`,`data_key`),
  KEY `constituency` (`constituency`)
);

CREATE TABLE `constituency` (
  `name` varchar(100) NOT NULL default '',
  `main_name` tinyint(1) NOT NULL default '0',
  `from_date` date NOT NULL default '1000-01-01',
  `to_date` date NOT NULL default '9999-12-31',
  `cons_id` int(11) default NULL,
  KEY `from_date` (`from_date`),
  KEY `to_date` (`to_date`),
  KEY `name` (`name`),
  KEY `constituency` (`cons_id`)
);

CREATE TABLE `epobject` (
  `epobject_id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `body` mediumtext,
  `type` int(11) default NULL,
  `created` datetime default NULL,
  `modified` datetime default NULL,
  PRIMARY KEY  (`epobject_id`),
  KEY `type` (`type`)
);

CREATE TABLE `gidredirect` (
  `gid_from` char(60) default NULL,
  `gid_to` char(60) default NULL,
  `hdate` date NOT NULL default '0000-00-00',
  `major` int(11) default NULL,
  UNIQUE KEY `gid_from` (`gid_from`),
  KEY `gid_to` (`gid_to`)
);

CREATE TABLE `hansard` (
  `epobject_id` int(11) NOT NULL default '0',
  `gid` varchar(100) default NULL,
  `htype` int(11) NOT NULL default '0',
  `speaker_id` int(11) NOT NULL default '0',
  `major` int(11) NOT NULL default '0',
  `section_id` int(11) NOT NULL default '0',
  `subsection_id` int(11) NOT NULL default '0',
  `hpos` int(11) NOT NULL default '0',
  `hdate` date NOT NULL default '0000-00-00',
  `htime` time default NULL,
  `source_url` varchar(255) NOT NULL default '',
  `minor` int(11) default NULL,
  `created` datetime default NULL,
  `modified` datetime default NULL,
  PRIMARY KEY  (`epobject_id`),
  UNIQUE KEY `gid` (`gid`),
  KEY `epobject_id` (`epobject_id`),
  KEY `subsection_id` (`subsection_id`),
  KEY `section_id` (`section_id`),
  KEY `hdate` (`hdate`),
  KEY `speaker_id` (`speaker_id`),
  KEY `hansard_speaker_id_hdate_hpos` (`speaker_id`,`hdate`,`hpos`),
  KEY `major` (`major`),
  KEY `htype` (`htype`),
  KEY `majorhdate` (`major`,`hdate`),
  KEY `modified` (`modified`),
  KEY `source_url` (`source_url`)
);

CREATE TABLE `member` (
  `member_id` int(11) NOT NULL default '0',
  `house` int(11) default NULL,
  `first_name` varchar(100) default NULL,
  `last_name` varchar(255) NOT NULL default '',
  `constituency` varchar(100) NOT NULL default '',
  `party` varchar(100) NOT NULL default '',
  `entered_house` date NOT NULL default '1000-01-01',
  `left_house` date NOT NULL default '9999-12-31',
  `entered_reason` enum('unknown','general_election','by_election','changed_party','reinstated','appointed','devolution','election','accession','regional_election','replaced_in_region','became_presiding_officer') NOT NULL default 'unknown',
  `left_reason` enum('unknown','still_in_office','general_election','general_election_standing','general_election_not_standing','changed_party','died','declared_void','resigned','disqualified','became_peer','devolution','dissolution','retired','regional_election','became_presiding_officer') NOT NULL default 'unknown',
  `person_id` int(11) NOT NULL default '0',
  `title` varchar(50) NOT NULL default '',
  `lastupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`member_id`),
  UNIQUE KEY `first_name` (`first_name`,`last_name`,`constituency`,`entered_house`,`left_house`),
  KEY `person_id` (`person_id`),
  KEY `constituency` (`constituency`),
  KEY `house` (`house`),
  KEY `left_house_house` (`left_house`,`house`)
);

CREATE TABLE `memberinfo` (
  `member_id` int(11) NOT NULL default '0',
  `data_key` varchar(100) NOT NULL default '',
  `data_value` text NOT NULL,
  `lastupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  UNIQUE KEY `memberinfo_member_id_data_key` (`member_id`,`data_key`),
  KEY `member_id` (`member_id`)
);

CREATE TABLE `moffice` (
  `moffice_id` int(11) NOT NULL auto_increment,
  `dept` varchar(100) NOT NULL default '',
  `position` varchar(200) NOT NULL default '',
  `from_date` date NOT NULL default '1000-01-01',
  `to_date` date NOT NULL default '9999-12-31',
  `person` int(11) default NULL,
  `source` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`moffice_id`),
  KEY `person` (`person`)
);

CREATE TABLE `personinfo` (
  `person_id` int(11) NOT NULL default '0',
  `data_key` varchar(100) NOT NULL default '',
  `data_value` text NOT NULL,
  `lastupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  UNIQUE KEY `personinfo_person_id_data_key` (`person_id`,`data_key`),
  KEY `person_id` (`person_id`)
);

CREATE TABLE `postcode_lookup` (
  `postcode` varchar(10) NOT NULL default '',
  `name` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`postcode`)
);

-- each time we index, we increment the batch number;
-- can use this to speed up search
CREATE TABLE `indexbatch` (
  `indexbatch_id` int(11) NOT NULL auto_increment,
  `created` datetime default NULL,
  PRIMARY KEY  (`indexbatch_id`)
);

-- For Public Bill Committees originally
CREATE TABLE `bills` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `url` varchar(255) NOT NULL default '',
  `lords` tinyint(1) NOT NULL default '0',
  `session` varchar(50) NOT NULL default '',
  `standingprefix` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `title` (`title`)
);

CREATE TABLE `pbc_members` (
  `id` int(11) NOT NULL auto_increment,
  `member_id` int(11) NOT NULL default '0',
  `chairman` tinyint(1) NOT NULL default '0',
  `bill_id` int(11) NOT NULL default '0',
  `sitting` varchar(4) NOT NULL default '',
  `attending` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `member_id` (`member_id`),
  KEY `bill_id` (`bill_id`)
);

CREATE TABLE `titles` (
  `title` varchar(190) NOT NULL default '',
  PRIMARY KEY  (`title`)
);

--
-- User content tables
--

CREATE TABLE `alerts` (
  `alert_id` mediumint(8) unsigned NOT NULL auto_increment,
  `email` varchar(255) NOT NULL default '',
  `criteria` varchar(255) NOT NULL default '',
  `deleted` tinyint(1) NOT NULL default '0',
  `registrationtoken` varchar(34) NOT NULL default '',
  `confirmed` tinyint(1) NOT NULL default '0',
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`alert_id`),
  KEY `email` (`email`),
  KEY `confirmed` (`confirmed`,`deleted`)
);

CREATE TABLE `anonvotes` (
  `epobject_id` int(10) unsigned NOT NULL default '0',
  `yes_votes` int(10) unsigned NOT NULL default '0',
  `no_votes` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`epobject_id`)
);

CREATE TABLE `commentreports` (
  `report_id` int(11) NOT NULL auto_increment,
  `comment_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `body` text,
  `reported` datetime default NULL,
  `resolved` datetime default NULL,
  `resolvedby` int(11) default NULL,
  `locked` datetime default NULL,
  `lockedby` int(11) default NULL,
  `upheld` tinyint(1) NOT NULL default '0',
  `firstname` varchar(50) default NULL,
  `lastname` varchar(50) default NULL,
  `email` varchar(100) default NULL,
  PRIMARY KEY  (`report_id`)
);

CREATE TABLE `comments` (
  `comment_id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL default '0',
  `epobject_id` int(11) NOT NULL default '0',
  `body` text,
  `posted` datetime default NULL,
  `modflagged` datetime default NULL,
  `visible` tinyint(1) NOT NULL default '0',
  `original_gid` varchar(60) default NULL,
  PRIMARY KEY  (`comment_id`),
  KEY `user_id` (`user_id`,`epobject_id`,`visible`),
  KEY `epobject_id` (`epobject_id`,`visible`),
  KEY `visible` (`visible`)
);

CREATE TABLE `editqueue` (
  `edit_id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `edit_type` int(11) default NULL,
  `epobject_id_l` int(11) default NULL,
  `epobject_id_h` int(11) default NULL,
  `glossary_id` int(11) default NULL,
  `time_start` datetime default NULL,
  `time_end` datetime default NULL,
  `title` varchar(255) default NULL,
  `body` text,
  `submitted` datetime default NULL,
  `editor_id` int(11) default NULL,
  `approved` tinyint(1) default NULL,
  `decided` datetime default NULL,
  `reason` varchar(255) default NULL,
  PRIMARY KEY  (`edit_id`),
  KEY `approved` (`approved`),
  KEY `glossary_id` (`glossary_id`)
);

CREATE TABLE `glossary` (
  `glossary_id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `body` text,
  `wikipedia` varchar(255) default NULL,
  `created` datetime default NULL,
  `last_modified` datetime default NULL,
  `type` int(2) default NULL,
  `visible` tinyint(4) default NULL,
  PRIMARY KEY  (`glossary_id`),
  KEY `visible` (`visible`)
);

CREATE TABLE `search_query_log` (
  `id` int(11) NOT NULL auto_increment,
  `query_string` text,
  `page_number` int(11) default NULL,
  `count_hits` int(11) default NULL,
  `ip_address` text,
  `query_time` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `query_time` (`query_time`)
);

CREATE TABLE `trackbacks` (
  `trackback_id` int(11) NOT NULL auto_increment,
  `epobject_id` int(11) default NULL,
  `blog_name` varchar(255) default NULL,
  `title` varchar(255) default NULL,
  `excerpt` varchar(255) default NULL,
  `url` varchar(255) default NULL,
  `posted` datetime default NULL,
  `visible` tinyint(1) NOT NULL default '0',
  `source_ip` varchar(20) default NULL,
  PRIMARY KEY  (`trackback_id`),
  KEY `visible` (`visible`)
);

CREATE TABLE `users` (
  `user_id` mediumint(9) NOT NULL auto_increment,
  `firstname` varchar(255) NOT NULL default '',
  `lastname` varchar(255) NOT NULL default '',
  `email` varchar(255) NOT NULL default '',
  `password` varchar(34) NOT NULL default '',
  `lastvisit` datetime NOT NULL default '0000-00-00 00:00:00',
  `registrationtime` datetime NOT NULL default '0000-00-00 00:00:00',
  `registrationip` varchar(20) default NULL,
  `status` enum('Viewer','User','Moderator','Administrator','Superuser') default 'Viewer',
  `emailpublic` tinyint(1) NOT NULL default '0',
  `optin` tinyint(1) NOT NULL default '0',
  `deleted` tinyint(1) NOT NULL default '0',
  `postcode` varchar(10) NOT NULL default '',
  `registrationtoken` varchar(24) NOT NULL default '',
  `confirmed` tinyint(1) NOT NULL default '0',
  `url` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`user_id`),
  KEY `email` (`email`)
);

CREATE TABLE `uservotes` (
  `user_id` int(10) unsigned NOT NULL default '0',
  `epobject_id` int(11) NOT NULL default '0',
  `vote` tinyint(1) NOT NULL default '0',
  KEY `epobject_id` (`epobject_id`,`vote`)
);
