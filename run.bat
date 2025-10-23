@echo off
title Pi-Squared Bot by @MeoMunDep
color 0A

cd %~dp0

echo Checking for bot updates...
git pull origin main > nul 2>&1
echo Bot updated!

echo Checking configuration files...

if not exist configs.json (
    echo {> configs.json
    echo   "proxyMode": "static",>> configs.json
    echo   "skipInvalidProxy": false,>> configs.json
    echo   "delayEachAccount": [5, 8],>> configs.json
    echo   "timeToRestartAllAccounts": 300,>> configs.json
    echo   "howManyAccountsRunInOneTime": 36,>> configs.json
    echo   "stopOnExpiredTokens": false,>> configs.json
    echo   "doTasks": true,>> configs.json
    echo   "clickGame": {>> configs.json
    echo   "enable": true,>> configs.json
    echo   "processLog": true,>> configs.json
    echo   "amountOfGames": 50>> configs.json
    echo   },>> configs.json
    echo   "faucetNative": true,>> configs.json
    echo   "faucetTokens": true,>> configs.json
    echo   "newWalletCount": 1,>> configs.json
    echo   "sendFromTempWalletsToThisAccount": true,>> configs.json
    echo   "transferToRandomWallets": true>> configs.json
    echo }>> configs.json
    echo Created configs.json
)


(for %%F in (privateKeys.txt proxies.txt) do (
    if not exist %%F (
        type nul > %%F
        echo Created %%F
    )
))

echo Configuration files checked.

echo Checking dependencies...
if exist "..\node_modules" (
    echo Using node_modules from parent directory...
    cd ..
    CALL npm install user-agents axios meo-forkcy-colors meo-forkcy-utils meo-forkcy-proxy meo-forkcy-logger ethers crypto-js cheerio tweetnacl
    cd %~dp0
) else (
    echo Installing dependencies in current directory...
    CALL npm install user-agents axios meo-forkcy-colors meo-forkcy-utils meo-forkcy-proxy meo-forkcy-logger ethers crypto-js cheerio tweetnacl
)
echo Dependencies installation completed!

echo Starting the bot...
node meomundep

pause
exit
