# Full-Stack Learning Blog Application

## Overview
This is a full-stack blog application built using Servlet, JSP, AJAX, SweetAlert, JDBC, and MySQL. It allows users to create, edit, and delete blog posts, with a dynamic and responsive UI.

## Features
- Secured login, registration, and logout feature
- Protected routes using filters in the Servlet
- Comment system using Facebook's comment plugin
- Like system for blog posts
- Users can post blogs and read other people's blogs
- Category-wise filters for better content organization
- Users can update and delete their blogs
- AJAX-based dynamic content updates
- SweetAlert for interactive notifications
- MySQL database for data storage
- Responsive design for better user experience

## Technologies Used
### Frontend:
- HTML, CSS, JavaScript
- JSP (JavaServer Pages)
- AJAX (Asynchronous JavaScript and XML)
- SweetAlert (for beautiful notifications)

### Backend:
- Java Servlet
- JDBC (Java Database Connectivity)
- MySQL (Database Management System)

## Installation & Setup
### Prerequisites:
- Java Development Kit (JDK v21.0.3) installed
- Apache Tomcat Server(v10.1) installed
- MySQL(v8.0) Database installed and running

### Steps to Setup:
1. Clone the repository:
   ```sh
   git clone https://github.com/AmmarTheDeveloper/Java-Fullstack-Blog-App.git
   ```
2. Import the project into your favorite IDE (Eclipse/IntelliJ IDEA).
3. Configure the database:
   - Create a MySQL database using the following SQL command:
     ```sql
     CREATE DATABASE learnonline;
     ```
   - Create tables using the provided `db.txt` file.
   - Update database connection details in `com.learnonline.helper.ConnectionProvider.java`:
     ```java
     String url = "jdbc:mysql://localhost:3306/learnonline";
     String user = "your_username";
     String password = "your_password";
     ```
4. Deploy the project on Apache Tomcat.
5. Start the Tomcat server and access the application at:
   ```
   http://localhost:8080/YourProjectName/
   ```

## Usage
1. Register a new account or log in with an existing account.
2. Create, edit, or delete blog posts.
3. View all posts in a structured format.
4. Use category filters to find relevant posts.
5. Like blog posts.
6. Comment on blogs using Facebook's comment plugin.
7. Receive notifications using SweetAlert.

## License
This project is open-source and available under the [MIT License](LICENSE).

## Contact
For any questions or support, reach out via email at [ammarthedeveloper@gmail.com](ammarthedeveloper@gmail.com) or create an issue on GitHub.

---
Enjoy coding and happy blogging! 🚀