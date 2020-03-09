#!/bin/sh

#ninos boulous
currentuser=$(stat -f%Su /dev/console)
FILE="/Users/$currentuser/Downloads/GitHub.zip"
appPath="/Applications/GitHub Desktop.app"

#Download URL
URL='https://central.github.com/deployments/desktop/desktop/latest/darwin'

# test download URL
test=`curl -Is $URL | head -n 1 | awk '{print $2}'`
if [[ "$test" != "302" ]]; then
	/bin/echo "URL is invalid"
	exit 1
fi

# Download Github desktop
curl -L $URL -so /Users/$currentuser/Downloads/GitHub.zip

if [[ -f "$FILE" ]]; then 
	echo "$FILE Downloaded successfully"
else 
	echo "$FILE Did not Download."
	exit 1
fi

# Unzip .zip file
unzip /Users/$currentuser/Downloads/GitHub.zip -d /tmp

# Install and set permissions
/usr/bin/ditto -rsrc "/tmp/GitHub Desktop.app" "/Applications/Github Desktop.app"
/usr/sbin/chown -R $currentuser:staff "/Applications/Github Desktop.app"

# Cleanup
rm -r "/Users/$currentuser/Downloads/GitHub.zip" 
rm -rf "/tmp/Github Desktop.app"

if [[ -e "$appPath" ]]; then
 echo "GitHub Desktop has been installed successfully!"
 exit 0
else
	/bin/echo "GitHub did not install"
	exit 1
fi