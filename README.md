Still do be done.  Add in the following code:

 user_data = <<-EOF
              <powershell>
              # === Firewall Rules ===
              New-NetFirewallRule -DisplayName "Allow TCP 25565" -Direction Inbound -LocalPort 25565 -Protocol TCP -Action Allow
              New-NetFirewallRule -DisplayName "Allow UDP 25565" -Direction Inbound -LocalPort 25565 -Protocol UDP -Action Allow
              New-NetFirewallRule -DisplayName "Allow UDP 25565" -Direction Outbound -LocalPort 25565 -Protocol UDP -Action Allow
              New-NetFirewallRule -DisplayName "Allow UDP 25565" -Direction Outbound -LocalPort 25565 -Protocol UDP -Action Allow

              # === Create Temp Directory ===
              $tempPath = "C:\\Temp"
              New-Item -ItemType Directory -Force -Path $tempPath

              # === Install Steam ===
              $steamInstaller = "$tempPath\\SteamSetup.exe"
              $steamUrl = "https://cdn.cloudflare.steamstatic.com/client/installer/SteamSetup.exe"
              Invoke-WebRequest -Uri $steamUrl -OutFile $steamInstaller
              Start-Process -FilePath $steamInstaller -ArgumentList "/S" -Wait
              Remove-Item -Path $steamInstaller -Force

              # === Install OpenMW ===
              $openmwInstaller = "$tempPath\\OpenMW-0.49.0-win64.exe"
              $openmwUrl = "https://github.com/OpenMW/openmw/releases/download/openmw-0.49.0/OpenMW-0.49.0-win64.exe"
              Invoke-WebRequest -Uri $openmwUrl -OutFile $openmwInstaller

              # Try silent install (Inno Setup format uses /VERYSILENT /SUPPRESSMSGBOXES)
              Start-Process -FilePath $openmwInstaller -ArgumentList "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART" -Wait
              Remove-Item -Path $openmwInstaller -Force
              </powershell>
              EOF

The OpenMW installation part might not work.  Will test it the next time I can.
