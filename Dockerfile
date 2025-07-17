# Stage 1: Build the Java Servlet
# We use a Tomcat image that includes a Java Development Kit (JDK) to compile the code.
FROM tomcat:9-jdk11-openjdk-slim as builder

# Set a working directory inside the container
WORKDIR /usr/src/app

# Copy the Java source file into the working directory
COPY WEB-INF/classes/DataServlet.java .

# Compile the Java code. The '-cp' flag adds the necessary Servlet library
# (which is part of Tomcat) to the classpath for a successful compilation.
RUN javac -cp /usr/local/tomcat/lib/servlet-api.jar DataServlet.java

# Stage 2: Create the final, runnable image
# We use a slim Tomcat image that doesn't include the JDK, making it smaller.
FROM tomcat:9-slim

# Remove the default web application that comes with Tomcat.
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy the essential application files for runtime.
# First, the main page.
COPY index.jsp /usr/local/tomcat/webapps/ROOT/
# Then, the web application configuration.
COPY WEB-INF/web.xml /usr/local/tomcat/webapps/ROOT/WEB-INF/
# Finally, copy the compiled Java class from our 'builder' stage.
COPY --from=builder /usr/src/app/DataServlet.class /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/

# The base Tomcat image already knows to expose port 8080 and start the server,
# so we don't need to add EXPOSE or CMD instructions.
