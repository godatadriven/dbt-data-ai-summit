Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test

# Welcome to the DBTLake

![](static/overview.png)

## Main commands

### DBT Run

To run the pipelines:

```bash
# Run everything
dbt run
```

```bash
# Run a full refresh
dbt run --full-refresh
```

Run specific models

```bash
# Run all models orders
dbt run --models orders
```

Run specific tags:

```bash
# Run all models tagged "daily"
$ dbt run --model tag:daily
```

### DBT Test

To run the data tests:

```bash
dbt test
```

### DBT Test

To generate the docs

```bash
dbt docs generate
```

This requires a Spark cluster to inspect the tables.

This will run a local web-server to present the docs:

```bash
dbt docs run
```

## What is DBT?

DBT believes that data analysts are the most valuable employees of modern, data-driven businesses. We build tools that empower analysts to own the entire analytics engineering workflow.

- **Analytics is collaborative.** We believe that mature analytics workflows should have the same features that have made software engineering teams successful collaborators: version control, quality assurance, documentation, and modularity.
- **Analytic code is an asset.** The code, processes, and tooling required to produce analysis are core organizational investments. We believe a mature analytics workflow should have the following characteristics so as to protect and grow that investment: environments, service level agreements, a design for maintainability.
- **Analytics workflows require automated tools.** Analysts spend an enormous portion of their time on repetitive, mundane tasks. We believe analysts’ tooling should automate these processes in the same way software engineers’ tools do today. Data ingestion, testing, modeling, and documentation should all leverage automation to a much greater degree than they do today.

[DBT Viewpoint](https://docs.getdbt.com/docs/about/viewpoint/)

## Integrating with Databricks

You need to create a profile to connect with Databricks:

```yaml
cat ~/.dbt/profiles.yml
default:
  target: dev
  outputs:
    dev:
      method: http
      type: spark
      schema: fokko
      organization: "..."
      host: "westeurope.azuredatabricks.net"
      port: 443
      token: "..."
      cluster: "..."
      connect_retries: 20
      connect_timeout: 60
      threads: 8

config:
  send_anonymous_usage_stats: False
```

## Integrating with Thor

To be discussed.

### Storage account

Create a source by referencing the Delta files directly:

```sql
SELECT *
FROM delta.`/mnt/thor-prd/bibo/orders/`
```

### External metastore

Having an external metastore to have the tables available within the Databricks workspace.

## DBT in Docker

I like to run this in Docker.

```bash
docker build -t dbt-spark .
docker run -t -i -v `pwd`:/dbtlake/ -v ~/.dbt/:/root/.dbt/ -p 8080:8080 dbt-spark bash
```

## Install for Linux
1. ```sudo apt-get install git libpq-dev python-dev python3-pip```
2. ```pip3 install dbt```
3.``` pip3 install dbt-spark``` (if you get a sasl error: ```sudo apt-get install libsasl2-dev```) and try again

## Install for Windows
1. Install microsoft visual c++ build tools (https://visualstudio.microsoft.com/visual-cpp-build-tools/) and make sure you select build tools
2. Run  ```pip3 install dbt-spark``` in the command window. When it gives an error on sasl, try ```pip3 install https://download.lfd.uci.edu/pythonlibs/s2jqpv5t/sasl-0.2.1-cp37-cp37m-win_amd64.whl``` and try step 2 again
3. Create a .dbt folder in your home directory (give the folder the name .dbt.)
4. Create a profiles.yml file in the .dbt folder
