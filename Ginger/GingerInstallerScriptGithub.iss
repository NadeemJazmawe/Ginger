[Setup]
AppName=Ginger
AppVersion=1.0
DefaultDirName={pf}\Ginger
DefaultGroupName=Ginger
OutputBaseFilename=GingerSetup
Compression=lzma
SolidCompression=yes
OutputDir={src}

[Files]
Source: "SetGingerExe.bat"; DestDir: "{app}"; Flags: ignoreversion

; [Run]
; Filename: "{app}\SetGingerExe.bat"; Flags: runhidden

[Code]
procedure AddToPath;
var
  Path: string;
begin
  if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'Path', Path) then
  begin
    if Pos(';{app}', Path) = 0 then
    begin
      Path := Path + ';{app}';
      RegWriteStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'Path', Path);
      SendMessageTimeout(HWND_BROADCAST, WM_SETTINGCHANGE, 0, LPARAM(PChar('Environment')), SMTO_ABORTIFHUNG, 5000, PDWORD(nil)^);
    end;
  end;
end;

procedure UpdateRegistry;
begin
  RegWriteStringValue(HKEY_CLASSES_ROOT, 'ginger', '', '');
  RegWriteStringValue(HKEY_CLASSES_ROOT, 'ginger', 'URL Protocol', '');
  RegWriteStringValue(HKEY_CLASSES_ROOT, 'ginger\shell', '', '');
  RegWriteStringValue(HKEY_CLASSES_ROOT, 'ginger\shell\open', '', '');
  RegWriteStringValue(HKEY_CLASSES_ROOT, 'ginger\shell\open\command', '', '"{app}\Ginger.exe" "%1"');
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    AddToPath;
    UpdateRegistry;
  end;
end;