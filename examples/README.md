# Examples

This module is for the Azure SQL database.  Managed instances & SQL VMs will be created as separate modules.  The following examples illustrate the use of this module:

- [database](./database/) - an mssql server and a single database.
- [default](./default/) - this will create a mssql server.
- [elastic_pool](./elastic_pool/) - this will create a mssql server and one elastic pool.
- [elastic_pool_database](./elastic_pool_database/) - this augments the elastic pool example to add a database.

## Contributing new examples

New examples to test functionality or illustrate use are welcome.

- Create a directory for each example.
- Create a `_header.md` file in each directory to describe the example.
- See the `default` example provided as a skeleton - this must remain, but you can add others.
- Run `make fmt && make docs` from the repo root to generate the required documentation.

> **Note:** Examples must be deployable and idempotent. Ensure that no input variables are required to run the example and that random values are used to ensure unique resource names. E.g. use the [naming module](https://registry.terraform.io/modules/Azure/naming/azurerm/latest) to generate a unique name for a resource.
