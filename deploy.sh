#!/bin/bash
git pull
mvn package
if [[ "$?" -ne 0 ]] ; then
  echo 'could not perform tests'; exit $rc
else
    while true; do
      pid=`ps -ef |grep lindagrid |grep -v grep |awk '{print $2}'`
      if [ -n "$pid" ]; then
        kill -15 $pid
        echo "ending lindagrid process"
        sleep 1
      else
        echo "lindagrid killed successfully!"
        break
      fi
    done
     nohup java -jar target/lindagrid-1.0.1-SNAPSHOT.jar >/dev/null 2>&1 &
    sleep 10
    echo "ok!"
fi

