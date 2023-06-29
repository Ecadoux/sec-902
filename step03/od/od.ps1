$O = (Get-WmiObject -Class Win32_OperatingSystem).Caption

switch -Wildcard ($O) {
    "Microsoft Windows*" {
        Write-Host "w"
    }
    "Linux*" {
        Write-Host "l"
    }
    "macOS*" {
        Write-Host "d"
    }
    default {
        Write-Host "YOSINS"
        exit 1
    }
}