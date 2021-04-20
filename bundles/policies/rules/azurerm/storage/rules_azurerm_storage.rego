package rules.azurerm.storage

import input as tfplan

# default foo = false

storage_accounts := [ resource |
    resource := input.resource_changes[_]
    resource.type == "azurerm_storage_account"
	resource.mode == "managed"
]

# Storage Accounts must not be accessible over HTTP
deny[msg] {
    violations := count([res | res := storage_accounts[_]; not res.change.after.enable_https_traffic_only])
    violations > 0
    msg := sprintf("Expected every Storage Account to be accessible over HTTPS only, but %v were not", [violations])
}

# Storage Accounts must enforce TLS 1.2
deny[msg] {
    violations := count([res | res := storage_accounts[_]; not res.change.after.min_tls_version == "TLS1_2"])
    violations > 0
    msg := sprintf("Expected every Storage Account to require TLS 1.2, but %v were not", [violations])
}

# Storage Accounts must not allow public access
deny[msg] {
    violations := count([res | res := storage_accounts[_]; res.change.after.allow_blob_public_access])
    violations > 0
    msg := sprintf("Expected every Storage Account to prevent public access, but %v were not", [violations])
}