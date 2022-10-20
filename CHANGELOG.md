# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.2] - 20-10-2022

- add `vpc_id` to client vpn endpoint to access security group
- update vpn route to have description & subnet name as id to avoid duplicate error

## [2.0.1] - 19-10-2022

- fix `for_each` issue for list(objects) for authorization_rules & additional_routes

## [2.0.0] - 27-09-2022

- update TLS provider to latest
- update aws provider to v4
- fix deprecations
- fix upgrading arguments
- fix pipelines

## [1.1.1] - 16-06-2021

- fix to map

## [1.1.0] - 16-06-2021

- update `map` to `tomap`

## [1.0.1] - 16-06-2021

- update README.md

## [1.0.0] - 16-06-2021

- update Terraform version to v1.0.0
- update terraform-aws-provider to v3.45
- add changelog
- add CODEOWNERS
- update gitignore
