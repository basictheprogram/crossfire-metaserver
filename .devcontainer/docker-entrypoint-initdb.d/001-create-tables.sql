USE metaserver;
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> e69ad672795b1eaddf924824b29df86eadd24b47

CREATE TABLE `blacklist` (
	  `entry` INT NOT NULL auto_increment,
	  `hostname` varchar(80),
	  PRIMARY KEY  (`entry`)
);

CREATE TABLE `servers` (
	  `entry` INT NOT NULL auto_increment,
<<<<<<< HEAD
=======
=======
CREATE TABLE `servers` (
	  `entry` int(11) NOT NULL auto_increment,
>>>>>>> dfdac81 (feat: Add development container setup with Docker and VSCode)
>>>>>>> e69ad672795b1eaddf924824b29df86eadd24b47
	  `hostname` varchar(80),
	  `port` int(11),
	  `html_comment` varchar(1024),
	  `text_comment` varchar(256),
	  `archbase` varchar(64),
	  `mapbase` varchar(64),
	  `codebase` varchar(64),
	  `flags` varchar(20),
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> e69ad672795b1eaddf924824b29df86eadd24b47
	  `num_players` int,
	  `in_bytes` int,
	  `out_bytes` int,
	  `uptime` int,
<<<<<<< HEAD
=======
=======
	  `num_players` int(11),
	  `in_bytes` int(11),
	  `out_bytes` int(11),
	  `uptime` int(11),
>>>>>>> dfdac81 (feat: Add development container setup with Docker and VSCode)
>>>>>>> e69ad672795b1eaddf924824b29df86eadd24b47
	  `version` varchar(64),
	  `sc_version` varchar(20),
	  `cs_version` varchar(20),
	  `last_update` datetime,
<<<<<<< HEAD
	  PRIMARY KEY  (`entry`)
);
=======
<<<<<<< HEAD
	  PRIMARY KEY  (`entry`)
);
=======
	  PRIMARY KEY  (`entry`))
>>>>>>> dfdac81 (feat: Add development container setup with Docker and VSCode)
>>>>>>> e69ad672795b1eaddf924824b29df86eadd24b47
