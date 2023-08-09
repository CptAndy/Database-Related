/*database*/ 
DROP DATABASE IF EXISTS transcore;
DROP VIEW IF EXISTS trackingView;


CREATE DATABASE TransCore;

USE TransCore;


/*Create table requirement*/

CREATE TABLE requirements(
/*id for sorting purposes*/
 req_id INT NOT NULL AUTO_INCREMENT,
/*Requirement number*/
RequirementNumber VARCHAR(20),
/*requirement text*/
RequirementText VARCHAR(500),
    
    PRIMARY KEY(req_id)
);

/*Create table priority*/
CREATE TABLE priority(
    priority_id INT NOT NULL AUTO_INCREMENT,
/* priority value*/
    PriorityValue int,
/*priority text*/
 PriorityText varchar(55),
    
    PRIMARY KEY(priority_id)
);

/*Create table status*/
CREATE TABLE status(
status_id INT NOT NULL AUTO_INCREMENT,
    /*Status Value*/
    StatusValue int,
    /*Status text*/
    StatusText varchar(255),
    
    PRIMARY KEY(status_id)
);


/*Create table tracking*/
/*Table tracking containing foreign keys to tables requirement, priority
and status to provide data analysis of the requirements, requirement
priority, and requirement status*/
CREATE TABLE tracking(
tracking_id INT NOT NULL AUTO_INCREMENT,
     req_id INT,
    priority_id INT,
    status_id INT,
    FOREIGN KEY(req_id)REFERENCES requirements(req_id),
    FOREIGN KEY(priority_id)REFERENCES priority(priority_id),
    FOREIGN KEY(status_id) REFERENCES status(status_id),
PRIMARY KEY(tracking_id)
);

/*Insert values into requirements*/
INSERT INTO requirements (RequirementNumber, RequirementText)
VALUES 
/*Start of 3.2.1.1*/
('3.2.1.1.1', 'An icon shall be selected during detailed design to show a gate in a closed position.'),
  ('3.2.1.1.2', 'An icon shall be selected during detailed design to show a gate in an open position.'),
  ('3.2.1.1.3', 'An icon shall be selected during detailed design to show a gate in a partially open (15%) position.'),
  ('3.2.1.1.4', 'The gate icon shall be configurable to show the name of the gate with the icon.'),
  ('3.2.1.1.5', 'The gate icon shall be configurable to show the state of the gate (e.g., open or close).'),
  ('3.2.1.1.6', 'The gate icon shall be configurable to show the status of the gate (operational, failed, or no data). The color of the gate icon shall be changed to show the status of the gate.'),

('3.2.1.1.7', 'When the operator moves the mouse over a gate icon a text window shall be displayed showing a summary of the gate status. The details of the summary status display will be defined in the GUI design document.'),
  ('3.2.1.1.8', 'The operator shall be able to activate a detailed device status window for the selected gate by double left clicking on the icon. This action shall cause a circle to be displayed over the gate icon for as long as the detailed device status window is displayed for that gate.'),
  ('3.2.1.1.9', 'The operator shall be able to activate a device control window for the selected gate by right clicking on the icon. The right click on the icons shall display a pop-up menu of available device actions from which the user may select. This action shall cause a circle to be displayed over the gate icon for as long as the device control window is displayed for that gate.'),
  ('3.2.1.1.9.1', 'If operation of the device is locked out for safety reasons a command option will be "grayed out" and not selectable.'),

/*Start of 3.2.1.2*/
  ('3.2.1.2.1', 'An icon shall be selected during detailed design to indicate a group of popups in an "Up" or entrance closed position.'),
  ('3.2.1.2.2', 'An icon shall be selected during detailed design to indicate a group of popups in a "Down" or entrance opened position.'),
  ('3.2.1.2.3', 'An icon shall be selected during detailed design to indicate a failure status when some popups in a group are in a "Down" position and some popups in the same group are in an "Up" position.'),
  ('3.2.1.2.4', 'The popup icon shall be configurable to display the name of the popup group.'),
  ('3.2.1.2.5', 'The popup icon shall be configurable to display the state of the popup group (up or down).'),
  ('3.2.1.2.6', 'The popup icon shall be configurable to display the status of the popup group. The color of the icon shall be changed to show the status of the popup group.'),
  ('3.2.1.2.7', 'When the operator moves the mouse over a popup icon a text window shall be displayed showing a summary of the popup group status. The details of the status display will be defined in the GUI design document.'),
