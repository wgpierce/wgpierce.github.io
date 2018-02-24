# bootup: ping that raspberry pi has been booted
# runs when system is booted

echo 'System has just been turned on' | mail -s 'sump-pi status' <your email>
