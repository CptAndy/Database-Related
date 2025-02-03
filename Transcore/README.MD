# **TransCore DB**

## **Overview**
A more refined take on a previous database assignment. Making use of more advanced queries such as IN, LIKE, IN, and Subqueries. Overall taking a more structured approach with effeciency in mind using the innoDB engine provided in MySQL to produce an MWB and forward engineering it to create the script.
## Database Schema

### **Tables**

1. **priority** - Defines priority levels (P0 - P4) to manage task importance.
2. **requirements** - Stores requirement details, ensuring unique requirement numbers and descriptions.
3. **status** - Tracks project statuses (e.g., Not Started, Active, Completed, etc.).
4. **tracking** - Links requirements, priorities, and statuses for tracking purposes.
#

### **Views**

1. **v_progress_log** - Keeps count/track of what needs to be done
2. **v_tracking_log** - Tracks each requirement and its current status as well as priority level
#

### SQL Queries

#### UPDATE priority in tracking

```sql
UPDATE tracking
SET pri_id = (SELECT pri_id FROM priority WHERE pri_num = 'p4');
```
#### UPDATE status in tracking

```sql
-- Begin as not started
UPDATE tracking 
SET status_id = (SELECT status_id FROM status WHERE status_desc = 'Not started');

-- Set every even track_id to 'On Track'
UPDATE tracking 
SET status_id = (SELECT status_id FROM status WHERE status_desc = 'On Track')
WHERE track_id % 2 = 0;

-- Set specific track_ids to 'At Risk'
UPDATE tracking 
SET status_id = (SELECT status_id FROM status WHERE status_desc = 'At Risk')
WHERE track_id IN (163, 157, 57, 37, 154, 142, 56, 99, 139, 106);

-- Set requirements containing 'The Operator' to 'Completed'
UPDATE tracking 
SET status_id = (SELECT status_id FROM status WHERE status_desc = 'Completed')
WHERE track_id IN (SELECT req_id FROM requirements WHERE req_desc LIKE '%The Operator%');

-- Set requirements starting with 'An icon' to 'Off Track'
UPDATE tracking 
SET status_id = (SELECT status_id FROM status WHERE status_desc = 'Off Track')
WHERE track_id IN (SELECT req_id FROM requirements WHERE req_desc LIKE 'An icon%');
```
#### UPDATE priority in tracking
```sql
UPDATE tracking 
SET pri_id = (SELECT pri_id FROM priority WHERE pri_num = 'p0') WHERE track_id % 2;

UPDATE tracking 
SET pri_id = (SELECT pri_id FROM priority WHERE pri_num = 'p1') 
WHERE track_id IN (163, 157, 57, 37, 154, 142, 56, 99, 139, 106);

UPDATE tracking 
SET pri_id = (SELECT pri_id FROM priority WHERE pri_num = 'p2') 
WHERE track_id IN (SELECT req_id FROM requirements WHERE req_desc LIKE '%The Operator%');

UPDATE tracking 
SET pri_id = (SELECT pri_id FROM priority WHERE pri_num = 'p3') 
WHERE track_id IN (SELECT req_id FROM requirements WHERE req_desc LIKE '%An icon%');
```
#

# Views
The tables here keep track of the data in a way thats easty to understand for the user.
#### tracking log
```sql
-- Keeps track of the different tasks and presents them in a readable format
CREATE VIEW V_tracking_log AS
SELECT 
  t.track_id AS "Tracking No.", 
  r.req_num AS "Section", 
  r.req_desc AS "Description", 
  s.status_desc AS "Status", 
  p.pri_text AS "Priority" 
FROM 
  tracking t 
  JOIN requirements r ON t.req_id = r.req_id 
  JOIN priority p ON t.pri_id = p.pri_id 
  JOIN status s ON t.status_id = s.status_id 
ORDER BY 
  track_id ASC;
```
#### progress log
```sql
-- This takes the percentages of the different statuses 
-- Displays it in readable way

CREATE VIEW v_progress_log AS
SELECT 
  s.status_desc AS "Status", 
  COUNT(s.status_desc) AS "Current Progress", 
  ROUND(
    COUNT(s.status_desc)/ 196 * 100, 2) AS "Current Progress %" 
FROM 
  status s 
  JOIN tracking t ON s.status_id = t.status_id 
GROUP BY 
  s.status_desc -- WITH ROLLUP to ensure data is accurate 
ORDER BY
s.status_id DESC; 
```
#
##### Author: Anderson Mota
