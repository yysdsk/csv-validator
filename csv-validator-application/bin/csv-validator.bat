@REM
@REM Copyright (c) 2013, The National Archives <digitalpreservation@nationalarchives.gov.uk>
@REM https://www.nationalarchives.gov.uk
@REM
@REM This Source Code Form is subject to the terms of the Mozilla Public
@REM License, v. 2.0. If a copy of the MPL was not distributed with this
@REM file, You can obtain one at http://mozilla.org/MPL/2.0/.
@REM

# Location of this script at runtime
SCRIPT=$0

# Resolve absolute and relative symlinks
while [ -h "$SCRIPT" ]; do
    LS=$( ls -ld "$SCRIPT" )
    LINK=$( expr "$LS" : '.*-> \(.*\)$' )
    if expr "$LINK" : '/.*' > /dev/null; then
        SCRIPT="$LINK"
    else
        SCRIPT="$( dirname "$SCRIPT" )/$LINK"
    fi
done

# Store absolute location
CWD=$( pwd )
APP_HOME="$( cd "$(dirname "$SCRIPT" )" && pwd )"
cd "$CWD"

# Create param for runtime options:
OPTIONS=""

# Detect if we are running on a Mac:
OS=$( uname )
if [ "Darwin" = "$OS" ]; then
    OPTIONS=$OPTIONS" -Xdock:name=CSV-Validator"
    OPTIONS=$OPTIONS" -Dcom.apple.mrj.application.growbox.intrudes=false"
    OPTIONS=$OPTIONS" -Dcom.apple.mrj.application.live-resize=true"
fi

java $OPTIONS -jar "$APP_HOME/csv-validator-ui-${project.version}.jar"