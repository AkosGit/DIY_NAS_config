#/bin/bash
# This script will save the md file to a repo in the Notes folder categorized by the first tag in a note.
# The images will be ripped and saved and categorized by tags in Notes/Images
# Script uses wget, Hedgedoc cli
repo="REPO NAME"
eval "rm -rf  $repo"
eval "git clone YOUR GIT PROFILE/$repo"
eval "cd $repo"
eval "rm -rf Notes"
export HEDGEDOC_SERVER='DOMAIN'
hedgedoc login --email EMAIL PASSWORD
hjson=$(hedgedoc history --json) 
eval "mkdir Notes"
eval "cd Notes"
eval "mkdir Images"
ext=0
count=`echo "$hjson" | jq -r '.history | length'`
for ((i=0; i<$count; i++)); do
        id=`echo "$hjson" | jq -r '.history['$i'].id'`
        text=`echo "$hjson" | jq -r '.history['$i'].text'`
        tag=`echo "$hjson" | jq -r '.history['$i'].tags[0]'`
        text2="$( echo "$text" | sed 's/://g')"
        text3="$( echo "$text2" | sed 's/[[:space:]]/_/g')"     
        eval "mkdir $tag"
        eval "hedgedoc export --md $id $tag/$text3.md"
        images=$(grep -oP 'http.+.(png|jpg)' "$tag/$text3.md")
        ext=0
        if [ "$images" != "" ]
        then
                while read line; do 
                        ext=$((ext+1))

                        eval "mkdir Images/${tag}"
                        eval "cd Images/${tag}"
                        echo "wget -O ${text3}_${ext}.png -P Images/${tag} ${line}"
                        eval "wget -O ${text3}_${ext}.png ${line}"
                        eval "cd .."
                        eval "cd .."
                        echo "sed -i 's#${line}#\/Notes\/Images\/${tag}\/${text3}_${ext}.png#g' ${tag}/${text3}.md"
                        eval "sed -i 's#${line}#\/Notes\/Images\/${tag}\/${text3}_${ext}.png#g' ${tag}/${text3}.md"     
                done <<< "$images"
        fi
        eval "pandoc --pdf-engine=xelatex  $tag/$text3.md -o $tag/$text3.pdf"        
done
eval "git add . -A"
eval "git commit -m 'Updated notes'"
eval "git push"