('3.2.1.2.8', 'The operator shall be able to activate a detailed device status window for the selected popup group by double left clicking on the icon. A circle shall be displayed over the icon as long as the detailed status window is displayed for the icon.'),
  ('3.2.1.2.9', 'The operator shall be able to activate a device control window for the selected popup by right clicking on the icon. The right click on the icon shall display a pop-up menu of available device actions from which the user may select. A circle shall be displayed over the icon as long as the device control window is displayed for the icon.'),
  ('3.2.1.2.9.1', 'If operation of the device is locked out for safety reasons a command option will be "grayed out" and not selectable.'),
  
  /*Start of 3.2.1.3*/
  ('3.2.1.3.1', 'An icon shall be selected during detailed design to indicate changeable message signs.'),
  ('3.2.1.3.2', 'An icon shall be selected during detailed design to indicate a changeable message sign that is displaying a message.'),
  ('3.2.1.3.3', 'The CMS icon shall be configurable to display the name of the sign with the icon.'),
  ('3.2.1.3.4', 'The CMS icon shall be configurable to display an abbreviated message text with the icon.'),
  ('3.2.1.3.5', 'The CMS icon shall be configurable to display the status of the sign associated with the icon. The CMS icon color shall represent the operational status of the CMS sign: green for operational, yellow for operational with errors, gray for no communications and red for failed.'),
  ('3.2.1.3.6', 'If the operator moves the mouse over the CMS icon then a text window shall be displayed with a summary of the operational state and status of the sign and the text of any message being displayed on the sign.'),
  ('3.2.1.3.7', 'The operator shall be able to activate a detailed device status window for the sign by double left clicking on the selected icon. A circle shall be displayed over the icon as long as the detailed device status window is displayed for that icon.'),

