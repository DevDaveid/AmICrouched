#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>

public Plugin myinfo = 
{
	name = "Am I Crouched?",
	author = "Dave",
	description = "Checks if player is crouched",
	version = "1.0.0",
	url = "https://daveskz.com/"
};

public void OnPluginStart()
{
	RegConsoleCmd("sm_c", Command_Crouched);
	RegConsoleCmd("sm_amicrouched", Command_Crouched);
}

public Action Command_Crouched(int client, int args) 
{
	if (args > 1) {
		PrintToChat(client, "\x01[AIC] Incorrect usage, '!c'");
		return Plugin_Handled;
	}
	
	
	if (GetEntProp(client, Prop_Send, "m_bDucking")) {
		PrintToChat(client, "[AIC] \x09Half Crouched");
		return Plugin_Handled;
	} else if (GetEntityFlags(client) & FL_DUCKING)
	{
		PrintToChat(client, "[AIC] \x04Fully Crouched");
		return Plugin_Handled;
	} else {
		PrintToChat(client, "[AIC] \x07Not Crouched");
		return Plugin_Handled;
	}
}