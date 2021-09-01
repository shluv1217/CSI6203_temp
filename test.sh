#!/bin/bash
#Name : Sunghoon Shin (David)
#Student Number : 10529950

while true; do # begin loop
    read -p "Plase enther the search pattern: " keyword # prompt the user for an option for searching pattern
    read -p "Do you want a whole match?(y(whole)/n(any)): " wholeyn # prompt the user for an option for searching 
    read -p "Do you want an inverted match?(y/n): " invertyn # prompt the user for a keyword for searching
    orig_ifs=IFS # save the default IFS to a variable $orig_ifs
    IFS=$'\n' # set $IFS value to newline \n
    cnt=1 # create a line counter and initialize to 1
    matchcnt=0 # create a match coutner and initialize to 0
    for line in $(cat access_log.txt); do # read in each line of access_log.txt into for loop variable $line
        if [[ $invertyn == "y" ]]; then # check if current line contains the whole match word with the input argument $keyword
            if [[ $wholeyn == "y" ]]; then
                if [[ ! $line == "$keyword" ]]; then # check if current line contains the whole match word with the input argument $keyword
                    echo "Line $cnt: $line" # if yes, print the linenumber and line itself
                    ((matchcnt++)) # increment match counter by 1
                fi
                ((cnt++)) # increment line counter by 1
            else 
                if [[ ! $line == *"$keyword"* ]]; then # check if current line contains the whole match word with the input argument $keyword
                    echo "Line $cnt: $line" # if yes, print the linenumber and line itself
                    ((matchcnt++)) # increment match counter by 1
                fi
                ((cnt++)) # increment line counter by 1
            fi
        else 
            if [[ $wholeyn == "y" ]]; then
                if [[ $line == "$keyword" ]]; then # check if current line contains the whole match word with the input argument $keyword
                    echo "Line $cnt: $line" # if yes, print the linenumber and line itself
                    ((matchcnt++)) # increment match counter by 1
                fi
                ((cnt++)) # increment line counter by 1
            else 
                if [[ $line == *"$keyword"* ]]; then # check if current line contains the whole match word with the input argument $keyword
                    echo "Line $cnt: $line" # if yes, print the linenumber and line itself
                    ((matchcnt++)) # increment match counter by 1
                fi
                ((cnt++)) # increment line counter by 1
            fi
        fi
    done
    IFS=orig_ifs # restite #IFS with its original value 

    echo "matched count : $matchcnt" # print total matched count

    if [ $matchcnt = 0 ]; then echo "No matches found" # if there are no matched word, print "no found" message
    fi

    read -p "Do you want to continue[y/n]" yn # prompt the user whether countiuing the search
    if [ $yn = 'n' ]; then break # if no, break the loop
    else continue # if yes, repeat the search process
    fi
done 
exit 0 # exit program
