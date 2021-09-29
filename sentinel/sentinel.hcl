module "opa" {
  source = "./modules/opa.sentinel"
}

policy "policy" {
  source = "./policy.sentinel"
  enforcement_level = "hard-mandatory"
}

