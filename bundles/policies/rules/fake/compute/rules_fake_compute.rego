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
    msg := {
        "information": sprintf("All 'fakewebservices_server' resources are required to have a type of 't2.small', but %v resources did not", [violations]),
        "resources": servers[_]
    }
}