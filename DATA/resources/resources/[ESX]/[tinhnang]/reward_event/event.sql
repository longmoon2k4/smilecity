ALTER TABLE `users`  ADD COLUMN  `eventpoint` int(11) NOT NULL DEFAULT 0;
ALTER TABLE `users`  ADD COLUMN  `eventtime` int(50) NOT NULL DEFAULT 0;
ALTER TABLE `users`  ADD COLUMN  `eventpremium` int(1) NOT NULL DEFAULT 0;
ALTER TABLE `users`  ADD COLUMN  `eventdata` longtext DEFAULT '[]';
ALTER TABLE `users`  ADD COLUMN  `eventdaily` longtext DEFAULT '[]';


INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
    (   'premium_pass', 'Premium Event Pass' , -1, 0, 1)
;      