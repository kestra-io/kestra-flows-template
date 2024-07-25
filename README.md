# kestra-flows-template

To develop and deploy Kestra [flows](https://kestra.io/docs/developer-guide/flow), we use [Terraform](https://developer.hashicorp.com/terraform/intro).

File structure follows :

```YAML
.
└── environment/
    ├── development
    ├── production/ # Contains subfolders defining Kestra flows resources
    │   ├── automation/
    │   ├── cicd/
    │   ├── dbt/
    │   ├── main.tf # Instanciate each folder (automation, dbt ...)
    │   └── ...
    ├── modules/ # Terraform modules to be used in environments
    │   ├── dbt_run/
    │   ├── postgres_query/
    │   └── ...
    └── subflows/ # Kestra subflows
        ├── main.tf
        ├── sub_cloud_sql_airbyte_query.yml
        └── ...
```

## Flow defintion

- Each environment (i.e. development folder) is linked to a Kestra [namespace](https://kestra.io/docs/concepts/flows#namespace)
  - we wrap flow definition in folders to separate use cases
  - each TF module created in an `environmnent` sub-folder is called in `main.tf` to be instanciated
  - `triggers` are meant to be reusable to DRY our code. They should not be declared for a specific flow (except for [flow trigger](https://kestra.io/docs/developer-guide/triggers/flow))

## Environments

`development` & `production` are deployed on same Kestra instance.

`development` allows you to test your flow before going in production. Make sure you are not working at the same time on it.

`production` requires you to create a PR to validate your changes before being able to apply.

>TODO: improve developer experience if concurrent access. Not needed now. Secure `terraform apply` in production using CI/CD.

## FLow deployment

Currently there is no CI/CD.

1. Before creating your PR

    To ensure your changes are correct and check how it impacts current state, run in `environment` :
   - `terraform init`
   - `terraform plan`

2. Create your PR : fill the pull_request template

    - Copy paste the `terraform plan` or directly join the output file generated using `terraform plan -no-color > my_pr.txt`.

3. **When PR has been reviewed and accepted**

    - Merge your PR
    - Go on `main` branch
    - Run `terraform apply` to apply your changes

## [CoreOps] - Module & subflows

In order to provide modular dev experience, we leverage Terraform [modules](https://developer.hashicorp.com/terraform/language/modules/develop) and [subflow](https://kestra.io/docs/flow-examples/subflow) pattern.

- `modules` are used as an abstraction layer for regular user to write workflows (i.e. triggering an Airbyte sync) without having to worry about Kestra syntax, authentication or connection details.

- `subflows` are used for generic tasks where logging is not necessary to have in flow execution.
  - It contains direct YAML and are declared within [subflows/main.tf](subflows/main.tf) and define Inputs and Outputs clearly.
  - Subflows can depend on each other, this dependency should be materialized by `depends_on` field in [subflows/main.tf](subflows/main.tf).
  - Can be used by `modules` to hide some non-necessary complexity and to dry redundant tasks (GCP secret retrieval for example)

# Useful links

Kestra Developer [documentation](https://kestra.io/docs/developer-guide)