('3.2.1.3.8', 'The operator shall be able to activate a device control window for the CMS sign by right clicking on the selected icon. The right click on the icon shall display a pop-up menu of available device actions from which the user may select. A circle shall be displayed over the icon as long as the device control window is displayed for that icon.'),
  ('3.2.1.3.8.1', 'If operation of the device is locked out for safety reasons a command option will be "grayed out" and not selectable.'),
  ('3.2.1.4.1', 'An icon shall be selected to indicate a CCTV camera.'),
  ('3.2.1.4.2', 'The camera icon shall be configurable to show the name of the camera with the icon.'),
  ('3.2.1.4.3', 'The camera icon shall be configurable to show the state of the camera.'),
  ('3.2.1.4.4', 'The camera icon shall be configurable to show the status of the camera. The color of the camera icon shall be changed to show the status of the camera.'),
  ('3.2.1.4.5', 'When a user moves the mouse over a camera icon a text window shall be displayed showing a summary of the camera status.'),
  ('3.2.1.4.6', 'The user shall be able to activate a detailed device status window for the selected camera by double left clicking on the icon. This action shall cause a circle to be displayed over the camera icon for as long as the detailed device status window is displayed for that camera.'),
  ('3.2.1.4.7', 'The user shall be able to activate a device control window for the selected camera by right clicking on the icon. The right click on the icon shall display a pop-up menu of available device actions from which the user may select. This action shall cause a circle to be displayed over the camera icon for as long as the device control window is displayed for that camera.'),
  ('3.2.1.5.1', 'An icon shall be selected during detailed design to indicate a group of draw lights that are off.'),
  ('3.2.1.5.2', 'An icon shall be selected during detailed design to indicate a group of draw lights that are on.'),
  ('3.2.1.5.3', 'An icon shall be selected during detailed design to indicate a group of draw lights where some are on and some are off.'),
  ('3.2.1.5.4', 'The draw light icon shall be configurable to display the name of the draw lights.'),
  ('3.2.1.5.5', 'The draw light icon shall be configurable to display the state of the draw lights.'),
  ('3.2.1.5.6', 'The draw light icon shall be configurable to display the status of the draw lights. The color of the draw light icon shall represent the status of the draw light: green for operational, yellow for operational with errors, gray for no communications and red for failed.'),

  ('3.2.1.5.7', 'When the operator moves the mouse over a draw light icon a text window shall be displayed showing a summary of the status of the group of draw lights. The details of the status display will be defined in the GUI design document.'),
  ('3.2.1.5.8', 'The operator shall be able to activate a detailed device status window for the draw lights by double left clicking on the selected icon. A circle shall be displayed over the icon as long as the detailed device status window is displayed for that icon.'),
  ('3.2.1.5.9', 'The operator shall be able to activate a device control window for the draw lights by right clicking on the selected icon. The right click on the icon shall display a pop-up menu of available device actions from which the user may select. A circle shall be displayed over the icon as long as the device control window is displayed for that icon.'),
  ('3.2.1.5.9.1', 'If operation of the device is locked out for safety reasons the command option will be "grayed out" and not selectable.'),
  ('3.2.1.6.1', 'An icon shall be selected during detailed design to indicate a group of wrong way lights that are off.'),
  ('3.2.1.6.2', 'An icon shall be selected during detailed design to indicate a group of wrong way lights that are on.'),
  ('3.2.1.6.3', 'An icon shall be selected during detailed design to indicate a group of wrong way lights where some are on and some are off.'),
  ('3.2.1.6.4', 'The wrong way light icon shall be configurable to display the name of the draw lights.'),
  ('3.2.1.6.5', 'The wrong way light icon shall be configurable to display the state of the wrong way lights.'),
  ('3.2.1.6.6', 'The wrong way light icon shall be configurable to display the status of the group of wrong way lights. The color of the wrong way light icon shall represent the status of the wrong way light: green for operational, yellow for operational with errors, gray for no communications and red for failed.'),
  ('3.2.1.6.7', 'When the operator moves the mouse over a wrong way light icon a text window shall be displayed showing a summary of the status of the group of wrong way lights. The details of the status display will be defined in the GUI design document.'),
  ('3.2.1.6.8', 'The operator shall be able to activate a detailed device status window for the wrong way lights by double left clicking on the selected icon. A circle shall be displayed over the icon as long as the detailed device status window is displayed for that icon.'),
  ('3.2.1.6.9', 'The operator shall be able to activate the control window for the wrong way light by right clicking on the selected icon. The right click on the icon shall display a pop-up menu of available device actions from which the user may select. A circle shall be displayed over the icon as long as the device control window is displayed for that icon.'),
  ('3.2.1.6.9.1', 'If operation of the device is locked out for safety reasons, a command option will be "grayed out" and not selectable.'),
  ('3.2.1.7.1', 'An icon shall be selected during detailed design to indicate a loop detector.'),
  ('3.2.1.7.2', 'An icon shall be selected during detailed design to indicate a group of loop detectors.'),
  ('3.2.1.7.3', 'The loop detector and group detector icons shall use color to indicate either speed, volume, or occupancy is within a specified range or if no data is available from the detector or from all loop detectors in a group.'),
  ('3.2.1.7.4', 'The color used to indicate a range shall be configurable.'),
  ('3.2.1.7.5', 'The data being displayed by color shall be configurable.'),
  ('3.2.1.7.6', 'The range being displayed by color shall be configurable.'),
  ('3.2.1.7.7', 'The operator shall be able to configure the color, the range, and/or the data type without restarting the application.'),
('3.2.1.7.8', 'The loop detector icon shall be configurable to display the name of the loop detector.'),
    ('3.2.1.7.9', 'The loop detector icon shall be configurable to display the N second volume, speed, and occupancy values as text associated with the icon. The value of N shall be configurable.'),
    ('3.2.1.7.10', 'The group detector icon shall be configurable to display the name of the detector group name as text with the icon.'),
    ('3.2.1.7.11', 'The group detector icon shall be configurable to display the N second average of volume, speed, and occupancy for all detectors in the group as text with the icon. The value of N shall be configurable.'),
    ('3.2.1.7.12', 'The detector loop icon shall be configurable to display the status of the loop detector or group of loop detectors.'),
    ('3.2.1.7.13', 'When the operator moves the mouse over a detector loop icon, a text window shall be displayed showing a summary of the status of the loop detector or the group of detector loops. The details of the status display will be defined in the GUI design document.'),
    ('3.2.1.7.14', 'The operator shall be able to activate a detailed device status window for the loop or group of loops by double left clicking on the selected icon. A circle shall be displayed over the icon as long as the detailed device status window for that icon.'),
