#!/bin/bash
# (c) mostly by Andre Klapper <ak-47 gmx net>
# taken from https://mail.gnome.org/archives/gnome-i18n/2018-August/msg00030.html
# get teams list from e.g. thunar dir with:
# ls -lsa *.po | awk '{ print $10 }' | sed -e 's/\..*$//' | tr '\n' ' ' && echo ''
deadline="2017-08-27"
teams=(am ar ast be bg bn ca cs da de el en_AU en_GB eo es et eu fa_IR fi fr gl he hr hu id is it ja kk ko lt lv ms nb nl nn oc pa pl pt_BR pt ro ru si sk sl sq sr sv te th tr ug uk ur_PK ur vi zh_CN zh_HK zh_TW)
for t in "${teams[@]}"; do
  count=0
  for i in $( ls ); do
    if [ -d $i ]; then
      cd $i
      if [ -d "po" ]; then
        cd po
        if [ -f "$t.po" ]; then
          if [ `git log --after=$DEADLINE --pretty=oneline "$t.po" | wc -l` == "0" ]; then
            let "count += 1"
          fi
        fi
        cd ..
      fi
      cd ..
    fi
  done
  echo "$t: $count repositories updated since $deadline" >> deadline_full.log
  count=0
done

awk '$2 < 20  {print ;}' <deadline_full.log > deadline.log

echo "check deadline.log for repos with < 20 .po files changed. all changes are logged to deadline_full.log"
