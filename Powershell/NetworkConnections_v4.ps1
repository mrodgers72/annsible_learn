


#Create PSSessions
new-pssession -computername (get-content c:\temp\serverlist.txt)
$all = get-pssession

#Create ScriptBlock
 $sb = {Start-Job{
    $results=@()
    $IP = (Test-Connection -computername $env:computername -count 1 |
        Select-Object -ExpandProperty IPV4Address).ipaddresstostring
    $Connections = get-nettcpconnection | where {$_.localaddress -eq $IP}
    foreach($C in $Connections){
        $TCPInfo = [ordered]@{
            Name = $env:computername
            LocalPort = $c.localport
            LocalAddress = $C.localaddress
            RemotePort = $C.remoteport
            RemoteAddress = $c.Remoteaddress
            State = $C.state
            ProcessID = $C.owningprocess
            ProcessName = (get-process -id $C.owningprocess).name
            ProgramPath = (get-process -id $C.owningprocess).path
            UserRunningProcess = (get-process -id $C.owningprocess -includeusername).username
            CreationTime = $C.CreationTime
            CreationAge = (get-date) - $C.creationtime
        }
        $Data = New-Object psobject -Property $TCPInfo
        $results += $Data
        
    }    
    $results | select * -excludeproperty RunspaceID
} -Name NetConnect}

#Run the script block remotely
invoke-command -scriptblock $sb -Session $all
invoke-command -scriptblock {get-job|wait-job} -session $all

#Receive Jobs
$NetConnections = invoke-command {receive-job NetConnect -keep} -session $all

$NetConnections

$Netconnections | select * -excludeproperty PSShowComputerName, PSComputerName, RunspaceID | export-csv -notypeinformation c:\temp\NetworkConnections.csv

get-pssession | remove-pssession

