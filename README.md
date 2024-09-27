# Kestra Flow Factory with Terraform

To develop and deploy Kestra [flows](https://kestra.io/docs/workflow-components/flow), Kestra developers can use [Terraform](https://kestra.io/docs/terraform/guides/configurations).

Doing so comes with great advantages:

- Scale the codebase by using the [DRY best practices](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself)
- Manage multiple environments thanks to Terraform
- Make reproducibility at the core of your Kestra development

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

- Each environment (i.e. development folder) is linked to a Kestra [namespace](https://kestra.io/docs/workflow-components/namespace)
  - we wrap flow definition in folders to separate use cases
  - each TF module created in an `environmnent` sub-folder is called in `main.tf` to be instanciated
  - `triggers` are meant to be reusable to DRY our code. They should not be declared for a specific flow (except for [flow trigger](https://kestra.io/docs/workflow-components/triggers/flow-trigger))

## Environments

`development` & `production` are deployed on same Kestra instance.

`development` allows you to test your flow before going in production. Make sure you are not working at the same time on it.

`production` requires you to create a PR to validate your changes before being able to apply.
> Note: Using namespaces to seperate environment within the same Kestra instance is not recommanded for production. You can read more about best practices for Kestra environment and deployment management [here](https://kestra.io/docs/best-practices/from-dev-to-prod)
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

In order to provide modular dev experience, we leverage Terraform [modules](https://developer.hashicorp.com/terraform/language/modules/develop) and [subflow](https://kestra.io/docs/workflow-components/subflows) pattern.

- `modules` are used as an abstraction layer for a whole use case (i.e. triggering an Airbyte sync and runnong dbt) without having to worry about Kestra syntax, authentication or connection details. It allows you to use all native Terraform features regarding input validation and passing from other ressources, outputs to create dependencies between components etc.

- `subflows` with terraform are best suited for generic and standalone tasks.
  - It contains direct YAML and are declared within [subflows/main.tf](subflows/main.tf) and define Inputs and Outputs clearly.
  - Subflows can depend on each other, this dependency should be materialized by `depends_on` field in [subflows/main.tf](subflows/main.tf).
  - Can be used by `modules` to hide some non-necessary complexity and to dry redundant tasks (GCP secret retrieval for example)

# Useful links

Kestra Developer [documentation](https://kestra.io/docs/developer-guide)
