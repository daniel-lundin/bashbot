
echo $1 >> $LOGFILE
for word in $1; do
    uri=`echo $word | grep "\."`
    #echo "URL is $uri" >> bashbot.log
    if [[ $uri != "" ]]; then
        len=${#uri}
        trimmed=${uri:0:len-1}
        nospace=$(curl -L -s $trimmed | tee 1 | grep -i -o -P "<title>[\n\s]*.*[\n\s]*</title>" | sed "s/<[^>]*>//g" | tr '\r' ' ' | tr '\n' ' ')
        # bash trims all whitespace when assigning variables
        echo $nospace | tee -a $LOGFILE
    fi
done;

