#include <sourcemod>
#include <admincache>

public Plugin:myinfo = 
{
	name = "ServerInfo",
	author = "Jonas Ermert",
	description = "Puts out different server information",
	version = "1.0",
	url = "<- URL ->"
}

public OnPluginStart()
{
	new String:serverName[64];
    	new String:mapName[64];
	new String:language[64];
	new time = GetTime();
	new String:formattedTime[64];
	
	new playerCount = GetPlayerCount();
	
   	GetConVarString(FindConVar("hostname"), serverName, sizeof(serverName));
    	GetMapName(mapName, sizeof(mapName));
	
	PrintToServer("Server name: %s", serverName);
    	PrintToServer("Current map: %s", mapName);
	PrintToServer("Number of players: %d", playerCount);
	
	// Server Time
	FormatTime(formattedTime, sizeof(formattedTime), "%Y-%m-%d %H:%M:%S", time);
	PrintToServer("Server time: %s", formattedTime);
	
	// Server Language
	GetConVarString(FindConVar("sv_language"), language, sizeof(language));
	PrintToServer("Server language: %s", language);
	
	// Liste der Admins
	new String:admins[][MAX_NAME_LENGTH];
        new adminCount = 0;
        
        for (new i = 1; i <= MaxClients; i++)
        {
            // Wenn der Spieler ein Admin ist, füge seinen Namen zur Liste hinzu
            if (GetUserAdmin(i))
            {
                GetClientName(i, admins[adminCount], sizeof(admins[adminCount]));
                adminCount++;
            }
        }
        
        PrintToServer("Admins:");
        for (new i = 0; i < adminCount; i++)
        {
            PrintToServer("- %s", admins[i]);
        }
    }
}
