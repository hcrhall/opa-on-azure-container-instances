package terraform

import input

storage_accounts := [ resource |
    resource := input.resource_changes[_]
    resource.type == "azurerm_storage_account"
	resource.mode == "managed"
]

# Storage Accounts must not be accessible over HTTP
deny[msg] {
    violations := [sa | sa := storage_accounts[_]; not sa.change.after.enable_https_traffic_only]
    count(violations) > 0
    msg := sprintf("Expected every Storage Account to be accessible over HTTPS only, but %v does not", [violations[_].change.after.name])
}

# Storage Accounts must enforce TLS 1.2
deny[msg] {
    violations := [sa | sa := storage_accounts[_]; not sa.change.after.min_tls_version == "TLS1_2"]
    count(violations) > 0
    msg := sprintf("Expected every Storage Account to require TLS 1.2, but %v does not", [violations[_].change.after.name])
}

# Storage Accounts must not allow public access
deny[msg] {
    violations := [sa | sa := storage_accounts[_]; sa.change.after.allow_blob_public_access]
    count(violations) > 0
    msg := sprintf("Expected every Storage Account to prevent public access, but %v does not", [violations[_].change.after.name])
}
