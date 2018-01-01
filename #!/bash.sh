start_date="2018-01-01"
end_date="2024-12-01"
auth="coderift"

while [ "$start_date" != "$end_date" ]; do
    echo "Commit on $start_date" >> fakefile.txt
    git add .
    GIT_COMMITTER_DATE="$start_date 12:00:00" GIT_AUTHOR_DATE="$start_date 12:00:00" git commit -m "commit for $start_date by $auth"
    start_date=$(date -I -d "$start_date + 1 day")
done

git push --force