('3.2.1.8.1', 'Icons shall be selected during detailed design to represent the FCUs and the DCU/MCUs.'),
    ('3.2.1.8.2', 'The FCU icon and the DCU/MCU icon shall be configurable to show the name of the site with the icon.'),
    ('3.2.1.8.3', 'The icons shall be configurable to show the status of the equipment at the site. The color of the icons shall be changed to show the status of the equipment.'),
    ('3.2.1.8.4', 'When the operator moves the mouse over an FCU or DCU/MCU icon, a text window shall be displayed showing a summary of the site status. The details of the status display will be defined in the GUI design document.'),
    ('3.2.1.8.5', 'The operator shall be able to activate a detailed device status window for the selected site by double left clicking on the icon. This action shall cause a circle to be displayed over the icon for as long as the detailed device status window is displayed for that site.'),
('3.2.1.9.1', 'An icon shall represent the end point of the HOV lanes (North and South). The icon shall have different shapes to represent that the end point is closed, open Southbound, or open Northbound.'),
  ('3.2.1.9.2', 'The end point icon shall be configurable to show the name of the end point associated with the icon.'),
  ('3.2.1.9.3', 'The end point icon shall be configurable to show the state of the end point associated with the icon.'),
  ('3.2.1.9.4', 'The end point icon shall be configurable to show the status of the end point. The color of the icon shall be changed to show the status of the end point.'),
  ('3.2.1.9.5', 'When the operator moves the mouse over an end point icon a text window shall be displayed showing a summary of the end point status. The details of the summary status display will be defined in the GUI design document.'),
  ('3.2.1.9.6', 'The operator shall be able to activate a detailed device status window for the selected end point by double left clicking on the icon. This action shall cause a circle to be displayed over the icon for as long as the detailed device status window is displayed for that end point.'),
  ('3.2.1.10.1', 'An icon shall be selected during detailed design to represent active incidents.'),
  ('3.2.1.10.2', 'The incident icon shall be configurable to display the state of the incident.'),
  ('3.2.1.10.3', 'When the operator moves the mouse over an incident icon a text window shall be displayed showing a summary of the incident state. The details of the summary state display will be defined in the GUI design document.'),
  ('3.2.1.10.4', 'The operator shall be able to activate a detailed incident state window for the selected incident by double left clicking on the icon. This action shall cause a circle to be displayed over the incident icon for as long as the detailed device status window is displayed for that incident.'),
  ('3.2.1.10.5', 'The operator shall be able to activate an edit window for the selected incident by right clicking on the icon. This action shall cause a circle to be displayed over the incident icon for as long as the edit window is displayed for that incident.'),
/*END OF 3.2*/

