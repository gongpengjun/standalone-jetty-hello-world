rm -rf output
# create output folder
mkdir -p output
# copy class file
mkdir -p output/WEB-INF/classes/com/gongpengjun/servlets/
cp WEB-INF/classes/com/gongpengjun/servlets/HelloWorldServlet.class output/WEB-INF/classes/com/gongpengjun/servlets/
# copy web.xml
cp WEB-INF/web.xml output/WEB-INF/
# copy index.html
cp index.html output/
# generate war
cd output
jar cfv helloservlet.war *
# show war
jar tf helloservlet.war
cd ..