# Set start and end dates
START_DATE="2018-01-01"
END_DATE="2023-12-31"

# Loop through each day from START_DATE to END_DATE
while [ "$(date -d "$START_DATE" +%Y-%m-%d)" != "$(date -d "$END_DATE + 1 day" +%Y-%m-%d)" ]; do
    # Check if the day is not Saturday (6) or Sunday (0)
    DAY_OF_WEEK=$(date -d "$START_DATE" +%u) # 1=Monday, ..., 7=Sunday
    if [ "$DAY_OF_WEEK" -lt 6 ]; then
        # Generate a random number of commits for the day (1 to 5 commits)
        NUM_COMMITS=$((RANDOM % 5 + 1))

        for ((i = 1; i <= NUM_COMMITS; i++)); do
            # Generate a random time during the day
            HOUR=$((RANDOM % 24))
            MINUTE=$((RANDOM % 60))
            SECOND=$((RANDOM % 60))

            # Set the commit date and time
            COMMIT_DATE="$START_DATE $HOUR:$MINUTE:$SECOND"

            # Create a fake commit
            export GIT_AUTHOR_DATE="$COMMIT_DATE"
            export GIT_COMMITTER_DATE="$COMMIT_DATE"
            echo "Fake commit on $COMMIT_DATE" > commit.txt
            git add commit.txt
            git commit -m "Commit on $COMMIT_DATE"
        done
    fi

    # Increment the date by 1 day
    START_DATE=$(date -I -d "$START_DATE + 1 day")
done