('3.3.1.1', 'The map window shall be displayed the HOV lanes, the adjacent lanes of I-15 and SR 163, crossing streets and their interchange, if any, and icons.'),
('3.3.1.2', 'Three map window shall be provided: one showing the entire length of the HOV lanes, one showing a detail of the south end of the HOV lanes and one showing a detail of the North end of the HOV lanes.'),
('3.3.1.3', 'Caltrans shall be able to create new maps using a commercial off the shelf (COTS) software package and place a device icons on the map.'),
('3.3.2.1', 'The Command Toolbar shall allow a user to select a window for display.'),
('3.3.2.2', 'The Command Toolbar shall always be displayed to the user.'),
('3.3.2.3', 'The Command Toolbar shall only display valid commands.'),
('3.3.3.1', 'Menu'),
('3.3.3.1.1', 'The device control window shall display a three level menu allowing the operator to select the device to be commanded.'),
('3.3.3.1.1.1', 'The first level shall be the device type selections: CMS, draw light, gate, pop-up, etc.'),
('3.3.3.1.1.2', 'The second level shall be a list of specific devices of that type that are available to be commanded.'),
('3.3.3.1.1.3', 'The third level shall be a list of available commands (if any) for the selected device.'),
('3.3.3.1.2', 'Once the device type, device and command have been selected via the menu system the operator shall be presented with a form for the completion of any parameters for the command.'),
('3.3.3.1.3', 'The device command completion form shall have a button labeled “Perform Action” to allow the operator to execute the command.'),
('3.3.3.1.3.1', 'The “Perform Action” button shall be grayed out and unselectable until the device command form has been filled out.'),
('3.3.3.1.3.2', 'The “Perform Action” button shall log the command submittal.'),
('3.3.3.1.4', 'The device command completion form shall have a button labeled “Cancel Command” to allow the operator to stop the completion of the command.'),
('3.3.3.2', 'Confirmation Dialog'),
('3.3.3.2.1', 'Any device control action that involves human safety shall use a confirmation dialog to validate the action.'),
('3.3.3.2.1.1', 'All device actions defined in the detailed design shall be classified as either involving human safety or not involving human safety.'),
('3.3.3.2.1.2', 'The default classification shall be that the device action involves human safety.'),
('3.3.3.2.2', 'The required validation method (if any) shall be displayed with the confirmation dialog.'),
('3.3.3.2.3', 'The confirmation dialog shall specify the action and prompt the user for a YES or NO to continue.'),
('3.3.3.2.4', 'The confirmation dialog shall default to NO.'),
('3.3.3.3', 'The action and the confirmation shall be displayed in the System Log window.'),
('3.3.3.4', 'The device control window shall display any returned device status resulting from the device control command.'),
('3.3.3.5', 'If the requested device control command results in multiple steps at the field control level, the intermediate steps and their status shall be displayed in the device control window.'),
('3.3.4.1', 'The summary device status window shall display a text and graphic summary presentation on the status of the selected device or group of devices.'),
('3.3.5.1', 'The detailed device status window shall display a text and graphic presentation on the status of the selected device or group of devices.'),
('3.3.5.2', 'The detailed device status window shall allow a user to select more detailed status information on an individual device.'),
('3.3.5.3', 'The operator shall be able to call up a device control window for any device shown on the device status window.'),
('3.3.5.4', 'The summary device status window shall have a menu bar with File and Help as a minimum.'),
('3.3.5.4.1', 'The File menu item shall include an option to open a command window for the selected device.'),
('3.3.5.4.2', 'The File menu item shall include an option to open a detailed status window for the selected device.'),
('3.3.5.4.3', 'The File menu item shall include an option to print the summary device status page.'),
('3.3.5.4.4', 'The Help menu item shall activate the on-line help system.'),
('3.3.5.5', 'The summary device status window shall display a list of all devices along with a miniature icon of the device color coded with the device status. The color-coding shall match the color-coding described above.'),
('3.3.5.6', 'The summary device status window shall list the full name of each device.'),
('3.3.5.7', 'The summary device status window shall list the most recent error code and description for the device if the device is failed or experiencing errors.'),
('3.3.5.8', 'The summary device status window shall list the time and date of the last device status check.'),
('3.3.6.1', 'A user shall be able to enter information on an incident, including location, description, and time period.'),
('3.3.6.2', 'A user shall be able to edit or close an existing incident.'),
('3.3.6.3', 'Entry or editing of an incident shall be recorded in the Daily Diary along with the time and the user performing the entry.'),
('3.3.6.4', 'The Incident Entry / Edit Window shall have a menu bar with File, Edit, Report, and Help.'),
('3.3.6.4.1', 'The File menu item shall have an option to create a new incident entry.'),
('3.3.6.4.2', 'The File menu item shall have an option to print the Incident Entry / Edit Window.'),
('3.3.6.4.3', 'The Edit menu item shall have an option to append information to an incident entry.'),
('3.3.6.4.4', 'The Edit menu item shall have an option to update the information on an incident entry.'),
('3.3.6.4.5', 'The report menu shall have an option to print a report on all active incidents.'),
('3.3.6.4.6', 'The report menu shall have an option to print a report on all entries associated with a specific incident.'),
('3.3.6.4.7', 'The Help menu item shall invoke the Help system.'),

