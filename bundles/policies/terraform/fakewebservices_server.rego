package terraform

import input

web_servers := [ resource |
    resource := input.resource_changes[_]
    resource.type == "fakewebservices_server"
	resource.mode == "managed"
]

deny[msg] {
    violations := [ws | ws := web_servers[_]; not ws.change.after.type == "t2.small"]
    count(violations) > 0
    msg := {
        "information": sprintf("All 'fakewebservices_server' resources are required to have a type of 't2.small', but %v resources did not", [violations]),
        "resources": web_servers[_]
    }
}