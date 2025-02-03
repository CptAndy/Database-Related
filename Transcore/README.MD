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
