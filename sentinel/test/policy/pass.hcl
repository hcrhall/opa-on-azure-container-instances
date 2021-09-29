module "opa" {
    source = "../../modules/opa.sentinel"
}

mock "tfplan/v2" {
  module {
    source = "../../testdata/mock-tfplan-v2-pass.sentinel"
  }
}

test {
  rules = {
    main = true
  }
}