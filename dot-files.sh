#!/bin/sh

print_usage ()
{
    echo "Usage:" 1>&2
    echo "$0 list {all|installed|not-installed}" 1>&2
    echo "$0 {install|reinstall|uninstall|update|status} [BRANCH...]" 1>&2
}

print_branch_scripts ()
{
    find /usr/bin -type f -name "dot-files-*.sh" | sort
}

COMMAND="$1"

if [ -z "$COMMAND" ]
then
    print_usage
    exit 0
fi

shift 1

case "$COMMAND" in
    list)
        if [ "$#" -ne 1 ]
        then
            print_usage
            exit 1
        fi

        case "$1" in
            all)
                print_branch_scripts | sed "s/^.*\/dot-files-//; s/\.sh$//"
                ;;
            installed)
                print_branch_scripts | xargs -I "{}" sh "{}" status 2>&1 | grep "is installed" | sed "s/^dot-files-//; s/ .*//"
                ;;
            not-installed)
                print_branch_scripts | xargs -I "{}" sh "{}" status 2>&1 | grep "is not installed" | sed "s/^dot-files-//; s/ .*//"
                ;;
            *)
                print_usage
                exit 1
        esac
        ;;

    install|reinstall|uninstall|update|status)
        for branch in "$@"
        do
            if ! command -v "dot-files-$branch.sh" > /dev/null
            then
                echo "Error: no such branch '$branch' is available in the system" 1>&2
                exit 1
            fi
        done

        for branch in "$@"
        do
            sh "/usr/bin/dot-files-$branch.sh" "$COMMAND"
        done
        ;;

    *)
        print_usage
        exit 1
esac

exit 0

