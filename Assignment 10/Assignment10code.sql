/*Check user*/

select current_user;

/*Create new user*/

CREATE USER 'karin'@'localhost' IDENTIFIED BY 'cgs2545$%';

/*Verify new user*/

select host, user, select_priv, insert_priv,
update_priv, delete_priv, create_priv, drop_priv from mysql.user;

/*Grant user permission to select*/

GRANT SELECT, INSERT, UPDATE on * to 'karin'@'localhost';

/*Verify user permissions*/

SHOW GRANTS FOR 'karin'@'localhost';

/*User change from root to karin*/

system mysql -u karin -p

/*use cruise*/

use cruise;

/*Delete using karin*/

Delete from timesheet