('3.3.7.1', 'Operator command and confirmation actions shall be recorded in the Daily diary.'),
('3.3.7.2', 'The Daily Diary Window shall show the date and time of the entry.'),
('3.3.7.3', 'The Daily Diary Window shall show the ID of the operator for each entry.'),
('3.3.7.4', 'The Daily Diary Window shall provide a button (labeled Diary Entry) to activate a screen (Diary Entry) for the operator to make a Diary entry.'),
('3.3.7.5', 'The Diary Entry screen shall provide the operator with a form to make an entry in the Daily Diary.'),
('3.3.7.6', 'The current date, time, and operator ID shall be displayed on the form in read-only display fields.'),
('3.3.8.1', 'The Problem Work Order Window shall allow the User to enter, modify and close information about a system failure.'),
('3.3.8.1.1', 'The Problem Work Order Window shall have a menu bar with File, Edit, Report and Help.'),
('3.3.8.1.1.1', 'The File menu item shall have an option to create a new system failure entry.'),
('3.3.8.1.1.2', 'The File menu item shall have an option to print the Problem Work Order Window.'),
('3.3.8.1.1.3', 'The File menu item shall have an option to close the Problem Work Order Window.'),
('3.3.8.1.1.4', 'The Edit menu item shall have an option to add an update to an existing system failure.'),
('3.3.8.1.1.5', 'The Report menu item shall include an option to print all entries associated with a specific device.'),
('3.3.8.1.1.6', 'The Report menu item shall include an option to print a summary of all active system failures.'),
('3.3.8.1.1.7', 'The Report menu item shall include an option to print all entries associated with a specific system failure.'),
('3.3.9.1', 'The Scheduler Window shall allow the user to enter, modify, delete and view information on events that affect the facility.'),
('3.3.9.2', 'The user shall be able to search for specific events by date and type.'),
('3.3.10.1', 'The Paging Contact Window shall allow an authorized user to enter, modify and delete a paging profile for various points of contact.'),

('3.3.11.1', 'The user shall select an existing macro to be edited or to define a new macro.'),
('3.3.11.2', 'The operation being implemented shall determine which operations are permissible.'),
('3.3.11.3', 'The Macro editor shall allow the user to insert a device action into a macro.'),
('3.3.11.4', 'The Macro editor shall allow the user to delete a device action from a macro.'),
('3.3.11.5', 'The operator shall be able to modify the order of the actions by selecting an action with the mouse and dragging the action to a new location in the macro.'),
('3.3.11.6', 'The Macro editor shall allow the user to specify a security level on a macro.'),
('3.3.11.7', 'The Macro editor shall allow the user to specify a minimum delay time between device actions.'),
('3.3.11.8', 'The Macro editor shall allow the user to specify that operator confirmation is required prior to starting a device action.'),
('3.3.11.9', 'The Macro editor shall allow the user to specify a valid time of activation for the macro.'),
('3.3.11.10', 'The Macro editor shall allow the user to specify the expected amount of time an action will take to complete.'),

('3.3.12.1', 'The Macro Control Window shall provide a File entry on the menu bar.'),
('3.3.12.2', 'The Macro Control Window shall provide an Open entry under the File entry on the menu bar.'),
('3.3.12.3', 'The Macro Control Window shall provide a button (labeled Start) to start the macro.'),
('3.3.12.4', 'The Macro Control Window shall provide a button (labeled Pause) to pause the macro execution.'),
('3.3.12.5', 'The Macro Control Window shall provide a button (labeled Stop) to halt execution of the macro execution.'),
('3.3.12.6', 'The Macro Control Window shall provide a button (labeled Next) to execute the next action in the sequence.'),
('3.3.12.7', 'The Macro Control Window shall provide a counter showing the elapsed time since the macro execution was started.'),

('3.3.13.1', 'The Logon window shall enable a user to enter a user name and password.'),
('3.3.13.2', 'The Logon Window will indicate to the user if the user name and password were accepted.'),
('3.3.13.3', 'The Logon window shall allow the user to accept or reject command authority for the system.'),
('3.3.14.1', 'The User Identification Window shall display the name of the user logged at this workstation, the location of the workstation, the name and location of the user with command control (the operator), and the date and time.'),
('3.3.14.2', 'The User Identification Window shall always be displayed.'),


