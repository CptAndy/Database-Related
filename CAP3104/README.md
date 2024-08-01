# MySQL Database for User Interface Requirements

## Overview
The TransCore project involves the design and implementation of a SQL database to support a traffic control system. This database includes tables for managing requirements, priority, status, and tracking of various functionalities related to the system.

## Requirements
The database will store the following information for each requirement:

1. **Requirement Number**
2. **Requirement Text**
3. **Priority Rating** (e.g., 1 = high, 5 = low)
4. **Status** (e.g., completed, 50% complete, not implemented)

## Database Design
The database will consist of the following tables:

### 1. Requirement Table
- **Purpose**: Store requirement number and requirement text.
- **Fields**:
  - `requirement_id` (Primary Key)
  - `requirement_text`

### 2. Priority Table
- **Purpose**: Store priority values and their corresponding text.
- **Fields**:
  - `priority_id` (Primary Key)
  - `priority_value` (e.g., 1 for high, 5 for low)
  - `priority_text`

### 3. Status Table
- **Purpose**: Store status values and their corresponding text.
- **Fields**:
  - `status_id` (Primary Key)
  - `status_value` (e.g., completed, 50% complete, not implemented)
  - `status_text`

### 4. Tracking Table
- **Purpose**: Provide data analysis of the requirements, priority, and status.
- **Fields**:
  - `tracking_id` (Primary Key)
  - `requirement_id` (Foreign Key referencing Requirement Table)
  - `priority_id` (Foreign Key referencing Priority Table)
  - `status_id` (Foreign Key referencing Status Table)

### 5. View: `trackingView`
- **Purpose**: Provide a text-based version of the data from the Tracking table through a join query.
- **Fields**:
  - `requirement_text`
  - `priority_text`
  - `status_text`
