#include <a_samp>
#include <core>
#include <float>

forward CheckIfFlood(playerid);

new globFA0[MAX_PLAYERS][30]; // IP gracza
new playerFloodCount[MAX_PLAYERS];

public OnFilterScriptInit()
{
    print("AntiFlood filter script loaded.");
    return 1;
}

public OnPlayerConnect(playerid)
{
    GetPlayerIp(playerid, globFA0[playerid], 30); // zapis IP gracza
    playerFloodCount[playerid] = 0;               // reset licznika
    SetTimerEx("CheckIfFlood", 1000, true, "i", playerid); // timer co 1 sekundê
    return 1;
}

public CheckIfFlood(playerid)
{
    new var0[30];
    GetPlayerIp(playerid, var0, 30);

    if(!strcmp(globFA0[playerid], var0))
    {
        playerFloodCount[playerid]++;
    }

    if(playerFloodCount[playerid] > 3)
    {
        // Kick gracza i wypisanie info
        Kick(playerid);

        new msg[64];
        format(msg, sizeof(msg), "Gracz %i dostal kicka za flooding.", playerid);
        print(msg);

        playerFloodCount[playerid] = 0; // reset po kicku
    }

    return 1;
}
