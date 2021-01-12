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
	LoadTranslations("common.phrases.txt");
}

public Action Command_Crouched(int client, int args) 
{
	char players[32];
	int target;

	if(args == 1)
	{
		GetCmdArg(1, players, sizeof(players));
		target = FindTarget(client, players);
		
		if(target == -1) {
			PrintToChat(client, "[AIC] \x0BPlayer not found");
			return Plugin_Handled;
		}
	} else
	{
		target = client;
	}
	
	if (GetEntProp(target, Prop_Send, "m_bDucking")) {
		PrintToChat(client, "[AIC] \x09Half Crouched");
		return Plugin_Handled;
	} else if (GetEntityFlags(target) & FL_DUCKING)
	{
		PrintToChat(client, "[AIC] \x04Fully Crouched");
		return Plugin_Handled;
	} else
	{
		PrintToChat(client, "[AIC] \x07Not Crouched");
		return Plugin_Handled;
	} 
}