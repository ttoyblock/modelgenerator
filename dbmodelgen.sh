#!/bin/bash
echo 'generate db model'


cur=`pwd`

$cur/modelgenerator \
-tplFile=$cur'/model_byte.tpl' \
-modelFolder='./model_test/' \
-packageName='db' \
-dbIP=''  \
-dbPort=3306 \
-dbConnection='dbhelper.DB' \
-dbName='' \
-userName='' \
-pwd='' \
-genTable='' \

echo 'done'

# sh dbmodelgen.sh