('3.3.15.1', 'The User Administration Window shall allow a properly authorized operator to enter/modify/delete user names, passwords, user security level, and use display preferences.'),
('3.3.16.1', 'The Report Windows shall allow the user to select and view reports generated by the system.'),
('3.3.16.2', 'The Report Window shall allow the user to select the information to be included in a report format, including the time frame the report is to cover.'),

('3.3.17.1', 'The Scenario Editor shall provide the operator with the ability to create new scenarios.'),
('3.3.17.2', 'The Scenario Editor shall provide the operator with the ability to modify existing scenarios.'),
('3.3.17.3', 'The Scenario Editor shall provide the operator with the ability to define the state of all devices: operational, failed, unknown.'),
('3.3.17.4', 'The Scenario Editor shall provide the operator with the ability to define equipment malfunctions by an offset time from the start of the scenario.'),

('3.3.18.1', 'The Scenario Control Window shall provide the training user the ability to start a scenario.'),
('3.3.18.2', 'The Scenario Control Window shall provide the training user the ability to pause a scenario.'),
('3.3.18.3', 'The Scenario Control Window shall provide the training user the ability to restart a scenario.'),
('3.3.18.4', 'The Scenario Control Window shall provide the training user the ability to correct device malfunctions.'),
('3.3.18.5', 'The Scenario Control Window shall provide the training user the ability to create device malfunctions.'),
('3.3.18.6', 'The Scenario Control Window shall provide the training user the ability to see all commands issued by the trainee user.'),
('3.3.19.1', 'The Help Window shall allow the user to request and display help information.'),


('4.1.1.1', 'All icons shall be configurable to display a minimum of information as text with the icon.'),
  ('4.1.1.1.1', 'The icons shall be configurable to display the text with relationship to the icon at the top, bottom, left or right.'),
  ('4.1.1.2', 'All icons shall be configurable to display four colors: green, yellow, red, or gray.'),
  ('4.1.1.2.1', 'For all icons, the color gray shall represent no data available, that is, communication with the device is not possible.'),
  ('4.1.1.2.2', 'For all icons except the Loop Detector icon, the other colors shall represent the status of the device, with the color green indicating a working device, red indicating a failed device, and yellow indicating a partially failed device.'),
  ('4.1.1.2.3', 'For the Loop Detector Icon, the meaning of the color of the icon is defined in 5.2.1.7.');

/*Insert values into priority */
INSERT into priority(PriorityValue,PriorityText)
VALUES
(1,'High'),
(2,'Medium'),
(3,'Medium-Low'),
(4,'Low');

/*Insert values into status*/
INSERT into status(StatusValue, StatusText)
VALUES
(1,'Not Started'),
(2,'In Progress'),
(3,'Completed');


/*Insert into tracking*/
/*The req_id,priority_id,status_id for the view*/

/*Insert first column, rest should be null for now*/
INSERT INTO tracking (req_id)
SELECT req_id
FROM requirements;




UPDATE tracking
SET priority_id = 1;



UPDATE tracking
SET status_id = 3;


/*Set prioirty for multiple id*/
UPDATE tracking
SET Priority_id = 2
WHERE tracking_id IN (6, 8, 9, 16, 18, 19, 25, 27, 28, 33, 35, 36, 42, 44, 45, 52, 54, 55, 65, 67, 70, 73, 75, 76, 79, 81, 85, 86, 122);

UPDATE tracking
SET Priority_id = 4
WHERE tracking_id IN (193,194,195);

/*View*/
CREATE VIEW  trackingView as
SELECT t.tracking_id as 'Tracking #', r.RequirementNumber as 'Section' , r.RequirementText 'Description', p.PriorityText as 'Priority', s.StatusText 'Status'
FROM tracking t
JOIN requirements r ON t.req_id = r.req_id
JOIN priority p ON t.priority_id = p.priority_id
JOIN status s ON t.status_id = s.status_id ORDER BY tracking_id ASC;

System cls
show tables;
SELECT * FROM trackingView \G

