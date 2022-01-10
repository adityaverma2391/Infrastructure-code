<#Get members of the AD group vpn_grp_hse
and filter the output with saMAccountName and Name#>

Get-ADGroupMember -Identity [vpn_grp_csr, vpn_grp_hse] -Recursive | select-object saMAccountName, Name| format-table -autosize