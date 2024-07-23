USE metaserver;

CREATE TABLE `blacklist` (
	  `entry` INT NOT NULL auto_increment,
	  `hostname` varchar(80),
	  PRIMARY KEY  (`entry`)
);

CREATE TABLE `servers` (
	  `entry` INT NOT NULL auto_increment,
	  `hostname` varchar(80),
	  `port` int(11),
	  `html_comment` varchar(1024),
	  `text_comment` varchar(256),
	  `archbase` varchar(64),
	  `mapbase` varchar(64),
	  `codebase` varchar(64),
	  `flags` varchar(20),
	  `num_players` int,
	  `in_bytes` int,
	  `out_bytes` int,
	  `uptime` int,
	  `version` varchar(64),
	  `sc_version` varchar(20),
	  `cs_version` varchar(20),
	  `last_update` datetime,
	  PRIMARY KEY  (`entry`)
);

