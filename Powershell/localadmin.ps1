$group = "YourGroupName"
$servers = Get-Content -Path "D:\OneDrive\Scripts\github\annsible_learn\Powershell\servers.txt"

foreach ($server in $servers) {
    try {
        Invoke-Command -ComputerName $server -ScriptBlock {
            param($group)

            $admins = Get-WmiObject -Class Win32_Group | Where-Object {$_.Name -eq "Administrators"}
            $groupMembers = $admins.GetRelated("Win32_UserAccount") | Where-Object {$_.Name -eq $group}

            if ($groupMembers) {
                Write-Host "$group is a member of Administrators group on $_"
            } else {
                Write-Host "$group is not a member of Administrators group on $_"
            }
        } -ArgumentList $group
    } catch {
        Write-Host "Failed to connect to $server"
    }
}