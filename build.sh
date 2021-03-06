#!/usr/bin/env bash

usage()
{
    echo
    echo "There are new changes on how we build. Use this script only for generic"
    echo "build instructions that apply for both build native and build managed."
    echo "Otherwise:"
    echo
    echo "Before                Now"
    echo "build.sh managed     build-managed.sh"
    echo
    echo "For more information: https://github.com/dotnet/corefx/blob/master/Documentation/project-docs/developer-guide.md"
    echo "----------------------------------------------------------------------------"
    echo
    echo
}

if [ "$1" == "-?" ]; then
    usage
fi

__scriptpath=$(cd "$(dirname "$0")"; pwd -P)
__workingDir=$(pwd -P)

if [ "$1" != "" ]; then
    if [ -d $__workingDir/$1 ]; then
        $__scriptpath/run.sh build-directory -directory:$__workingDir/$*
        exit $?
    fi
    if [ -d $__scriptpath/src/$1 ]; then
        $__scriptpath/run.sh build-directory -directory:$__scriptpath/$*
        exit $?
    fi
fi

"$__scriptpath/build-managed.sh" -BuildPackages=true $*
exit $?
