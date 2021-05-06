package rules.fake.compute

import input as tfplan

servers := [ resource |
    resource := input.resource_changes[_]
    resource.type == "fakewebservices_server"
	resource.mode == "managed"
]

deny[msg] {
    violations := count([srv | srv := servers[_]; not srv.change.after.type == "t2.small"])
    violations > 0
    msg := sprintf("Expected every Storage Account to be accessible over HTTPS only, but %v were not", [violations])
}