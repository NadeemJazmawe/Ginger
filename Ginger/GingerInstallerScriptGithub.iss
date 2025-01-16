[Setup]
AppName=Ginger
AppVersion=1.0
DefaultDirName={pf}\Ginger
DefaultGroupName=Ginger
OutputBaseFilename=GingerSetup
Compression=lzma
SolidCompression=yes
OutputDir=D:\a\Installers

[Files]
Source: "SetGingerExe.bat"; DestDir: "{app}"; Flags: ignoreversion

[Run]
Filename: "{app}\SetGingerExe.bat"; Flags: runhidden

