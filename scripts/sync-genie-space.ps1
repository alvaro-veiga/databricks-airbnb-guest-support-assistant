param(
    [int]$IntervalSeconds = 60,
    [string]$Profile = "alvaro"
)

$ErrorActionPreference = "Stop"
$SpaceId = "01f1c6fb4c89143da42b35e364ceb6c6"
$ApiPath = "/api/2.0/genie/spaces/$SpaceId`?include_serialized_space=true"
$FilePath = [System.IO.Path]::GetFullPath(
    (Join-Path $PSScriptRoot "..\src\airbnb_guest_support.geniespace.json")
)

Write-Host "Monitorando o Genie Space a cada $IntervalSeconds segundos."
Write-Host "Arquivo: $FilePath"
Write-Host "Pressione Ctrl+C para parar."

while ($true) {
    try {
        $lines = & databricks api get $ApiPath --profile $Profile
        $exitCode = $LASTEXITCODE

        if ($exitCode -ne 0) {
            throw "A consulta à API falhou (código $exitCode)."
        }

        $responseText = $lines -join [Environment]::NewLine
        $data = $responseText | ConvertFrom-Json

        if ([string]::IsNullOrWhiteSpace($data.serialized_space)) {
            throw "A API não retornou serialized_space."
        }

        $newSpace = [string]$data.serialized_space
        $newNormalized = ($newSpace | ConvertFrom-Json |
            ConvertTo-Json -Depth 100 -Compress)

        $currentNormalized = ""
        if (Test-Path $FilePath) {
            $currentRaw = Get-Content $FilePath -Raw
            $currentNormalized = ($currentRaw | ConvertFrom-Json |
                ConvertTo-Json -Depth 100 -Compress)
        }

        if ($newNormalized -ne $currentNormalized) {
            if (Test-Path $FilePath) {
                $backup = "$FilePath.$(Get-Date -Format 'yyyyMMdd-HHmmss').bak"
                Copy-Item $FilePath $backup
                Write-Host "Backup criado: $backup"
            }

            Set-Content -Path $FilePath -Value $newSpace -Encoding UTF8
            Write-Host "[$(Get-Date -Format 'HH:mm:ss')] Genie atualizado no arquivo local." -ForegroundColor Green
        }
        else {
            Write-Host "[$(Get-Date -Format 'HH:mm:ss')] Sem alterações."
        }
    }
    catch {
        Write-Warning "[$(Get-Date -Format 'HH:mm:ss')] $($_.Exception.Message)"
    }

    Start-Sleep -Seconds $IntervalSeconds
}
