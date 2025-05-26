# ACER Fruit Company Management System

![ACER Logo](./img/favicon.ico)

## Table of Contents

- [ACER Fruit Company Management System](#acer-fruit-company-management-system)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Features](#features)
    - [For Shop Staff](#for-shop-staff)
    - [For Warehouse Staff](#for-warehouse-staff)
    - [For Senior Management](#for-senior-management)
  - [Technology Stack](#technology-stack)
  - [System Architecture](#system-architecture)
  - [Prerequisites](#prerequisites)
  - [Installation and Setup](#installation-and-setup)
  - [Usage Guide](#usage-guide)
    - [Login and Navigation](#login-and-navigation)
    - [Login Credentials](#login-credentials)
    - [For Shop Staff](#for-shop-staff-1)
    - [For Warehouse Staff](#for-warehouse-staff-1)
    - [For Senior Management](#for-senior-management-1)
  - [Project Structure](#project-structure)
    - [Package Organization](#package-organization)
      - [Java Packages](#java-packages)
      - [Web Resources](#web-resources)
    - [Key Files](#key-files)
  - [Security](#security)
  - [Key Features Implementation](#key-features-implementation)
    - [AI-Powered Analysis](#ai-powered-analysis)
    - [PDF Export Capability](#pdf-export-capability)
    - [Real-time Stock Tracking](#real-time-stock-tracking)
    - [Responsive Design](#responsive-design)
  - [UI Design](#ui-design)
  - [Known Issues](#known-issues)
  - [License](#license)
  - [Acknowledgments](#acknowledgments)

## Overview

ACER Fruit Company Management System is a Java EE-based web application designed to streamline the fruit inventory, reservation, borrowing, and delivery processes across multiple locations (shops, cities, and warehouses). The system enables efficient materials management for Acer International Bakery (AIB), which operates in major cities across Japan, USA, and Hong Kong.

## Features

### For Shop Staff
- User account management
- Fruit reservation from source cities
- Fruit borrowing from shops in the same city
- Reservation record tracking
- Stock level management and updates
- View fruits on delivery (borrowed/reserved)

### For Warehouse Staff
- User account management
- Stock level updates (check-in)
- Process reserve approvals by country
- Arrange deliveries to target country warehouses (checkout)
- Coordinate local delivery from central warehouses to shops

### For Senior Management
- Consumption analytics and reporting
- User account management
- Fruit types management
- Reservation needs analysis with AI-powered insights
- Visual data representation with charts and graphs

## Technology Stack

- **Frontend**: JSP, HTML5, CSS3, Bootstrap 5
- **Client-side Logic**: JavaScript, jQuery
- **Backend**: Java EE (Jakarta EE 10), Servlets
- **Data Management**: JavaBeans, JDBC
- **Database**: MySQL
- **Additional Libraries**:
  - Google Material Icons
  - Google Fonts (Poppins)
  - Chart.js for data visualization
  - html2pdf.js for PDF export
  - Deepseek API for AI-powered analytics

## System Architecture

The application follows the Model-View-Controller (MVC) architecture:

- **Model**: JavaBeans in `ict.bean` package handle data representation and business logic
- **View**: JSP pages in various directories render the user interface
- **Controller**: Servlets in `ict.servlet` package manage request/response flow and application logic

## Prerequisites

- JDK 17 or higher
- Apache Tomcat 10 or compatible Jakarta EE server
- MySQL 8.0 or higher
- Maven 3.8+ for dependency management and building

## Installation and Setup

1. **Clone the repository**
   ```bash
   git clone https://your-repository-url/ITP4511_Project.git
   ```

2. **Configure database**
   - Create a MySQL database
   - Import the SQL schema from `./database/schema.sql`
   - Update database connection settings in `src/main/java/ict/db/ProjectDB.java`

3. **Build the project**
   ```bash
   cd ITP4511_Project
   mvn clean install
   ```

4. **Deploy to Tomcat**
   - Copy the generated WAR file from `target/ITP4511_Project-1.0-SNAPSHOT.war` to your Tomcat's webapps directory
   - Alternatively, configure your IDE to deploy directly to Tomcat

5. **Access the application**
   - Navigate to `http://localhost:8080/ITP4511_Project/` in your web browser
   - Use the provided credentials to log in based on your role

## Usage Guide

### Login and Navigation

The system supports three user types with different dashboards:
- Shop Staff
- Warehouse Staff
- Senior Management

After login, users will be directed to their role-specific dashboard with the following features:

### Login Credentials

For testing and demonstration purposes, you can use the following credentials:

| Role              | Username | Password |
| ----------------- | -------- | -------- |
| Shop Manager      | User 12  | 123456   |
| Shop Staff        | User 1   | 123456   |
| Warehouse Manager | User 3   | 123456   |
| Warehouse Staff   | User 8   | 123456   |
| Senior Management | User 13  | 123456   |

### For Shop Staff

1. **Reserve Fruit**
   - Browse available fruits
   - Select quantities
   - Add notes for special requirements
   - Submit reservation request

2. **Borrow Fruit**
   - Search for fruits available in local shops
   - Submit borrowing requests
   - Track borrowing status

3. **View Records**
   - Check reservation history
   - Monitor borrowing records
   - Track delivery status

### For Warehouse Staff

1. **Inventory Management**
   - Update stock levels
   - Process check-ins and check-outs

2. **Orders and Deliveries**
   - Manage reserve requests
   - Coordinate deliveries between warehouses and shops

### For Senior Management

1. **Analytics Dashboard**
   - View consumption reports
   - Analyze reservation needs
   - Generate AI-powered insights

2. **System Administration**
   - Manage user accounts
   - Update fruit catalog

## Project Structure

```
ITP4511_Project/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── ict/
│   │   │       ├── bean/       # JavaBeans for data representation
│   │   │       ├── db/         # Database connection and operations
│   │   │       ├── servlet/    # Controller servlets by user role
│   │   │       │   ├── store/          # Shop staff controllers
│   │   │       │   ├── warehouse/      # Warehouse staff controllers
│   │   │       │   └── seniorManagement/ # Management controllers
│   │   │       └── tag/        # Custom JSP tag libraries
│   │   └── webapp/
│   │       ├── css/            # Stylesheets organized by user role
│   │       │   ├── store/
│   │       │   ├── warehouse/
│   │       │   └── seniorManagement/
│   │       ├── js/             # JavaScript files by user role
│   │       │   ├── store/
│   │       │   ├── warehouse/
│   │       │   └── seniorManagement/
│   │       ├── img/            # Images and assets
│   │       ├── page/           # JSP pages organized by user role
│   │       │   ├── store/              # Shop staff interface
│   │       │   ├── warehouse/          # Warehouse staff interface
│   │       │   └── seniorManagement/   # Management interface
│   │       ├── WEB-INF/
│   │       │   ├── tlds/       # Tag library descriptors
│   │       │   └── web.xml     # Web application configuration
│   │       ├── error.jsp       # Custom error page
│   │       └── index.jsp       # Entry point
└── target/                     # Build output
    └── ITP4511_Project-1.0-SNAPSHOT/
```

### Package Organization

The project follows a structured organization by functionality and user roles:

#### Java Packages

- **ict.bean**: Contains JavaBean classes representing data entities like `UserBean`, `FruitBean`, `OrderBean`, etc.
- **ict.db**: Database connectivity and operations including `ProjectDB` for all database interactions
- **ict.servlet**: Servlet controllers divided by user role:
  - **store**: Handles shop staff operations (reservations, borrowing)
  - **warehouse**: Manages warehouse operations (inventory, deliveries)
  - **seniorManagement**: Supports management tasks (analytics, user management)
- **ict.tag**: Custom JSP tag handlers for common UI components like navigation bars and footers

#### Web Resources

- **page/**: JSP views organized by user role to maintain separation of interfaces:
  - **store/**: Shop staff interfaces (fruit reservation, borrowing, records)
  - **warehouse/**: Warehouse staff interfaces (inventory, delivery management)
  - **seniorManagement/**: Management interfaces (analytics, system configuration)

- **css/, js/**: Frontend assets organized in parallel to match the JSP structure
  - Each user role has dedicated styling and client-side logic

### Key Files

- **db.sql**: Database schema and sample data
- **web.xml**: Servlet mappings and configuration
- **login.jsp**: Authentication entry point
- **error.jsp**: Centralized error handling
- **darkModeControl.js**: Theme toggling functionality used across interfaces
- **Nav and footer tag files**: Reusable UI components implemented as custom tags

## Security

- Role-based access control for different user types
- Session management and secure user authentication
- Password encryption using secure hashing algorithms
- Error handling with custom error pages

## Key Features Implementation

### AI-Powered Analysis
The system integrates with Deepseek API to provide advanced analytics and insights on reservation needs. This helps management make data-driven decisions about fruit inventory and distribution.

### PDF Export Capability
Reports and analytics can be exported to PDF format for offline review and sharing with stakeholders.

### Real-time Stock Tracking
The system provides real-time visibility of fruit inventory across all locations, enabling effective stock management and reducing waste.

### Responsive Design
The application uses Bootstrap 5 to ensure a seamless experience across desktop and mobile devices.

## UI Design
![Image](https://github.com/user-attachments/assets/61dc84ff-56b7-49c9-a678-07aefb72aa75) <br>
![Image](https://github.com/user-attachments/assets/3121d094-ebe5-45fe-9917-0e0ce0b3b000) <br>
![Image](https://github.com/user-attachments/assets/3696d035-f8a9-40cd-9c88-c52e03e4a25d) <br>
![Image](https://github.com/user-attachments/assets/45bec267-cae3-46ad-9406-da1b3b8da31f) <br>

## Known Issues

- Deepseek API quota may limit analysis frequency.
- No email notifications implemented yet.

## License

This project was developed for educational purposes as part of the Higher Diploma in Software Engineering (IT114105) coursework, Enterprise Systems Development (ITP4511) at the Hong Kong Institute of Vocational Education.

## Acknowledgments

- Deepseek for providing the AI analysis API
- Open-source libraries and frameworks used in this project
