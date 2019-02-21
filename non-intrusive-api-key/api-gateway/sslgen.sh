#!/bin/sh

keytool -genkey -alias format-converter -keyalg RSA -keystore keystore.jks -keysize 2048 -deststoretype pkcs12
keytool -export -alias format-converter -storepass helloworld -file server.cer -keystore keystore.jks
keytool -import -v -trustcacerts -alias format-converter -file server.cer -keystore cacerts.jks -keypass helloworld -storepass helloworld
