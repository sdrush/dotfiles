ssh-add_wf ()
{
    while read -r line; do
        for file in ~/.ssh/*.pub;
        do
            printf "%s %s\n" "$(ssh-keygen -lf "$file" | awk '{$1=""}1')" "$file";
        done | column -t | grep --color=auto "$line" || echo "$line";
    done < <(ssh-add -l | awk '{print $2}')
}