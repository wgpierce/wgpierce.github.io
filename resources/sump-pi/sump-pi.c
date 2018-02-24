/* sump-pi: sump pump monitor for raspberry pi
 *
 * William Pierce 
 * August 13, 2017
 *
*/

#include <stdio.h>

#define numSamples 5

/* Designed to be run every hour */

int main(int argc, char * argv[])
{
	/* Set up pi */
	if (wiringPiSetup() == 1) {
		system("echo 'Failed to setup' | "
			"mail -s 'sump-pi status' <your email>");
		return 2;
	}
	/* Set up mcp3008 */ 
	mcp3004Setup(100, 0);

	unsigned int waterAmt = 0;
	for (int i = 0; i < numSamples; i++) {
		waterAmt += analogRead(100);
	}
	waterAmt /= numSamples;		

	char mailCommand[255];
	char * message;

	if (waterAmt >= 0 && waterAmt < 30) {
		//don't send notification email
		return 0;
		//message = "Notify: Water level is normal";
	} else if (waterAmt < 100) {
		message = "Alert: Water level is elevated. Check sump pump";
	} else if (waterAmt < 200) {
		message = "WARNING: Water level is high. Check sump pump now";
	} else if (waterAmt >= 200) {
		message = "WARNING: Water level is extremely high. Check sump pump IMMEDIATELY";
	} else {
		message = "Water level reading is abnormal";
	}

	sprintf(mailCommand, "echo '%s\nWater level is %d' | "
		"mail -s 'sump-pi reading' <your email>",
		message, waterAmt);

	system(mailCommand);
	return 0;
}
