# 1. Build the vulnerable Apache Struts server Docker image
cat > Dockerfile << 'EOF'
# Use Tomcat 8.5 with Java 8
FROM tomcat:8.5-jre8

# Download the vulnerable Apache Struts 2.3.32 WAR
RUN curl -L -o /usr/local/tomcat/webapps/struts2-showcase.war \
https://archive.apache.org/dist/struts/2.3.32/struts2-showcase.war

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
EOF

docker build -t equifax-vulnerable-app .

# 2. Run the vulnerable app
docker run -d --name equifax-vuln-server -p 8080:8080 equifax-vulnerable-app

# 3. Verify the server is running
docker ps
curl http://localhost:8080/struts2-showcase

# 4. Scan the Docker image with Trivy for vulnerabilities
trivy image equifax-vulnerable-app
trivy image --scanners vuln equifax-vulnerable-app # faster, only vuln scan


OLD DOCKERFILE DEL IF NEWONE WORKS
# Use Tomcat 8.5 with Java 8
FROM tomcat:8.5-jre8

# Download the vulnerable Apache Struts 2.3.32 WAR
RUN curl -L -o /usr/local/tomcat/webapps/struts2-showcase.war \
    https://archive.apache.org/dist/struts/2.3.32/struts2-showcase.war

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]


http://localhost:8080/struts2-showcase/index.action

COMMAND THAT WORKS
trivy image --scanners vuln --skip-db-update equifax-vulnerable-app
